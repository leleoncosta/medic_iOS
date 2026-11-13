# Gera tokens/tokens.json (formato DTCG, lido pelo Style Dictionary) e os arquivos Swift
# de Sources/MedicDesignSystem/Tokens a partir de tools/tokens-data.txt.
# Uso (na raiz do repositório):  powershell -ExecutionPolicy Bypass -File tools/generate-tokens.ps1
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)

function Camel([string]$name) {
    $parts = $name -split '[-/]' | Where-Object { $_ -ne '' }
    $out = $parts[0].ToLower()
    for ($i = 1; $i -lt $parts.Count; $i++) { $p = $parts[$i]; $out += $p.Substring(0,1).ToUpper() + $p.Substring(1) }
    return $out
}
function Num([string]$s) { return [double]::Parse($s, [Globalization.CultureInfo]::InvariantCulture) }
function Fmt([double]$v) { return $v.ToString('0.##', [Globalization.CultureInfo]::InvariantCulture) }
function SetPath($tree, [string[]]$path, $value) {
    $node = $tree
    for ($i = 0; $i -lt $path.Count - 1; $i++) {
        if (-not $node.Contains($path[$i])) { $node[$path[$i]] = [ordered]@{} }
        $node = $node[$path[$i]]
    }
    $node[$path[-1]] = $value
}
function SwiftColor([string]$v) {
    if ($v.StartsWith('#')) {
        $h = $v.Substring(1)
        if ($h.Length -eq 8) {
            $a = [Convert]::ToInt32($h.Substring(6,2),16) / 255.0
            return "Color(hex: 0x$($h.Substring(0,6)), alpha: $(Fmt ([math]::Round($a,3))))"
        }
        return "Color(hex: 0x$h)"
    }
    return "MedicPalette.$(Camel $v)"
}
function JsonColorRef([string]$v) {
    if ($v.StartsWith('#')) { return $v }
    return '{color.palette.' + (($v -split '/') -join '.') + '}'
}

$lines = Get-Content (Join-Path $PSScriptRoot 'tokens-data.txt') -Encoding UTF8 | Where-Object { $_ -and -not $_.StartsWith('#') }
$PAL = @(); $SEM = @(); $NUM = @(); $SPC = @()
foreach ($l in $lines) {
    $f = $l.Split('|')
    switch ($f[0]) { 'P' { $PAL += ,$f } 'C' { $SEM += ,$f } 'N' { $NUM += ,$f } 'S' { $SPC += ,$f } }
}
$spacing = @{}; foreach ($n in $NUM) { if ($n[1].StartsWith('spacing/')) { $spacing[$n[1]] = Num $n[2] } }
function Px([string]$v) { if ($spacing.ContainsKey($v)) { return $spacing[$v] } else { return (Num $v) } }

# ---------- JSON (DTCG / Style Dictionary) ----------
$tree = [ordered]@{ color = [ordered]@{}; dimension = [ordered]@{}; duration = [ordered]@{} }
foreach ($p in $PAL) {
    SetPath $tree (@('color','palette') + ($p[1] -split '/')) ([ordered]@{ '$value' = $p[2]; '$type' = 'color' })
}
foreach ($c in $SEM) {
    $path = $c[1] -split '/'; $path[0] = $path[0] -replace '^color-',''
    $tok = [ordered]@{
        '$value' = (JsonColorRef $c[2]); '$type' = 'color'
        '$extensions' = [ordered]@{ 'com.medic.mode' = [ordered]@{ dark = (JsonColorRef $c[3]) } }
    }
    SetPath $tree (@('color') + $path) $tok
}
foreach ($n in $NUM) {
    $path = $n[1] -split '/'
    if ($n[1].StartsWith('duration/')) {
        SetPath $tree (@('duration') + $path[1..($path.Count-1)]) ([ordered]@{ '$value' = "$($n[2])ms"; '$type' = 'duration' })
    } else {
        SetPath $tree (@('dimension') + $path) ([ordered]@{ '$value' = "$($n[2])px"; '$type' = 'dimension' })
    }
}
foreach ($s in $SPC) {
    $path = $s[1] -split '/'
    $tok = [ordered]@{
        '$value' = "$(Fmt (Px $s[2]))px"; '$type' = 'dimension'
        '$extensions' = [ordered]@{ 'com.medic.mode' = [ordered]@{ dense = "$(Fmt (Px $s[3]))px" } }
    }
    SetPath $tree (@('dimension') + $path) $tok
}
New-Item -ItemType Directory -Force (Join-Path $root 'tokens') | Out-Null
[IO.File]::WriteAllText((Join-Path $root 'tokens/tokens.json'), ($tree | ConvertTo-Json -Depth 12), $utf8)

# ---------- Swift ----------
$dir = Join-Path $root 'Sources/MedicDesignSystem/Tokens'
New-Item -ItemType Directory -Force $dir | Out-Null
$hdr = "// GERADO por tools/generate-tokens.ps1 a partir de tools/tokens-data.txt. Não edite à mão.`n// Fonte: Figma `"Design System - iOS`" (NdxangiWk18nefmJvebkTW).`n`nimport SwiftUI`n"

$sb = New-Object System.Text.StringBuilder
[void]$sb.Append($hdr)
[void]$sb.AppendLine("`n/// Primitivas de cor. Prefira os tokens semânticos de ``MedicColor`` nas telas.`npublic enum MedicPalette {")
foreach ($p in $PAL) { [void]$sb.AppendLine("    public static let $(Camel $p[1]) = Color(hex: 0x$($p[2].Substring(1)))  // $($p[1])") }
[void]$sb.AppendLine('}')
[IO.File]::WriteAllText((Join-Path $dir 'MedicPalette.swift'), $sb.ToString(), $utf8)

$sb = New-Object System.Text.StringBuilder
[void]$sb.Append($hdr)
[void]$sb.AppendLine("`n/// Tokens semânticos de cor (Light/Dark automático pelo tema do sistema).`npublic enum MedicColor {")
foreach ($c in $SEM) {
    $name = Camel ($c[1] -replace '^color-','')
    [void]$sb.AppendLine("    public static let $name = Color(light: $(SwiftColor $c[2]), dark: $(SwiftColor $c[3]))  // $($c[1])")
}
[void]$sb.AppendLine('}')
[IO.File]::WriteAllText((Join-Path $dir 'MedicColor.swift'), $sb.ToString(), $utf8)

$sb = New-Object System.Text.StringBuilder
[void]$sb.Append($hdr)
[void]$sb.AppendLine("`n/// Escala primitiva de espaçamento. Atenção: ``space16`` vale 64 pt (herança do Figma), não 16.`npublic enum MedicSpace {")
foreach ($n in $NUM) { if ($n[1].StartsWith('spacing/')) { [void]$sb.AppendLine("    public static let $(Camel ($n[1] -replace '^spacing/','space-')): CGFloat = $($n[2])") } }
[void]$sb.AppendLine("}`n`n/// Tamanhos de toque, ícone e avatar.`npublic enum MedicSizing {")
foreach ($n in $NUM) { if ($n[1].StartsWith('sizing/')) { [void]$sb.AppendLine("    public static let $(Camel ($n[1] -replace '^sizing/','')): CGFloat = $($n[2])") } }
[void]$sb.AppendLine("}`n`n/// Alturas de safe area do iOS (referência de layout; o app deve usar a safe area real do sistema).`npublic enum MedicSafeArea {")
foreach ($n in $NUM) { if ($n[1].StartsWith('safe-area/')) { [void]$sb.AppendLine("    public static let $(Camel ($n[1] -replace '^safe-area/','')): CGFloat = $($n[2])") } }
[void]$sb.AppendLine("}`n`n/// Durações de animação em segundos.`npublic enum MedicMotion {")
foreach ($n in $NUM) { if ($n[1].StartsWith('duration/')) { [void]$sb.AppendLine("    public static let $(Camel $n[1]): Double = $(Fmt ((Num $n[2]) / 1000))") } }
[void]$sb.AppendLine('}')
[IO.File]::WriteAllText((Join-Path $dir 'MedicDimensions.swift'), $sb.ToString(), $utf8)

$sb = New-Object System.Text.StringBuilder
[void]$sb.Append($hdr)
[void]$sb.AppendLine("`n/// Espaçamentos e raios semânticos. Dois modos: ``standard`` (Default) e ``dense`` (Dense).`n/// Nas views: ``@Environment(\.medicSpacing) private var spacing``.`npublic struct MedicSpacing {")
foreach ($s in $SPC) { [void]$sb.AppendLine("    public let $(Camel $s[1]): CGFloat") }
[void]$sb.AppendLine("")
foreach ($mode in @(@('standard',2), @('dense',3))) {
    [void]$sb.AppendLine("    public static let $($mode[0]) = MedicSpacing(")
    $items = @()
    foreach ($s in $SPC) { $items += "        $(Camel $s[1]): $(Fmt (Px $s[$mode[1]]))" }
    [void]$sb.AppendLine(($items -join ",`n"))
    [void]$sb.AppendLine("    )")
}
[void]$sb.AppendLine("}`n`nprivate struct MedicSpacingKey: EnvironmentKey {`n    static let defaultValue = MedicSpacing.standard`n}`n`npublic extension EnvironmentValues {`n    var medicSpacing: MedicSpacing {`n        get { self[MedicSpacingKey.self] }`n        set { self[MedicSpacingKey.self] = newValue }`n    }`n}")
[IO.File]::WriteAllText((Join-Path $dir 'MedicSpacing.swift'), $sb.ToString(), $utf8)

"OK: $($PAL.Count) primitivas de cor, $($SEM.Count) cores semânticas, $($NUM.Count) números, $($SPC.Count) espaçamentos/raios"

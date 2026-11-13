# Gera um template Code Connect por ícone em figma/icons/<símbolo>.figma.ts.
# Cada template mostra MedicIcon("<símbolo>") e expõe o nome em metadata.props.symbol, para os templates de
# Button, TextField, TableRow e Empty State trocarem o ícone por systemImage: "<símbolo>".
# Uso (na raiz do repositório):  powershell -ExecutionPolicy Bypass -File tools/generate-figma-icon-templates.ps1
# Fonte: componentes "Icon / *" da página Iconography do Figma (49 de 52; sem Line, two.checkmark e circle.fill.body).
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$dir = Join-Path $root 'figma/icons'
New-Item -ItemType Directory -Force $dir | Out-Null
$utf8 = New-Object System.Text.UTF8Encoding($false)

$icons = @'
133:1481|person.2.fill
213:1428|doc.text.fill
133:1483|person.circle
155:1975|bell.fill
133:1470|magnifyingglass
133:1472|xmark.circle.fill
133:1476|eye.fill
795:5987|eye.trianglebadge.exclamationmark.fill
133:1410|barcode.viewfinder
115:1508|chevron.right
133:1479|chevron.down
730:5427|chevron.up
133:1480|checkmark
133:1484|lock.fill
133:1488|star.fill
133:1489|paperclip
133:1490|plus
133:1493|square.and.pencil
133:1503|info.circle
133:1506|plus.circle
133:1504|arrow.up
133:1505|arrow.down
137:1445|arrow.right
133:1509|envelope
143:1453|nosign
133:1485|building.2.fill
143:1467|bubble.left.and.bubble.right.fill
507:1370|dollarsign.circle.fill
144:1525|thermometer
144:1518|arrow.up.arrow.down
144:1517|bolt.heart.fill
155:1974|exclamationmark.triangle.fill
144:1526|stethoscope
213:1439|line.3.horizontal.decrease.circle
213:1442|line.3.horizontal.decrease.circle.fill
350:1327|pills.fill
571:1440|circle.fill
601:1410|xmark.circle
642:1528|circle.circle.fill
824:6005|doc.text.below.ecg
831:6090|doc.text.image
940:6051|bed.double.fill
940:6054|cross.fill
940:6057|waveform.path.ecg.rectangle.fill
940:6060|cross.case.fill
941:6063|c.circle.fill
952:6028|personalhotspot.circle.fill
968:6041|questionmark.circle
1003:6053|person.2.circle.fill
'@

$count = 0
foreach ($line in ($icons -split "`r?`n")) {
    if (-not $line.Trim()) { continue }
    $id, $name = $line.Split('|')
    $nodeParam = $id.Replace(':', '-')
    $body = @"
// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=$nodeParam
// source=Sources/MedicDesignSystem/Components/MedicIcon.swift
// component=MedicIcon
import figma from 'figma'

export default {
  example: figma.code``MedicIcon("$name")``,
  imports: ['import MedicDesignSystem'],
  id: 'medic-icon-$name',
  metadata: { nestable: true, props: { symbol: '$name' } },
}
"@
    [IO.File]::WriteAllText((Join-Path $dir "$name.figma.ts"), $body + "`n", $utf8)
    $count++
}
"OK: $count templates de ícones em figma/icons"

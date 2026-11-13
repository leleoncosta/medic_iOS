# MedicDesignSystem (SwiftUI)

Pacote Swift com os tokens e componentes do Figma **Design System - iOS** (arquivo `NdxangiWk18nefmJvebkTW`).
Gerado a partir do Figma em 2026-11-13. **Não foi compilado nem rodado** (criado em Windows, sem Xcode):
a primeira compilação no Xcode pode apontar ajustes.

Para compilar, use o Xcode com um destino iOS (simulador). `swift build` no terminal do Mac falha, porque o pacote
usa UIKit e só declara a plataforma iOS.

Para IA e para quem estende o pacote: leia o `AGENTS.md` (regras, catálogo, quando usar o quê e como adicionar componentes).

## Testar sem Mac (GitHub Actions)

O workflow `.github/workflows/ios.yml` roda a cada push na `main` (e manualmente em Actions → iOS → Run workflow).
Ele compila o pacote num Mac virtual, roda `Tests/MedicDesignSystemTests` no simulador de iPhone e publica dois artefatos:
`component-snapshots` (PNGs de cada componente em claro e escuro, para comparar com o Figma) e `build-logs`
(log do `xcodebuild` e resultado dos testes). Os testes só conferem que a imagem foi gerada; a comparação visual é manual.

## Estrutura

| Pasta | Conteúdo |
|---|---|
| `Sources/MedicDesignSystem/Tokens` | `MedicPalette` (primitivas), `MedicColor` (semânticas Light/Dark), `MedicSpacing` (Default/Dense), `MedicSpace`, `MedicSizing`, `MedicSafeArea`, `MedicMotion` — **gerados, não edite** |
| `Sources/MedicDesignSystem/Typography` | `MedicTextStyle` e `.medicText(_:)` (estilos de texto do Figma) |
| `Sources/MedicDesignSystem/Components` | Componentes do núcleo (abaixo) |
| `Sources/MedicDesignSystem/Previews` | Galeria para conferir contra o Figma |
| `tokens/tokens.json` | Tokens em formato DTCG, para o Style Dictionary |
| `tools/` | `tokens-data.txt` (fonte única) e `generate-tokens.ps1` (gera Swift e JSON) |

Para regenerar os tokens depois de mudar `tools/tokens-data.txt`:

```bash
powershell -ExecutionPolicy Bypass -File tools/generate-tokens.ps1
```

## Componentes do núcleo

| Componente Swift | Figma (node) | Variantes e propriedades cobertas |
|---|---|---|
| `MedicButton` | Button `2990:150` | Type (Primary, Secondary, Destructive, Ghost), State (Default, Pressed via estilo, Disabled via `.disabled`), Size (Large 48, Regular 44), ícones leading/trailing |
| `MedicBadge` | Badge `2994:268` | Type (Info, Success, Warning, Error, Neutral), Style (Soft, Strong), Show Dot |
| `MedicSectionHeader` | Section Header `3003:21` | Style (Grouped, Prominent), Show Action + Action Label |
| `MedicTextField` | TextField `2994:127` | State (Default, Focus automático, Error, Success, Disabled), Filled (derivado do texto), Label, Required, Helper, ícones |
| `MedicTableRow` | TableRow (novo) `2982:265` | Title, Subtitle, Detail, Right Label, Date, Leading, Chevron, Trailing, Separator, Style Destructive, Pressed (overlay), Disabled |
| `MedicTopNavigation` | TopNavigation `10:980` | Title, Left Title/Back, Right (slot), Large Title, Search, Segmented (slot `bottom`) |
| `MedicTabBar` | TabBar `10:3527` + TabBar-item `10:3496` | 2 a 5 abas, aba selecionada |
| `MedicIcon` | Icon / * (página Iconography) | Glifo SF Symbol 22 pt, cor padrão `color-icon/default` |
| `MedicCheckbox` | Checkbox `3007:27` | Selected (False, True, Indeterminate), State (Default, Pressed automático, Focus, Disabled via `.disabled`), Label |
| `MedicRadio` | Radio `3007:43` | Selected (False, True), State (idem), Label; o grupo é de quem usa |
| `MedicSwitch` | Switch `10:3750` | On (True, False), State (Default, Disabled via `.disabled`) |
| `MedicSpinner` | Spinner `3011:21` | Size (Small 20, Large 37); gira, e para com "Reduzir Movimento" |
| `MedicSkeleton` | Skeleton `3014:14` | Type (Line, Avatar, Block, Row); estático |
| `MedicEmptyState` | Empty State `3004:28` | Size (Large, Compact), ícone opcional, mensagem, ação opcional |

## O que NÃO está coberto (decisões e pendências)

- **Slide Action do TableRow** (Delete, Action): use `.swipeActions` do SwiftUI em `List`.
- **Barra de status e Home Indicator**: são do sistema iOS. TopNavigation e TabBar respeitam a safe area.
- **Segmented do TopNavigation**: o componente SegmentedPicker ainda não foi convertido; entra pelo slot `bottom`.
- **Padding inferior do TopNavigation**: no Figma varia de 6 a 9 pt por variante; o código usa 6 (`space3`).
- **Cor do placeholder e do ícone do campo de busca** (dentro do TopNavigation): não vem como token no Figma lido; usei `color-translucent/text-secondary`. Conferir.
- **Tamanho dos ícones**: 22 pt em todos (glifo SF Pro do Figma). Se o visual divergir no app, ajuste em `MedicIcon`.
- **Chevron do TableRow**: no Figma é `color-translucent/divider` com opacidade 40% aplicada na instância; replicado como está.
- **Dynamic Type**: os estilos usam tamanho fixo, como no Figma.
- **iOS mínimo**: 16 (escolha do assistente; `Package.swift`).
- **Checkbox/Radio**: a camada Pressed Overlay cobre só a caixa de 22 pt (medido no Figma), com 15% de opacidade. O check e o traço usam as medidas do Figma (traço de 2 pt, pontas arredondadas).
- **Spinner**: a rotação (1 s por volta, contínua) é decisão do código; o Figma é estático e o UIActivityIndicator gira em passos.
- **Empty State**: o texto é centralizado (alinhamento não lido no Figma).
- **Switch**: sombras do knob convertidas do blur do Figma para o raio do SwiftUI (blur ÷ 2).
- **Code Connect (Figma → SwiftUI)**: os 13 componentes da tabela acima estão mapeados no Figma (rótulo SwiftUI) para os arquivos deste repositório. O mapeamento é simples (componente → arquivo); ainda não há template com as propriedades. Os ícones não têm mapeamento individual (correspondem a `MedicIcon`).
- Sem elevação (sombras `Elevation/*`) e sem os demais componentes do Figma (SegmentedPicker, Select, Pill Button, Alerts, Action Sheet, Calendar, Keyboard etc.).

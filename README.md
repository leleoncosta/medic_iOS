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
| `tools/` | `tokens-data.txt` (fonte única) e `generate-tokens.ps1` (gera Swift e JSON); `generate-figma-icon-templates.ps1` (templates dos ícones) |
| `figma/` e `figma.config.json` | Templates do Code Connect (`.figma.ts`), **ainda não publicados nem testados**; veja `figma/README.md` |

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
| `MedicSegmentedPicker` | SegmentedPicker `2611:5973` | 2 a 4 opções, segmento selecionado, versão "+ Nav" (`onNavigationBar`) |
| `MedicPillButton` | Pill Button `135:1527` | Type (uma ou duas linhas), State (Selected), Interaction (Pressed automático, Disabled via `.disabled`) |
| `MedicSearchField` | SearchField `10:915` | Type (Default, Cancel via `onCancel`), ícone à direita opcional |
| `MedicSlider` | Slider `10:3772` | Icons (False, True via `minimumValueImage`/`maximumValueImage`) |
| `MedicSelect` | Select `71:1217` | Selected (False, True), State (Disabled via `.disabled`); só o indicador de 22 pt |
| `MedicPagination` | Pagination `71:1086` | Número de páginas e página atual |
| `MedicNotification` | Notification `10:4357` | Default, Image (miniatura), Stacked, Pressed (com `action`); sem Options |
| `MedicIncomingCallBanner` | Notification-incomingCall `10:4326` | Contato, tipo, recusar e aceitar |
| `MedicMessageBubble` | MessageBubble `10:3985` | Sender, Recipient, Group Recipient; hora, entrega e cauda (aproximada) |
| `MedicCard` | página Custom Card (container) | Sombra subtle ou soft; compõe `MedicTableRow` |
| `MedicNumberCard` | Card / Number `219:1643` | Rótulo, título e valor grande |
| `MedicProfileCard` | Card / Profile Icon `441:1468` | Avatar com iniciais, nome e especialidade |
| `MedicTextAreaCard` | Card / Textarea Row `580:1531` | Cabeçalho + texto de várias linhas |

## O que NÃO está coberto (decisões e pendências)

- **Slide Action do TableRow** (Delete, Action): use `.swipeActions` do SwiftUI em `List`.
- **Barra de status e Home Indicator**: são do sistema iOS. TopNavigation e TabBar respeitam a safe area.
- **Segmented do TopNavigation**: entra pelo slot `bottom` com `MedicSegmentedPicker(..., onNavigationBar: true)`.
- **Padding inferior do TopNavigation**: no Figma varia de 6 a 9 pt por variante; o código usa 6 (`space3`).
- **Busca do TopNavigation**: usa `MedicSearchField` com fundo `surface/primary`; lupa e texto de apoio em `color-translucent/text-secondary` (lido no Figma).
- **Tokens translúcidos**: o alfa já está no token (`translucent/*`). O Figma mostra "@70" ou "@40" ao lado, mas é o mesmo alfa, aplicado uma vez (medido no render do Figma). Não aplique `.opacity` por cima.
- **Tamanho dos ícones**: 22 pt em todos (glifo SF Pro do Figma). Se o visual divergir no app, ajuste em `MedicIcon`.
- **Dynamic Type**: os estilos usam tamanho fixo, como no Figma.
- **iOS mínimo**: 16 (escolha do assistente; `Package.swift`).
- **Checkbox/Radio**: a camada Pressed Overlay cobre só a caixa de 22 pt (medido no Figma), com o alfa do token `state-pressed-overlay`. O check e o traço usam as medidas do Figma (traço de 2 pt, pontas arredondadas).
- **Spinner**: a rotação (1 s por volta, contínua) é decisão do código; o Figma é estático e o UIActivityIndicator gira em passos.
- **Empty State**: o texto é centralizado (alinhamento não lido no Figma).
- **Switch**: sombras do knob convertidas do blur do Figma para o raio do SwiftUI (blur ÷ 2).
- **Code Connect (Figma → SwiftUI)**: os 25 mapeamentos (todos os componentes da tabela acima, menos `MedicIcon` e `MedicCard`, que é só container) estão feitos no Figma (rótulo SwiftUI) para os arquivos deste repositório. O mapeamento é simples (componente → arquivo); ainda não há template com as propriedades. Os 49 ícones (`Icon / *`) também estão mapeados para `MedicIcon` (os 3 sem SF Symbol equivalente, `Line`, `two.checkmark` e `circle.fill.body`, foram removidos do Figma em 2026-11-14). As ferramentas do Figma gravam só o mapeamento simples (`hasTemplate` volta `false`, mesmo ao enviar um template); templates com propriedades exigem publicar pelo CLI do Code Connect (Node + token do Figma) e antes desconectar o mapeamento simples na interface do Figma.
- **Pagination**: no Figma a cor da bolinha é fixa por posição (a 2ª é sempre `icon/brand`) e só a opacidade segue a página atual, o que parece um defeito do desenho. O código usa `icon/brand` na página atual e `pagination-inactive` a 30% nas outras. Confirmar com o design.
- **SegmentedPicker**: o segmento selecionado usa `surface/elevated` (o do componente interno do Figma; a instância usa `surface/primary`, que no escuro fica ainda mais escuro). No escuro o segmento continua um pouco mais escuro que o trilho: um segmento mais claro exigiria um token novo (decisão de design). As divisórias entre segmentos não selecionados seguem o padrão do iOS (estão ocultas no componente do Figma). Os tipos "Two Lines" da opção não foram implementados.
- **Select**: o check usa o SF Symbol `checkmark` em branco (o desenho vetorial do Figma não foi reproduzido); o anel mede ~1,6 pt. O preenchimento selecionado usa `action/primary/bg` (como Checkbox e Radio); o Figma usa `action/primary/bg-pressed`, que clareia no escuro e tira o contraste do check. Se o Figma for corrigido para `bg`, os dois ficam iguais.
- **Pill Button**: título em Semibold quando selecionado ou com duas linhas; as sombras seguem o Figma (preto 25%, y 4, blur 4). A 2ª linha do Pill Button selecionado usa `neutral-50` nos dois temas: o Figma usa `surface/secondary`, que escurece no tema escuro e perde contraste sobre o azul. Ideal: corrigir o token no Figma.
- **Componentes do sistema iOS** (Alert, Action Sheet, Contextual Menu, Date Picker/Calendar, FaceID): decisão de usar o nativo do SwiftUI e não recriar a aparência; o mapeamento está no `AGENTS.md`.
- **MessageBubble**: a cauda é aproximada (canto inferior com raio de 4 pt); hora de envio centralizada e fonte de 11 pt (Caption-2) assumidas; avatar do grupo opcional.
- **Notification**: o estado Pressed usa a sobreposição `state-pressed-overlay` (o Figma não detalha); o fundo é sólido `surface/elevated` (o blur de 80 do Figma não é reproduzido, pois o fundo é opaco). O estado Options (Clear) fica para `.swipeActions`.
- **IncomingCall**: tamanho dos glifos de recusar/aceitar assumido em 16 pt. O tipo do telefone ("mobile") usa `#EBEBF5` a 60% nos dois temas: o Figma usa `translucent/text-secondary`, que escurece no tema claro e some sobre o fundo escuro do banner.
- **Custom Card**: dos 7 cartões do Figma, 3 viraram componentes próprios (Number, Profile Icon, Textarea Row); os de linha (Profile Icon + Two/Four Labels, Three Labels Row) e o Card Number + Two Fields compõem-se com `MedicCard` e `MedicTableRow`. O valor grande do `MedicNumberCard` usa 32 pt Semibold sem estilo de texto no Figma (altura de linha 37 lida do Figma, espaçamento 0 assumido).
- Sem elevação (sombras `Elevation/*`) e sem o Keyboard do Figma.

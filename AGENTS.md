# Instruções para IA: MedicDesignSystem (SwiftUI)

Pacote Swift (`MedicDesignSystem`, iOS 16+) com os tokens e componentes do Figma **Design System - iOS**
(arquivo `NdxangiWk18nefmJvebkTW`). Leia também o `README.md`. Este arquivo diz **como usar e como estender**
o pacote sem inventar valores.

## Regras que não se negociam

1. **Nunca escreva cor, espaçamento, raio ou fonte soltos.** Use os tokens:
   - Cores: `MedicColor.<papel>` (ex.: `MedicColor.textPrimary`). Já são Light/Dark; não trate o tema à mão.
   - Primitivas (`MedicPalette.neutral900`) só dentro do próprio pacote ou para casos sem token semântico.
   - Espaçamento e raios: `@Environment(\.medicSpacing) private var spacing` e `spacing.paddingComponentMd`,
     `spacing.gapStackSm`, `spacing.radiusXl`... (modos `standard` e `dense`).
   - Tamanhos fixos: `MedicSizing` (toque 44, ícone, avatar), `MedicSafeArea`, `MedicSpace` (escala primitiva).
   - Texto: `.medicText(.bodyRegular)` etc. (`MedicTextStyle`); nunca `.font(.system(...))` solto.
   - Ícones: `MedicIcon("nome.do.simbolo")` (SF Symbols, 22 pt, cor `color-icon/default`).
2. **Não edite `Sources/MedicDesignSystem/Tokens/Medic*.swift` nem `tokens/tokens.json`**: são gerados.
   Para mudar um token: edite `tools/tokens-data.txt` e rode
   `powershell -ExecutionPolicy Bypass -File tools/generate-tokens.ps1`.
3. **Não invente.** Se o Figma não traz um valor, deixe uma pendência registrada (README) em vez de chutar.
4. **Prefira o componente a recriar o visual.** Se existe `MedicButton`, não monte um botão com `Button` + estilos.
5. Escreva textos de interface e descrições em **português**.

## Nomes dos tokens (Figma → Swift)

`color-text/primary` → `MedicColor.textPrimary` (tira `color-`, camelCase, `/` e `-` viram maiúscula).
`color-action/primary/bg-pressed` → `MedicColor.actionPrimaryBgPressed`. `padding/component-md` →
`spacing.paddingComponentMd`. `radius/2xl` → `spacing.radius2xl`. `spacing/16` vale **64** pt (não 16).
Itens `kit-*` (ex.: `radiusKit10`) vêm do UI kit da Apple; use só onde o Figma usa.

## Componentes (`Sources/MedicDesignSystem/Components`)

| Componente | Uso |
|---|---|
| `MedicButton("Salvar", kind: .primary/.secondary/.destructive/.ghost, size: .large/.regular, leadingSystemImage:, trailingSystemImage:, fullWidth:) { }` | Ação da tela. Desabilitar com `.disabled(true)` |
| `MedicBadge("Ativo", type: .info/.success/.warning/.error/.neutral, style: .soft/.strong, showDot:)` | Situação de um registro |
| `MedicSectionHeader("Título", style: .grouped/.prominent, actionLabel:, action:)` | Título de grupo de linhas |
| `MedicTextField(text:, label:, placeholder:, helper:, isRequired:, state: .default/.error/.success/.disabled, leadingSystemImage:, trailingSystemImage:)` | Texto livre. Erro e sucesso exigem `helper` |
| `MedicTableRow("Título", subtitle:, detail:, rightLabel:, date:, showChevron:, trailingSystemImage:, showSeparator:, isDestructive:, action:) { leading }` | Linha de lista |
| `MedicTopNavigation(title:, largeTitle:, backTitle:, onBack:, search:, trailing: { }, bottom: { })` | Topo de tela não modal |
| `MedicTabBar(items: [MedicTabItem], selection: $id)` | Navegação principal (2 a 5 abas) |
| `MedicCheckbox(isOn:, label:, isIndeterminate:)` | Escolhas independentes |
| `MedicRadio("Opção", isSelected:) { }` | Escolha única (o grupo é seu) |
| `MedicSwitch(isOn:, label:)` | Liga/desliga imediato |
| `MedicSpinner(size: .small/.large)` | Espera sem forma definida |
| `MedicSkeleton(.line/.avatar/.block/.row)` | Carregamento com forma conhecida |
| `MedicEmptyState("Título", message:, systemImage:, size: .large/.compact, actionTitle:, action:)` | Sem conteúdo |
| `MedicSegmentedPicker(options: [String], selection: $index, onNavigationBar:)` | Visões do mesmo conteúdo (2 a 4 opções aqui) |
| `MedicPillButton("Filtro", subtitle:, isSelected:) { }` | Filtro/categoria (não é ação) |
| `MedicSearchField(text:, placeholder:, trailingSystemImage:, onCancel:)` | Busca |
| `MedicSlider(value:, in:, minimumValueImage:, maximumValueImage:, label:)` | Valor contínuo |
| `MedicSelect(isSelected:)` | Indicador de seleção em círculo (leading de linha) |
| `MedicPagination(numberOfPages:, currentPage:)` | Indicador de páginas |
| `MedicNotification(title:, message:, time:, appIcon:, imagePreview:, isStacked:, action:)` | Banner in-app passivo (se exige decisão, use Alert nativo) |
| `MedicIncomingCallBanner(name:, phoneType:, photo:, onDecline:, onAccept:)` | Banner de chamada recebida |
| `MedicMessageBubble("texto", kind: .sender/.recipient/.groupRecipient(senderName:, avatar:), sendTime:, deliveryStatus:, showsTail:)` | Conversa entre duas partes |
| `MedicCard(shadow: .subtle/.soft/.none) { }` | Container de cartão de registro (compõe `MedicTableRow`) |
| `MedicNumberCard(label:, title:, value:)`, `MedicProfileCard(initials:, name:, subtitle:)`, `MedicTextAreaCard(title:, text:, placeholder:)` | Cartões do Figma (Number, Profile Icon, Textarea Row) |

Estados (Pressed, Focus, Disabled) são automáticos ou vêm de `.disabled(true)`; não os desenhe à mão.
Slide Action de linha: use `.swipeActions` do SwiftUI (o `MedicTableRow` não o inclui).

## Quando usar o quê (resumo das Usage Guidelines do Figma)

| Decisão | Regra |
|---|---|
| Alert × Action Sheet | Alert: informação crítica que exige reconhecimento (máx. 2-3 ações). Action Sheet: usuário já iniciou uma ação e escolhe entre opções, sempre com Cancelar |
| Notification × Alert | Notification: atualização passiva, ignorável. Alert: só quando o usuário precisa decidir antes de continuar |
| Segmented Picker × Tab Bar | Segmented: visões do mesmo conteúdo (2 a 5). Tab Bar: seções principais do app |
| Checkbox × Radio × Switch | Checkbox: escolhas independentes (aceita parcial). Radio: uma entre opções excludentes, sempre em grupo. Switch: liga/desliga com efeito imediato; nunca em formulário que exige salvar |
| Spinner × Skeleton | Spinner: espera sem forma definida. Skeleton: estrutura conhecida (lista, tela). Nunca os dois na mesma área |
| Button × Pill Button | Button: ação da tela, no máximo **um Primary** por tela. Pill Button: filtro/categoria, não é ação |
| Switch × Slider | Switch: binário. Slider: valor contínuo |
| Badge | Situação de um registro; não para contagem; a cor não pode ser a única indicação |
| Empty State | Sem conteúdo; não durante carregamento (Skeleton) nem para erro bloqueante (Alert) |
| Section Header | Título de grupo, nunca título da tela (isso é a TopNavigation) |
| TextField | Texto livre; para opções conhecidas use Radio, Segmented ou Picker; para busca, SearchField |
| TopNavigation | No máximo uma ação primária/destrutiva na barra |

## Lacunas (não existem neste pacote; não improvise com o mesmo nome)

Keyboard (depende de biblioteca externa do Figma) e Elevation (sombras `Elevation/*`); Notification com `Options`
(Clear/Options: use `.swipeActions`); os tipos "Two Lines" da opção do SegmentedPicker.
Se a tela precisar de um deles, **peça o componente** (ou leia a spec no Figma e crie seguindo o fluxo abaixo).

## Componentes do sistema iOS: use o nativo (não há `Medic*` para eles)

O Figma redesenha estas telas a partir do kit da Apple. No app, use as APIs do sistema (acessibilidade, animação,
foco e Dynamic Type já vêm prontos). Siga as regras de uso da tabela acima.

| Figma | SwiftUI nativo | Observações |
|---|---|---|
| Alert (1 a 3 ações) | `.alert(_:isPresented:actions:message:)` | Ação destrutiva com `Button(role: .destructive)`; ação preferida com `.keyboardShortcut(.defaultAction)`. Máx. 2-3 ações |
| Action Sheet | `.confirmationDialog(_:isPresented:titleVisibility:actions:message:)` | Sempre inclua `Button("Cancelar", role: .cancel)` |
| Contextual Menu | `.contextMenu { ... }` ou `Menu { ... } label: { ... }` | Toque longo no objeto: `.contextMenu`; botão "...": `Menu` |
| Calendar / Picker (Date Picker) | `DatePicker(_:selection:displayedComponents:)` | `.datePickerStyle(.graphical)` (Calendar) ou `.wheel` (Picker) |
| FaceID | `LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason:)` (LocalAuthentication) | Exige `NSFaceIDUsageDescription` no Info.plist. Nunca simule a interface de FaceID |
| Slide Action (TableRow) e Options (Notification) | `.swipeActions` em `List` | Até 2 ações frequentes por linha |

## Como adicionar ou alterar um componente

1. Leia a spec no Figma (variantes, propriedades, tokens ligados, medidas). Não copie valores de memória.
2. Crie `Sources/MedicDesignSystem/Components/Medic<Nome>.swift`, só com tokens (regras acima), `public`,
   comentário de cabeçalho com o nome e o node do Figma.
3. Estados: Disabled por `.disabled`/`@Environment(\.isEnabled)`, Pressed por `ButtonStyle`, Dark pelos tokens.
4. Acessibilidade: rótulo, valor e traços (`isSelected`, `isHeader`) em todo controle.
5. Adicione um teste em `Tests/MedicDesignSystemTests/ComponentSnapshotTests.swift` e uma linha na tabela do `README.md`.
6. Não há Swift no Windows: valide enviando para a `main` e lendo o GitHub Actions (`.github/workflows/ios.yml`).
   Os PNGs de cada componente (claro/escuro) saem como artefato `component-snapshots`.
   `TextField` aparece como marcador amarelo nos PNGs (limitação do `ImageRenderer`).

## Pendências conhecidas

- Cor do placeholder/ícone da busca na `MedicTopNavigation` (usa `color-translucent/text-secondary`, sem token no Figma).
- Padding inferior da `MedicTopNavigation` (Figma varia de 6 a 9 pt por variante; o código usa 6).
- Tokens `translucent/*` já carregam o alfa: **não** aplique `.opacity(...)` por cima (o "@70" do Figma é o mesmo alfa).
- `MedicPagination`: o Figma fixa a cor por posição (provável defeito); o código segue a página atual.
- Keyboard do Figma depende de biblioteca externa (Apple UI kit); não reproduzido.
- Dynamic Type não implementado (estilos de tamanho fixo, como no Figma).
- Descrições de variáveis no Figma são mecânicas (nome + valor); a intenção de uso de cada token ainda não foi escrita.

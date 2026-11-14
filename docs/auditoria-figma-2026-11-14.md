# Auditoria do Figma "Design System - iOS" (2026-11-14)

> **Atualização (2026-11-14), decisão sobre os componentes:** por escolha do usuário foram removidos, com o quadro de
> documentação dedicado e o rótulo de cada um: `Icon / Line`, `Icon / two.checkmark`, `Icon / circle.fill.body`,
> `Activity Indicator` e `Alert Template`; também o título "Templates" da página Alerts, que ficou sem conteúdo.
> Foram mantidos: Pill Button Collection, os 4 padrões de cartão, a referência dos componentes nativos do iOS e o
> Keyboard. O restante do relatório descreve o estado da auditoria (o arquivo agora tem 104 componentes em vez de 109).
>
> **Atualização (2026-11-14), decisão sobre variáveis e estilos:** foram removidas 38 variáveis nunca usadas e que não
> vão para o Swift: Typography (9), easings (5), Semantic/Motion (6) e Elevation (18). A coleção `Semantic/Motion`
> ficou vazia (400 → 363 variáveis). Mantidos: Spacing, Semantic/Spacing e durações (o Swift usa), cores Support, todos
> os estilos de texto (22 sem uso) e os 10 estilos de efeito Elevation.
>
> **Atualização (2026-11-14), limpeza final:** a coleção `Semantic/Motion` (vazia) foi apagada e a documentação órfã
> saiu das páginas Typography (font-size/10, font-size/14 e o bloco "Line Height (%)") e Elevation & Motion (blocos
> "Shadow Opacity Scale" e "Blur"); dois textos foram corrigidos (contagem de tokens e nota de limitação).
> As tabelas das seções 2 e 3 abaixo refletem o estado antes da remoção.

Somente leitura: **nada foi apagado nem alterado.** Arquivo `NdxangiWk18nefmJvebkTW`: 109 componentes, 401 variáveis em
15 coleções, 54 estilos locais (38 de texto, 13 de efeito, 3 de grade), 42 páginas.

Como ler os números:
- **Uso real** = a variável ou o estilo aparece em componentes, templates ou na página WIP (fora das páginas de
  documentação Cover, Governance, Usage Guidelines, Colors, Typography, Grid e Elevation & Motion).
- **Só documentação** = aparece apenas nas amostras dessas páginas (eu liguei os swatches às variáveis na Fase 3).
- **Nunca usada** = não aparece em lugar nenhum (nem em documentação, nem em estilo).
- **Via alias** = é referenciada por outra variável (ex.: primitiva usada por uma semântica).
- **Atenção ao código:** várias variáveis "sem uso" no Figma são consumidas pelo pacote Swift (`tools/tokens-data.txt`).
  Apagá-las no Figma não quebra o Swift, mas as tira de sincronia.

## 1. Componentes (109: 74 com Code Connect, 35 sem)

### 1.1 Sem uso e provavelmente sobras (6)
| Componente | Página | Observação |
|---|---|---|
| Icon / Line `578:1504` | Iconography | Linha, não é um ícone. Zero instâncias |
| Icon / two.checkmark `821:6001` | Iconography | Nome sem SF Symbol equivalente. Zero instâncias |
| Icon / circle.fill.body `596:1414` | Iconography | Nome sem SF Symbol equivalente. Zero instâncias |
| Activity Indicator `808:5982` | Status Bar & Home Indicator | Zero instâncias; o Spinner o substitui |
| Pill Button Collection `166:1991` | Pill Button | Zero instâncias |
| Alert Template `10:3730` | Alerts | Zero instâncias. Descrição (confirmada por você): modelo para criar variações do Alert |

### 1.2 Sem uso, padrões de cartão sem componente Swift (4)
Card / Card Number + Two Fields `219:1668`, Card / Profile Icon + Two Labels `593:1448`,
Card / Profile Icon + Four Labels `135:1525`, Card / Three Labels Row `213:1367` (página Custom Card).
Zero instâncias. No código compõem-se com `MedicCard` e `MedicTableRow`.

### 1.3 Sem uso, referência dos componentes nativos do iOS (6)
ContextualMenu `10:3845`, ActionSheet `10:3926`, Calendar `10:4266`, Picker `778:7825`, FaceID `10:4485` e Alert `10:3654`
(o Alert só é usado dentro do Alert Template). No app usam o componente nativo do SwiftUI. Servem de referência de design.
Seus internos (`_Action-item`, `_ContextualMenu-menuItem`, `_ActionSheet-action`, `_Calendar-timePicker`,
`_Calendar-dayRow`) só são usados por eles.

### 1.4 Keyboard (3 conjuntos, zero instâncias)
Alphanumeric `778:5573` (50 variantes), Numeric `778:7680` (6), Header `778:7805` (2). As 1.926 instâncias da página
Keyboard vêm da biblioteca externa (Apple UI kit).

### 1.5 Sem Code Connect, mas em uso (16): não são sobras
_StatusBar-time, StatusBar / iPhone X, HomeIndicator (usados por TopNavigation e TabBar); TableRow-Leading (TableRow);
TabBar-item (TabBar, 54 usos); _SegmentedPicker-option (58); MessageBubble-avatar; _Notification-iconType;
NotificationOptions; Header Filter (TopNavigation); Table Row Group (4 usos em outras páginas); _Action-item,
_ContextualMenu-menuItem, _ActionSheet-action, _Calendar-timePicker, _Calendar-dayRow.

### 1.6 Com Code Connect e nunca instanciados fora de si
Cerca de 45 (a maioria dos 49 ícones mapeados, Slider, Pagination, MessageBubble, Notification, cartões...). É normal
numa biblioteca: o componente existe para ser usado. Não é candidato a exclusão.

## 2. Variáveis (401)

| Coleção | Total | Uso real | Via alias | Só documentação | Nunca usada |
|---|---|---|---|---|---|
| Primitive/Brand | 20 | 0 | 11 | 9 | 0 |
| Primitive/Neutral | 13 | 1 | 12 | 0 | 0 |
| Primitive/Feedback | 40 | 0 | 33 | 7 | 0 |
| Primitive/Support | 18 | 0 | 0 | 18 | 0 |
| Semantic/Color | 116 | 77 | 0 | 39 | 0 |
| Primitive/Typography | 55 | 31 | 0 | 24 | 9 |
| Primitive/Spacing | 37 | 12 | 5 | 20 | 20 |
| Semantic/Spacing | 31 | 21 | 0 | 10 | 10 |
| Primitive/Elevation | 36 | 0 | 0 | 36 | 18 |
| Primitive/Motion | 11 | 0 | 0 | 11 | 11 |
| Semantic/Motion | 6 | 0 | 0 | 6 | 6 |
| Semantic/Keyboard | 8 | 5 | 0 | 3 | 0 |
| Semantic/Translucent | 6 | 6 | 0 | 0 | 0 |
| Semantic/Messages | 2 | 2 | 0 | 0 | 0 |
| Semantic/Notification | 2 | 2 | 0 | 0 | 0 |
| **Total** | **401** | **157** | **61** | **183** | **74** |

(Nesta tabela, "Só documentação" já inclui as 74 "Nunca usada".)

### 2.1 Nunca usadas em lugar nenhum (74)
- **Typography (9):** font-size/10, font-size/14, line-height/100, /120, /130, /140, /150, /160, line-height-px/26.
  Não vão para o Swift: podem sair sem efeito no código.
- **Spacing (20):** spacing/12, /13, /14, /15, sizing/touch-min, touch-comfortable, touch-large, icon-sm, icon-md,
  icon-lg, icon-xl, avatar-sm, avatar-md, avatar-lg, safe-area/status-bar, nav-bar, tab-bar, home-indicator,
  top-total, bottom-total. **O Swift usa** (`MedicSizing`, `MedicSafeArea`, `MedicSpace`): não recomendo apagar.
- **Semantic/Spacing (10):** padding/component-xs, padding/screen-section, gap/inline-xs, gap/stack-xs, gap/stack-md,
  gap/stack-xl, gap/stack-2xl, gap/section, radius/none, radius/2xl. **O Swift usa** (`MedicSpacing`): não recomendo.
- **Elevation (18):** shadow/level-0-blur, opacity/shadow-xs..xl, opacity/shadow-dark-sm..lg, opacity/inner-sm..lg,
  opacity/overlay, opacity/overlay-heavy, opacity/disabled, blur/subtle, blur/medium, blur/heavy. Não vão para o Swift.
- **Motion (11):** duration/instant, fast, clinical-alert, quick, normal, slow (**o Swift usa** `MedicMotion`) e
  easing/linear, ease-out, ease-in, ease-in-out, spring (não vão para o Swift).
- **Semantic/Motion (6):** motion/appear, dismiss, transition, feedback, loading, clinical-alert (não vão para o Swift).

### 2.2 Só em documentação (sem uso nos componentes)
- **Semantic/Color (39):** color-text/quaternary, placeholder, link, on-error; color-surface/brand, brand-strong,
  success, error, warning, info; color-border/focus, brand, brand-subtle, error, error-subtle, warning, success, info;
  color-action/primary/bg-hover, color-action/destructive/border; color-feedback/error/border,
  error/text-strong, warning/text-strong, success/text-strong, info/text-strong; color-icon/secondary, disabled,
  inverse, error, warning, success, info, brand-secondary; color-nav/bar-border, tab-border, tab-badge-bg,
  tab-badge-text; color-input/icon-leading, icon-trailing.
  Todas vão para o Swift (`MedicColor`).
- **Primitive/Brand (9):** brand-blue/100, /900; brand-teal/50, /100, /200, /400, /500, /800, /900.
- **Primitive/Feedback (7):** feedback-green-100, -600, -800; feedback-red-100, -800; feedback-yellow-50; feedback-info-800.
- **Primitive/Support (18):** toda a família support-purple, support-orange e support-cyan (nenhuma é usada por
  semântica ou componente).
- **Primitive/Typography (24):** os 9 acima + font-size/24, /28, /40, letter-spacing/tight, wide, wider, semitight,
  pos0-364, line-height-px/24, /34, /15, /17, /23, /29, /40 (usadas só pelos estilos de texto sem uso).
- **Semantic/Keyboard (3):** color-keyboard/key-text, key-icon, key-icon-secondary (o Keyboard usa teclas da biblioteca externa).

## 3. Estilos (54; 32 sem uso)
- **Texto sem uso (22):** Display/Semibold, Display/Regular, Title-2/Semibold, Headline/Regular, Title-1/Semibold,
  Body/Medium, Footnote/Medium, Caption-2/Regular e os 14 Clinical (Data-XL, Data-Large, Data-Medium, Data-Small,
  Data-Unit, Data-Label, Drug-Name, Drug-Dose, Drug-Schedule, Result-Value, Result-Range, Alert-Title, Alert-Body,
  Timestamp). Todos existem no Swift (`MedicTextStyle`).
- **Efeito sem uso (10):** Elevation/Level-0 a Level-4 e as cinco versões /Dark. Usados: Bar/Navigation, Bar/Tab e
  Control/Segmented-Thumb.
- **Grade:** os 3 estilos estão em uso (página Grid).

## 4. Propriedades de componentes
- **Propriedades sem uso (não ligadas a nenhuma camada):** nenhuma.
- **Propriedade de variante com um único valor (3):** `Type=Default` em `_StatusBar-time` e `StatusBar / iPhone X`, e
  `Device=iPhone X (or newer)` em `TopNavigation`. As duas primeiras só se removem pela interface do Figma.

## 5. Páginas e camadas soltas
- Nenhuma página vazia além dos separadores e dos títulos FOUNDATION e COMPONENTS (intencionais).
- **WIP** tem 4 telas (414×844): Pacientes • Cadastro geral, Consultas • Agenda do dia, Internação • Pacientes por
  leito, Acompanhamento • Plano de cuidado. Trabalho em andamento, não é sobra.
- Quadros soltos no topo de página (fora de seções): Cover, os 3 quadros de Grid e as 4 telas do WIP. Normal.
- Nenhum quadro vazio encontrado.

## 6. Dependência de biblioteca externa
- **Keyboard:** 1.926 instâncias (teclas, sugestões, Home Indicator).
- **Cabeçalho das páginas de componentes:** 57 instâncias remotas, em 16 páginas: `_Header` (Link=True/False) com
  `_Icon`, e `_Component Type` (Type=Atoms, Molecules ou Templates). São o cabeçalho de documentação do kit original;
  não afetam os componentes. Páginas: Iconography, Status Bar & Home Indicator, Navigation Bar, Table Views, Tab bar,
  Segmented Picker, Custom Card, Alerts, Switches & Sliders, Contextual Menu, Action Sheet, Messages, Date Picker,
  Notification, FaceID, Pill Button.

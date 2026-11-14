# Auditoria da organização das páginas de componentes (2026-11-14)

> **Atualização (2026-11-14), Fase A executada:**
> - **Links do HIG:** os 12 links usavam o caminho antigo (`/ios/...`) e todos davam 404. Por decisão do usuário, o link foi
>   **removido de todas as páginas** (cabeçalho na variante `Link=False`; título realinhado à esquerda em 13 páginas).
> - **Nomes:** "Tab bar" → "Tab Bar"; "FaceID" → "Face ID" (página e seção); camada "FaceID" do Keyboard → "Keyboard".
>   O quadro "FaceID" do Keyboard era só o título "Keyboard" com nome de camada errado, e o texto "Picker" do Date Picker é
>   o título do conjunto: nenhum dos dois era item solto.
> - **Páginas novas:** fundo `#E5E5E5` e seção com raio 16. **Rótulos** "Light / variante" no Spinner e no Skeleton
>   (Roboto Mono; as outras páginas usam SF Mono, indisponível para edição).
> - **Cover:** 104 componentes, 363 tokens (variáveis), 35 páginas. O contador de snapshots não foi alterado.
> - **Correção deste relatório:** o arquivo tem **40 páginas** (35 com conteúdo, sem 3 separadores e 2 títulos de grupo),
>   e não 42 e 37, como estava escrito.
>
> **Atualização (2026-11-14), Fase B executada (desacoplar):** as instâncias remotas dos cabeçalhos (`_Header`, `_Icon` e
> os chips `_Component Type`), cerca de 60 em 17 páginas, foram desacopladas e viraram quadros locais, sem mudança visual.
> Por decisão do usuário, os componentes locais reutilizáveis (Doc Header e chips) e a faixa de metadados foram para a
> Fase C: as fontes SF não estão disponíveis para edição na automação, então componentes novos teriam de usar outra fonte.
> Restam fora do arquivo apenas as teclas do Keyboard (biblioteca externa).
>
> **Atualização (2026-11-14), Fase C executada (ficha técnica):** 47 fichas, uma por componente público (sem ícones e sem
> internos com prefixo `_`), ao lado do título de cada componente. Blocos: status, Swift (nome e link do arquivo, ou a API
> nativa), propriedades (tipo, opções, padrão e parâmetro Swift), "Quando usar / não usar" (das Usage Guidelines, só onde há
> regra) e tokens usados. Status por fatos: 25 "No código", 11 "Referência de design", 6 "Parte de outro componente" e
> 5 "Sem uso". O texto novo usa Inter e Roboto Mono (as fontes SF não estão disponíveis na automação). Ainda não há blocos
> de acessibilidade nem versão ("desde vX"), e a Fase D (Light e Dark lado a lado e agrupamento por categoria) segue pendente.

Somente leitura: **nada foi alterado no Figma.** Escopo: as 26 páginas do grupo COMPONENTS (mais Iconography e Templates)
do arquivo `NdxangiWk18nefmJvebkTW`.

## 1. Diagnóstico: duas gerações de página

| Aspecto | Páginas antigas (16 + Iconography, do kit da Apple) | Páginas novas (9 + Templates, criadas na consultoria) |
|---|---|---|
| Fundo da página | `#E5E5E5` | `#F5F5F5` |
| Seção | branca, raio 16 | branca, **raio 2** |
| Cabeçalho | `Header + Icon`: ícone, título e link para o HIG | **nenhum** |
| Nível atômico | chips `_Component Type` (Atoms, Molecules, Templates), instâncias da biblioteca externa | **nenhum** |
| Moldura do componente | quadro tracejado roxo com nome em fonte mono e rótulos "Light / variante" | componente solto + quadro "Exemplos" |
| Exemplos de uso | não tem | tem (instâncias das variantes principais) |
| Descrição no componente | tem (todos, adicionadas na Fase 3) | tem (todos) |

Páginas novas: Button, TextField, Badge, Section Header, Empty State, Checkbox, Radio, Spinner, Skeleton. Spinner e Skeleton
não têm nenhum rótulo de texto.

## 2. Inconsistências página a página

| Página | Problema |
|---|---|
| Custom Card | Cartões soltos na seção, sem moldura nem rótulo; os dois chips (Atoms e Molecules) ficam seguidos, sem nada entre eles; **link do HIG aponta para "Navigation Bars"** |
| Pill Button | Componentes soltos; **link do HIG aponta para "Sliders, Switches"**; mistura Pill Button, Header Filter e Pill Button Collection |
| Switches & Sliders | Só o chip Atoms, mas reúne 4 famílias (Switch, Slider, Pagination, Select); quadros genéricos ("Action", "Frame 871", "Frame 872"); link com texto, **sem URL** |
| Messages | Só o chip Atoms, mas contém o MessageBubble (molécula); **sem link do HIG** |
| FaceID | Título "Face ID", seção e página "FaceID"; chip "Templates"; **sem link** |
| Keyboard | Quadro solto "FaceID" 92×24, instância remota "Picker Keyboard", chip "Templates"; **sem link** |
| Date Picker | Texto solto "Picker" e o conjunto Picker sem moldura |
| Table Views | Dois chips "Molecules" seguidos; TableRow-Leading (átomo) fica dentro do quadro do TableRow |
| Tab bar | Página "Tab bar", seção "Tab Bar" (maiúscula diferente) |
| Iconography | Sem chips nem link (esperado), mas sem padrão de cabeçalho com descrição |
| Páginas novas (9) | Sem cabeçalho, chips, link do HIG e padrão de moldura; seção com raio 2 |

Nomes de página que não correspondem ao conteúdo: **Switches & Sliders** (tem Pagination e Select), **Date Picker** (Calendar e
Picker), **Navigation Bar** (TopNavigation e SearchField), **Table Views** (TableRow e Table Row Group), **Pill Button**
(Header Filter e Collection). As páginas seguem a ordem de criação (antigas primeiro, novas depois), sem agrupamento por categoria.

Os links do HIG usam o caminho antigo `.../ios/...`. Verifique se ainda abrem (a Apple reorganizou o site).

## 3. Capa (Cover) desatualizada
A capa diz "101 COMPONENTES • 386 TOKENS • 31 PÁGINAS • 0 SNAPSHOTS". Hoje são **104 componentes**, **363 variáveis** e **40 páginas**
(35 com conteúdo, mais 3 separadores e 2 títulos de grupo; os números 42 e 37 acima estavam errados). A contagem de "snapshots" também não existe mais.

## 4. O que falta em TODAS as páginas (informação que já existe e não aparece)

| Informação | Onde já existe | Valor |
|---|---|---|
| Nome do componente em Swift e link para o arquivo no GitHub | `README.md`, Code Connect | A pessoa de design vê o equivalente no código sem sair do Figma |
| Quando usar / quando não usar | página Usage Guidelines e descrição do componente | Evita ir e voltar entre páginas |
| Tabela de propriedades (nome, tipo, opções, padrão, parâmetro Swift) | propriedades do componente + templates em `figma/` | Hoje só se vê abrindo o painel do Figma |
| Variantes e estados em Light e Dark lado a lado | tokens Light/Dark | As páginas só mostram o Light |
| Tokens usados (cores, espaçamento, raio, texto) | ligações de variáveis | Ajuda a auditar e a trocar tokens |
| Acessibilidade (área de toque 44 pt, traços, contraste) | código Swift e `AGENTS.md` | Hoje não está documentado no Figma |
| Status e versão ("estável", "reserva", "desde v1.xx") | changelog na Governance | Mostra a maturidade de cada componente |
| Dependências (quais componentes ele usa por dentro) | instâncias aninhadas | Mostra o impacto de mudar um átomo |
| Classificação atômica correta e consistente | chips existentes (com erros) | Um critério único (átomo, molécula, template) |

## 5. Padrão proposto para toda página de componente

1. **Canvas e seção:** um estilo só (sugestão: o das antigas, fundo `#E5E5E5`, seção branca com raio 16, mesmo recuo de 64).
2. **Cabeçalho local** (componente próprio, não a biblioteca externa): ícone, título, descrição de uma linha, e uma faixa com
   Status, Nível atômico, "Desde vX", link do HIG (verificado), link do Swift (`MedicX`) e referência às Usage Guidelines.
3. **Blocos em ordem fixa:** Visão geral (quando usar e quando não) → Anatomia e propriedades (tabela) → Variantes e estados
   (Light e Dark) → Exemplos → Tokens → Acessibilidade → Código (trecho Swift) → Histórico (versões do changelog).
4. **Moldura padrão** em cada componente: quadro tracejado com o nome em mono e rótulos "Light / variante".
5. **Nomes:** página = nome do componente em código; uma família por página, ou um índice dentro da página quando houver várias;
   capitalização única (por exemplo, "Tab Bar" e "Face ID" em todo lugar).
6. **Índice e ordem:** agrupar COMPONENTS por categoria (Ações, Entradas, Navegação, Exibição de dados, Feedback, Sistema iOS)
   e atualizar os números da Cover.
7. **Checklist de contribuição:** novo item no processo da Governance exigindo esse modelo em toda página nova.

## 6. Fases sugeridas (da menos arriscada à mais trabalhosa)

- **A. Correções (sem estrutura nova):** links do HIG (Custom Card, Pill Button, Switches & Sliders, Messages, FaceID, Keyboard),
  texto solto e quadro solto (Date Picker, Keyboard), maiúsculas, rótulos de Spinner e Skeleton, números da Cover,
  raio e fundo nas páginas novas.
- **B. Cabeçalho padrão:** criar os componentes locais (Doc Header, chip de nível, chip de status) e aplicar nas 26 páginas,
  trocando também os 57 itens da biblioteca externa dos cabeçalhos.
- **C. Conteúdo novo por página:** tabela de propriedades, link e nome do Swift, tokens usados, acessibilidade.
- **D. Light e Dark lado a lado** e reorganização por categoria.

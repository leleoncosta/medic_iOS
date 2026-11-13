# Templates do Code Connect (SwiftUI)

Arquivos `.figma.ts` que fazem o Dev Mode do Figma mostrar **código SwiftUI com as propriedades** de cada
componente (por exemplo, `Type=Primary` vira `kind: .primary`). Arquivo do Figma: `NdxangiWk18nefmJvebkTW`.

> **Não testado.** Foram escritos sem Node e sem acesso ao Dev Mode. Publique, abra um componente no Dev Mode e
> confira. Se algo sair errado, o nome da propriedade no `get`/`getEnum` é o primeiro suspeito (diferencia maiúsculas).

## Como publicar

Pré-requisitos: Node, plano Organization ou Enterprise com acesso de desenvolvedor, componentes publicados na
biblioteca e um token de acesso pessoal do Figma.

1. Instale o CLI: `npm install --global @figma/code-connect@latest`
2. **Desconecte os mapeamentos simples existentes** (os 25 componentes e os 49 ícones já têm um): no Figma,
   Dev Mode → componente → Code Connect → desconectar. As ferramentas usadas aqui não conseguem sobrescrevê-los.
   (Se o `publish` substituir sozinho, melhor; isso não foi confirmado.)
3. Na raiz do repositório: `npx figma connect publish --token=SEU_TOKEN`
   (ou defina `FIGMA_ACCESS_TOKEN` e rode `npx figma connect publish`).
4. Para desfazer: `npx figma connect unpublish`.

## Estrutura

- `components/`: um template por componente (nome da propriedade do Figma → parâmetro do componente Swift).
- `icons/`: um template por ícone, gerado por `tools/generate-figma-icon-templates.ps1`. Cada um expõe o nome do
  SF Symbol em `metadata.props.symbol`, para que botões, linhas e campos com ícone troquem por `systemImage: "nome"`.

## Convenções dos templates

- A parte do Swift é montada em texto e entregue em `figma.code`. Nunca concatene o resultado de `executeTemplate()`.
- Estados que o código trata sozinho (Pressed, Focus) não geram parâmetro. Disabled vira `.disabled(true)`.
- Propriedades do Figma sem parâmetro equivalente no Swift são omitidas, não inventadas.
- Onde o Swift pede um binding (`$isOn`, `$text`), o template usa um nome genérico; troque pelo seu estado.

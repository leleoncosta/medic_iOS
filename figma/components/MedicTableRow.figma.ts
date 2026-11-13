// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=2982-265
// source=Sources/MedicDesignSystem/Components/MedicTableRow.swift
// component=MedicTableRow
import figma from 'figma'
const instance = figma.selectedInstance

const title = instance.getString('Title')
const subtitle = instance.getString('Subtitle')
const detail = instance.getString('Detail')
const rightLabel = instance.getString('Right Label')
const date = instance.getString('Date')
const showLeading = instance.getBoolean('Show Leading')
const showSubtitle = instance.getBoolean('Show Subtitle')
const showDetail = instance.getBoolean('Show Detail')
const showRightLabel = instance.getBoolean('Show Right Label')
const showDate = instance.getBoolean('Show Date')
const showChevron = instance.getBoolean('Show Chevron')
const showTrailing = instance.getBoolean('Show Trailing')
const showSeparator = instance.getBoolean('Show Separator')
const slide = instance.getEnum('Slide Action', { Hidden: 'hidden', Delete: 'delete', 'Delete + Action': 'both' })
const style = instance.getEnum('Style', { Default: 'default', Destructive: 'destructive' })
const state = instance.getEnum('State', { Default: 'default', Pressed: 'pressed', Disabled: 'disabled' })

let trailingSymbol: string | null = null
if (showTrailing) {
  const icon = instance.getInstanceSwap('Trailing Icon')
  if (icon && icon.type === 'INSTANCE') {
    const meta = icon.executeTemplate().metadata
    if (meta && meta.props && meta.props.symbol) trailingSymbol = meta.props.symbol
  }
}

const args = [`"${title}"`]
if (showSubtitle) args.push(`subtitle: "${subtitle}"`)
if (showDetail) args.push(`detail: "${detail}"`)
if (showRightLabel) args.push(`rightLabel: "${rightLabel}"`)
if (showDate) args.push(`date: "${date}"`)
if (showChevron) args.push('showChevron: true')
if (trailingSymbol) args.push(`trailingSystemImage: "${trailingSymbol}"`)
if (!showSeparator) args.push('showSeparator: false')
if (style === 'destructive') args.push('isDestructive: true')

let call = `MedicTableRow(${args.join(', ')})` + (showLeading ? ' {\n    // conteúdo leading (ex.: MedicIcon ou avatar)\n}' : '')
if (state === 'disabled') call += '\n    .disabled(true)'
if (slide !== 'hidden') call += '\n    // Slide Action: use .swipeActions { ... } na List (o MedicTableRow não o inclui)'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-table-row',
  metadata: { nestable: false },
}

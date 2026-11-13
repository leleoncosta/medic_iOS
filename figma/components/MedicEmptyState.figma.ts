// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=3004-28
// source=Sources/MedicDesignSystem/Components/MedicEmptyState.swift
// component=MedicEmptyState
import figma from 'figma'
const instance = figma.selectedInstance

const title = instance.getString('Title')
const description = instance.getString('Description')
const showIcon = instance.getBoolean('Show Icon')
const showAction = instance.getBoolean('Show Action')
const size = instance.getEnum('Size', { Large: 'large', Compact: 'compact' })

let symbol: string | null = null
if (showIcon) {
  const icon = instance.getInstanceSwap('Icon')
  if (icon && icon.type === 'INSTANCE') {
    const meta = icon.executeTemplate().metadata
    if (meta && meta.props && meta.props.symbol) symbol = meta.props.symbol
  }
}

const args = [`"${title}"`, `message: "${description}"`]
args.push(showIcon ? (symbol ? `systemImage: "${symbol}"` : 'systemImage: "doc.text.fill"') : 'systemImage: nil')
args.push(`size: .${size}`)
if (showAction) args.push('actionTitle: "Ação"')
const call = `MedicEmptyState(${args.join(', ')})` + (showAction ? ' { }' : '')

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-empty-state',
  metadata: { nestable: false },
}

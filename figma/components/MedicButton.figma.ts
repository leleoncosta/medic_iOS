// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=2990-150
// source=Sources/MedicDesignSystem/Components/MedicButton.swift
// component=MedicButton
import figma from 'figma'
const instance = figma.selectedInstance

const label = instance.getString('Label')
const kind = instance.getEnum('Type', { Primary: 'primary', Secondary: 'secondary', Destructive: 'destructive', Ghost: 'ghost' })
const size = instance.getEnum('Size', { Large: 'large', Regular: 'regular' })
const state = instance.getEnum('State', { Default: 'default', Pressed: 'pressed', Disabled: 'disabled' })

function symbolOf(swapName: string, showName: string): string | null {
  if (!instance.getBoolean(showName)) return null
  const icon = instance.getInstanceSwap(swapName)
  if (icon && icon.type === 'INSTANCE') {
    const meta = icon.executeTemplate().metadata
    if (meta && meta.props && meta.props.symbol) return meta.props.symbol
  }
  return null
}
const leading = symbolOf('Leading Icon', 'Show Leading Icon')
const trailing = symbolOf('Trailing Icon', 'Show Trailing Icon')

const args = [`"${label}"`, `kind: .${kind}`, `size: .${size}`]
if (leading) args.push(`leadingSystemImage: "${leading}"`)
if (trailing) args.push(`trailingSystemImage: "${trailing}"`)
let call = `MedicButton(${args.join(', ')}) { }`
if (state === 'disabled') call += '\n    .disabled(true)'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-button',
  metadata: { nestable: true },
}

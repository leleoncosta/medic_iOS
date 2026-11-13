// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=2994-127
// source=Sources/MedicDesignSystem/Components/MedicTextField.swift
// component=MedicTextField
import figma from 'figma'
const instance = figma.selectedInstance

const label = instance.getString('Label')
const value = instance.getString('Value')
const helper = instance.getString('Helper')
const showLabel = instance.getBoolean('Show Label')
const required = instance.getBoolean('Required')
const showHelper = instance.getBoolean('Show Helper')
const filled = instance.getEnum('Filled', { False: false, True: true })
// Focus é automático (campo em foco): não gera parâmetro.
const state = instance.getEnum('State', { Default: 'default', Focus: 'default', Error: 'error', Success: 'success', Disabled: 'disabled' })

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

const args = ['text: $text']
if (showLabel) args.push(`label: "${label}"`)
if (!filled) args.push(`placeholder: "${value}"`)
if (showHelper) args.push(`helper: "${helper}"`)
if (required) args.push('isRequired: true')
if (state !== 'default') args.push(`state: .${state}`)
if (leading) args.push(`leadingSystemImage: "${leading}"`)
if (trailing) args.push(`trailingSystemImage: "${trailing}"`)
const call = `MedicTextField(${args.join(', ')})` + (filled ? `\n// Filled = True: o campo já tem texto ("${value}")` : '')

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-text-field',
  metadata: { nestable: true },
}

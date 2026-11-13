// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=3007-27
// source=Sources/MedicDesignSystem/Components/MedicCheckbox.swift
// component=MedicCheckbox
import figma from 'figma'
const instance = figma.selectedInstance

const label = instance.getString('Label')
const showLabel = instance.getBoolean('Show Label')
const selected = instance.getEnum('Selected', { False: 'false', True: 'true', Indeterminate: 'indeterminate' })
// Pressed e Focus são automáticos: não geram parâmetro.
const state = instance.getEnum('State', { Default: 'default', Disabled: 'disabled', Pressed: 'pressed', Focus: 'focus' })

const args = ['isOn: $isOn']
if (showLabel) args.push(`label: "${label}"`)
if (selected === 'indeterminate') args.push('isIndeterminate: true')
let call = `MedicCheckbox(${args.join(', ')})`
if (selected === 'true') call += ' // marcado: isOn = true'
if (state === 'disabled') call += '\n    .disabled(true)'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-checkbox',
  metadata: { nestable: true },
}

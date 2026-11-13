// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=135-1527
// source=Sources/MedicDesignSystem/Components/MedicPillButton.swift
// component=MedicPillButton
import figma from 'figma'
const instance = figma.selectedInstance

const type = instance.getEnum('Type', { 'Pill Button': 'one', 'Pill Button Two Lines': 'two' })
const selected = instance.getEnum('State', { 'Not Selected': false, Selected: true })
// Pressed é automático; Disabled vira .disabled(true).
const interaction = instance.getEnum('Interaction', { Default: 'default', Pressed: 'pressed', Disabled: 'disabled' })

const labelLayer = instance.findText('Label')
const label = labelLayer.type === 'TEXT' ? labelLayer.textContent : 'Label'
const subLayer = instance.findText('dd/mm/aaaa')
const subtitle = subLayer.type === 'TEXT' ? subLayer.textContent : 'dd/mm/aaaa'

const args = [`"${label}"`]
if (type === 'two') args.push(`subtitle: "${subtitle}"`)
args.push(`isSelected: ${selected}`)
let call = `MedicPillButton(${args.join(', ')}) { }`
if (interaction === 'disabled') call += '\n    .disabled(true)'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-pill-button',
  metadata: { nestable: true },
}

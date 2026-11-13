// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=71-1217
// source=Sources/MedicDesignSystem/Components/MedicSelect.swift
// component=MedicSelect
import figma from 'figma'
const instance = figma.selectedInstance

const selected = instance.getEnum('Selected', { False: false, True: true })
const state = instance.getEnum('State', { Default: 'default', Disabled: 'disabled' })

let call = `MedicSelect(isSelected: ${selected})`
if (state === 'disabled') call += '\n    .disabled(true)'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-select',
  metadata: { nestable: true },
}

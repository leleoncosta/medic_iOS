// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=3007-43
// source=Sources/MedicDesignSystem/Components/MedicRadio.swift
// component=MedicRadio
import figma from 'figma'
const instance = figma.selectedInstance

const label = instance.getString('Label')
const showLabel = instance.getBoolean('Show Label')
const selected = instance.getEnum('Selected', { False: false, True: true })
const state = instance.getEnum('State', { Default: 'default', Disabled: 'disabled', Pressed: 'pressed', Focus: 'focus' })

let call = (showLabel ? `MedicRadio("${label}", isSelected: ${selected}) { }` : `MedicRadio(isSelected: ${selected}) { }`)
if (state === 'disabled') call += '\n    .disabled(true)'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-radio',
  metadata: { nestable: true },
}

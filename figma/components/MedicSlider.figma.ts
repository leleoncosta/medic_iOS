// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=10-3772
// source=Sources/MedicDesignSystem/Components/MedicSlider.swift
// component=MedicSlider
import figma from 'figma'
const instance = figma.selectedInstance

const icons = instance.getEnum('Icons', { False: false, True: true })
const call = icons
  ? 'MedicSlider(value: $value, minimumValueImage: "speaker.wave.1", maximumValueImage: "speaker.wave.3")'
  : 'MedicSlider(value: $value)'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-slider',
  metadata: { nestable: true },
}

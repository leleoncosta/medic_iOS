// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=3011-21
// source=Sources/MedicDesignSystem/Components/MedicSpinner.swift
// component=MedicSpinner
import figma from 'figma'
const instance = figma.selectedInstance

const size = instance.getEnum('Size', { Small: 'small', Large: 'large' })
const call = `MedicSpinner(size: .${size})`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-spinner',
  metadata: { nestable: true },
}

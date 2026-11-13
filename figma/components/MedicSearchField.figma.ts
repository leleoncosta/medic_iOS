// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=10-915
// source=Sources/MedicDesignSystem/Components/MedicSearchField.swift
// component=MedicSearchField
import figma from 'figma'
const instance = figma.selectedInstance

const type = instance.getEnum('Type', { Default: 'default', Cancel: 'cancel' })
const call = type === 'cancel'
  ? 'MedicSearchField(text: $text, onCancel: { })'
  : 'MedicSearchField(text: $text)'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-search-field',
  metadata: { nestable: true },
}

// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=3014-14
// source=Sources/MedicDesignSystem/Components/MedicSkeleton.swift
// component=MedicSkeleton
import figma from 'figma'
const instance = figma.selectedInstance

const type = instance.getEnum('Type', { Line: 'line', Avatar: 'avatar', Block: 'block', Row: 'row' })
const call = `MedicSkeleton(.${type})`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-skeleton',
  metadata: { nestable: true },
}

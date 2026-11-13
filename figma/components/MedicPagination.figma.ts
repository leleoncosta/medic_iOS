// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=71-1086
// source=Sources/MedicDesignSystem/Components/MedicPagination.swift
// component=MedicPagination
import figma from 'figma'
const instance = figma.selectedInstance

// No Figma a página é 1, 2 ou 3; no Swift, currentPage é 0-based.
const page: number = instance.getEnum('Current Page', { '1': 0, '2': 1, '3': 2 })
const call = `MedicPagination(numberOfPages: 3, currentPage: ${page})`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-pagination',
  metadata: { nestable: true },
}

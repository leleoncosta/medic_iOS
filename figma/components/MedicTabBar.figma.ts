// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=10-3527
// source=Sources/MedicDesignSystem/Components/MedicTabBar.swift
// component=MedicTabBar
import figma from 'figma'
const instance = figma.selectedInstance

const count: number = instance.getEnum('Tab Count', { '2 Tabs': 2, '3 Tabs': 3, '4 Tabs': 4, '5 Tabs': 5 })
const selected: number = instance.getEnum('Selected Tab', { '1': 1, '2': 2, '3': 3, '4': 4, '5': 5 })

const items: string[] = []
for (let i = 0; i < count; i++) {
  items.push(`MedicTabItem(id: ${i}, title: "Aba ${i + 1}", systemImage: "circle")`)
}
const call = `MedicTabBar(\n    items: [\n        ${items.join(',\n        ')}\n    ],\n    selection: $tab // aba ${selected} selecionada: tab = ${selected - 1}\n)`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-tab-bar',
  metadata: { nestable: false },
}

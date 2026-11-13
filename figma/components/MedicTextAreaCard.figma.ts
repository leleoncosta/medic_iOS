// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=580-1531
// source=Sources/MedicDesignSystem/Components/MedicCard.swift
// component=MedicTextAreaCard
import figma from 'figma'
const instance = figma.selectedInstance

function textOf(layerName: string, fallback: string): string {
  const layer = instance.findText(layerName, { traverseInstances: true })
  return layer.type === 'TEXT' ? layer.textContent : fallback
}
const title = textOf('TITLE', 'Título')
const placeholder = textOf('✏️ Label', 'Escreva aqui')
const call = `MedicTextAreaCard(title: "${title}", text: $text, placeholder: "${placeholder}")`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-text-area-card',
  metadata: { nestable: false },
}

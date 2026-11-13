// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=441-1468
// source=Sources/MedicDesignSystem/Components/MedicCard.swift
// component=MedicProfileCard
import figma from 'figma'
const instance = figma.selectedInstance

function textOf(layerName: string, fallback: string): string {
  const layer = instance.findText(layerName, { traverseInstances: true })
  return layer.type === 'TEXT' ? layer.textContent : fallback
}
// As iniciais são a camada de texto "LM"; nome e especialidade são camadas "Label" de mesmo nome (exemplo fixo).
const initials = textOf('LM', 'LM')
const call = `MedicProfileCard(initials: "${initials}", name: "Nome do médico", subtitle: "Especialidade")`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-profile-card',
  metadata: { nestable: false },
}

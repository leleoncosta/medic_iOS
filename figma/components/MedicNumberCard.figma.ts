// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=219-1643
// source=Sources/MedicDesignSystem/Components/MedicCard.swift
// component=MedicNumberCard
import figma from 'figma'

// Componente sem propriedades no Figma: os textos são camadas sem nome único ("Title" aparece duas vezes),
// então o exemplo usa valores de exemplo.
const call = 'MedicNumberCard(label: "Rótulo", title: "Título", value: "R$ 0,00")'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-number-card',
  metadata: { nestable: false },
}

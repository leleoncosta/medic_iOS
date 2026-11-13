// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=10-4326
// source=Sources/MedicDesignSystem/Components/MedicIncomingCallBanner.swift
// component=MedicIncomingCallBanner
import figma from 'figma'
const instance = figma.selectedInstance

function textOf(layerName: string, fallback: string): string {
  const layer = instance.findText(layerName, { traverseInstances: true })
  return layer.type === 'TEXT' ? layer.textContent : fallback
}
const name = textOf('✏️ Contact Name', 'Contato')
const phoneType = textOf('✏️ Phone Type', 'mobile')

const call = `MedicIncomingCallBanner(name: "${name}", phoneType: "${phoneType}", onDecline: { }, onAccept: { })`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-incoming-call-banner',
  metadata: { nestable: false },
}

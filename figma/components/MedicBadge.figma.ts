// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=2994-268
// source=Sources/MedicDesignSystem/Components/MedicBadge.swift
// component=MedicBadge
import figma from 'figma'
const instance = figma.selectedInstance

const label = instance.getString('Label')
const type = instance.getEnum('Type', { Info: 'info', Success: 'success', Warning: 'warning', Error: 'error', Neutral: 'neutral' })
const style = instance.getEnum('Style', { Soft: 'soft', Strong: 'strong' })
const showDot = instance.getBoolean('Show Dot')

const args = [`"${label}"`, `type: .${type}`, `style: .${style}`]
if (showDot) args.push('showDot: true')
const call = `MedicBadge(${args.join(', ')})`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-badge',
  metadata: { nestable: true },
}

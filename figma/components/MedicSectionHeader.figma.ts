// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=3003-21
// source=Sources/MedicDesignSystem/Components/MedicSectionHeader.swift
// component=MedicSectionHeader
import figma from 'figma'
const instance = figma.selectedInstance

const title = instance.getString('Title')
const style = instance.getEnum('Style', { Grouped: 'grouped', Prominent: 'prominent' })
const showAction = instance.getBoolean('Show Action')
const actionLabel = instance.getString('Action Label')

const args = [`"${title}"`, `style: .${style}`]
if (showAction) args.push(`actionLabel: "${actionLabel}"`)
const call = `MedicSectionHeader(${args.join(', ')})` + (showAction ? ' { }' : '')

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-section-header',
  metadata: { nestable: true },
}

// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=10-3750
// source=Sources/MedicDesignSystem/Components/MedicSwitch.swift
// component=MedicSwitch
import figma from 'figma'
const instance = figma.selectedInstance

const on = instance.getEnum('On', { True: true, False: false })
const state = instance.getEnum('State', { Default: 'default', Disabled: 'disabled' })

let call = 'MedicSwitch(isOn: $isOn, label: "Descrição para o VoiceOver")' + (on ? ' // ligado: isOn = true' : ' // desligado: isOn = false')
if (state === 'disabled') call += '\n    .disabled(true)'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-switch',
  metadata: { nestable: true },
}

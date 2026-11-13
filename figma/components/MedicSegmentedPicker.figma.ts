// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=2611-5973
// source=Sources/MedicDesignSystem/Components/MedicSegmentedPicker.swift
// component=MedicSegmentedPicker
import figma from 'figma'
const instance = figma.selectedInstance

const count: number = instance.getEnum('Options', { '2 Options': 2, '3 Options': 3, '4 Options': 4 })
// O valor do enum é o próprio nome; o índice e a versão "+ Nav" são derivados abaixo.
const selectedName: string = instance.getEnum('Selected', {
  'Left Selected': 'Left Selected',
  'Right Selected': 'Right Selected',
  'Left-Center Selected': 'Left-Center Selected',
  'Right-Center Selected': 'Right-Center Selected',
  'Center Selected': 'Center Selected',
  'Left Selected + Nav': 'Left Selected + Nav',
  'Right Selected + Nav': 'Right Selected + Nav',
  'Left-Center Selected + Nav': 'Left-Center Selected + Nav',
  'Right-Center Selected + Nav': 'Right-Center Selected + Nav',
  'Center Selected + Nav': 'Center Selected + Nav',
})

let index = 0
if (selectedName.includes('Right-Center')) index = 2
else if (selectedName.includes('Left-Center')) index = 1
else if (selectedName.includes('Center')) index = 1
else if (selectedName.includes('Right')) index = count - 1
const onNav = selectedName.includes('+ Nav')

const options: string[] = []
for (let i = 0; i < count; i++) options.push(`"Opção ${i + 1}"`)
const args = [`options: [${options.join(', ')}]`, 'selection: $selection']
if (onNav) args.push('onNavigationBar: true')
const call = `MedicSegmentedPicker(${args.join(', ')}) // segmento selecionado: selection = ${index}`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-segmented-picker',
  metadata: { nestable: true },
}

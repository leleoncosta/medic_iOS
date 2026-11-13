// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=10-4357
// source=Sources/MedicDesignSystem/Components/MedicNotification.swift
// component=MedicNotification
import figma from 'figma'
const instance = figma.selectedInstance

const type: string = instance.getEnum('Type', {
  Default: 'Default',
  Image: 'Image',
  Stacked: 'Stacked',
  Pressed: 'Pressed',
  'Pressed Image': 'Pressed Image',
  Options: 'Options',
})

function textOf(layerName: string, fallback: string): string {
  const layer = instance.findText(layerName, { traverseInstances: true })
  return layer.type === 'TEXT' ? layer.textContent : fallback
}
const title = textOf('✏️ Title', 'Título')
const message = textOf('✏️ Description', 'Mensagem')
const time = textOf('✏️ Time', 'agora')

const args = [`title: "${title}"`, `message: "${message}"`, `time: "${time}"`, 'appIcon: Image("icone-do-app")']
if (type.includes('Image')) args.push('imagePreview: Image("miniatura")')
if (type === 'Stacked') args.push('isStacked: true')
if (type.includes('Pressed')) args.push('action: { }')
let call = `MedicNotification(${args.join(', ')})`
if (type === 'Options') call += '\n// Options (Clear/Options): use .swipeActions; o MedicNotification não inclui esse estado'

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-notification',
  metadata: { nestable: false },
}

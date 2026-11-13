// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=10-980
// source=Sources/MedicDesignSystem/Components/MedicTopNavigation.swift
// component=MedicTopNavigation
import figma from 'figma'
const instance = figma.selectedInstance

// O valor do enum é o próprio nome do Type; as combinações são derivadas abaixo.
const type: string = instance.getEnum('Type', {
  Search: 'Search',
  'Large Title': 'Large Title',
  'Large Title + Search': 'Large Title + Search',
  'Search + Segmented': 'Search + Segmented',
  'Large Title + Search + Segmented': 'Large Title + Search + Segmented',
  Default: 'Default',
  'Default + Search + Segmented Control': 'Default + Search + Segmented Control',
  'Default + Segmented': 'Default + Segmented',
  'Default + Actions': 'Default + Actions',
})
const title = instance.getString('Title')
const leftTitle = instance.getString('Left Title')
const rightTitle = instance.getString('Right Title')
const largeTitle = instance.getString('Large Title')
const showBack = instance.getBoolean('Show Back Icon')
const showLeft = instance.getBoolean('Show Left Title')
const showRight = instance.getBoolean('Show Right Title')
const showRightIcon = instance.getBoolean('Show Right Icon')

const hasLarge = type.includes('Large Title')
const hasSearch = type.includes('Search')
const hasSegmented = type.includes('Segmented')

const args: string[] = [`title: "${title}"`]
if (hasLarge) args.push(`largeTitle: "${largeTitle}"`)
if (showLeft) args.push(`backTitle: "${leftTitle}"`)
if (showBack || showLeft) args.push('onBack: { }')
if (hasSearch) args.push('search: $search')
if (showRight || showRightIcon) {
  const inner = showRight ? `Text("${rightTitle}")` : 'MedicIcon("line.3.horizontal.decrease.circle")'
  args.push(`trailing: { ${inner} }`)
}
if (hasSegmented) args.push('bottom: { MedicSegmentedPicker(options: ["Opção 1", "Opção 2"], selection: $selection, onNavigationBar: true) }')
const call = `MedicTopNavigation(\n    ${args.join(',\n    ')}\n)`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-top-navigation',
  metadata: { nestable: false },
}

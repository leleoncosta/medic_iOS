// url=https://www.figma.com/design/NdxangiWk18nefmJvebkTW/Design-System---iOS?node-id=10-3985
// source=Sources/MedicDesignSystem/Components/MedicMessageBubble.swift
// component=MedicMessageBubble
import figma from 'figma'
const instance = figma.selectedInstance

const type = instance.getEnum('Type', { Sender: 'sender', Recipient: 'recipient', 'Group Recipient': 'group' })
const msgInfo = instance.getEnum('Msg. Info', { True: true, False: false })
const delivery = instance.getEnum('Delivery', { True: true, False: false })
const tail = instance.getEnum('Tail', { True: true, False: false })

function textOf(layerName: string, fallback: string): string {
  const layer = instance.findText(layerName, { traverseInstances: true })
  return layer.type === 'TEXT' ? layer.textContent : fallback
}
const message = textOf('✏️ Message', 'Mensagem')
const sendTime = textOf('Send Time', 'Ontem 9:41')
const status = textOf('Delivery Status', 'Lida 10:02')
const sender = textOf('✏️ Sender', 'Remetente')

const kind = type === 'group' ? `.groupRecipient(senderName: "${sender}", avatar: nil)` : `.${type}`
const args = [`"${message}"`, `kind: ${kind}`]
if (msgInfo && type !== 'group') args.push(`sendTime: "${sendTime}"`)
if (delivery && type === 'sender') args.push(`deliveryStatus: "${status}"`)
if (!tail) args.push('showsTail: false')
const call = `MedicMessageBubble(${args.join(', ')})`

export default {
  example: figma.code`${call}`,
  imports: ['import MedicDesignSystem'],
  id: 'medic-message-bubble',
  metadata: { nestable: false },
}

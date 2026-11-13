import SwiftUI

/// Figma: MessageBubble (10:3985) e MessageBubble-avatar (10:3956). Type = Sender | Recipient | Group Recipient;
/// Msg. Info (hora de envio), Delivery (status de entrega), Tail (cauda).
/// Balão com raio 18, padding 6/12, texto Body. Sender: `messages/bubble-sent-bg` com texto `text/on-primary`;
/// Recipient: `messages/bubble-received-bg` com texto `text/primary`. Largura máxima 267 pt (305 no grupo).
/// Use para conversa entre duas partes (paciente e equipe). Para aviso de sistema, use `MedicNotification`.
///
/// Aproximação: a cauda é representada pelo canto inferior do lado do remetente com raio pequeno (4 pt);
/// o desenho vetorial da cauda do Figma não foi reproduzido.
public enum MedicMessageKind {
    case sender
    case recipient
    case groupRecipient(senderName: String, avatar: Image?)
}

public struct MedicMessageBubble: View {
    private let text: String
    private let kind: MedicMessageKind
    private let sendTime: String?
    private let deliveryStatus: String?
    private let showsTail: Bool

    public init(
        _ text: String,
        kind: MedicMessageKind = .sender,
        sendTime: String? = nil,
        deliveryStatus: String? = nil,
        showsTail: Bool = true
    ) {
        self.text = text; self.kind = kind; self.sendTime = sendTime
        self.deliveryStatus = deliveryStatus; self.showsTail = showsTail
    }

    private var isSender: Bool { if case .sender = kind { return true } else { return false } }

    private var maxWidth: CGFloat {
        if case .groupRecipient = kind { return 305 }
        return 267
    }

    public var body: some View {
        VStack(alignment: isSender ? .trailing : .leading, spacing: 8) {
            if let sendTime {
                Text(sendTime).medicText(.caption2Regular).foregroundStyle(MedicColor.translucentTextStrong)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            if case let .groupRecipient(name, _) = kind {
                Text(name).medicText(.caption2Regular).foregroundStyle(MedicColor.translucentTextStrong)
                    .padding(.leading, 42)
            }
            HStack(alignment: .bottom, spacing: 12) {
                if case let .groupRecipient(_, avatar) = kind { avatarView(avatar) }
                bubble
            }
            if let deliveryStatus {
                Text(deliveryStatus).medicText(.caption2Regular).foregroundStyle(MedicColor.translucentTextSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: isSender ? .trailing : .leading)
        .padding(.horizontal, MedicSpace.space8)
    }

    private var bubble: some View {
        Text(text)
            .medicText(.bodyRegular)
            .foregroundStyle(isSender ? MedicColor.textOnPrimary : MedicColor.textPrimary)
            .padding(.horizontal, MedicSpace.space6)
            .padding(.vertical, MedicSpace.space3)
            .background(
                isSender ? MedicColor.messagesBubbleSentBg : MedicColor.messagesBubbleReceivedBg,
                in: BubbleShape(tailOnRight: isSender, hasTail: showsTail)
            )
            .frame(maxWidth: maxWidth - (isGroup ? 42 : 0), alignment: isSender ? .trailing : .leading)
    }

    private var isGroup: Bool { if case .groupRecipient = kind { return true } else { return false } }

    private func avatarView(_ avatar: Image?) -> some View {
        Group {
            if let avatar { avatar.resizable().scaledToFill() }
            else { MedicColor.surfaceTertiary }
        }
        .frame(width: 30, height: 30)
        .clipShape(Circle())
        .accessibilityHidden(true)
    }
}

/// Retângulo com raio 18, e raio 4 no canto inferior do lado da "cauda".
private struct BubbleShape: Shape {
    let tailOnRight: Bool
    let hasTail: Bool

    func path(in rect: CGRect) -> Path {
        let big: CGFloat = 18, small: CGFloat = 4
        let br = (hasTail && tailOnRight) ? small : big
        let bl = (hasTail && !tailOnRight) ? small : big
        var p = Path()
        p.move(to: CGPoint(x: rect.minX + big, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX - big, y: rect.minY))
        p.addRelativeArc(center: CGPoint(x: rect.maxX - big, y: rect.minY + big), radius: big, startAngle: .degrees(-90), delta: .degrees(90))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - br))
        p.addRelativeArc(center: CGPoint(x: rect.maxX - br, y: rect.maxY - br), radius: br, startAngle: .degrees(0), delta: .degrees(90))
        p.addLine(to: CGPoint(x: rect.minX + bl, y: rect.maxY))
        p.addRelativeArc(center: CGPoint(x: rect.minX + bl, y: rect.maxY - bl), radius: bl, startAngle: .degrees(90), delta: .degrees(90))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + big))
        p.addRelativeArc(center: CGPoint(x: rect.minX + big, y: rect.minY + big), radius: big, startAngle: .degrees(180), delta: .degrees(90))
        p.closeSubpath()
        return p
    }
}

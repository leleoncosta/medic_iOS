import SwiftUI

/// Figma: Notification-incomingCall (10:4326), 359×90. Banner de chamada recebida: contato, tipo, recusar e aceitar.
/// Fundo `color-notification/incoming-call-backdrop`, raio 13 (`radius/kit-13`). Cores dos botões:
/// recusar `color-feedback/error/icon`, aceitar `color-notification/call-accept-accent`.
/// Observação: o tamanho dos glifos dos botões não foi lido no Figma (usei 16 pt).
public struct MedicIncomingCallBanner: View {
    private let name: String
    private let phoneType: String
    private let photo: Image?
    private let onDecline: () -> Void
    private let onAccept: () -> Void
    @Environment(\.medicSpacing) private var spacing

    public init(
        name: String,
        phoneType: String = "mobile",
        photo: Image? = nil,
        onDecline: @escaping () -> Void,
        onAccept: @escaping () -> Void
    ) {
        self.name = name; self.phoneType = phoneType; self.photo = photo
        self.onDecline = onDecline; self.onAccept = onAccept
    }

    public var body: some View {
        HStack(spacing: 20) {
            HStack(spacing: spacing.gapStackLg) {
                avatar
                VStack(alignment: .leading, spacing: spacing.gapInlineXs) {
                    Text(name).medicText(.title3Regular).foregroundStyle(MedicColor.textOnPrimary).lineLimit(1)
                    // O fundo do banner é escuro nos dois temas. `translucent/text-secondary` escurece no tema claro e some sobre ele;
                    // por isso usamos o valor claro (o Dark do token: #EBEBF5 a 60%) nos dois temas.
                    Text(phoneType).medicText(.title3Regular).foregroundStyle(Color(hex: 0xEBEBF5, alpha: 0.6))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 14) {
                callButton(systemImage: "phone.down.fill", fill: MedicColor.feedbackErrorIcon, label: "Recusar", action: onDecline)
                callButton(systemImage: "phone.fill", fill: MedicColor.notificationCallAcceptAccent, label: "Aceitar", action: onAccept)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(MedicColor.notificationIncomingCallBackdrop, in: RoundedRectangle(cornerRadius: spacing.radiusKit13))
    }

    private var avatar: some View {
        Group {
            if let photo {
                photo.resizable().scaledToFill()
            } else {
                ZStack {
                    MedicColor.surfaceTertiary
                    Image(systemName: "person.fill").foregroundStyle(MedicColor.iconSecondary)
                }
            }
        }
        .frame(width: 45, height: 45)
        .clipShape(Circle())
        .accessibilityHidden(true)
    }

    private func callButton(systemImage: String, fill: Color, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 16))
                .foregroundStyle(MedicColor.surfaceElevated)
                .frame(width: 36, height: 36)
                .background(fill, in: Circle())
        }
        .buttonStyle(MedicUndimmedButtonStyle())
        .accessibilityLabel(label)
    }
}

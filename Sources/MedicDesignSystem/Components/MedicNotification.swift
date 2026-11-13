import SwiftUI

/// Figma: Notification (10:4357). Type = Default | Image | Stacked | Pressed | Pressed Image (Options não incluso).
/// Banner in-app de 355 pt: ícone de 38 pt (raio 10), título + hora, descrição, miniatura opcional (32×36).
/// Use para uma atualização passiva que não exige ação imediata (o usuário pode ignorar).
/// Se exige decisão antes de continuar, é caso de Alert nativo (ver AGENTS.md).
/// - Pressed: automático quando há `action` (sobreposição `state-pressed-overlay`; o Figma não detalha o estado).
/// - Stacked: faixa de 8 pt atrás do banner (`isStacked`), indicando mais notificações.
public struct MedicNotification: View {
    private let title: String
    private let message: String
    private let time: String?
    private let appIcon: Image?
    private let imagePreview: Image?
    private let isStacked: Bool
    private let action: (() -> Void)?
    @Environment(\.medicSpacing) private var spacing

    public init(
        title: String,
        message: String,
        time: String? = nil,
        appIcon: Image? = nil,
        imagePreview: Image? = nil,
        isStacked: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title; self.message = message; self.time = time
        self.appIcon = appIcon; self.imagePreview = imagePreview
        self.isStacked = isStacked; self.action = action
    }

    private var content: some View {
        HStack(alignment: .center, spacing: MedicSpace.space5) {
            icon
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: MedicSpace.space5) {
                    Text(title).medicText(.subheadlineSemibold).foregroundStyle(MedicColor.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let time { Text(time).medicText(.footnoteRegular).foregroundStyle(MedicColor.textPrimary) }
                }
                Text(message).medicText(.footnoteRegular).foregroundStyle(MedicColor.textPrimary)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            if let imagePreview {
                imagePreview.resizable().scaledToFill().frame(width: 32, height: 36).clipped()
            }
        }
        .padding(MedicSpace.space5)
        .frame(maxWidth: .infinity)
        .background(MedicColor.surfaceElevated, in: RoundedRectangle(cornerRadius: MedicSpace.space8))
    }

    private var icon: some View {
        Group {
            if let appIcon {
                appIcon.resizable().scaledToFill()
            } else {
                MedicColor.surfaceTertiary
            }
        }
        .frame(width: 38, height: 38)
        .clipShape(RoundedRectangle(cornerRadius: MedicSpace.space5))
        .accessibilityHidden(true)
    }

    public var body: some View {
        Group {
            if let action {
                Button(action: action) { content }.buttonStyle(NotificationPressStyle())
            } else {
                content
            }
        }
        .background(alignment: .bottom) {
            if isStacked {
                RoundedRectangle(cornerRadius: MedicSpace.space8)
                    .fill(MedicColor.surfaceSecondary)
                    .padding(.horizontal, MedicSpace.space5)
                    .offset(y: 8)
            }
        }
        .padding(.bottom, isStacked ? 8 : 0)
    }

    private struct NotificationPressStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label.overlay {
                if configuration.isPressed {
                    RoundedRectangle(cornerRadius: MedicSpace.space8).fill(MedicColor.translucentStatePressedOverlay)
                }
            }
        }
    }
}

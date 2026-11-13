import SwiftUI

/// Figma: Empty State (3004:28). Estado vazio para listas, buscas e telas sem conteúdo.
/// Size = Large (tela inteira: círculo de 80, Title-3/Semibold) | Compact (dentro de cartão ou seção:
/// círculo de 56, Headline/Semibold). Ícone padrão `doc.text.fill`; ação opcional (botão Primary Regular).
public enum MedicEmptyStateSize { case large, compact }

public struct MedicEmptyState: View {
    private let title: String
    private let message: String?
    private let systemImage: String?
    private let size: MedicEmptyStateSize
    private let actionTitle: String?
    private let action: (() -> Void)?
    @Environment(\.medicSpacing) private var spacing

    /// - Parameters:
    ///   - systemImage: nome do SF Symbol; `nil` esconde o ícone (Show Icon do Figma).
    ///   - actionTitle / action: mostram o botão de ação (Show Action do Figma).
    public init(
        _ title: String,
        message: String? = nil,
        systemImage: String? = "doc.text.fill",
        size: MedicEmptyStateSize = .large,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title; self.message = message; self.systemImage = systemImage
        self.size = size; self.actionTitle = actionTitle; self.action = action
    }

    private var circle: CGFloat { size == .large ? 80 : 56 }

    public var body: some View {
        VStack(spacing: size == .large ? spacing.gapStackLg : spacing.gapStackMd) {
            if let systemImage {
                ZStack {
                    Circle().fill(MedicColor.surfaceSecondary)
                    MedicIcon(systemImage)
                }
                .frame(width: circle, height: circle)
            }
            Text(title)
                .medicText(size == .large ? .title3Semibold : .headlineSemibold)
                .foregroundStyle(MedicColor.textPrimary)
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)
            if let message {
                Text(message)
                    .medicText(.subheadlineRegular)
                    .foregroundStyle(MedicColor.textSecondary)
                    .multilineTextAlignment(.center)
            }
            if let actionTitle {
                MedicButton(actionTitle, kind: .primary, size: .regular) { action?() }
            }
        }
        .padding(spacing.paddingComponentXl)
        .frame(maxWidth: .infinity)
    }
}

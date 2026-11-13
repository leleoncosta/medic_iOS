import SwiftUI

/// Figma: Button (2990:150). Type = Primary | Secondary | Destructive | Ghost; State = Default | Pressed | Disabled; Size = Large | Regular.
public enum MedicButtonKind { case primary, secondary, destructive, ghost }
public enum MedicButtonSize { case large, regular }

public struct MedicButton: View {
    private let title: String
    private let kind: MedicButtonKind
    private let size: MedicButtonSize
    private let leadingSystemImage: String?
    private let trailingSystemImage: String?
    private let fullWidth: Bool
    private let action: () -> Void

    /// - Parameters:
    ///   - size: `.large` (48 pt, ação principal da tela) ou `.regular` (44 pt).
    ///   - fullWidth: largura cheia (recomendado para a ação principal com `.large`).
    ///   - leadingSystemImage / trailingSystemImage: nome de SF Symbol (Show Leading/Trailing Icon do Figma).
    public init(
        _ title: String,
        kind: MedicButtonKind = .primary,
        size: MedicButtonSize = .large,
        leadingSystemImage: String? = nil,
        trailingSystemImage: String? = nil,
        fullWidth: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title; self.kind = kind; self.size = size
        self.leadingSystemImage = leadingSystemImage; self.trailingSystemImage = trailingSystemImage
        self.fullWidth = fullWidth; self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let leadingSystemImage { Image(systemName: leadingSystemImage).font(.system(size: 22)) }
                Text(title).medicText(size == .large ? .headlineSemibold : .calloutMedium)
                if let trailingSystemImage { Image(systemName: trailingSystemImage).font(.system(size: 22)) }
            }
        }
        .buttonStyle(MedicButtonStyle(kind: kind, size: size, fullWidth: fullWidth))
    }
}

struct MedicButtonStyle: ButtonStyle {
    let kind: MedicButtonKind
    let size: MedicButtonSize
    let fullWidth: Bool

    func makeBody(configuration: Configuration) -> some View {
        Body(configuration: configuration, kind: kind, size: size, fullWidth: fullWidth)
    }

    private struct Body: View {
        let configuration: Configuration
        let kind: MedicButtonKind
        let size: MedicButtonSize
        let fullWidth: Bool
        @Environment(\.isEnabled) private var isEnabled
        @Environment(\.medicSpacing) private var spacing

        private var pressed: Bool { configuration.isPressed }

        private var background: Color {
            guard isEnabled else {
                switch kind {
                case .primary, .destructive: return MedicColor.actionPrimaryBgDisabled
                case .secondary: return MedicColor.actionSecondaryBg
                case .ghost: return .clear
                }
            }
            switch kind {
            case .primary: return pressed ? MedicColor.actionPrimaryBgPressed : MedicColor.actionPrimaryBg
            case .secondary: return pressed ? MedicColor.actionSecondaryBgHover : MedicColor.actionSecondaryBg
            case .destructive: return pressed ? MedicColor.actionDestructiveBgHover : MedicColor.actionDestructiveBg
            case .ghost: return pressed ? MedicColor.actionGhostBgHover : .clear
            }
        }

        private var foreground: Color {
            guard isEnabled else { return MedicColor.textDisabled }
            switch kind {
            case .primary: return MedicColor.actionPrimaryText
            case .secondary: return MedicColor.actionSecondaryText
            case .destructive: return MedicColor.actionDestructiveText
            case .ghost: return MedicColor.actionGhostText
            }
        }

        var body: some View {
            configuration.label
                .foregroundStyle(foreground)
                .padding(.horizontal, spacing.paddingComponentLg)
                .frame(maxWidth: fullWidth ? .infinity : nil)
                .frame(height: size == .large ? 48 : MedicSizing.touchMin)
                .background(background, in: RoundedRectangle(cornerRadius: spacing.radiusXl))
                .overlay {
                    if kind == .secondary {
                        RoundedRectangle(cornerRadius: spacing.radiusXl)
                            .strokeBorder(isEnabled ? MedicColor.actionSecondaryBorder : MedicColor.borderDisabled, lineWidth: 1)
                    }
                }
                .contentShape(RoundedRectangle(cornerRadius: spacing.radiusXl))
        }
    }
}

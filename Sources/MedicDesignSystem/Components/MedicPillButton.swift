import SwiftUI

/// Figma: Pill Button (135:1527). Type = Pill Button | Pill Button Two Lines (com `subtitle`);
/// State = Not Selected | Selected; Interaction = Default | Pressed (automático) | Disabled (`.disabled(true)`).
/// Use para filtro ou categoria, seleção compacta (tags, filtros de busca). **Não é uma ação**: para ações use `MedicButton`.
public struct MedicPillButton: View {
    private let title: String
    private let subtitle: String?
    private let isSelected: Bool
    private let action: () -> Void

    /// - Parameters:
    ///   - subtitle: segunda linha (ex.: data `dd/mm/aaaa`); ativa o tipo Two Lines.
    public init(_ title: String, subtitle: String? = nil, isSelected: Bool, action: @escaping () -> Void) {
        self.title = title; self.subtitle = subtitle; self.isSelected = isSelected; self.action = action
    }

    public var body: some View {
        Button(action: action) { EmptyView() }
            .buttonStyle(PillStyle(title: title, subtitle: subtitle, isSelected: isSelected))
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(subtitle.map { "\(title), \($0)" } ?? title)
            .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }

    private struct PillStyle: ButtonStyle {
        let title: String
        let subtitle: String?
        let isSelected: Bool

        func makeBody(configuration: Configuration) -> some View {
            PillContent(title: title, subtitle: subtitle, isSelected: isSelected, isPressed: configuration.isPressed)
        }
    }

    private struct PillContent: View {
        let title: String
        let subtitle: String?
        let isSelected: Bool
        let isPressed: Bool
        @Environment(\.isEnabled) private var isEnabled
        @Environment(\.medicSpacing) private var spacing

        private var background: Color {
            guard isSelected else { return MedicColor.surfaceElevated }
            return isEnabled ? MedicColor.actionPrimaryBg : MedicColor.actionPrimaryBgDisabled
        }

        private var titleColor: Color {
            if isSelected { return MedicColor.actionPrimaryText }
            return isEnabled ? MedicColor.textPrimary : MedicColor.textDisabled
        }

        private var subtitleColor: Color {
            if isSelected { return MedicColor.surfaceSecondary }
            return isEnabled ? MedicColor.translucentTextStrong : MedicColor.textDisabled
        }

        var body: some View {
            let shape = RoundedRectangle(cornerRadius: spacing.radiusLg)
            VStack(spacing: 0) {
                Text(title)
                    .medicText(isSelected || subtitle != nil ? .footnoteSemibold : .footnoteRegular)
                    .foregroundStyle(titleColor)
                if let subtitle {
                    Text(subtitle).medicText(.footnoteRegular).foregroundStyle(subtitleColor)
                }
            }
            .padding(.horizontal, subtitle == nil ? spacing.paddingComponentLg : spacing.paddingComponentSm)
            .padding(.vertical, subtitle == nil ? MedicSpace.spaceKit5 : spacing.paddingComponentSm)
            .background(background, in: shape)
            .overlay {
                if subtitle != nil && !isSelected { shape.strokeBorder(MedicColor.translucentDivider, lineWidth: 0.5) }
            }
            .overlay { if isPressed { shape.fill(MedicColor.translucentStatePressedOverlay) } }
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        }
    }
}

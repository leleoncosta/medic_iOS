import SwiftUI

/// Figma: Section Header (3003:21). Style = Grouped | Prominent.
/// Grouped: rótulo em maiúsculas (Caption-1) sobre fundo agrupado, altura 24.
/// Prominent: título em Title-3/Semibold com espaço acima, altura 49.
public enum MedicSectionHeaderStyle { case grouped, prominent }

public struct MedicSectionHeader: View {
    private let title: String
    private let style: MedicSectionHeaderStyle
    private let actionLabel: String?
    private let action: (() -> Void)?
    @Environment(\.medicSpacing) private var spacing

    /// - Parameters:
    ///   - actionLabel: texto do link à direita (Show Action do Figma). Sem ele, não há ação.
    public init(
        _ title: String,
        style: MedicSectionHeaderStyle = .grouped,
        actionLabel: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title; self.style = style; self.actionLabel = actionLabel; self.action = action
    }

    public var body: some View {
        HStack(alignment: .bottom, spacing: spacing.gapInlineMd) {
            switch style {
            case .grouped:
                Text(title.uppercased())
                    .medicText(.caption1Regular)
                    .foregroundStyle(MedicColor.translucentTextStrong)
                    .frame(maxWidth: .infinity, alignment: .leading)
            case .prominent:
                Text(title)
                    .medicText(.title3Semibold)
                    .foregroundStyle(MedicColor.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)
            }
            if let actionLabel {
                Button(actionLabel) { action?() }
                    .medicText(style == .grouped ? .caption1Medium : .subheadlineMedium)
                    .foregroundStyle(MedicColor.actionGhostText)
            }
        }
        .padding(.horizontal, spacing.paddingScreenHorizontal)
        .padding(.top, style == .prominent ? spacing.paddingScreenHorizontal : 0)
        .padding(.bottom, spacing.paddingComponentSm)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

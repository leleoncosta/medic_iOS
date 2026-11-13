import SwiftUI

/// Figma: Badge (2994:268). Type = Info | Success | Warning | Error | Neutral; Style = Soft | Strong.
/// Use para a situação de um registro (ex.: situação do paciente), não para contagem de notificações.
public enum MedicBadgeType { case info, success, warning, error, neutral }
public enum MedicBadgeStyle { case soft, strong }

public struct MedicBadge: View {
    private let label: String
    private let type: MedicBadgeType
    private let style: MedicBadgeStyle
    private let showDot: Bool
    @Environment(\.medicSpacing) private var spacing

    public init(_ label: String, type: MedicBadgeType = .info, style: MedicBadgeStyle = .soft, showDot: Bool = false) {
        self.label = label; self.type = type; self.style = style; self.showDot = showDot
    }

    private var colors: (background: Color, dot: Color, text: Color) {
        switch (type, style) {
        case (.info, .soft): return (MedicColor.feedbackInfoBg, MedicColor.feedbackInfoIcon, MedicColor.feedbackInfoText)
        case (.info, .strong): return (MedicColor.feedbackInfoBgStrong, MedicColor.feedbackInfoOnStrong, MedicColor.feedbackInfoOnStrong)
        case (.success, .soft): return (MedicColor.feedbackSuccessBg, MedicColor.feedbackSuccessIcon, MedicColor.feedbackSuccessText)
        case (.success, .strong): return (MedicColor.feedbackSuccessBgStrong, MedicColor.feedbackSuccessOnStrong, MedicColor.feedbackSuccessOnStrong)
        case (.warning, .soft): return (MedicColor.feedbackWarningBg, MedicColor.feedbackWarningIcon, MedicColor.feedbackWarningText)
        case (.warning, .strong): return (MedicColor.feedbackWarningBgStrong, MedicColor.feedbackWarningOnStrong, MedicColor.feedbackWarningOnStrong)
        case (.error, .soft): return (MedicColor.feedbackErrorBg, MedicColor.feedbackErrorIcon, MedicColor.feedbackErrorText)
        case (.error, .strong): return (MedicColor.feedbackErrorBgStrong, MedicColor.feedbackErrorOnStrong, MedicColor.feedbackErrorOnStrong)
        case (.neutral, .soft): return (MedicColor.surfaceTertiary, MedicColor.textTertiary, MedicColor.textPrimary)
        case (.neutral, .strong): return (MedicColor.surfaceInverse, MedicColor.textInverse, MedicColor.textInverse)
        }
    }

    public var body: some View {
        HStack(spacing: spacing.gapInlineSm) {
            if showDot { Circle().fill(colors.dot).frame(width: 6, height: 6) }
            Text(label).medicText(.caption1Medium).foregroundStyle(colors.text)
        }
        .padding(.horizontal, spacing.paddingComponentSm)
        .padding(.vertical, spacing.gapInlineXs)
        .background(colors.background, in: Capsule())
    }
}

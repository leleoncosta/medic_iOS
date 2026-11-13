import SwiftUI

/// Figma: TableRow (novo) (2982:265). Style = Default | Destructive; State = Default | Pressed | Disabled.
/// - Pressed: sobreposição `color-translucent/state-pressed-overlay` (aplicada quando há `action`).
/// - Disabled: use `.disabled(true)` (textos em `color-text/disabled`).
/// - Não inclui o "Slide Action" (Delete / Action) do Figma: em listas SwiftUI use `.swipeActions`.
public struct MedicTableRow<Leading: View>: View {
    private let title: String
    private let subtitle: String?
    private let detail: String?
    private let rightLabel: String?
    private let date: String?
    private let showChevron: Bool
    private let trailingSystemImage: String?
    private let showSeparator: Bool
    private let isDestructive: Bool
    private let action: (() -> Void)?
    private let leading: Leading

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.medicSpacing) private var spacing

    public init(
        _ title: String,
        subtitle: String? = nil,
        detail: String? = nil,
        rightLabel: String? = nil,
        date: String? = nil,
        showChevron: Bool = false,
        trailingSystemImage: String? = nil,
        showSeparator: Bool = true,
        isDestructive: Bool = false,
        action: (() -> Void)? = nil,
        @ViewBuilder leading: () -> Leading
    ) {
        self.title = title; self.subtitle = subtitle; self.detail = detail
        self.rightLabel = rightLabel; self.date = date; self.showChevron = showChevron
        self.trailingSystemImage = trailingSystemImage; self.showSeparator = showSeparator
        self.isDestructive = isDestructive; self.action = action; self.leading = leading()
    }

    private var secondaryColor: Color {
        isEnabled ? MedicColor.translucentTextStrong : MedicColor.textDisabled
    }

    private var titleColor: Color {
        guard isEnabled else { return MedicColor.textDisabled }
        return isDestructive ? MedicColor.actionDestructiveBg : MedicColor.textPrimary
    }

    private var rowContent: some View {
        VStack(spacing: 0) {
            HStack(spacing: spacing.gapInlineMd) {
                leading
                    .padding(.vertical, MedicSpace.spaceKit11)
                VStack(alignment: .leading, spacing: 0) {
                    Text(title).medicText(.bodyRegular).foregroundStyle(titleColor)
                    if let subtitle { Text(subtitle).medicText(.footnoteRegular).foregroundStyle(secondaryColor) }
                    if let detail { Text(detail).medicText(.footnoteRegular).foregroundStyle(secondaryColor) }
                }
                .padding(.vertical, MedicSpace.spaceKit11)
                .frame(maxWidth: .infinity, alignment: .leading)
                if let rightLabel { Text(rightLabel).medicText(.footnoteRegular).foregroundStyle(secondaryColor) }
                if let date { Text(date).medicText(.footnoteRegular).foregroundStyle(secondaryColor) }
                if let trailingSystemImage {
                    Image(systemName: trailingSystemImage).font(.system(size: 22))
                        .foregroundStyle(isEnabled ? MedicColor.iconDefault : MedicColor.textDisabled)
                }
                if showChevron {
                    Image(systemName: "chevron.right").font(.system(size: 22))
                        .foregroundStyle(MedicColor.translucentDivider)
                }
            }
            .padding(.trailing, spacing.paddingScreenHorizontal)
            .frame(minHeight: MedicSizing.touchMin)

            if showSeparator {
                Rectangle().fill(MedicColor.borderDefault).frame(height: 0.5)
            }
        }
        .padding(.leading, spacing.paddingScreenHorizontal)
        .background(MedicColor.surfacePrimary)
    }

    public var body: some View {
        if let action {
            Button(action: action) { rowContent }
                .buttonStyle(MedicRowPressStyle())
        } else {
            rowContent
        }
    }
}

public extension MedicTableRow where Leading == EmptyView {
    init(
        _ title: String,
        subtitle: String? = nil,
        detail: String? = nil,
        rightLabel: String? = nil,
        date: String? = nil,
        showChevron: Bool = false,
        trailingSystemImage: String? = nil,
        showSeparator: Bool = true,
        isDestructive: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.init(
            title, subtitle: subtitle, detail: detail, rightLabel: rightLabel, date: date,
            showChevron: showChevron, trailingSystemImage: trailingSystemImage,
            showSeparator: showSeparator, isDestructive: isDestructive, action: action
        ) { EmptyView() }
    }
}

/// Estado Pressed da linha: sobreposição translúcida do token `color-translucent/state-pressed-overlay`.
public struct MedicRowPressStyle: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                if configuration.isPressed { MedicColor.translucentStatePressedOverlay }
            }
    }
}

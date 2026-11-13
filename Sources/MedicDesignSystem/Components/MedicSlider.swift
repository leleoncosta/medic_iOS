import SwiftUI

/// Figma: Slider (10:3772), 375×44. Icons = False (só a barra) | True (com ícones nas extremidades).
/// Trilho de 4 pt em `color-translucent/fill-tertiary`, parte preenchida em `color-feedback/info/icon`,
/// knob de 28 pt em `color-surface/elevated`. Sem estado Disabled no Figma.
/// Use para valor contínuo dentro de um intervalo (volume, brilho, dosagem). Para binário, use `MedicSwitch`.
public struct MedicSlider: View {
    @Binding private var value: Double
    private let range: ClosedRange<Double>
    private let minimumValueImage: String?
    private let maximumValueImage: String?
    private let accessibilityLabelText: String
    @Environment(\.medicSpacing) private var spacing
    @Environment(\.isEnabled) private var isEnabled

    private let knob: CGFloat = 28

    /// - Parameters:
    ///   - minimumValueImage / maximumValueImage: SF Symbols das extremidades (Icons = True; ex.: `speaker.wave.1` e `speaker.wave.3`).
    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        minimumValueImage: String? = nil,
        maximumValueImage: String? = nil,
        label: String = ""
    ) {
        self._value = value
        self.range = range
        self.minimumValueImage = minimumValueImage
        self.maximumValueImage = maximumValueImage
        self.accessibilityLabelText = label
    }

    private var fraction: Double {
        let span = range.upperBound - range.lowerBound
        guard span > 0 else { return 0 }
        return min(max((value - range.lowerBound) / span, 0), 1)
    }

    public var body: some View {
        HStack(spacing: spacing.gapStackLg) {
            if let minimumValueImage { sideIcon(minimumValueImage) }
            track
            if let maximumValueImage { sideIcon(maximumValueImage) }
        }
        .padding(.horizontal, spacing.paddingScreenHorizontal)
        .padding(.vertical, spacing.paddingComponentSm)
        .frame(minHeight: MedicSizing.touchMin)
    }

    private func sideIcon(_ name: String) -> some View {
        Image(systemName: name)
            .font(.system(size: 22))
            .foregroundStyle(MedicColor.translucentDivider)
            .accessibilityHidden(true)
    }

    private var track: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let travel = max(width - knob, 1)
            let x = fraction * travel
            ZStack(alignment: .leading) {
                Capsule().fill(MedicColor.translucentFillTertiary).frame(height: 4)
                // Preenchimento vai até a borda direita do knob (Figma: 128 pt com o knob em x = 100).
                Capsule().fill(MedicColor.feedbackInfoIcon).frame(width: x + knob, height: 4)
                Circle()
                    .fill(MedicColor.surfaceElevated)
                    .frame(width: knob, height: knob)
                    .shadow(color: .black.opacity(0.12), radius: 6.5, x: 0, y: 6)
                    .shadow(color: .black.opacity(0.12), radius: 2, x: 0, y: 0.5)
                    .offset(x: x)
            }
            .frame(height: knob)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0).onChanged { drag in
                    guard isEnabled else { return }
                    let f = min(max((drag.location.x - knob / 2) / travel, 0), 1)
                    value = range.lowerBound + f * (range.upperBound - range.lowerBound)
                }
            )
        }
        .frame(height: knob)
        .accessibilityElement()
        .accessibilityLabel(accessibilityLabelText)
        .accessibilityValue("\(Int((fraction * 100).rounded())) por cento")
        .accessibilityAdjustableAction { direction in
            let step = (range.upperBound - range.lowerBound) * 0.1
            switch direction {
            case .increment: value = min(value + step, range.upperBound)
            case .decrement: value = max(value - step, range.lowerBound)
            @unknown default: break
            }
        }
    }
}

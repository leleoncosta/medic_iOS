import SwiftUI

/// Base visual compartilhada por `MedicCheckbox` e `MedicRadio`.
/// Figma: Checkbox (3007:27) e Radio (3007:43). Linha de 44 pt de altura mínima, gap 12, caixa de 22 pt.
struct MedicSelectionControl: View {
    enum Kind { case checkbox, radio }

    let kind: Kind
    let isSelected: Bool
    let isIndeterminate: Bool
    let label: String?
    let isPressed: Bool

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.isFocused) private var isFocused
    @Environment(\.medicSpacing) private var spacing

    private var filled: Bool { isSelected || isIndeterminate }

    private var fill: Color {
        if filled { return isEnabled ? MedicColor.actionPrimaryBg : MedicColor.actionPrimaryBgDisabled }
        return isEnabled ? MedicColor.inputBg : MedicColor.inputBgDisabled
    }

    /// Contorno: foco (2 pt) tem precedência; sem preenchimento usa a borda do campo (1,5 pt).
    private var stroke: (color: Color, width: CGFloat)? {
        if isFocused && isEnabled { return (MedicColor.inputBorderFocus, 2) }
        if !filled { return (isEnabled ? MedicColor.inputBorder : MedicColor.inputBorderDisabled, 1.5) }
        return nil
    }

    var body: some View {
        HStack(spacing: spacing.paddingComponentMd) {
            box
            if let label {
                Text(label)
                    .medicText(.bodyRegular)
                    .foregroundStyle(isEnabled ? MedicColor.textPrimary : MedicColor.inputTextDisabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(minHeight: MedicSizing.touchMin)
        .contentShape(Rectangle())
    }

    @ViewBuilder
    private var box: some View {
        if kind == .checkbox {
            layers(RoundedRectangle(cornerRadius: spacing.radiusKit693))
        } else {
            layers(Circle())
        }
    }

    // Genérico em InsettableShape: `AnyShape` não oferece `strokeBorder`.
    private func layers<S: InsettableShape>(_ shape: S) -> some View {
        ZStack {
            shape.fill(fill)
            if let stroke { shape.strokeBorder(stroke.color, lineWidth: stroke.width) }
            glyph
            if isPressed { shape.fill(MedicColor.translucentStatePressedOverlay) }
        }
        .frame(width: 22, height: 22)
    }

    @ViewBuilder
    private var glyph: some View {
        switch kind {
        case .checkbox where isIndeterminate:
            Path { p in p.move(to: CGPoint(x: 6, y: 11)); p.addLine(to: CGPoint(x: 16, y: 11)) }
                .stroke(MedicColor.actionPrimaryText, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        case .checkbox where isSelected:
            Path { p in
                p.move(to: CGPoint(x: 5.5, y: 11.5))
                p.addLine(to: CGPoint(x: 9.5, y: 15.5))
                p.addLine(to: CGPoint(x: 16.5, y: 7))
            }
            .stroke(MedicColor.actionPrimaryText, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        case .radio where isSelected:
            Circle().fill(MedicColor.actionPrimaryText).frame(width: 8, height: 8)
        default:
            EmptyView()
        }
    }
}

struct MedicSelectionStyle: ButtonStyle {
    let kind: MedicSelectionControl.Kind
    let isSelected: Bool
    let isIndeterminate: Bool
    let label: String?

    func makeBody(configuration: Configuration) -> some View {
        MedicSelectionControl(
            kind: kind, isSelected: isSelected, isIndeterminate: isIndeterminate,
            label: label, isPressed: configuration.isPressed
        )
    }
}

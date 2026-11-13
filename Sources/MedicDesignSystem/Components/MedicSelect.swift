import SwiftUI

/// Figma: Select (71:1217). Seleção em círculo usada no TableRow-Leading (Type = Select).
/// Selected = False | True; State = Default | Disabled (`.disabled(true)` no contêiner).
/// É só o indicador visual (22 pt): quem usa trata o toque. Para escolha única com rótulo, use `MedicRadio`.
public struct MedicSelect: View {
    private let isSelected: Bool
    @Environment(\.isEnabled) private var isEnabled

    public init(isSelected: Bool) { self.isSelected = isSelected }

    public var body: some View {
        ZStack {
            if isSelected {
                Circle().fill(isEnabled ? MedicColor.actionPrimaryBgPressed : MedicColor.actionPrimaryBgDisabled)
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(MedicColor.actionPrimaryText)
            } else {
                // Anel de ~1,6 pt (22 pt externos, 18,8 pt internos no Figma).
                Circle().strokeBorder(isEnabled ? MedicColor.translucentDivider : MedicColor.borderDisabled, lineWidth: 1.6)
            }
        }
        .frame(width: 22, height: 22)
        .accessibilityHidden(true)
    }
}

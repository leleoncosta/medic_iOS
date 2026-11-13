import SwiftUI

/// Figma: Radio (3007:43). Selected = False | True; State = Default | Disabled | Pressed | Focus.
/// Botão de opção para escolha única dentro de um grupo (ex.: tipo de atendimento).
/// O grupo é de quem usa: guarde a opção escolhida e passe `isSelected` em cada `MedicRadio`.
public struct MedicRadio: View {
    private let label: String?
    private let isSelected: Bool
    private let action: () -> Void

    public init(_ label: String? = nil, isSelected: Bool, action: @escaping () -> Void) {
        self.label = label
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        Button(action: action) { EmptyView() }
            .buttonStyle(MedicSelectionStyle(kind: .radio, isSelected: isSelected, isIndeterminate: false, label: label))
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(label ?? "")
            .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }
}

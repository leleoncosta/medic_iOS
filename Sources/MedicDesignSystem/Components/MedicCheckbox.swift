import SwiftUI

/// Figma: Checkbox (3007:27). Selected = False | True | Indeterminate; State = Default | Disabled | Pressed | Focus.
/// Use para escolhas múltiplas e opções independentes (filtros, termos). Para escolha única, use `MedicRadio`.
/// - Disabled: `.disabled(true)`. Pressed: automático ao tocar. Focus: foco do teclado/Acesso por Teclado.
/// - Indeterminate: seleção parcial de um grupo; tocar marca (`isOn = true`).
public struct MedicCheckbox: View {
    @Binding private var isOn: Bool
    private let label: String?
    private let isIndeterminate: Bool

    public init(isOn: Binding<Bool>, label: String? = nil, isIndeterminate: Bool = false) {
        self._isOn = isOn
        self.label = label
        self.isIndeterminate = isIndeterminate
    }

    public var body: some View {
        Button {
            isOn = isIndeterminate ? true : !isOn
        } label: {
            EmptyView()
        }
        .buttonStyle(MedicSelectionStyle(kind: .checkbox, isSelected: isOn, isIndeterminate: isIndeterminate, label: label))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label ?? "")
        .accessibilityValue(isIndeterminate ? "Parcial" : (isOn ? "Marcado" : "Desmarcado"))
        .accessibilityAddTraits(isOn ? [.isButton, .isSelected] : .isButton)
    }
}

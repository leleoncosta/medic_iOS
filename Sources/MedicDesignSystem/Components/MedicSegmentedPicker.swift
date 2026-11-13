import SwiftUI

/// Figma: SegmentedPicker (2611:5973) e _SegmentedPicker-option (2611:5933). 2 a 4 opções; Selected = qual segmento.
/// Altura 32 pt, trilho `color-translucent/fill-tertiary`, segmento selecionado com fundo `color-surface/elevated` (o do componente `_SegmentedPicker-option`),
/// borda de 0,5 pt a 4% e a sombra `Control/Segmented-Thumb`.
/// Use para alternar visões do MESMO conteúdo (2 a 5 opções); para seções do app, use `MedicTabBar`.
public struct MedicSegmentedPicker: View {
    private let options: [String]
    @Binding private var selection: Int
    private let onNavigationBar: Bool
    @Environment(\.medicSpacing) private var spacing

    /// - Parameters:
    ///   - selection: índice (0-based) do segmento selecionado.
    ///   - onNavigationBar: versão "+ Nav" do Figma, para uso dentro da barra de navegação:
    ///     o texto dos segmentos NÃO selecionados fica branco (`neutral-0`); só use sobre fundo escuro.
    public init(options: [String], selection: Binding<Int>, onNavigationBar: Bool = false) {
        self.options = options
        self._selection = selection
        self.onNavigationBar = onNavigationBar
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id: \.self) { index in
                segment(index)
            }
        }
        .padding(2)
        .frame(height: 32)
        .background(MedicColor.translucentFillTertiary, in: RoundedRectangle(cornerRadius: spacing.radiusKit891))
        .animation(.easeInOut(duration: MedicMotion.durationQuick), value: selection)
    }

    private func segment(_ index: Int) -> some View {
        let selected = index == selection
        return Button { selection = index } label: {
            Text(options[index])
                .medicText(selected ? .footnoteSemibold : .footnoteRegular)
                .foregroundStyle(selected || !onNavigationBar ? MedicColor.textPrimary : MedicPalette.neutral0)
                .lineLimit(1)
                .padding(.horizontal, 6)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    if selected {
                        RoundedRectangle(cornerRadius: spacing.radiusKit693)
                            .fill(MedicColor.surfaceElevated)
                            .overlay(RoundedRectangle(cornerRadius: spacing.radiusKit693).strokeBorder(Color.black.opacity(0.04), lineWidth: 0.5))
                            .shadow(color: .black.opacity(0.04), radius: 0.5, x: 0, y: 3)
                            .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 3)
                    }
                }
                .overlay(alignment: .trailing) {
                    // Divisória entre dois segmentos vizinhos que não estão selecionados.
                    if index < options.count - 1 && selection != index && selection != index + 1 {
                        Rectangle().fill(MedicColor.translucentDivider).frame(width: 1, height: 16)
                    }
                }
                .contentShape(Rectangle())
        }
        .buttonStyle(MedicUndimmedButtonStyle())
        .accessibilityAddTraits(selected ? [.isButton, .isSelected] : .isButton)
    }
}

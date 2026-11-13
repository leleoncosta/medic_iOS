import SwiftUI

/// Figma: SearchField (10:915). Type = Default (campo com lupa) | Cancel (campo + botão Cancelar à direita).
/// Altura 36 pt, raio 10, preenchimento `color-translucent/fill-tertiary`; lupa e texto de apoio em
/// `color-translucent/text-secondary`. Para texto livre em formulário, use `MedicTextField`.
public struct MedicSearchField: View {
    @Binding private var text: String
    private let placeholder: String
    private let trailingSystemImage: String?
    private let background: Color
    private let cancelTitle: String
    private let onCancel: (() -> Void)?
    @Environment(\.medicSpacing) private var spacing

    /// - Parameters:
    ///   - trailingSystemImage: ícone à direita do campo (ex.: `barcode.viewfinder`, como no Figma).
    ///   - background: `color-translucent/fill-tertiary` por padrão; a barra de navegação usa `surface/primary`.
    ///   - onCancel: se informado, mostra o botão de cancelar (Type = Cancel do Figma).
    public init(
        text: Binding<String>,
        placeholder: String = "Search",
        trailingSystemImage: String? = nil,
        background: Color = MedicColor.translucentFillTertiary,
        cancelTitle: String = "Cancel",
        onCancel: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.trailingSystemImage = trailingSystemImage
        self.background = background
        self.cancelTitle = cancelTitle
        self.onCancel = onCancel
    }

    public var body: some View {
        HStack(spacing: 14) {
            field
            if let onCancel {
                Button(cancelTitle, action: onCancel)
                    .medicText(.bodyRegular)
                    .foregroundStyle(MedicColor.actionDestructiveTextSubtle)
            }
        }
        .padding(.trailing, onCancel == nil ? 0 : spacing.paddingComponentMd)
    }

    private var field: some View {
        HStack(spacing: spacing.gapStackXs) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15))
                .foregroundStyle(MedicColor.translucentTextSecondary)
                .accessibilityHidden(true)
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(MedicColor.translucentTextSecondary))
                .medicText(.bodyRegular)
                .foregroundStyle(MedicColor.textPrimary)
                .submitLabel(.search)
            if let trailingSystemImage {
                Image(systemName: trailingSystemImage)
                    .font(.system(size: 22))
                    .foregroundStyle(MedicColor.translucentTextSecondary)
                    .accessibilityHidden(true)
            }
        }
        .padding(.horizontal, spacing.paddingComponentSm)
        .frame(height: 36)
        .background(background, in: RoundedRectangle(cornerRadius: spacing.radiusKit10))
    }
}

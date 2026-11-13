import SwiftUI

/// Figma: página Custom Card. Cartão que resume um registro discreto de dado (paciente, medicação).
/// Container: raio 14 (`radius/kit-14`), fundo `color-surface/primary`, sombra suave.
/// Não sobrecarregue com muitos campos: para muito dado, use uma tela de detalhe com `MedicTableRow`.
///
/// Os cartões do Figma "Profile Icon + Two Labels", "Profile Icon + Four Labels" e "Three Labels Row"
/// são linhas de lista dentro deste container: componha `MedicCard { MedicTableRow(...) }`.
public enum MedicCardShadow {
    /// Sombra 0/0, blur 17, preto 10% (cartão Number).
    case subtle
    /// Sombra y 4, blur 64, preto 10% (cartão Card Number + Two Fields).
    case soft
    case none
}

public struct MedicCard<Content: View>: View {
    private let shadow: MedicCardShadow
    private let content: Content
    @Environment(\.medicSpacing) private var spacing

    public init(shadow: MedicCardShadow = .subtle, @ViewBuilder content: () -> Content) {
        self.shadow = shadow
        self.content = content()
    }

    public var body: some View {
        let shape = RoundedRectangle(cornerRadius: spacing.radiusKit14)
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(MedicColor.surfacePrimary, in: shape)
            .clipShape(shape)
            .shadow(color: .black.opacity(shadow == .none ? 0 : 0.1), radius: shadow == .soft ? 32 : 8.5, x: 0, y: shadow == .soft ? 4 : 0)
    }
}

/// Figma: Card / Number (219:1643). Rótulo de cabeçalho, título e um valor grande em `color-text/brand`.
/// O valor usa 32 pt Semibold (sem estilo de texto no Figma; altura de linha 37, espaçamento 0 assumido).
public struct MedicNumberCard: View {
    private let label: String
    private let title: String
    private let value: String

    public init(label: String, title: String, value: String) {
        self.label = label; self.title = title; self.value = value
    }

    private static let valueStyle = MedicTextStyle(size: 32, weight: .semibold, lineHeight: 37, tracking: 0)

    public var body: some View {
        MedicCard {
            VStack(alignment: .leading, spacing: 0) {
                Text(label).medicText(.footnoteRegular).foregroundStyle(MedicColor.translucentTextStrong)
                VStack(alignment: .leading, spacing: MedicSpace.space4) {
                    Text(title).medicText(.caption1Medium).foregroundStyle(MedicColor.textPrimary)
                    Text(value).medicText(Self.valueStyle).foregroundStyle(MedicColor.textBrand)
                }
            }
            .padding(.horizontal, MedicSpace.space8)
            .padding(.vertical, MedicSpace.spaceKit11)
        }
        .accessibilityElement(children: .combine)
    }
}

/// Figma: Card / Profile Icon (441:1468). Avatar de 60 pt com iniciais, nome e especialidade, centralizados.
/// Sem fundo próprio (o Figma não define preenchimento); o avatar usa `color-translucent/divider`.
public struct MedicProfileCard: View {
    private let initials: String
    private let name: String
    private let subtitle: String

    public init(initials: String, name: String, subtitle: String) {
        self.initials = initials; self.name = name; self.subtitle = subtitle
    }

    public var body: some View {
        VStack(spacing: MedicSpace.space4) {
            Text(initials)
                .medicText(.bodyRegular)
                .foregroundStyle(MedicColor.textOnPrimary)
                .frame(width: 60, height: 60)
                .background(MedicColor.translucentDivider, in: Circle())
                .accessibilityHidden(true)
            VStack(spacing: 0) {
                Text(name).medicText(.headlineSemibold).foregroundStyle(MedicColor.textPrimary)
                Text(subtitle).medicText(.subheadlineRegular).foregroundStyle(MedicColor.translucentTextStrong)
            }
        }
        .padding(.horizontal, MedicSpace.space8 - 1)
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }
}

/// Figma: Card / Textarea Row (580:1531). Cabeçalho em maiúsculas (Caption-1) e uma linha de texto de várias
/// linhas em cartão (raio 14, fundo `surface/primary`). O texto de apoio usa `color-translucent/text-strong`.
public struct MedicTextAreaCard: View {
    @Binding private var text: String
    private let title: String
    private let placeholder: String
    @Environment(\.medicSpacing) private var spacing

    public init(title: String, text: Binding<String>, placeholder: String = "") {
        self.title = title; self._text = text; self.placeholder = placeholder
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title.uppercased())
                .medicText(.caption1Regular)
                .foregroundStyle(MedicColor.translucentTextStrong)
                .padding(.leading, spacing.paddingScreenHorizontal)
                .padding(.bottom, spacing.paddingComponentSm)
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(MedicColor.translucentTextStrong), axis: .vertical)
                .medicText(.bodyRegular)
                .foregroundStyle(MedicColor.textPrimary)
                .lineLimit(6...)
                .padding(.horizontal, spacing.paddingScreenHorizontal)
                .padding(.top, MedicSpace.space5)
                .padding(.bottom, spacing.paddingComponentMd)
                .frame(minHeight: 181, alignment: .topLeading)
                .background(MedicColor.surfacePrimary, in: RoundedRectangle(cornerRadius: spacing.radiusKit14))
        }
    }
}

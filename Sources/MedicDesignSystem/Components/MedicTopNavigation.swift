import SwiftUI

/// Figma: TopNavigation (10:980). Barra de navegação sobre `color-nav/bar-bg`.
/// A barra de status (hora, sinal, bateria e notch) é do sistema iOS: não é desenhada aqui; a barra
/// estende o fundo sob ela pela safe area.
///
/// Combinações do `Type` do Figma:
/// - Default: `title` (+ `backTitle`/`onBack` e `trailing`)
/// - Large Title: `largeTitle`
/// - Search: `search` (campo de busca)
/// - Segmented: `bottom` (ex.: `MedicSegmentedPicker(..., onNavigationBar: true)`)
///
/// Ao passar só um dos blocos, use o rótulo: `trailing: { ... }` ou `bottom: { ... }`
/// (a closure final sem rótulo é ambígua entre os dois).
public struct MedicTopNavigation<Trailing: View, Bottom: View>: View {
    private let title: String?
    private let largeTitle: String?
    private let backTitle: String?
    private let onBack: (() -> Void)?
    private let search: Binding<String>?
    private let searchPlaceholder: String
    private let trailing: Trailing
    private let bottom: Bottom
    @Environment(\.medicSpacing) private var spacing

    public init(
        title: String? = nil,
        largeTitle: String? = nil,
        backTitle: String? = nil,
        onBack: (() -> Void)? = nil,
        search: Binding<String>? = nil,
        searchPlaceholder: String = "Search",
        @ViewBuilder trailing: () -> Trailing,
        @ViewBuilder bottom: () -> Bottom
    ) {
        self.title = title; self.largeTitle = largeTitle; self.backTitle = backTitle
        self.onBack = onBack; self.search = search; self.searchPlaceholder = searchPlaceholder
        self.trailing = trailing(); self.bottom = bottom()
    }

    public var body: some View {
        VStack(spacing: spacing.gapInlineXs) {
            HStack(spacing: 0) {
                leftAccessory.frame(maxWidth: .infinity, alignment: .leading)
                if let title {
                    Text(title).medicText(.headlineSemibold)
                        .foregroundStyle(MedicColor.navBarTitle)
                        .lineLimit(1)
                        .accessibilityAddTraits(.isHeader)
                }
                trailing
                    .medicText(.bodyRegular)
                    .foregroundStyle(MedicColor.navBarAction)
                    .padding(9)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(height: 42)

            if largeTitle != nil || search != nil {
                VStack(alignment: .leading, spacing: MedicSpace.space5) {
                    if let largeTitle {
                        Text(largeTitle).medicText(.displayBold)
                            .foregroundStyle(MedicColor.navBarTitle)
                            .accessibilityAddTraits(.isHeader)
                    }
                    if let search { searchField(search) }
                }
                .padding(.horizontal, spacing.paddingScreenHorizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            bottom
        }
        .padding(.bottom, MedicSpace.space3)
        .frame(maxWidth: .infinity)
        .background(
            MedicColor.navBarBg
                .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 0.5)
                .ignoresSafeArea(edges: .top)
        )
    }

    @ViewBuilder
    private var leftAccessory: some View {
        if onBack != nil || backTitle != nil {
            Button { onBack?() } label: {
                HStack(spacing: MedicSpace.spaceKit5) {
                    Image(systemName: "chevron.left").font(.system(size: 22))
                    if let backTitle { Text(backTitle).medicText(.bodyRegular) }
                }
                .foregroundStyle(MedicColor.navBarAction)
                .padding(9)
            }
            .buttonStyle(.plain)
        }
    }

    private func searchField(_ text: Binding<String>) -> some View {
        // No Figma a busca da barra usa `surface/primary` no lugar do preenchimento translúcido.
        MedicSearchField(text: text, placeholder: searchPlaceholder, background: MedicColor.surfacePrimary)
    }
}

public extension MedicTopNavigation where Trailing == EmptyView {
    init(
        title: String? = nil,
        largeTitle: String? = nil,
        backTitle: String? = nil,
        onBack: (() -> Void)? = nil,
        search: Binding<String>? = nil,
        searchPlaceholder: String = "Search",
        @ViewBuilder bottom: () -> Bottom
    ) {
        self.init(
            title: title, largeTitle: largeTitle, backTitle: backTitle, onBack: onBack,
            search: search, searchPlaceholder: searchPlaceholder,
            trailing: { EmptyView() }, bottom: bottom
        )
    }
}

public extension MedicTopNavigation where Bottom == EmptyView {
    init(
        title: String? = nil,
        largeTitle: String? = nil,
        backTitle: String? = nil,
        onBack: (() -> Void)? = nil,
        search: Binding<String>? = nil,
        searchPlaceholder: String = "Search",
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.init(
            title: title, largeTitle: largeTitle, backTitle: backTitle, onBack: onBack,
            search: search, searchPlaceholder: searchPlaceholder,
            trailing: trailing, bottom: { EmptyView() }
        )
    }
}

public extension MedicTopNavigation where Trailing == EmptyView, Bottom == EmptyView {
    init(
        title: String? = nil,
        largeTitle: String? = nil,
        backTitle: String? = nil,
        onBack: (() -> Void)? = nil,
        search: Binding<String>? = nil,
        searchPlaceholder: String = "Search"
    ) {
        self.init(
            title: title, largeTitle: largeTitle, backTitle: backTitle, onBack: onBack,
            search: search, searchPlaceholder: searchPlaceholder,
            trailing: { EmptyView() }, bottom: { EmptyView() }
        )
    }
}

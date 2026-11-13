import SwiftUI

/// Figma: TabBar (10:3527), item TabBar-item (10:3496). Tab Count = 2 a 5 abas; Selected Tab = aba ativa.
/// A altura de 49 pt exclui o Home Indicator (83 pt no Figma): ele é do sistema, a barra respeita a safe area.
public struct MedicTabItem: Identifiable {
    public let id: Int
    public let title: String
    public let systemImage: String

    public init(id: Int, title: String, systemImage: String) {
        self.id = id; self.title = title; self.systemImage = systemImage
    }
}

public struct MedicTabBar: View {
    private let items: [MedicTabItem]
    @Binding private var selection: Int
    @Environment(\.medicSpacing) private var spacing

    /// - Parameters:
    ///   - selection: `id` do item selecionado.
    public init(items: [MedicTabItem], selection: Binding<Int>) {
        self.items = items
        self._selection = selection
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(items) { item in
                let selected = item.id == selection
                Button { selection = item.id } label: {
                    VStack(spacing: MedicSpace.spaceKit5) {
                        Image(systemName: item.systemImage).font(.system(size: 22))
                        Text(item.title)
                            .font(.system(size: 10, weight: .medium))
                            .tracking(-0.24)
                    }
                    .foregroundStyle(selected ? MedicColor.navTabActive : MedicColor.navTabInactive)
                    .padding(.top, spacing.paddingComponentSm)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(selected ? [.isButton, .isSelected] : .isButton)
            }
        }
        .frame(height: MedicSafeArea.tabBar - MedicSafeArea.homeIndicator)
        .background(
            MedicColor.navTabBg
                .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: -0.5)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

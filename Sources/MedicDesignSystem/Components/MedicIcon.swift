import SwiftUI

/// Ícone do Design System. Os ícones do Figma são glifos SF Symbols (componentes "Icon / <nome do símbolo>",
/// glifo em SF Pro, 22 pt); aqui o nome do símbolo vira `Image(systemName:)`.
/// Cor padrão: `color-icon/default`. Cores de status ou marca devem ser aplicadas na instância.
public struct MedicIcon: View {
    private let name: String
    private let color: Color

    public init(_ systemName: String, color: Color = MedicColor.iconDefault) {
        self.name = systemName
        self.color = color
    }

    public var body: some View {
        Image(systemName: name)
            .font(.system(size: 22))
            .foregroundStyle(color)
            .accessibilityHidden(true)
    }
}

import SwiftUI

/// Figma: Pagination (71:1086), 200×20. Current Page = 1 | 2 | 3. Bolinhas de 7 pt com 9 pt entre elas.
/// A página atual fica em `color-icon/brand` (opacidade 1); as demais em `color-icon/pagination-inactive` a 30%.
///
/// Atenção: no Figma a cor é fixa por posição (a bolinha 2 é sempre `icon/brand`, as outras `pagination-inactive`)
/// e só a opacidade muda com a página atual. Aqui a cor segue a página atual, que é o comportamento esperado.
public struct MedicPagination: View {
    private let numberOfPages: Int
    private let currentPage: Int

    /// - Parameters:
    ///   - currentPage: índice (0-based) da página atual.
    public init(numberOfPages: Int = 3, currentPage: Int) {
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
    }

    public var body: some View {
        HStack(spacing: 9) {
            ForEach(0..<max(numberOfPages, 0), id: \.self) { index in
                let current = index == currentPage
                Circle()
                    .fill(current ? MedicColor.iconBrand : MedicColor.iconPaginationInactive)
                    .opacity(current ? 1 : 0.3)
                    .frame(width: 7, height: 7)
            }
        }
        .frame(height: 20)
        .accessibilityElement()
        .accessibilityLabel("Página \(currentPage + 1) de \(numberOfPages)")
    }
}

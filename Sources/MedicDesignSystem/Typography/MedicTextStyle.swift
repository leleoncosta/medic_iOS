import SwiftUI
import UIKit

/// Estilo de texto do Figma (família SF Pro). Valores em pontos, iguais aos estilos locais do arquivo.
/// Uso: `Text("Olá").medicText(.bodyRegular)`.
/// Observação: usa tamanho fixo, como no Figma. Para Dynamic Type, envolva em `@ScaledMetric` na tela.
public struct MedicTextStyle {
    public let size: CGFloat
    public let weight: Font.Weight
    public let lineHeight: CGFloat
    public let tracking: CGFloat

    public init(size: CGFloat, weight: Font.Weight, lineHeight: CGFloat, tracking: CGFloat) {
        self.size = size; self.weight = weight; self.lineHeight = lineHeight; self.tracking = tracking
    }

    var uiWeight: UIFont.Weight {
        switch weight {
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        default: return .regular
        }
    }

    /// Espaço extra entre linhas para chegar na altura de linha do Figma.
    var lineSpacing: CGFloat {
        max(0, lineHeight - UIFont.systemFont(ofSize: size, weight: uiWeight).lineHeight)
    }
}

public extension MedicTextStyle {
    // Display
    static let displayRegular = MedicTextStyle(size: 34, weight: .regular, lineHeight: 41, tracking: 0.374)
    static let displaySemibold = MedicTextStyle(size: 34, weight: .semibold, lineHeight: 41, tracking: 0.374)
    static let displayBold = MedicTextStyle(size: 34, weight: .bold, lineHeight: 41, tracking: 0.374)
    // Títulos
    static let title1Semibold = MedicTextStyle(size: 28, weight: .semibold, lineHeight: 34, tracking: 0.364)
    static let title2Regular = MedicTextStyle(size: 22, weight: .regular, lineHeight: 28, tracking: 0.35)
    static let title2Semibold = MedicTextStyle(size: 22, weight: .semibold, lineHeight: 28, tracking: 0.35)
    static let title3Regular = MedicTextStyle(size: 20, weight: .regular, lineHeight: 25, tracking: 0.38)
    static let title3Semibold = MedicTextStyle(size: 20, weight: .semibold, lineHeight: 25, tracking: 0.38)
    // Corpo
    static let headlineRegular = MedicTextStyle(size: 17, weight: .regular, lineHeight: 22, tracking: -0.408)
    static let headlineSemibold = MedicTextStyle(size: 17, weight: .semibold, lineHeight: 22, tracking: -0.408)
    static let bodyRegular = MedicTextStyle(size: 17, weight: .regular, lineHeight: 22, tracking: -0.408)
    static let bodyMedium = MedicTextStyle(size: 17, weight: .medium, lineHeight: 22, tracking: -0.408)
    static let calloutRegular = MedicTextStyle(size: 16, weight: .regular, lineHeight: 21, tracking: -0.32)
    static let calloutMedium = MedicTextStyle(size: 16, weight: .medium, lineHeight: 21, tracking: -0.32)
    static let subheadlineRegular = MedicTextStyle(size: 15, weight: .regular, lineHeight: 20, tracking: -0.23)
    static let subheadlineMedium = MedicTextStyle(size: 15, weight: .medium, lineHeight: 20, tracking: -0.23)
    static let subheadlineSemibold = MedicTextStyle(size: 15, weight: .semibold, lineHeight: 20, tracking: -0.23)
    static let footnoteRegular = MedicTextStyle(size: 13, weight: .regular, lineHeight: 18, tracking: -0.078)
    static let footnoteMedium = MedicTextStyle(size: 13, weight: .medium, lineHeight: 18, tracking: -0.078)
    static let footnoteSemibold = MedicTextStyle(size: 13, weight: .semibold, lineHeight: 18, tracking: -0.078)
    static let caption1Regular = MedicTextStyle(size: 12, weight: .regular, lineHeight: 16, tracking: 0)
    static let caption1Medium = MedicTextStyle(size: 12, weight: .medium, lineHeight: 16, tracking: 0)
    static let caption2Regular = MedicTextStyle(size: 11, weight: .regular, lineHeight: 13, tracking: 0.066)
    static let caption2Medium = MedicTextStyle(size: 11, weight: .medium, lineHeight: 13, tracking: 0.066)
    // Clínicos (reserva: sem uso nas telas atuais)
    static let clinicalDataXL = MedicTextStyle(size: 40, weight: .semibold, lineHeight: 40, tracking: -2)
    static let clinicalDataLarge = MedicTextStyle(size: 34, weight: .semibold, lineHeight: 34, tracking: -2)
    static let clinicalDataMedium = MedicTextStyle(size: 24, weight: .medium, lineHeight: 24, tracking: -1)
    static let clinicalDataSmall = MedicTextStyle(size: 20, weight: .medium, lineHeight: 20, tracking: 0)
    static let clinicalDataUnit = MedicTextStyle(size: 13, weight: .regular, lineHeight: 13, tracking: 2)
    static let clinicalDataLabel = MedicTextStyle(size: 11, weight: .semibold, lineHeight: 13, tracking: 5)
    static let clinicalDrugName = MedicTextStyle(size: 17, weight: .semibold, lineHeight: 24, tracking: 0)
    static let clinicalDrugDose = MedicTextStyle(size: 15, weight: .medium, lineHeight: 21, tracking: 0)
    static let clinicalDrugSchedule = MedicTextStyle(size: 13, weight: .regular, lineHeight: 18, tracking: 0)
    static let clinicalResultValue = MedicTextStyle(size: 22, weight: .medium, lineHeight: 29, tracking: 0)
    static let clinicalResultRange = MedicTextStyle(size: 11, weight: .regular, lineHeight: 15, tracking: 2)
    static let clinicalAlertTitle = MedicTextStyle(size: 17, weight: .semibold, lineHeight: 22, tracking: 0)
    static let clinicalAlertBody = MedicTextStyle(size: 15, weight: .regular, lineHeight: 23, tracking: 0)
    static let clinicalTimestamp = MedicTextStyle(size: 12, weight: .regular, lineHeight: 17, tracking: 2)
}

public extension View {
    /// Aplica fonte, espaçamento entre letras e altura de linha de um estilo do Design System.
    func medicText(_ style: MedicTextStyle) -> some View {
        self
            .font(.system(size: style.size, weight: style.weight))
            .tracking(style.tracking)
            .lineSpacing(style.lineSpacing)
    }
}

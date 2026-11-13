import SwiftUI

/// Figma: Spinner (3011:21). Indicador de carregamento indeterminado de 8 raios (estilo UIActivityIndicatorView).
/// Size = Small (20 pt, dentro de botões e linhas) | Large (37 pt, centralizado na área que carrega).
/// Cor `color-text/secondary`. O Figma é estático; a rotação (1 s por volta) é do código e
/// fica parada quando o usuário ativa "Reduzir Movimento".
public enum MedicSpinnerSize { case small, large }

public struct MedicSpinner: View {
    private let size: MedicSpinnerSize
    @State private var angle: Double = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(size: MedicSpinnerSize = .small) { self.size = size }

    private var metrics: (diameter: CGFloat, width: CGFloat, length: CGFloat) {
        switch size {
        case .small: return (20, 2, 5.4)
        case .large: return (37, 3.7, 10)
        }
    }

    public var body: some View {
        let m = metrics
        ZStack {
            ForEach(0..<8, id: \.self) { index in
                RoundedRectangle(cornerRadius: m.width / 2)
                    .fill(MedicColor.textSecondary)
                    .opacity(1 - 0.1 * Double(index))
                    .frame(width: m.width, height: m.length)
                    .offset(y: -(m.diameter - m.length) / 2)
                    .rotationEffect(.degrees(Double(index) * 45))
            }
        }
        .frame(width: m.diameter, height: m.diameter)
        .rotationEffect(.degrees(angle))
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) { angle = 360 }
        }
        .accessibilityElement()
        .accessibilityLabel("Carregando")
    }
}

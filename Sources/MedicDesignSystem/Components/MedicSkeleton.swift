import SwiftUI

/// Figma: Skeleton (3014:14). Marcador de carregamento com a forma do conteúdo que vai chegar.
/// Type = Line (200×14, texto) | Avatar (círculo 40) | Block (343×120, imagem ou cartão) |
/// Row (375×62, mesmo desenho do TableRow com avatar e duas linhas). Cor `color-surface/tertiary`.
/// Estático, como no Figma (sem animação de brilho).
public enum MedicSkeletonType { case line, avatar, block, row }

public struct MedicSkeleton: View {
    private let type: MedicSkeletonType
    @Environment(\.medicSpacing) private var spacing

    public init(_ type: MedicSkeletonType) { self.type = type }

    private func bar(_ width: CGFloat, _ height: CGFloat, radius: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: radius).fill(MedicColor.surfaceTertiary).frame(width: width, height: height)
    }

    private var avatar: some View {
        Circle().fill(MedicColor.surfaceTertiary).frame(width: MedicSizing.avatarMd, height: MedicSizing.avatarMd)
    }

    public var body: some View {
        Group {
            switch type {
            case .line:
                bar(200, 14, radius: spacing.radiusSm)
            case .avatar:
                avatar
            case .block:
                bar(343, 120, radius: spacing.radiusMd)
            case .row:
                HStack(spacing: spacing.paddingComponentMd) {
                    avatar
                    VStack(alignment: .leading, spacing: MedicSpace.space3) {
                        bar(160, 16, radius: spacing.radiusSm)
                        bar(220, 12, radius: spacing.radiusSm)
                    }
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, spacing.paddingScreenHorizontal)
                .padding(.vertical, MedicSpace.spaceKit11)
                .frame(maxWidth: .infinity)
                .background(MedicColor.surfacePrimary)
            }
        }
        .accessibilityHidden(true)
    }
}

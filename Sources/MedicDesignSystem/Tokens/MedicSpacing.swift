// GERADO por tools/generate-tokens.ps1 a partir de tools/tokens-data.txt. Não edite à mão.
// Fonte: Figma "Design System - iOS" (NdxangiWk18nefmJvebkTW).

import SwiftUI

/// Espaçamentos e raios semânticos. Dois modos: `standard` (Default) e `dense` (Dense).
/// Nas views: `@Environment(\.medicSpacing) private var spacing`.
public struct MedicSpacing {
    public let paddingComponentXs: CGFloat
    public let paddingComponentSm: CGFloat
    public let paddingComponentMd: CGFloat
    public let paddingComponentLg: CGFloat
    public let paddingComponentXl: CGFloat
    public let paddingScreenHorizontal: CGFloat
    public let paddingScreenVertical: CGFloat
    public let paddingSection: CGFloat
    public let paddingScreenSection: CGFloat
    public let gapInlineXs: CGFloat
    public let gapInlineSm: CGFloat
    public let gapInlineMd: CGFloat
    public let gapStackXs: CGFloat
    public let gapStackSm: CGFloat
    public let gapStackMd: CGFloat
    public let gapStackLg: CGFloat
    public let gapStackXl: CGFloat
    public let gapStack2xl: CGFloat
    public let gapSection: CGFloat
    public let radiusNone: CGFloat
    public let radiusSm: CGFloat
    public let radiusMd: CGFloat
    public let radiusLg: CGFloat
    public let radiusXl: CGFloat
    public let radius2xl: CGFloat
    public let radiusFull: CGFloat
    public let radiusKit10: CGFloat
    public let radiusKit13: CGFloat
    public let radiusKit14: CGFloat
    public let radiusKit891: CGFloat
    public let radiusKit693: CGFloat

    public static let standard = MedicSpacing(
        paddingComponentXs: 4,
        paddingComponentSm: 8,
        paddingComponentMd: 12,
        paddingComponentLg: 16,
        paddingComponentXl: 24,
        paddingScreenHorizontal: 16,
        paddingScreenVertical: 24,
        paddingSection: 32,
        paddingScreenSection: 24,
        gapInlineXs: 2,
        gapInlineSm: 4,
        gapInlineMd: 8,
        gapStackXs: 6,
        gapStackSm: 8,
        gapStackMd: 12,
        gapStackLg: 16,
        gapStackXl: 24,
        gapStack2xl: 32,
        gapSection: 32,
        radiusNone: 0,
        radiusSm: 4,
        radiusMd: 6,
        radiusLg: 8,
        radiusXl: 12,
        radius2xl: 16,
        radiusFull: 64,
        radiusKit10: 10,
        radiusKit13: 13,
        radiusKit14: 14,
        radiusKit891: 8.91,
        radiusKit693: 6.93
    )
    public static let dense = MedicSpacing(
        paddingComponentXs: 4,
        paddingComponentSm: 6,
        paddingComponentMd: 8,
        paddingComponentLg: 12,
        paddingComponentXl: 16,
        paddingScreenHorizontal: 16,
        paddingScreenVertical: 16,
        paddingSection: 24,
        paddingScreenSection: 16,
        gapInlineXs: 2,
        gapInlineSm: 4,
        gapInlineMd: 6,
        gapStackXs: 4,
        gapStackSm: 6,
        gapStackMd: 8,
        gapStackLg: 12,
        gapStackXl: 16,
        gapStack2xl: 24,
        gapSection: 24,
        radiusNone: 0,
        radiusSm: 4,
        radiusMd: 4,
        radiusLg: 8,
        radiusXl: 8,
        radius2xl: 12,
        radiusFull: 64,
        radiusKit10: 10,
        radiusKit13: 13,
        radiusKit14: 14,
        radiusKit891: 8.91,
        radiusKit693: 6.93
    )
}

private struct MedicSpacingKey: EnvironmentKey {
    static let defaultValue = MedicSpacing.standard
}

public extension EnvironmentValues {
    var medicSpacing: MedicSpacing {
        get { self[MedicSpacingKey.self] }
        set { self[MedicSpacingKey.self] = newValue }
    }
}

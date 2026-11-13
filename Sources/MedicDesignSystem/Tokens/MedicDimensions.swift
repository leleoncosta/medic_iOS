// GERADO por tools/generate-tokens.ps1 a partir de tools/tokens-data.txt. Não edite à mão.
// Fonte: Figma "Design System - iOS" (NdxangiWk18nefmJvebkTW).

import SwiftUI

/// Escala primitiva de espaçamento. Atenção: `space16` vale 64 pt (herança do Figma), não 16.
public enum MedicSpace {
    public static let space0: CGFloat = 0
    public static let space1: CGFloat = 2
    public static let space2: CGFloat = 4
    public static let space3: CGFloat = 6
    public static let space4: CGFloat = 8
    public static let space5: CGFloat = 10
    public static let space6: CGFloat = 12
    public static let space7: CGFloat = 14
    public static let space8: CGFloat = 16
    public static let space9: CGFloat = 20
    public static let space10: CGFloat = 24
    public static let space11: CGFloat = 32
    public static let space12: CGFloat = 40
    public static let space13: CGFloat = 44
    public static let space14: CGFloat = 48
    public static let space15: CGFloat = 56
    public static let space16: CGFloat = 64
    public static let spaceKit5: CGFloat = 5
    public static let spaceKit7: CGFloat = 7
    public static let spaceKit9: CGFloat = 9
    public static let spaceKit11: CGFloat = 11
}

/// Tamanhos de toque, ícone e avatar.
public enum MedicSizing {
    public static let touchMin: CGFloat = 44
    public static let touchComfortable: CGFloat = 48
    public static let touchLarge: CGFloat = 56
    public static let iconSm: CGFloat = 16
    public static let iconMd: CGFloat = 20
    public static let iconLg: CGFloat = 24
    public static let iconXl: CGFloat = 32
    public static let avatarSm: CGFloat = 32
    public static let avatarMd: CGFloat = 40
    public static let avatarLg: CGFloat = 56
}

/// Alturas de safe area do iOS (referência de layout; o app deve usar a safe area real do sistema).
public enum MedicSafeArea {
    public static let statusBar: CGFloat = 59
    public static let navBar: CGFloat = 44
    public static let tabBar: CGFloat = 83
    public static let homeIndicator: CGFloat = 34
    public static let topTotal: CGFloat = 103
    public static let bottomTotal: CGFloat = 83
}

/// Durações de animação em segundos.
public enum MedicMotion {
    public static let durationInstant: Double = 0
    public static let durationFast: Double = 0.1
    public static let durationClinicalAlert: Double = 0.15
    public static let durationQuick: Double = 0.2
    public static let durationNormal: Double = 0.3
    public static let durationSlow: Double = 0.4
}

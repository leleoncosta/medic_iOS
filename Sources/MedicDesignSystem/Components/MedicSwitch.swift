import SwiftUI

/// Figma: Switch (10:3750), 51×31 pt. On = True | False; State = Default | Disabled (`.disabled(true)`).
/// Trilho ligado em `color-feedback/success/bg-strong`, desligado em `color-border/strong`;
/// desabilitado usa `color-action/primary/bg-disabled` (ligado) ou `color-border/disabled` (desligado).
public struct MedicSwitch: View {
    @Binding private var isOn: Bool
    private let label: String

    /// - Parameters:
    ///   - label: texto lido pelo VoiceOver (o Switch do Figma não tem rótulo visível).
    public init(isOn: Binding<Bool>, label: String = "") {
        self._isOn = isOn
        self.label = label
    }

    public var body: some View {
        Toggle(label, isOn: $isOn)
            .toggleStyle(MedicSwitchStyle())
            .labelsHidden()
    }
}

struct MedicSwitchStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        SwitchControl(configuration: configuration)
    }

    private struct SwitchControl: View {
        let configuration: ToggleStyleConfiguration
        @Environment(\.isEnabled) private var isEnabled

        private var track: Color {
            switch (configuration.isOn, isEnabled) {
            case (true, true): return MedicColor.feedbackSuccessBgStrong
            case (false, true): return MedicColor.borderStrong
            case (true, false): return MedicColor.actionPrimaryBgDisabled
            case (false, false): return MedicColor.borderDisabled
            }
        }

        var body: some View {
            Button { configuration.isOn.toggle() } label: {
                ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                    Capsule().fill(track)
                    Circle()
                        .fill(MedicPalette.neutral0)
                        .frame(width: 27, height: 27)
                        .shadow(color: .black.opacity(0.06), radius: 0.5, x: 0, y: 3)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 3)
                        .padding(2)
                }
                .frame(width: 51, height: 31)
                .animation(.easeInOut(duration: MedicMotion.durationQuick), value: configuration.isOn)
            }
            .buttonStyle(.plain)
            .accessibilityValue(configuration.isOn ? "Ligado" : "Desligado")
        }
    }
}

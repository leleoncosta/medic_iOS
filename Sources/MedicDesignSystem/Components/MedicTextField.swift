import SwiftUI

/// Figma: TextField (2994:127). State = Default | Focus | Error | Success | Disabled; Filled indica se há valor.
/// O estado Focus é automático (campo em foco). Error e Success têm precedência sobre o foco.
/// Estados de erro e sucesso exigem `helper` com a mensagem.
public enum MedicFieldState { case `default`, error, success, disabled }

public struct MedicTextField: View {
    @Binding private var text: String
    private let label: String?
    private let placeholder: String
    private let helper: String?
    private let isRequired: Bool
    private let state: MedicFieldState
    private let leadingSystemImage: String?
    private let trailingSystemImage: String?

    @FocusState private var isFocused: Bool
    @Environment(\.medicSpacing) private var spacing

    public init(
        text: Binding<String>,
        label: String? = nil,
        placeholder: String = "",
        helper: String? = nil,
        isRequired: Bool = false,
        state: MedicFieldState = .default,
        leadingSystemImage: String? = nil,
        trailingSystemImage: String? = nil
    ) {
        self._text = text
        self.label = label; self.placeholder = placeholder; self.helper = helper
        self.isRequired = isRequired; self.state = state
        self.leadingSystemImage = leadingSystemImage; self.trailingSystemImage = trailingSystemImage
    }

    private var disabled: Bool { state == .disabled }

    private var borderColor: Color {
        switch state {
        case .disabled: return MedicColor.inputBorderDisabled
        case .error: return MedicColor.inputBorderError
        case .success: return MedicColor.inputBorderSuccess
        case .default: return isFocused ? MedicColor.inputBorderFocus : MedicColor.inputBorder
        }
    }

    private var borderWidth: CGFloat {
        (state == .default && isFocused) ? 2 : 1
    }

    private var helperColor: Color {
        switch state {
        case .disabled: return MedicColor.inputTextDisabled
        case .error: return MedicColor.inputErrorText
        case .success: return MedicColor.feedbackSuccessText
        case .default: return MedicColor.inputHelper
        }
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: spacing.gapInlineSm) {
            if let label {
                HStack(spacing: spacing.gapInlineXs) {
                    Text(label).medicText(.subheadlineMedium)
                        .foregroundStyle(disabled ? MedicColor.inputTextDisabled : MedicColor.inputLabel)
                    if isRequired {
                        Text("*").medicText(.subheadlineMedium)
                            .foregroundStyle(disabled ? MedicColor.inputTextDisabled : MedicColor.inputLabelRequired)
                    }
                }
            }

            HStack(spacing: spacing.gapInlineMd) {
                if let leadingSystemImage {
                    Image(systemName: leadingSystemImage).font(.system(size: 22))
                        .foregroundStyle(disabled ? MedicColor.inputTextDisabled : MedicColor.inputIconLeading)
                }
                TextField(
                    "",
                    text: $text,
                    prompt: Text(placeholder)
                        .foregroundColor(disabled ? MedicColor.inputTextDisabled : MedicColor.inputPlaceholder)
                )
                .medicText(.bodyRegular)
                .foregroundStyle(disabled ? MedicColor.inputTextDisabled : MedicColor.inputText)
                .focused($isFocused)
                .disabled(disabled)
                if let trailingSystemImage {
                    Image(systemName: trailingSystemImage).font(.system(size: 22))
                        .foregroundStyle(disabled ? MedicColor.inputTextDisabled : MedicColor.inputIconTrailing)
                }
            }
            .padding(.horizontal, spacing.paddingComponentMd)
            .frame(height: MedicSizing.touchMin)
            .background(
                disabled ? MedicColor.inputBgDisabled : MedicColor.inputBg,
                in: RoundedRectangle(cornerRadius: spacing.radiusLg)
            )
            .overlay(
                RoundedRectangle(cornerRadius: spacing.radiusLg)
                    .strokeBorder(borderColor, lineWidth: borderWidth)
            )
            .contentShape(RoundedRectangle(cornerRadius: spacing.radiusLg))
            .onTapGesture { if !disabled { isFocused = true } }

            if let helper {
                Text(helper).medicText(.footnoteRegular).foregroundStyle(helperColor)
            }
        }
    }
}

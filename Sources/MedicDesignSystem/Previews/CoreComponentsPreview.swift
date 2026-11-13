import SwiftUI

/// Galeria dos 7 componentes do núcleo, para conferir no Xcode (Canvas) contra o Figma.
struct CoreComponentsPreview: View {
    @State private var name = ""
    @State private var filled = "Maria Souza"
    @State private var search = ""
    @State private var tab = 0

    var body: some View {
        VStack(spacing: 0) {
            MedicTopNavigation(largeTitle: "Pacientes", search: $search)

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    MedicSectionHeader("Resumo")
                    MedicTableRow("Maria Souza", subtitle: "Cardiologia", date: "12/11", showChevron: true, action: {}) {
                        MedicIcon("person.circle", color: MedicColor.iconBrandSecondary)
                    }
                    MedicTableRow("Sem ação", showChevron: true)
                    MedicTableRow("Desabilitada", showChevron: true).disabled(true)

                    MedicSectionHeader("Situação", style: .prominent, actionLabel: "Ver todos")
                    HStack {
                        MedicBadge("Ativo", type: .success, showDot: true)
                        MedicBadge("Atenção", type: .warning)
                        MedicBadge("Crítico", type: .error, style: .strong)
                        MedicBadge("Rascunho", type: .neutral)
                    }.padding(.horizontal, 16)

                    VStack(spacing: 12) {
                        MedicTextField(text: $name, label: "Nome", placeholder: "Nome completo", helper: "Como no documento", isRequired: true)
                        MedicTextField(text: $filled, label: "Erro", helper: "Campo inválido", state: .error)
                        MedicTextField(text: $filled, label: "Desabilitado", state: .disabled)
                    }.padding(.horizontal, 16)

                    VStack(spacing: 12) {
                        MedicButton("Salvar", fullWidth: true) {}
                        MedicButton("Cancelar", kind: .secondary, size: .regular) {}
                        MedicButton("Excluir", kind: .destructive, size: .regular) {}
                        MedicButton("Detalhes", kind: .ghost, size: .regular, trailingSystemImage: "chevron.right") {}
                        MedicButton("Indisponível", fullWidth: true) {}.disabled(true)
                    }.padding(.horizontal, 16)
                }
            }
            .background(MedicColor.surfaceSecondary)

            MedicTabBar(items: [
                MedicTabItem(id: 0, title: "Pacientes", systemImage: "person.2.fill"),
                MedicTabItem(id: 1, title: "Parecer", systemImage: "doc.text.fill"),
                MedicTabItem(id: 2, title: "Notificações", systemImage: "bell.fill"),
                MedicTabItem(id: 3, title: "Perfil", systemImage: "person.circle")
            ], selection: $tab)
        }
    }
}

struct CoreComponentsPreview_Previews: PreviewProvider {
    static var previews: some View {
        CoreComponentsPreview().previewDisplayName("Claro")
        CoreComponentsPreview().preferredColorScheme(.dark).previewDisplayName("Escuro")
    }
}

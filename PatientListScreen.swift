// Tela de teste: "Lista de pacientes" (Medic iOS)
// Gerada a partir do Figma "Design System - iOS" (NdxangiWk18nefmJvebkTW).
// Componentes usados: TopNavigation (Large Title + Search + Segmented, 10:1203),
// Pill Button (135:1513/1514), TableRow (Perfil Icon + Three Labels + Date Down + Chevron, 510:1436),
// TabBar (4 Tabs, 10:3536).
//
// Cada "GAP-n" marca um ponto em que o Figma não trouxe informação suficiente e a IA
// teve que adivinhar ou decidir sozinha. A lista consolidada está no relatório da conversa.
// NÃO compilado nem renderizado: ambiente Windows, sem Xcode.

import SwiftUI

// MARK: - Tokens (reconstruídos a mão)

// GAP-1: get_variable_defs exige seleção no app desktop; sem isso, os tokens só chegam como
// `var(--nome, #fallback)` dentro do código gerado. Light vem do fallback; Dark é desconhecido.
// GAP-2: nomes misturam convenções: `color-nav/bar-bg`, `color-surface/primary` e
// `neutral-0`, `divider-alpha`, `text-strong-alpha` (sem prefixo `color-`, sem camada semântica).
enum DS {
    enum Color {
        static let navBarBg      = SwiftUI.Color(hex: 0x1E6899) // color-nav/bar-bg. GAP-3: o fallback no código gerado é #214B63, mas o changelog v1.14.0 diz #1E6899
        static let actionPrimary = SwiftUI.Color(hex: 0x1E6899) // color-action/primary/bg
        static let textPrimary   = SwiftUI.Color(hex: 0x1C1C1E) // color-text/primary
        static let textStrong    = SwiftUI.Color(red: 60/255, green: 60/255, blue: 67/255).opacity(0.7) // text-strong-alpha
        static let textSecondary = SwiftUI.Color(red: 60/255, green: 60/255, blue: 67/255).opacity(0.6) // text-secondary-alpha
        static let divider       = SwiftUI.Color(red: 60/255, green: 60/255, blue: 67/255).opacity(0.4) // divider-alpha
        static let fillTertiary  = SwiftUI.Color(red: 118/255, green: 118/255, blue: 128/255).opacity(0.12) // fill-tertiary-alpha
        static let surfacePrimary  = SwiftUI.Color.white // color-surface/primary. GAP-4: Dark desconhecido
        static let surfaceElevated = SwiftUI.Color.white // color-surface/elevated. GAP-4
        // GAP-5: a Tab Bar ativa usa `color-text/link-visited` (#214B63) como cor de seleção,
        // e as abas inativas usam `divider-alpha`. Nenhum dos dois é token de navegação.
        // A IA copia o uso errado ou inventa `tabSelected`/`tabUnselected`.
        static let tabSelected   = SwiftUI.Color(hex: 0x214B63)
        static let tabUnselected = divider
    }
    // GAP-6: não há tokens de raio/espaçamento aplicados. O código traz 10, 8, 8.91 e 6.93 px,
    // e paddings de 7, 9 e 11 px, que são resíduos do UI kit da Apple e não seguem a página Grid.
    enum Radius { static let search: CGFloat = 10; static let pill: CGFloat = 8 }
}

extension Color {
    init(hex: UInt32) {
        self.init(red: Double((hex >> 16) & 0xFF) / 255,
                  green: Double((hex >> 8) & 0xFF) / 255,
                  blue: Double(hex & 0xFF) / 255)
    }
}

// MARK: - Modelo

struct Patient: Identifiable {
    let id = UUID()
    let initials: String
    let name: String
    let detail1: String   // GAP-7: no Figma os três textos são todos "Title"; o significado de cada linha não vem documentado
    let detail2: String
    let date: String
}

// MARK: - Tela

struct PatientListScreen: View {
    @State private var query = ""
    @State private var segment = 0
    @State private var filter = 0
    @State private var tab = 0

    // GAP-8: a descrição da página não diz que dados mostrar. Domínio inventado (Medic = saúde).
    private let patients = [
        Patient(initials: "AS", name: "Ana Souza", detail1: "Leito 12 · UTI", detail2: "Dr. Carlos Lima", date: "09:41"),
        Patient(initials: "BM", name: "Bruno Martins", detail1: "Leito 03 · Enfermaria", detail2: "Dra. Paula Reis", date: "Ontem"),
        Patient(initials: "CF", name: "Carla Ferreira", detail1: "Ambulatório", detail2: "Dr. Carlos Lima", date: "02/11"),
    ]
    private let filters = ["Todos", "Internados", "Ambulatório", "Alta"]

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                LazyVStack(spacing: 0) {
                    filterRow
                    ForEach(patients) { PatientRow(patient: $0) }
                }
            }
            tabBar
        }
        .background(Color(.systemGroupedBackground)) // GAP-9: não existe token de fundo de tela; o fundo do Table Views é neutral-0 (primitivo branco)
    }

    // TopNavigation / Large Title + Search + Segmented
    // GAP-10: o componente do Figma inclui StatusBar (44pt) e o notch como SVG. No iOS real isso
    // é do sistema; a IA precisa saber que deve descartar essa parte, e nada no arquivo diz isso.
    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Spacer()
                Text("Editar").font(.body) // "Right Title" no Figma; ação inventada
            }
            .padding(.horizontal, 9).frame(height: 42)

            VStack(alignment: .leading, spacing: 10) {
                // GAP-11: Large Title é "SF Pro Display Bold 34 / 41 / tracking 0.374". Não há token.
                // Aqui entra .largeTitle (Dynamic Type); o Figma não menciona acessibilidade de texto.
                Text("Pacientes").font(.largeTitle.bold())
                HStack(spacing: 6) {
                    Image(systemName: "magnifyingglass")
                    TextField("Buscar", text: $query) // GAP-12: o campo só tem estado Default/Cancel, sem estado de foco ou com texto
                    Image(systemName: "barcode.viewfinder") // ícone só existe no nome da camada: "Icon / barcode.viewfinder"
                }
                .padding(.horizontal, 8).padding(.vertical, 7)
                .background(DS.Color.surfacePrimary, in: RoundedRectangle(cornerRadius: DS.Radius.search))
                .foregroundStyle(DS.Color.textSecondary)
            }
            .padding(.horizontal, 16).padding(.bottom, 7)

            // GAP-13: o SegmentedPicker dentro do nav tem rótulos "On/Off/Off/Off" (texto de exemplo)
            // e texto branco fixo (neutral-0) nas opções não selecionadas. Fora do nav, esse texto
            // ficaria invisível em fundo claro, e o Figma não diz isso.
            Picker("", selection: $segment) {
                Text("Todos").tag(0); Text("Meus").tag(1); Text("Alertas").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20).padding(.vertical, 8)
        }
        .background(DS.Color.navBarBg)
        .foregroundStyle(.white) // GAP-14: texto do nav usa `neutral-0` direto, sem token `color-nav/title`
    }

    // Pill Button (Selected / Not Selected)
    // GAP-15: "Pill Button" tem raio de 8 px (não é pill) e na prática funciona como chip de filtro.
    // O Usage Guidelines confirma o papel, mas o nome engana na busca.
    private var filterRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(filters.indices, id: \.self) { i in
                    let selected = filter == i
                    Button { filter = i } label: {
                        Text(filters[i])
                            .font(.system(size: 13, weight: selected ? .semibold : .regular)) // GAP-11 de novo
                            .padding(.horizontal, 16).padding(.vertical, 5)
                            .foregroundStyle(selected ? .white : DS.Color.textPrimary)
                            .background(selected ? DS.Color.actionPrimary : DS.Color.surfaceElevated,
                                        in: RoundedRectangle(cornerRadius: DS.Radius.pill))
                    }
                }
            }
            .padding(.horizontal, 16).padding(.vertical, 12)
        }
    }

    // TabBar / 4 Tabs / "Device=1 Selected"
    // GAP-16: no Figma as abas são posicionadas com `left: calc(12.5% - 1.25px)` dentro de um
    // frame de 414 px, sem auto layout. Aqui usamos TabView, e o desenho do Figma não é seguido.
    // O estado de seleção vem em `Device=1 Selected`, uma propriedade com nome errado.
    // GAP-17: os rótulos da tab bar são "Pacientes/Parecer/Notificações/Perfil" (dados reais do Medic) com ícones
    // person.2.fill / doc.text.fill / bell.fill / person.circle, que só existem no nome da camada.
    private var tabBar: some View {
        HStack {
            tabItem("person.2.fill", "Pacientes", 0)
            tabItem("doc.text.fill", "Parecer", 1)
            tabItem("bell.fill", "Notificações", 2)
            tabItem("person.circle", "Perfil", 3)
        }
        .padding(.top, 8)
        .background(DS.Color.surfaceElevated)
        .overlay(alignment: .top) { Divider() } // sombra de 0,5 px em rgba(0,0,0,.3), hardcoded e sem token de efeito
    }

    private func tabItem(_ icon: String, _ title: String, _ index: Int) -> some View {
        VStack(spacing: 2) {
            Image(systemName: icon).font(.system(size: 22))
            Text(title).font(.system(size: 10, weight: .medium)) // 10 pt fixo no Figma
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(tab == index ? DS.Color.tabSelected : DS.Color.tabUnselected)
        .onTapGesture { tab = index }
    }
}

// TableRow / Perfil Icon + Three Labels / Date Down + Chevron
struct PatientRow: View {
    let patient: Patient
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 8) {
                // GAP-18: o avatar vem como SVG raster ("Ellipse1") com as iniciais num texto por cima.
                // A cor de fundo não é token e fica embutida no arquivo SVG.
                ZStack {
                    Circle().fill(DS.Color.divider)
                    Text(patient.initials).foregroundStyle(.white)
                }
                .frame(width: 40, height: 40).padding(.vertical, 12)

                VStack(alignment: .leading, spacing: 0) {
                    Text(patient.name).font(.body).foregroundStyle(DS.Color.textPrimary)
                    Text(patient.detail1).font(.footnote).foregroundStyle(DS.Color.textStrong)
                    Text(patient.detail2).font(.footnote).foregroundStyle(DS.Color.textStrong)
                }
                .padding(.vertical, 11)

                Spacer(minLength: 0)

                // "Date Down": a seta indica sentido de ordenação ou de variação? A página não diz.
                HStack(spacing: 8) {
                    Text(patient.date).font(.footnote).foregroundStyle(DS.Color.textStrong)
                    Image(systemName: "chevron.right").foregroundStyle(DS.Color.divider)
                }
                .padding(.vertical, 11)
            }
            .padding(.horizontal, 16)
            Divider().padding(.leading, 16)
        }
        .background(Color.white) // GAP-19: fundo = `neutral-0` (primitivo branco), não `color-surface/primary`; não adapta ao Dark mode
    }
}

#Preview { PatientListScreen() }

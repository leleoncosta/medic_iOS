import SwiftUI
import UIKit
import XCTest
@testable import MedicDesignSystem

/// Renderiza os componentes em PNG (claro e escuro) para comparar com o Figma.
/// Os arquivos vão para a pasta de `SNAPSHOT_DIR` (no CI: variável `TEST_RUNNER_SNAPSHOT_DIR`)
/// ou, sem ela, para a pasta temporária do teste. Também ficam anexados ao resultado do teste.
/// Os testes só verificam que a imagem foi gerada; a comparação visual é manual.
@MainActor
final class ComponentSnapshotTests: XCTestCase {

    // MARK: - Componentes

    func testButtons() throws {
        try snapshot("button", width: 390) {
            VStack(alignment: .leading, spacing: 12) {
                ForEach([MedicButtonKind.primary, .secondary, .destructive, .ghost], id: \.self) { kind in
                    HStack(spacing: 12) {
                        MedicButton("Large", kind: kind, size: .large) {}
                        MedicButton("Regular", kind: kind, size: .regular, leadingSystemImage: "plus") {}
                        MedicButton("Off", kind: kind, size: .regular, trailingSystemImage: "chevron.right") {}.disabled(true)
                    }
                }
            }
            .padding(16)
        }
    }

    func testBadges() throws {
        try snapshot("badge", width: 390) {
            VStack(alignment: .leading, spacing: 12) {
                ForEach([MedicBadgeStyle.soft, .strong], id: \.self) { style in
                    HStack(spacing: 8) {
                        MedicBadge("Info", type: .info, style: style, showDot: true)
                        MedicBadge("Sucesso", type: .success, style: style)
                        MedicBadge("Aviso", type: .warning, style: style)
                        MedicBadge("Erro", type: .error, style: style)
                        MedicBadge("Neutro", type: .neutral, style: style)
                    }
                }
            }
            .padding(16)
        }
    }

    func testSectionHeaders() throws {
        try snapshot("section-header", width: 375) {
            VStack(spacing: 0) {
                MedicSectionHeader("Resumo")
                MedicSectionHeader("Resumo", actionLabel: "Ver tudo")
                MedicSectionHeader("Prontuário", style: .prominent)
                MedicSectionHeader("Prontuário", style: .prominent, actionLabel: "Ver tudo")
            }
        }
    }

    func testTextFields() throws {
        try snapshot("text-field", width: 375) {
            VStack(spacing: 16) {
                MedicTextField(text: .constant(""), label: "Nome", placeholder: "Nome completo", helper: "Como no documento", isRequired: true)
                MedicTextField(text: .constant("Maria Souza"), label: "Preenchido", placeholder: "Nome completo")
                MedicTextField(text: .constant("abc"), label: "Erro", helper: "Valor inválido", state: .error, trailingSystemImage: "exclamationmark.circle")
                MedicTextField(text: .constant("ok"), label: "Sucesso", helper: "Tudo certo", state: .success)
                MedicTextField(text: .constant(""), label: "Desabilitado", placeholder: "Indisponível", state: .disabled, leadingSystemImage: "lock.fill")
            }
            .padding(16)
        }
    }

    func testTableRows() throws {
        try snapshot("table-row", width: 375) {
            VStack(spacing: 0) {
                MedicTableRow("Somente título")
                MedicTableRow("Com chevron", showChevron: true)
                MedicTableRow("Rótulo e chevron", rightLabel: "Label", showChevron: true)
                MedicTableRow("Maria Souza", subtitle: "Cardiologia", detail: "Sala 12", date: "12/11", showChevron: true) {
                    MedicIcon("person.circle", color: MedicColor.iconBrandSecondary)
                }
                MedicTableRow("Selecionada", trailingSystemImage: "checkmark")
                MedicTableRow("Destrutiva", isDestructive: true)
                MedicTableRow("Desabilitada", showChevron: true).disabled(true)
            }
        }
    }

    func testTopNavigation() throws {
        try snapshot("top-navigation", width: 414) {
            VStack(spacing: 24) {
                MedicTopNavigation(title: "Paciente", backTitle: "Voltar", onBack: {}, trailing: { Text("Editar") })
                MedicTopNavigation(largeTitle: "Pacientes", search: .constant(""))
            }
        }
    }

    func testTabBar() throws {
        try snapshot("tab-bar", width: 414) {
            VStack(spacing: 16) {
                MedicTabBar(items: Self.tabs(4), selection: .constant(0))
                MedicTabBar(items: Self.tabs(3), selection: .constant(2))
            }
        }
    }

    // MARK: - Apoio

    private static func tabs(_ count: Int) -> [MedicTabItem] {
        let all = [
            MedicTabItem(id: 0, title: "Pacientes", systemImage: "person.2.fill"),
            MedicTabItem(id: 1, title: "Parecer", systemImage: "doc.text.fill"),
            MedicTabItem(id: 2, title: "Notificações", systemImage: "bell.fill"),
            MedicTabItem(id: 3, title: "Perfil", systemImage: "person.circle")
        ]
        return Array(all.prefix(count))
    }

    private func snapshot<V: View>(_ name: String, width: CGFloat, @ViewBuilder content: () -> V) throws {
        let view = content()
        for (suffix, style) in [("light", UIUserInterfaceStyle.light), ("dark", .dark)] {
            let image = render(view, width: width, style: style)
            XCTAssertGreaterThan(image.size.width, 0, "\(name)-\(suffix): imagem vazia")
            XCTAssertGreaterThan(image.size.height, 0, "\(name)-\(suffix): imagem vazia")

            let data = try XCTUnwrap(image.pngData(), "\(name)-\(suffix): falha ao gerar PNG")
            let dir = ProcessInfo.processInfo.environment["SNAPSHOT_DIR"].map { URL(fileURLWithPath: $0) }
                ?? URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("snapshots")
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
            try data.write(to: dir.appendingPathComponent("\(name)-\(suffix).png"))

            let attachment = XCTAttachment(image: image)
            attachment.name = "\(name)-\(suffix)"
            attachment.lifetime = .keepAlways
            add(attachment)
        }
    }

    private func render<V: View>(_ view: V, width: CGFloat, style: UIUserInterfaceStyle) -> UIImage {
        // Fundo do app atrás do componente, como numa tela real.
        let framed = view
            .frame(width: width)
            .background(MedicColor.surfaceSecondary)
        let host = UIHostingController(rootView: framed)
        host.overrideUserInterfaceStyle = style
        let size = host.sizeThatFits(in: CGSize(width: width, height: .greatestFiniteMagnitude))

        let window = UIWindow(frame: CGRect(origin: .zero, size: size))
        window.overrideUserInterfaceStyle = style
        window.rootViewController = host
        window.makeKeyAndVisible()
        host.view.frame = window.bounds
        host.view.layoutIfNeeded()

        let renderer = UIGraphicsImageRenderer(bounds: window.bounds)
        return renderer.image { _ in
            host.view.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }
    }
}

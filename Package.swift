// swift-tools-version: 5.9
// Design System - iOS (Medic). Pacote Swift com tokens e componentes SwiftUI.
// A versão mínima de iOS (16) foi escolhida pelo assistente: confirme/ajuste conforme o app.
import PackageDescription

let package = Package(
    name: "MedicDesignSystem",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "MedicDesignSystem", targets: ["MedicDesignSystem"])
    ],
    targets: [
        .target(name: "MedicDesignSystem")
    ]
)

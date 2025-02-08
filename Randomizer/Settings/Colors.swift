//
//  Colors.swift
//  Randomizer
//
//  Created by Max Chuquimia on 4/6/2024.
//

import Foundation
import SwiftUI

enum ColorThemes: String, CaseIterable {
    case classic
    case navy
    case nightOcean
    case ocean
    case lightPurple
    case terracotta
    case lightCherry
    case cherry
    case forest
    case moss
    case bumbleBee

    var background: Color {
        switch self {
        case .classic: return .blue
        case .bumbleBee: return Color(hex: "#101820")
        case .cherry: return Color(hex: "#990011")
        case .ocean: return Color(hex: "#8AAAE5")
        case .nightOcean: return Color(hex: "#00246B")
        case .lightCherry: return Color(hex: "#CC313D")
        case .moss: return Color(hex: "#2C5F2D")
        case .terracotta: return Color(hex: "#B85042")
        case .lightPurple: return Color(hex: "#735DA5")
        case .forest: return Color(hex: "#31473A")
        case .navy: return Color(hex: "#002C54")
        }
    }

    var foreground: Color {
        switch self {
        case .classic: return .white
        case .bumbleBee: return Color(hex: "#FEE715")
        case .cherry: return Color(hex: "#FCF6F5")
        case .ocean: return Color(hex: "#FFFFFF")
        case .nightOcean: return Color(hex: "#CADCFC")
        case .lightCherry: return Color(hex: "#F7C5CC")
        case .moss: return Color(hex: "#97BC62")
        case .terracotta: return Color(hex: "#E7E8D1")
        case .lightPurple: return Color(hex: "#D3C5E5")
        case .forest: return Color(hex: "#EDF4F2")
        case .navy: return Color(hex: "#C5001A")
        }
    }
}


private extension Color {

    init(hex: String) {
        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0

        let scanner = Scanner(string: hex)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: " #")
        guard scanner.scanHexInt64(&rgb) else {
            self.init(red: 0, green: 0, blue: 0)
            return
        }

        r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }

}

struct ColorThemeButton: View {
    let theme: ColorThemes
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(theme.background)
                    .frame(width: 80, height: 80)
                    .shadow(color: .black.opacity(0.1), radius: 6)

                Image(systemName: "arrowshape.right.fill")
                    .font(.largeTitle)
                    .foregroundColor(theme.foreground)
            }
        }
    }
}

//
//  Directions.swift
//  Randomizer
//
//  Created by Max Chuquimia on 8/2/2025.
//

import SwiftUI

enum DirectionSettings: String, CaseIterable {
    case horizontal
    case vertical
    case four

    var icon: String {
        switch self {
        case .horizontal: return "arrow.left.arrow.right"
        case .vertical: return "arrow.up.arrow.down"
        case .four: return "arrow.up.and.down.and.arrow.left.and.right"
        }
    }

    var allDirections: [Double] {
        switch self {
        case .horizontal: return [0.0, 180.0]
        case .vertical: return [90.0, 270.0]
        case .four: return [0.0, 90.0, 180.0, 270.0]
        }
    }

    func getNextRotation() -> Double {
        allDirections.randomElement()!
    }

}

struct DirectionButton: View {
    let theme: ColorThemes
    let setting: DirectionSettings
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(theme.background)
                    .frame(width: 80, height: 80)
                    .shadow(color: .black.opacity(0.2), radius: 6)

                Image(systemName: setting.icon)
                    .font(.largeTitle)
                    .foregroundColor(theme.foreground)
            }
        }
    }

}

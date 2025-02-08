//
//  DelayAnimationView.swift
//  Randomizer
//
//  Created by Max Chuquimia on 8/2/2025.
//

import Foundation
import SwiftUI

// Tweaked version of one https://github.com/SwiftfulThinking/SwiftfulLoadingIndicators
struct DelayAnimationView: View {
    @State var isAnimating: Bool = false
    let timing: Double

    let maxCounter: Int = 3
    let frame: CGSize
    let color: Color

    init(color: Color = .black, size: CGFloat = 50, speed: Double = 0.5) {
        timing = speed * 4
        frame = CGSize(width: size, height: size)
        self.color = color
    }

    var body: some View {
        ZStack {
            ForEach(0..<maxCounter, id: \.self) { index in
                Circle()
                    .stroke(
                        color.opacity(isAnimating ? 0.0 : 0.9),
                        style: StrokeStyle(lineWidth: isAnimating ? 0.0 : 20.0))
                    .scaleEffect(isAnimating ? 1.0 : 0.0)
                    .animation(
                        Animation.easeOut(duration: timing)
                            .repeatForever(autoreverses: false)
                            .delay(Double(index) * timing / Double(maxCounter)),
                        value: isAnimating
                    )
            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .center)
        .onAppear {
            isAnimating.toggle()
        }
    }
}

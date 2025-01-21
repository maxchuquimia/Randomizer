//
//  ContentView.swift
//  Randomizer
//
//  Created by Max Chuquimia on 4/6/2024.
//

import SwiftUI

enum Direction {
    case left
    case right

    var angle: Double {
        switch self {
        case .left: return 180
        case .right: return 0
        }
    }
}

struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        ZStack {
            viewModel.theme.background.edgesIgnoringSafeArea(.all)

            if viewModel.isOnboardingVisible {
                onboardingView
            }

            Image(systemName: "arrowshape.right.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(viewModel.theme.foreground)
                .padding(50)
                .opacity(viewModel.isVisible ? 1 : 0)
                .animation(.linear(duration: 0.2), value: viewModel.isVisible)
                .shadow(radius: 10)
                .disabled(true)
                .rotationEffect(.degrees(viewModel.direction.angle))
        }
        .onTapGesture(count: 1) {
            viewModel.switchDirection()
        }
        .onLongPressGesture(perform: {
            viewModel.isSettingsVisible.toggle()
        })
        .overlay(alignment: .bottom) {
            settingsContent
                .edgesIgnoringSafeArea(.bottom)
                .offset(y: viewModel.isSettingsVisible ? 0 : 150)
                .frame(height: 100)
                .animation(.spring(), value: viewModel.isSettingsVisible)
        }
    }

    var settingsContent: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(ColorThemes.allCases, id: \.self) { theme in
                    ColorThemeButton(theme: theme) {
                        viewModel.use(theme: theme)
                    }
                    .padding(10)
                }
            }
            .padding()
        }
    }

    var onboardingView: some View {
        VStack(spacing: 16) {
            Text("TAP TO SELECT DIRECTION")
                .font(.title)
                .fontWeight(.light)
                .foregroundColor(viewModel.theme.foreground)

            Text("PRESS AND HOLD FOR OPTIONS")
                .font(.body)
                .fontWeight(.light)
                .foregroundColor(viewModel.theme.foreground)
        }
    }
}

extension ContentView {
    


}

#Preview {
    ContentView()
}

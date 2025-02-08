//
//  ContentView.swift
//  Randomizer
//
//  Created by Max Chuquimia on 4/6/2024.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                viewModel.theme.background.edgesIgnoringSafeArea(.all)
                
                if viewModel.isOnboardingVisible {
                    onboardingView
                }
                
                if viewModel.isWaitingToShow {
                    DelayAnimationView(
                        color: viewModel.theme.foreground,
                        size: min(proxy.size.width, proxy.size.height) * 0.9,
                        speed: 0.85
                    )
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
                    .rotationEffect(.degrees(viewModel.arrowAngle))
            }
            .onTapGesture(count: 1) { location in
                viewModel.handleSingleTap()
            }
            .onLongPressGesture(perform: {
                viewModel.handleLongPress()
            })
            .sheet(isPresented: $viewModel.isSettingsVisible, content: {
                SettingsView()
                    .environmentObject(viewModel)
            })
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

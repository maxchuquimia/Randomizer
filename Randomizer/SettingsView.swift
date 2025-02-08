//
//  SettingsView.swift
//  Randomizer
//
//  Created by Max Chuquimia on 8/2/2025.
//

import Foundation
import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack {
                titleView(string: "Theme", description: "What's your favorite color?") {
                    scrollView {
                        ForEach(ColorThemes.allCases, id: \.self) { theme in
                            ColorThemeButton(theme: theme) {
                                viewModel.theme = theme
                            }
                            .overlay(alignment: .bottomTrailing) {
                                if viewModel.theme == theme {
                                    checkmarkView()
                                }
                            }
                        }
                    }
                }

                titleView(string: "Arrow Direction", description: "Where do the arrows point?") {
                    scrollView {
                        ForEach(DirectionSettings.allCases, id: \.self) { direction in
                            DirectionButton(theme: viewModel.theme, setting: direction) {
                                viewModel.direction = direction
                            }
                            .overlay(alignment: .bottomTrailing) {
                                if viewModel.direction == direction {
                                    checkmarkView()
                                }
                            }
                        }
                    }
                }

                titleView(string: "Tap Delay", description: "How long does it take for the arrow to appear?") {
                    HStack(alignment: .center, spacing: 0) {
                        Picker("Tap Delay", selection: $viewModel.delay) {
                            ForEach(DelaySetting.allCases, id: \.self) { delay in
                                Text(delay.title)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(MenuPickerStyle())
                        .fixedSize()
                        .padding(.horizontal, -8)
                        Text("after tapping.")
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal)
                }

                titleView(string: "Arrow Duration", description: "How long does the arrow stay on screen?") {
                    HStack {
                        Text("\(Int(viewModel.arrowDuration)) seconds")
                            .monospacedDigit()
                        Slider(value: $viewModel.arrowDuration, in: DurationSetting.min...DurationSetting.max, step: 1)
                    }
                    .padding(.horizontal)
                }

                Spacer()

                HStack(spacing: 0) {
                    Text("Version \(version) (\(build)) • © \(year) ")
                        .font(.subheadline)

                    Button {
                        UIApplication.shared.open(URL(string: "https://mergeable.io/")!)
                    } label: {
                        Text("Mergeable")
                            .foregroundColor(.accentColor)
                            .font(.subheadline)
                    }
                }
                .padding(.bottom, 10)
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        viewModel.isSettingsVisible = false
                    }
                }
            }
        }
    }

    func titleView<Content: View> (string: String, description: String, content: () -> Content) -> some View {
        VStack {
            Text(string)
                .font(.title2)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(description)
                .font(.subheadline)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)

            content()
        }
        .padding(.top, 10)
    }

    func scrollView<Content: View> (content: () -> Content) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                content()
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }

    func checkmarkView() -> some View {
        Color.clear
            .frame(width: 24, height: 24)
            .overlay {
                Image(systemName: "checkmark.circle.fill")
                    .fontWeight(.medium)
                    .foregroundColor(viewModel.theme.foreground)
                    .frame(width: 12, height: 12)
            }
    }

}

private extension SettingsView {

    var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    var build: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }

    var year: String {
        let calendar = Calendar.current
        return String(calendar.component(.year, from: Date()))
    }

}

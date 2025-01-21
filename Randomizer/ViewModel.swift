//
//  ViewModel.swift
//  Randomizer
//
//  Created by Max Chuquimia on 4/6/2024.
//

import Foundation

final class ViewModel: ObservableObject {

    @Published var direction: Direction = .left
    @Published var isVisible: Bool = false
    @Published var isOnboardingVisible: Bool = true
    @Published var isSettingsVisible: Bool = false
    @Published var theme: ColorThemes = .classic

    var hideWorkItem: DispatchWorkItem?

    init() {
        loadCurrentTheme()
    }

    func switchDirection() {
        self.hideWorkItem?.cancel()

        let randomDirection: Direction = Bool.random() ? .left : .right
        isVisible = false
        isOnboardingVisible = false
        isSettingsVisible = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.direction = randomDirection
            self.isVisible = true

            self.hideWorkItem = DispatchWorkItem {
                self.isVisible = false
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.hideWorkItem!)
        }
    }

    func storeCurrentTheme() {
        UserDefaults.standard.set(theme.rawValue, forKey: "v2theme")
    }

    func loadCurrentTheme() {
        if let theme = UserDefaults.standard.string(forKey: "v2theme") {
            self.theme = ColorThemes(rawValue: theme) ?? .classic
        }
    }

    func use(theme: ColorThemes) {
        self.theme = theme
        storeCurrentTheme()
        isOnboardingVisible = true
    }

}

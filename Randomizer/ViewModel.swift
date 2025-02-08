//
//  ViewModel.swift
//  Randomizer
//
//  Created by Max Chuquimia on 4/6/2024.
//

import Foundation
import Combine

@MainActor
final class ViewModel: ObservableObject {

    @Published var arrowAngle: Double = 0
    @Published var isVisible: Bool = false
    @Published var isOnboardingVisible: Bool = true
    @Published var isSettingsVisible: Bool = false
    @Published var isWaitingToShow: Bool = false
    @Published var direction: DirectionSettings = .horizontal
    @Published var theme: ColorThemes = .classic
    @Published var delay: DelaySetting = .immediate
    @Published var arrowDuration: Double = DurationSetting.min

    private var cancellables: Set<AnyCancellable> = []
    private var onTapTask: Task<Void, Never>?

    init() {
        setup()
    }

    func handleSingleTap() {
        self.onTapTask?.cancel()

        onTapTask = Task(priority: .userInitiated) {
            try? await chooseRandomDirection()
        }
    }

    func handleLongPress() {
        isSettingsVisible.toggle()
    }

    func saveSettings() {
        print("Saving settings")
        storeCurrentSettings()
        isOnboardingVisible = true
    }

}

private extension ViewModel {

    func setup() {
        loadCurrentSettings()

        $theme
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] theme in
                self?.saveSettings()
            }
            .store(in: &cancellables)

        $delay
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] delay in
                self?.saveSettings()
            }
            .store(in: &cancellables)

        $arrowDuration
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] arrowDuration in
                self?.saveSettings()
            }
            .store(in: &cancellables)

        $direction
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] direction in
                self?.saveSettings()
            }
            .store(in: &cancellables)
    }

    func chooseRandomDirection() async throws {
        isVisible = false
        isOnboardingVisible = false
        isSettingsVisible = false

        let delay = self.delay.getInterval()

        if delay > 0.0 {
            isWaitingToShow = true
            try await Task.sleep(for: .milliseconds(Int(delay * 1000)))
        } else {
            // Let the finger move away before showing the arrow / ensure previous arrow has disappeared
            try await Task.sleep(for: .milliseconds(200))
        }

        self.arrowAngle = direction.getNextRotation()
        self.isVisible = true
        self.isWaitingToShow = false

        try await Task.sleep(for: .milliseconds(Int(arrowDuration * 1000)))

        self.isVisible = false
    }

    func storeCurrentSettings() {
        UserDefaults.standard.set(theme.rawValue, forKey: "v2theme")
        UserDefaults.standard.set(delay.rawValue, forKey: "v2delay")
        UserDefaults.standard.set(arrowDuration, forKey: "v2arrowDuration")
        UserDefaults.standard.set(direction.rawValue, forKey: "v2direction")
        UserDefaults.standard.synchronize()
    }

    func loadCurrentSettings() {
        if let theme = UserDefaults.standard.string(forKey: "v2theme") {
            self.theme = ColorThemes(rawValue: theme) ?? .classic
        }

        if let delay = UserDefaults.standard.string(forKey: "v2delay") {
            self.delay = DelaySetting(rawValue: delay) ?? .immediate
        }

        if let arrowDuration = UserDefaults.standard.object(forKey: "v2arrowDuration") as? Double, arrowDuration >= DurationSetting.min {
            self.arrowDuration = arrowDuration
        }

        if let direction = UserDefaults.standard.string(forKey: "v2direction") {
            self.direction = DirectionSettings(rawValue: direction) ?? .horizontal
        }
    }

}

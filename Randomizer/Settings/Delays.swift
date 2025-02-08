//
//  Delays.swift
//  Randomizer
//
//  Created by Max Chuquimia on 8/2/2025.
//

import Foundation

enum DelaySetting: String, CaseIterable {
    // Used as user defaults keys
    case immediate
    case two
    case five
    case twoTen
    case fiveFifteen

    var title: String {
        switch self {
        case .immediate: return "Immediately"
        case .two: return "2 seconds"
        case .five: return "5 seconds"
        case .twoTen: return "Between 2 and 10 seconds"
        case .fiveFifteen: return "Between 5 and 15 seconds"
        }
    }

    func getInterval() -> TimeInterval {
        switch self {
        case .immediate: return 0
        case .two: return 2
        case .five: return 5
        case .twoTen: return TimeInterval.random(in: 2...10)
        case .fiveFifteen: return TimeInterval.random(in: 5...15)
        }
    }

}

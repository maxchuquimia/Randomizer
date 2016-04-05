//
//  Randomizer.swift
//  Randomizer
//
//  Created by Max Chuquimia on 5/04/2016.
//  Copyright © 2016 Chuquimian Productions. All rights reserved.
//

import Foundation

struct Randomizer {

     static func zeroOrOne() -> Int {
        return Int(arc4random() % 2)
    }
}
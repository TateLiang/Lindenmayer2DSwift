//
//  LSystem.swift
//  LSystemDrawing
//
//  Created by Tate on 2020-08-20.
//  Copyright © 2020 Tate Liang. All rights reserved.
//

import Foundation

public struct LSystem {
    
    public var rules: [String: String]
    public var axiom: String
    
    public var strings: [String]
    public var currentString: String { strings.last ?? "" }
    public var generations: Int { strings.count }
    
    /**
     Creates an LSystem.
     - Parameter axiom: The string to start with.
     - Parameter rules: The rules to follow.
     */
    public init(_ axiom: String, _ rules: [String: String]) {
        self.rules = rules
        self.axiom = axiom
        self.strings = [axiom]
    }
    
    /**
     Advances the generation of the LSystem by adding a string to strings.
     */
    @discardableResult public mutating func advanceGeneration() -> String {
        var newString = ""
        for char in currentString {
            var changed = false
            for rule in rules {
                if String(char) == rule.key {
                    newString += rule.value
                    changed = true
                    break
                }
            }
            if !changed {
                newString += String(char)
            }
        }
        strings.append(newString)
        return currentString
    }
    
    /**
     Advances the generation by the specified number of generations.
     */
    public mutating func advanceGeneration(by generations: Int) {
        guard generations > 0 else { return }
        for _ in 0..<generations {
            advanceGeneration()
        }
    }
    
}

//
//  Library.swift
//  LSystemDrawing
//
//  Created by Tate on 2020-08-20.
//  Copyright © 2020 Tate Liang. All rights reserved.
//

import Foundation

public struct Library {
    
    public struct Tree {
        public var angle: Double
        public var lengthFactor: Double
        public var lsystem: LSystem
        
        public init(angle: Double = 0, lengthFactor: Double = 1, _ lsystem: LSystem) {
            self.lsystem = lsystem
            self.angle = angle * (.pi/180)
            self.lengthFactor = lengthFactor
        }
        
    }
    
    /** Willow-like tree */
    public static let tree1 = Tree(
        angle: 30,
        
        LSystem("F", [
            "F": "FF+[+F-F-F]-[-F+F+F]"
        ])
    )
    
    /** Curved, branchy tree */
    public static let tree2 = Tree(
        angle: 20,
        
        LSystem("X", [
            "F": "FF",
            "X": "F-[[X]+X]+F[+FX]-X"
        ])
    )
    
    /** Straight tree */
    public static let tree3 = Tree(
        angle: 45,
        lengthFactor: 1.36,
        
        LSystem("A", [
            "F": ">F<",
            "A": "F[+X]FB",
            "B": "F[-Y]FA",
            "X": "A",
            "Y": "B"
        ])
    )
    
    /** Thin bush */
    public static let tree4 = Tree(
        angle: 25.7,
        
        LSystem("Y", [
            "X": "X[-FFF][+FFF]FX",
            "Y": "YFX[+Y][-Y]"
        ])
    )
    
    /** Cauliflower bush */
    public static let tree5 = Tree(
        angle: 35,
        
        LSystem("F", [
            "F": "F[+FF][-FF]F[-F][+F]F"
        ])
    )
    
    /** Weird Fern */
    public static let tree6 = Tree(
        angle: 20,
        
        LSystem("VZFFF", [
            "V": "[+++W][---W]YV",
            "W": "+X[-W]Z",
            "X": "-W[+X]Z",
            "Y": "YZ",
            "Z": "[-FFF][+FFF]F"
        ])
    )
    
    /** Fractal Tree */
    public static let tree7 = Tree(
        angle: 40,
        lengthFactor: 0.6,
        
        LSystem("FX", [
            "X": ">[-FX]+FX<"
        ])
    )
    
    /** Weed */
    public static let tree8 = Tree(
        angle: 22.5,
        
        LSystem("F", [
            "F": "FF-[XY]+[XY]",
            "X": "+FY",
            "Y": "-FX"
        ])
    )
    
    /** Spruce Tree */
    public static let tree9 = Tree(
        angle: 25.7,
        
        LSystem("X", [
            "X": "F[+X][-X]FX",
            "F": "FF"
        ])
    )
    
    static let tree10 = Library.Tree(
        angle: 25.7,
        
        LSystem("X", [
            "X": "F+[-F-XF-X][+FF][--XF[+X]][++F-X]",
            "F": "FF"
        ])
    )
    
    static let tree11 = Library.Tree(
        angle: 15,
        
        LSystem("X", [
            "X": "FF[+XZ++X-F[+ZX]][-X++F-X]",
            "F": "FX[FX[+XF]]",
            "Z": "[+F-X-F][++ZX]"
        ])
    )
    
    static let tree12 = Library.Tree(
        angle: 10,
        
        LSystem("X", [
            "X": "-F[+F][---X]+F-F[++++X]-X",
            "F": "FF"
        ])
    )
}

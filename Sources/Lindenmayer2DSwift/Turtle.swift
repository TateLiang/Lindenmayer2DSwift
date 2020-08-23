//
//  Turtle.swift
//  LSystemDrawing
//
//  Created by Tate on 2020-08-20.
//  Copyright © 2020 Tate Liang. All rights reserved.
//

import Foundation
import UIKit

public struct Turtle {
    
    public typealias Radian = Double
    
    //parameters
    public var initialLength: Double
    public var initialAngle: Radian
    public var initialPos: Coordinate
    public var angle: Radian
    public var lengthFactor: Double
    
    //keeping track of traversal
    private lazy var currentLength = initialLength
    private lazy var currentPos = initialPos
    private lazy var currentAngle = initialAngle
    private var stack = Stack<(pos: Coordinate, angle: Radian)>()
    
    //output
    public var root: Coordinate?
    public var graph: [Coordinate: [Coordinate]] = [:]
    public var edgeList: [(Coordinate, Coordinate)] {
        var edges: [(Coordinate, Coordinate)] = []
        graph.forEach { (origin, destinations) in
            destinations.forEach { destination in
                edges.append((origin, destination))
            }
        }
        return edges
    }
    
    /**
     Initializes a turtle object.
     - Parameter length: the length of each forward command.
     - Parameter lengthFactor: the factor to change the length of the turtle.
     - Parameter angle: the amount to turn for each turn command.
     - Parameter initialPos: the initial position of the turtle.
     - Parameter initialAngle: the initial angle of the turtle.
     */
    public init(initialLength: Double = 0,
         initialPos: Coordinate = Coordinate(0, 0),
         initialAngle: Double = .pi/2,
         angle: Double = 0,
         lengthFactor: Double = 1) {
        
        self.initialLength = initialLength
        self.initialPos = initialPos
        self.initialAngle = initialAngle
        self.angle = angle
        self.lengthFactor = lengthFactor
    }
    
    /**
     Runs the turtle with the given string.
     - Parameter initialPos: the initial position of the turtle.
     - Parameter string: the string to follow.
     */
    public mutating func run(_ string: String) {
        root = nil
        graph = [:]
        currentLength = initialLength
        currentPos = initialPos
        currentAngle = initialAngle
        
        for char in string {
            switch char {
            case "F":
                if graph.isEmpty {
                    root = currentPos
                }
                graph[currentPos, default: []].append(forward())
            case "+":
                rotate(-angle)
            case "-":
                rotate(angle)
            case "[":
                push()
            case "]":
                pop()
            case ">":
                multiplyLength()
            case "<":
                divideLength()
            default:
                break
            }
        }
    }
    
    
    
    //MARK: - Turtle Functions
    
    @discardableResult private mutating func forward() -> Coordinate {
        let destination = Coordinate(currentPos.x + (currentLength * cos(currentAngle)),
                           currentPos.y + (currentLength * sin(currentAngle)))
        currentPos = destination
        return destination
    }
    
    private mutating func rotate(_ radian: Radian) {
        currentAngle += radian
    }
    
    private mutating func multiplyLength() {
        currentLength *= lengthFactor
    }
    
    private mutating func divideLength() {
        currentLength /= lengthFactor
    }
    
    
    //MARK: - Stack
    
    private mutating func push() {
        stack.push((pos: currentPos, angle: currentAngle))
    }
    private mutating func pop() {
        if let state = stack.pop() {
            currentPos = state.pos
            currentAngle = state.angle
        }
    }
    
    private struct Stack<T> {
        private var array = [T]()
        
        var isEmpty: Bool { array.isEmpty }
        var count: Int { array.count }
        var top: T? { array.last }
        var bottom: T? { array.first }
        
        mutating func push(_ element: T) {
            array.append(element)
        }
        mutating func pop() -> T? {
            array.popLast()
        }
    }
    
    
    
    //MARK: - Types
    
    /**
     Defines a coordinate in space.
     - Convertable to and from CGPoint.
     */
    public struct Coordinate: Hashable {
        public var x: Double
        public var y: Double
        
        
        public init(_ x: Double, _ y: Double) {
            self.x = x
            self.y = y
        }
        public init(_ x: Int, _ y: Int) {
            self.x = Double(x)
            self.y = Double(y)
        }
        public init(_ x: CGFloat, _ y: CGFloat) {
            self.x = Double(x)
            self.y = Double(y)
        }
        public init(_ point: CGPoint) {
            self.x = Double(point.x)
            self.y = Double(point.y)
        }
        
        public var cgPoint: CGPoint {
            CGPoint(x: x, y: y)
        }
    }
    
}

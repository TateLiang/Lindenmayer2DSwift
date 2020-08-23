# Lindenmayer2DSwift

Lindenmayer2DSwift is a swift framework that generates trees and other fractal structures using L-Systems.

## Examples


## Installation

The Lindenmayer2DSwift framework can be installed using the Swift Package Manager. In Xcode: `File > Swift Packages > Add Package Dependency..` with URL: `https://github.com/TateLiang/Lindenmayer2DSwift.git`

Or alternatively:
- Add `.package(url: "https://github.com/TateLiang/FortuneSwift.git", from: "1.0.3")` to your `Package.swift` file's `dependencies`.
- Update your packages using `$ swift package update`.

## Setup

1. Add package dependancy
2. Import `import Lindenmayer2DSwift`
3. Create a `Turtle` object
```swift
var turtle = Turtle()
```
4. Create a `LSystem` object
```swift
var lsystem = LSystem("X", [
    "F": "FF",
    "X": "F-[[X]+X]+F[+FX]-X"
])
```
Alternatively, use one of the preset trees of type `Tree`:
```swift
var tree = Library.tree3
```
<br>5. Setup the turtle with custom values:
```swift

private func setupTurtle() {
    turtle.initialLength = 100
    turtle.initialPos = Turtle.Coordinate(canvas.bounds.midX, canvas.bounds.minY)
    turtle.initialAngle = .pi/2
    turtle.angle = .pi/6
    turtle.lengthFactor = 1.3
}
```
Alternatively, use the preset tree's values:
```swift
private func setupTurtle() {
    turtle.initialLength = 100
    turtle.initialPos = Turtle.Coordinate(canvas.bounds.midX, canvas.bounds.minY)
    turtle.angle = tree.angle
    turtle.lengthFactor = tree.lengthFactor
}
```

## Processing Graph

### Example of using Lindenmayer2DSwift:
```swift

var tree = Library.tree3
var turtle = Turtle(initialLength: 100)

private func setupTurtle() {
    turtle.initialPos = Turtle.Coordinate(canvas.bounds.midX, canvas.bounds.minY)
    turtle.angle = tree.angle
    turtle.lengthFactor = tree.lengthFactor
}
    
private func nextGeneration() {
    let string = tree.lsystem.advanceGeneration()
        
    turtle.run(string)
    turtle.initialLength *= 0.66
        
    let edges = turtle.edgeList.map { ($0.cgPoint, $1.cgPoint) }
    canvas.clear()
    canvas.drawEdges(at: edges, type: .thick)
}
```

### Details
Lindenmayer2DSwift uses two main objects, `LSystem` and `Turtle`.

1. An `LSystem` object is defined by the axiom and rules:
```swift
LSystem("X", [
    "F": "FF",
    "X": "F-[[X]+X]+F[+FX]-X"
])
```
The generation can be advanced using either:
```swift
@discardableResult public mutating func advanceGeneration() -> String
public mutating func advanceGeneration(by generations: Int)
```
The following properties are provided for accessing the string:
```swift
public var strings: [String]
public var currentString: String { strings.last ?? "" }
public var generations: Int { strings.count }
```
<br>2. The `Turtle` object can be run by using:
```swift 
public mutating func run(_ string: String)
```
The following properties are provided for accessing the resulting graph:
```swift
public var root: Coordinate?
public var graph: [Coordinate: [Coordinate]] = [:]
public var edgeList: [(Coordinate, Coordinate)]
```

### Sample Features

Coloring the edges differently depending on depth:

```swift
private func getEdgesByDepth(cutoff: Int) -> (near: [(CGPoint, CGPoint)], far: [(CGPoint, CGPoint)])? {
    guard let root = turtle.root else { return nil }
    let graph = turtle.graph
    var nearEdges: [(CGPoint, CGPoint)] = []
    var farEdges: [(CGPoint, CGPoint)] = []
        
    func dfs(node: Turtle.Coordinate, depth: Int) {
        if let nextNodes = graph[node] {
            if depth < cutoff {
                nextNodes.forEach {
                    nearEdges.append((node.cgPoint, $0.cgPoint))
                    dfs(node: $0, depth: depth+1)
                }
            }else {
                nextNodes.forEach {
                    farEdges.append((node.cgPoint, $0.cgPoint))
                    dfs(node: $0, depth: depth+1)
                }
            }
        }
    }
    dfs(node: root, depth: 0)
        
    return (near: nearEdges, far: farEdges)
}
```

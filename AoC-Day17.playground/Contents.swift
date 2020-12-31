import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var initialInput: [[State]] = data.components(separatedBy: "\n").dropLast().compactMap {
    $0.map { $0 == "." ? .inactive : .active}
}

enum State {
    case active
    case inactive
}

struct Position: Equatable, Hashable, CustomStringConvertible {
    let x: Int
    let y: Int
    let z: Int
    let w: Int
    
    var description: String {
        "(x: \(x), y: \(y), z: \(z), w: \(w))"
    }
}

var activeCubes = Set<Position>()

initialInput.enumerated().forEach { y, row in
    row.enumerated().forEach { x, state in
        if state == .active {
            activeCubes.insert(Position(x: x, y: y, z: 0, w: 0))
        }
    }
}

print(activeCubes)

func getNeighbours(position: Position) -> Set<Position> {
    var neighbours = Set<Position>()
    neighbours.insert(Position(x: position.x - 1, y: position.y,     z: position.z, w: position.w)) // Mid Left
    neighbours.insert(Position(x: position.x - 1, y: position.y - 1, z: position.z, w: position.w)) // Mid Top Left
    neighbours.insert(Position(x: position.x,     y: position.y - 1, z: position.z, w: position.w)) // Mid Top
    neighbours.insert(Position(x: position.x + 1, y: position.y - 1, z: position.z, w: position.w)) // Mid Top Right
    neighbours.insert(Position(x: position.x + 1, y: position.y,     z: position.z, w: position.w)) // Mid Right
    neighbours.insert(Position(x: position.x + 1, y: position.y + 1, z: position.z, w: position.w)) // Mid Bottom Right
    neighbours.insert(Position(x: position.x,     y: position.y + 1, z: position.z, w: position.w)) // Mid Bottom
    neighbours.insert(Position(x: position.x - 1, y: position.y + 1, z: position.z, w: position.w)) // Mid Bottom Left
    
    // Front Section
    neighbours.insert(Position(x: position.x - 1, y: position.y,     z: position.z + 1, w: position.w)) // Front Left
    neighbours.insert(Position(x: position.x - 1, y: position.y - 1, z: position.z + 1, w: position.w)) // Front Top Left
    neighbours.insert(Position(x: position.x,     y: position.y - 1, z: position.z + 1, w: position.w)) // Front Top
    neighbours.insert(Position(x: position.x + 1, y: position.y - 1, z: position.z + 1, w: position.w)) // Front Top Right
    neighbours.insert(Position(x: position.x + 1, y: position.y,     z: position.z + 1, w: position.w)) // Front Right
    neighbours.insert(Position(x: position.x + 1, y: position.y + 1, z: position.z + 1, w: position.w)) // Front Bottom Right
    neighbours.insert(Position(x: position.x,     y: position.y + 1, z: position.z + 1, w: position.w)) // Front Bottom
    neighbours.insert(Position(x: position.x - 1, y: position.y + 1, z: position.z + 1, w: position.w)) // Front Bottom Left
    neighbours.insert(Position(x: position.x,     y: position.y,     z: position.z + 1, w: position.w)) // Front Center
    
    // Back Section
    neighbours.insert(Position(x: position.x - 1, y: position.y,     z: position.z - 1, w: position.w)) // Back Left
    neighbours.insert(Position(x: position.x - 1, y: position.y - 1, z: position.z - 1, w: position.w)) // Back Top Left
    neighbours.insert(Position(x: position.x,     y: position.y - 1, z: position.z - 1, w: position.w)) // Back Top
    neighbours.insert(Position(x: position.x + 1, y: position.y - 1, z: position.z - 1, w: position.w)) // Back Top Right
    neighbours.insert(Position(x: position.x + 1, y: position.y,     z: position.z - 1, w: position.w)) // Back Right
    neighbours.insert(Position(x: position.x + 1, y: position.y + 1, z: position.z - 1, w: position.w)) // Back Bottom Right
    neighbours.insert(Position(x: position.x,     y: position.y + 1, z: position.z - 1, w: position.w)) // Back Bottom
    neighbours.insert(Position(x: position.x - 1, y: position.y + 1, z: position.z - 1, w: position.w)) // Back Bottom Left
    neighbours.insert(Position(x: position.x,     y: position.y,     z: position.z - 1, w: position.w)) // Back Center
    
    // Hyper cube sides..
    // Front Section
    neighbours.insert(Position(x: position.x - 1, y: position.y,     z: position.z, w: position.w + 1)) // Front Left
    neighbours.insert(Position(x: position.x - 1, y: position.y - 1, z: position.z, w: position.w + 1)) // Front Top Left
    neighbours.insert(Position(x: position.x,     y: position.y - 1, z: position.z, w: position.w + 1)) // Front Top
    neighbours.insert(Position(x: position.x + 1, y: position.y - 1, z: position.z, w: position.w + 1)) // Front Top Right
    neighbours.insert(Position(x: position.x + 1, y: position.y,     z: position.z, w: position.w + 1)) // Front Right
    neighbours.insert(Position(x: position.x + 1, y: position.y + 1, z: position.z, w: position.w + 1)) // Front Bottom Right
    neighbours.insert(Position(x: position.x,     y: position.y + 1, z: position.z, w: position.w + 1)) // Front Bottom
    neighbours.insert(Position(x: position.x - 1, y: position.y + 1, z: position.z, w: position.w + 1)) // Front Bottom Left
    neighbours.insert(Position(x: position.x,     y: position.y,     z: position.z, w: position.w + 1)) // Front Center
    
    // Back Section
    neighbours.insert(Position(x: position.x - 1, y: position.y,     z: position.z, w: position.w - 1)) // Back Left
    neighbours.insert(Position(x: position.x - 1, y: position.y - 1, z: position.z, w: position.w - 1)) // Back Top Left
    neighbours.insert(Position(x: position.x,     y: position.y - 1, z: position.z, w: position.w - 1)) // Back Top
    neighbours.insert(Position(x: position.x + 1, y: position.y - 1, z: position.z, w: position.w - 1)) // Back Top Right
    neighbours.insert(Position(x: position.x + 1, y: position.y,     z: position.z, w: position.w - 1)) // Back Right
    neighbours.insert(Position(x: position.x + 1, y: position.y + 1, z: position.z, w: position.w - 1)) // Back Bottom Right
    neighbours.insert(Position(x: position.x,     y: position.y + 1, z: position.z, w: position.w - 1)) // Back Bottom
    neighbours.insert(Position(x: position.x - 1, y: position.y + 1, z: position.z, w: position.w - 1)) // Back Bottom Left
    neighbours.insert(Position(x: position.x,     y: position.y,     z: position.z, w: position.w - 1)) // Back Center
    
    // Front Section
    neighbours.insert(Position(x: position.x - 1, y: position.y,     z: position.z + 1, w: position.w + 1)) // Front Left
    neighbours.insert(Position(x: position.x - 1, y: position.y - 1, z: position.z + 1, w: position.w + 1)) // Front Top Left
    neighbours.insert(Position(x: position.x,     y: position.y - 1, z: position.z + 1, w: position.w + 1)) // Front Top
    neighbours.insert(Position(x: position.x + 1, y: position.y - 1, z: position.z + 1, w: position.w + 1)) // Front Top Right
    neighbours.insert(Position(x: position.x + 1, y: position.y,     z: position.z + 1, w: position.w + 1)) // Front Right
    neighbours.insert(Position(x: position.x + 1, y: position.y + 1, z: position.z + 1, w: position.w + 1)) // Front Bottom Right
    neighbours.insert(Position(x: position.x,     y: position.y + 1, z: position.z + 1, w: position.w + 1)) // Front Bottom
    neighbours.insert(Position(x: position.x - 1, y: position.y + 1, z: position.z + 1, w: position.w + 1)) // Front Bottom Left
    neighbours.insert(Position(x: position.x,     y: position.y,     z: position.z + 1, w: position.w + 1)) // Front Center
    
    // Front Section
    neighbours.insert(Position(x: position.x - 1, y: position.y,     z: position.z - 1, w: position.w + 1)) // Front Left
    neighbours.insert(Position(x: position.x - 1, y: position.y - 1, z: position.z - 1, w: position.w + 1)) // Front Top Left
    neighbours.insert(Position(x: position.x,     y: position.y - 1, z: position.z - 1, w: position.w + 1)) // Front Top
    neighbours.insert(Position(x: position.x + 1, y: position.y - 1, z: position.z - 1, w: position.w + 1)) // Front Top Right
    neighbours.insert(Position(x: position.x + 1, y: position.y,     z: position.z - 1, w: position.w + 1)) // Front Right
    neighbours.insert(Position(x: position.x + 1, y: position.y + 1, z: position.z - 1, w: position.w + 1)) // Front Bottom Right
    neighbours.insert(Position(x: position.x,     y: position.y + 1, z: position.z - 1, w: position.w + 1)) // Front Bottom
    neighbours.insert(Position(x: position.x - 1, y: position.y + 1, z: position.z - 1, w: position.w + 1)) // Front Bottom Left
    neighbours.insert(Position(x: position.x,     y: position.y,     z: position.z - 1, w: position.w + 1)) // Front Center
    
    // Front Section
    neighbours.insert(Position(x: position.x - 1, y: position.y,     z: position.z + 1, w: position.w - 1)) // Front Left
    neighbours.insert(Position(x: position.x - 1, y: position.y - 1, z: position.z + 1, w: position.w - 1)) // Front Top Left
    neighbours.insert(Position(x: position.x,     y: position.y - 1, z: position.z + 1, w: position.w - 1)) // Front Top
    neighbours.insert(Position(x: position.x + 1, y: position.y - 1, z: position.z + 1, w: position.w - 1)) // Front Top Right
    neighbours.insert(Position(x: position.x + 1, y: position.y,     z: position.z + 1, w: position.w - 1)) // Front Right
    neighbours.insert(Position(x: position.x + 1, y: position.y + 1, z: position.z + 1, w: position.w - 1)) // Front Bottom Right
    neighbours.insert(Position(x: position.x,     y: position.y + 1, z: position.z + 1, w: position.w - 1)) // Front Bottom
    neighbours.insert(Position(x: position.x - 1, y: position.y + 1, z: position.z + 1, w: position.w - 1)) // Front Bottom Left
    neighbours.insert(Position(x: position.x,     y: position.y,     z: position.z + 1, w: position.w - 1)) // Front Center
    
    // Front Section
    neighbours.insert(Position(x: position.x - 1, y: position.y,     z: position.z - 1, w: position.w - 1)) // Front Left
    neighbours.insert(Position(x: position.x - 1, y: position.y - 1, z: position.z - 1, w: position.w - 1)) // Front Top Left
    neighbours.insert(Position(x: position.x,     y: position.y - 1, z: position.z - 1, w: position.w - 1)) // Front Top
    neighbours.insert(Position(x: position.x + 1, y: position.y - 1, z: position.z - 1, w: position.w - 1)) // Front Top Right
    neighbours.insert(Position(x: position.x + 1, y: position.y,     z: position.z - 1, w: position.w - 1)) // Front Right
    neighbours.insert(Position(x: position.x + 1, y: position.y + 1, z: position.z - 1, w: position.w - 1)) // Front Bottom Right
    neighbours.insert(Position(x: position.x,     y: position.y + 1, z: position.z - 1, w: position.w - 1)) // Front Bottom
    neighbours.insert(Position(x: position.x - 1, y: position.y + 1, z: position.z - 1, w: position.w - 1)) // Front Bottom Left
    neighbours.insert(Position(x: position.x,     y: position.y,     z: position.z - 1, w: position.w - 1)) // Front Center
    
    return neighbours
}

var iteration = 0

while iteration < 6 {
    var newActiveCubes = Set<Position>()
    var neighbours = Set<Position>()
    activeCubes.forEach {
        neighbours.formUnion(getNeighbours(position: $0).subtracting(activeCubes))
    }
    
    neighbours.forEach {
        if getNeighbours(position: $0).intersection(activeCubes).count == 3 {
            newActiveCubes.insert($0)
        }
    }

    activeCubes.forEach {
        let aliveNeighbours = getNeighbours(position: $0).intersection(activeCubes)
        let count = aliveNeighbours.count
        
        if  count >= 2 && count <= 3 {
            newActiveCubes.insert($0)
        }
    }

    activeCubes = newActiveCubes
    print("Iteration: \(iteration)")
    iteration += 1
}

print(activeCubes.count)

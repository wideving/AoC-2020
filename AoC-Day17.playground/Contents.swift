import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var initialInput: [[State]] = data.components(separatedBy: "\n").dropLast().compactMap {
    $0.map { $0 == "." ? .inactive : .active}
}

enum State: CustomStringConvertible {
    case active
    case inactive
    
    var description: String {
        switch self {
        case .active: return "#"
        case .inactive: return "."
        }
    }
}

struct Cube: CustomStringConvertible {
    var state: State

    init(initialState: State = .inactive) {
        self.state = initialState
    }
    
    var description: String {
        return state.description
    }
}

struct Position:  Equatable, Hashable, CustomStringConvertible {
    let x: Int
    let y: Int
    let z: Int
    
    var description: String {
        "x: \(x), y: \(y), z: \(z)"
    }
}

var board = [Position: Cube]()

initialInput.enumerated().forEach { rowIndex, row in
    print(row)
    row.enumerated().forEach { (columnIndex, state) in
        board[Position(x: columnIndex, y: rowIndex, z: 0)] = Cube(initialState: state)
    }
}

func getNeighbours(position: Position) -> [(position: Position, cube: Cube)] {
    var neighbours = [(position: Position, cube: Cube)]()
    
    // Mid section
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x - 1, y: position.y,     z: position.z))) // Mid Left
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x - 1, y: position.y - 1, z: position.z))) // Mid Top Left
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x,     y: position.y - 1, z: position.z))) // Mid Top
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x + 1, y: position.y - 1, z: position.z))) // Mid Top Right
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x + 1, y: position.y,     z: position.z))) // Mid Right
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x + 1, y: position.y + 1, z: position.z))) // Mid Bottom Right
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x,     y: position.y + 1, z: position.z))) // Mid Bottom
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x - 1, y: position.y + 1, z: position.z))) // Mid Bottom Left
    
    // Front Section
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x - 1, y: position.y,     z: position.z + 1))) // Front Left
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x - 1, y: position.y - 1, z: position.z + 1))) // Front Top Left
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x,     y: position.y - 1, z: position.z + 1))) // Front Top
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x + 1, y: position.y - 1, z: position.z + 1))) // Front Top Right
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x + 1, y: position.y,     z: position.z + 1))) // Front Right
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x + 1, y: position.y + 1, z: position.z + 1))) // Front Bottom Right
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x,     y: position.y + 1, z: position.z + 1))) // Front Bottom
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x - 1, y: position.y + 1, z: position.z + 1))) // Front Bottom Left
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x,     y: position.y,     z: position.z + 1))) // Front Center
    
    // Back Section
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x - 1, y: position.y,     z: position.z - 1))) // Back Left
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x - 1, y: position.y - 1, z: position.z - 1))) // Back Top Left
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x,     y: position.y - 1, z: position.z - 1))) // Back Top
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x + 1, y: position.y - 1, z: position.z - 1))) // Back Top Right
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x + 1, y: position.y,     z: position.z - 1))) // Back Right
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x + 1, y: position.y + 1, z: position.z - 1))) // Back Bottom Right
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x,     y: position.y + 1, z: position.z - 1))) // Back Bottom
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x - 1, y: position.y + 1, z: position.z - 1))) // Back Bottom Left
    neighbours.append(findOrCreateCubeOnBoard(position: Position(x: position.x,     y: position.y,     z: position.z - 1))) // Back Center
    
    return neighbours
}

func findOrCreateCubeOnBoard(position: Position) -> (position: Position, cube: Cube) {
    if let cube = board[position] {
        return (position, cube)
    } else {
        let cube = Cube()
        board[position] = cube
        return (position, cube)
    }
}

var iteration = 0

while iteration < 6 {
    var newBoard = [Position: Cube]()
    board.forEach { outerPosition, outerCube in
        getNeighbours(position: outerPosition)
    }
    
    newBoard = board
    

    newBoard.forEach { position, cube in
        let neighbours = getNeighbours(position: position)
        let activeNeighbours = neighbours.reduce(0) {
            $0 + ($1.cube.state == .active ? 1 : 0)
        }
        
        switch cube.state {
        case .active:
            if activeNeighbours < 2 || activeNeighbours > 3 {
                newBoard[position] = Cube(initialState: .inactive)
            } else {
                newBoard[position] = cube
            }
        case .inactive:
            if activeNeighbours == 3 {
                newBoard[position] = Cube(initialState: .active)
            } else {
                newBoard[position] = cube
            }
        }
    }
    
    board = newBoard
    iteration += 1
}

print(board.values.reduce(0, {$0 + ($1.state == .active ? 1 : 0)}))














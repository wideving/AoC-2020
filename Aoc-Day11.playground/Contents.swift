import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n")

enum Space {
    case floor
    case occupied
    case empty
    
    var asCharacter: String {
        switch self {
        case .floor:
            return "."
        case .occupied:
            return "#"
        case .empty:
            return "L"
        }
    }
}

let space: [[Space]] = inputs.map { row in
    row.map {
        switch $0 {
        case "L":
            return Space.empty
        case "#":
            return Space.occupied
        default:
            return Space.floor
        }
    }
}

struct Airplane {
    var space: [[Space]]
    var temporarySpace = [[Space]]()
    
    func findOccupiedSeats(row: Int, column: Int) -> Int {
        var amount = 0
        //Left
        if isNotOutOfBounds(row: row, column: column - 1) && space[row][column - 1] == .occupied {
            amount += 1
        }
        
        //Top left
        if isNotOutOfBounds(row: row - 1, column: column - 1) && space[row - 1][column - 1] == .occupied {
            amount += 1
        }
        
        //Above
        if isNotOutOfBounds(row: row - 1, column: column) && space[row - 1][column] == .occupied {
            amount += 1
        }
        
        //Top right
        if isNotOutOfBounds(row: row - 1, column: column + 1) && space[row - 1][column + 1] == .occupied {
            amount += 1
        }
        
        //Right
        if isNotOutOfBounds(row: row, column: column + 1) && space[row][column + 1] == .occupied {
            amount += 1
        }
        
        //Bottom right
        if isNotOutOfBounds(row: row + 1, column: column + 1) && space[row + 1][column + 1] == .occupied {
            amount += 1
        }
        
        //Below
        if isNotOutOfBounds(row: row + 1, column: column) && space[row + 1][column] == .occupied {
            amount += 1
        }
        
        //Bottom left
        if isNotOutOfBounds(row: row + 1, column: column - 1) && space[row + 1][column - 1] == .occupied {
            amount += 1
        }
        return amount
    }
    
    private func isNotOutOfBounds(row: Int, column: Int) -> Bool {
        return (row >= 0 && row < space.count) && (column >= 0 && column < space[row].count)
    }
    
    mutating func letInPassengers() {
        temporarySpace = space.map { $0 }
        
        for row in 0..<space.count {
            for column in 0..<space[row].count {
                switch space[row][column] {
                case .floor:
                    continue
                case .empty:
                    if findOccupiedSeats(row: row, column: column) == 0 {
                        temporarySpace[row][column] = .occupied
                    }
                case .occupied:
                    if findOccupiedSeats(row: row, column: column) >= 4 {
                        temporarySpace[row][column] = .empty
                    }
                }
            }
        }
        
        space = temporarySpace.map { $0 }
    }
    
    func print() {
        space.forEach { row in
            var printableRow = ""
            row.forEach {
                printableRow.append($0.asCharacter)
            }
            Swift.print(printableRow)
        }
    }
    
    var occupiedSeats: Int {
        var seats = 0
        space.forEach { row in
            row.forEach {
                if $0 == .occupied {
                    seats += 1
                }
                
            }
        }
        return seats
    }
}

var airplane = Airplane(space: space)

var occupiedSeats = 0

repeat {
    occupiedSeats = airplane.occupiedSeats
    airplane.letInPassengers()
} while (airplane.occupiedSeats != occupiedSeats)

print(airplane.print())
print("--------------------")
print("Occupied seats: \(occupiedSeats)")


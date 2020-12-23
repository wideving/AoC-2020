import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n").dropLast().map { NavigationInstruction(data: $0) }

enum Direction {
    case north
    case east
    case south
    case west
}

struct Position {
    var x: Int = 0
    var y: Int = 0
}

struct NavigationInstruction {
    let action: String
    let value: Int
    
    init(data: String) {
        action = String(data.first!)
        value =  Int(data.dropFirst())!
    }
}

class Compass {
    var direction: Direction = .east
    private var rotation: Int = 90
    
    func changeDirection(degrees: Int) {
        rotation += degrees
        
        switch rotation % 360 {
        case 0:
            direction = .north
        case 90, -270:
            direction = .east
        case 180, -180:
            direction = .south
        case 270, -90:
            direction = .west
        default:
            return
        }
    }
}

class Ship {
    private let compass: Compass
    private let navigationInstructions: [NavigationInstruction]
    private var position = Position()
    
    
    init(compass: Compass, navigationInstructions: [NavigationInstruction]) {
        self.compass = compass
        self.navigationInstructions = navigationInstructions
    }
    
    private func move(direction: Direction, distance: Int) {
        switch direction {
        case .north:
            position.y += distance
        case .south:
            position.y -= distance
        case .east:
            position.x += distance
        case .west:
            position.x -= distance
        }
    }
    
    func travelToEndDestination(endDestination: (Position) -> Void) {
        navigationInstructions.forEach { instruction in
            switch instruction.action {
            case "F":
                move(direction: compass.direction, distance: instruction.value)
            case "R":
                compass.changeDirection(degrees: instruction.value)
            case "L":
                compass.changeDirection(degrees: -instruction.value)
            case "N":
                move(direction: .north, distance: instruction.value)
            case "E":
                move(direction: .east, distance: instruction.value)
            case "S":
                move(direction: .south, distance: instruction.value)
            case "W":
                move(direction: .west, distance: instruction.value)
            default:
                return
            }
        }
        endDestination(position)
    }
}

let ship = Ship(compass: Compass(), navigationInstructions: inputs)
ship.travelToEndDestination { (position) in
    print(abs(position.x) + abs(position.y))
}


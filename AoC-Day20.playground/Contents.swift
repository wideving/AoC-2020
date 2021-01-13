import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
let inputs = data.components(separatedBy: "\n\n")

struct Tile {
    let id: String
    let square: [String]
}

let tiles: [Tile] = inputs.map {
    let split = $0.split(separator: "\n")
    let idRange = split[0].range(of: #"\d+"#, options: .regularExpression)!
    let id: String = String(split[0][idRange])
    let square = split.dropFirst().map { String($0) }
    
    return Tile(id: id, square: Array(square))
}

tiles.forEach { (tile) in
    print(tile.id)
    tile.square.forEach {
        print($0)
    }
    print("")
}


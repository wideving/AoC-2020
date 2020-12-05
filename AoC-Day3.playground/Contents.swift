import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.split(separator: "\n")

struct Slope {
    let right: Int
    let down: Int
}

var column = 0
let maxColumns = inputs[0].count

var trees = 0

var sum = 1

var slopes = [
    Slope(right: 1, down: 1),
    Slope(right: 3, down: 1),
    Slope(right: 5, down: 1),
    Slope(right: 7, down: 1),
    Slope(right: 1, down: 2)
]

//Day3
inputs.forEach { row in
    let index = row.index(row.startIndex, offsetBy: (column % maxColumns))
    if (row[index] == "#") {
        trees += 1
    }
    column += 3
}

//Day3.5
slopes.forEach { slope in
    column = 0
    trees = 0
    for index in stride(from: 0, to: inputs.count, by: slope.down) {
        let row = inputs[index]
        let index = row.index(row.startIndex, offsetBy: (column % maxColumns))
        if (row[index] == "#") {
            trees += 1
        }
        column += slope.right
    }
    sum *= trees
}

print(sum)


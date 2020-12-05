import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.split(separator: "\n")

var column = 0
var trees = 0

var maxColumns = inputs[0].count

inputs.forEach { row in
    let index = row.index(row.startIndex, offsetBy: (column % maxColumns))
    if (row[index] == "#") {
        trees += 1
    }
    column += 3
}

print(trees)


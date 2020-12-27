import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.dropLast().split(separator: ",").compactMap {Int($0) }

var spokenNumbers = [Int: Int]()
inputs.enumerated().dropLast().forEach {
    let turn = $0 + 1
    spokenNumbers[$1] = turn
}

var index = inputs.count - 1

while (inputs.count < 2020) {
    let lastSpokenNumber = inputs[index]
    let turn = index + 1
    if spokenNumbers.contains(where: { $0.key == lastSpokenNumber} ) {
        let newSpokenNumber = turn - spokenNumbers[lastSpokenNumber]!
        spokenNumbers[lastSpokenNumber] = turn
        inputs.append(newSpokenNumber)
    } else {
        spokenNumbers[lastSpokenNumber] = turn
        inputs.append(0)
    }
    index += 1
}

print(inputs.last!)




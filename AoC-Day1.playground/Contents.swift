import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
let inputs = data.split(separator: "\n").map { Int(String($0))! }

var sum = 0

outerLoop: for i in 0..<inputs.count {
    for j in 0..<inputs.count {
        if inputs[i] + inputs[j] == 2020 {
            print("numbers are \(inputs[i]) and \(inputs[j])")
            sum = inputs[i] * inputs[j]
            break outerLoop
        }
    }
}

print(sum)


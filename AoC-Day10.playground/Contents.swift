import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n").compactMap { Int($0) }.sorted()
print(inputs)
var differences = [Int: Int]()

for i in 0..<inputs.count - 1 {
    if i == 0 {
        differences[inputs[0]] = inputs[0]
    }
    
    let diff = inputs[i + 1] - inputs[i]
    if differences[diff] != nil {
        differences[diff]! += 1
    } else {
        differences[diff] = 1
    }
}

if differences[3] != nil {
    differences[3]! += 1
}

if let ones = differences[1], let threes = differences[3] {
    print("Result: \(ones * threes)")
} else {
    print("Ones or threes are missing")
}


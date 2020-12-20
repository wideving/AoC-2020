import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n").compactMap { Int($0) }.sorted()
print(inputs)
var differences = [Int: Int]()
differences[inputs[0]] = 1
differences[3] = 1

//Day 10
for i in 0..<inputs.count - 1 {
    let diff = inputs[i + 1] - inputs[i]
    if differences[diff] != nil {
        differences[diff]! += 1
    } else {
        differences[diff] = 1
    }
}

if let ones = differences[1], let threes = differences[3] {
    print("Result: \(ones * threes)")
} else {
    print("Ones or threes are missing")
}



//Day 10.5 not complete
func findCombinations(_ joltage: Int) -> [Int] {
    inputs.filter { $0 >= (joltage + 1) && $0 <= (joltage + 3) }
}







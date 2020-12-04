import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
let inputs = data.split(separator: "\n").map { Int(String($0))! }

var sum = 0

//Day1

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

//Day1.5

outerLoop: for i in 0..<inputs.count {
    for j in 0..<inputs.count {
        for k in 0..<inputs.count {
            if inputs[i] + inputs[j] + inputs[k] == 2020 {
                print("numbers are \(inputs[i]) and \(inputs[j]) and \(inputs[k])")
                sum = inputs[i] * inputs[j] * inputs[k]
                break outerLoop
            }
        }
    }
}



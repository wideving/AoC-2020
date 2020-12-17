import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n").dropLast().compactMap { Int($0) }

let preambleCount = 25
let sumIndex = 25 //First index after preamble


//Day9
func findSum(numbers: [Int], sum: Int) -> Bool {
    for i in 0..<numbers.count {
        for j in 0..<numbers.count {
            if numbers[i] + numbers[j] == sum && numbers[i] != numbers[j] {
                print("Found match \(numbers[i]) + \(numbers[j]) is \(sum)")
                return false
            }
        }
    }
    print("Weakness is: \(sum)")
    return true
}

var foundWeakness = false


while (!foundWeakness && inputs.count > sumIndex) {
    let preamble =  Array(inputs.prefix(preambleCount))
    let sum = inputs[sumIndex]
    
    foundWeakness = findSum(numbers: preamble, sum: sum)
    
    if !foundWeakness {
        inputs = Array(inputs.dropFirst())
    }
}



//Day9.5
let weakness = 217430975
var numbers = Array(inputs.split(separator: 217430975)[0])



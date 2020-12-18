import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n").dropLast().compactMap { Int($0) }

let preambleCount = 25
let sumIndex = 25 //First index after preamble

var weakness = 0

//Day9
func findSum(numbers: [Int], sum: Int) -> Bool {
    for i in 0..<numbers.count {
        for j in 0..<numbers.count {
            if numbers[i] + numbers[j] == sum && numbers[i] != numbers[j] {
                return false
            }
        }
    }
    print("Weakness is: \(sum)")
    weakness = sum
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
let numbers = data
    .components(separatedBy: "\n")
    .dropLast()
    .compactMap { Int($0) }
    .split(separator: weakness)[0]



outer: for i in 400..<numbers.count {
    var sum = 0
    var contigiousNumbers = [Int]()
    for j in i..<numbers.count {
        contigiousNumbers.append(numbers[j])
        sum += numbers[j]
        if sum == weakness {
            let sort = contigiousNumbers.sorted()
            print("Weakness is: \(sort.first! + sort.last!)")
            break outer
        }
    }
}

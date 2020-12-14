import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n")
inputs = inputs.dropLast()

let regex = try! NSRegularExpression(pattern: "([a-z]{3}) ((\\+|-)\\d+)", options: .caseInsensitive)

enum Instruction: CustomStringConvertible {
    case acc(Int)
    case jmp(Int)
    case nop
    
    var description: String {
        switch self {
        case .acc(let amount):
            return "acc: \(amount)"
        case .jmp(let amount):
            return "jmp \(amount)"
        case .nop:
            return "nop"
        }
    }
}

func getInstructions(input: String) -> Instruction {
    let matches = regex.firstMatch(
        in: input,
        options: [],
        range: NSRange(location: 0, length: input.utf16.count)
    )!
    
    let instruction = input[Range(matches.range(at: 1), in: input)!]
    let amountInstruction = input[Range(matches.range(at: 2), in: input)!]
    let amount = amountInstruction.first == "+" ? Int(amountInstruction.dropFirst())! : -(Int(amountInstruction.dropFirst())!)
    
    switch instruction {
    case "acc": return .acc(amount)
    case "nop": return .nop
    case "jmp": return .jmp(amount)
    default: return .acc(-99999)
    }
    
}


let instructions: [Instruction] = inputs.map(getInstructions(input:))
var accumulator = 0
var index = 0

var visitedIndexes = [Int]()

func runInstruction() {
    if visitedIndexes.contains(index) {
        print(accumulator)
        return
    }
    
    visitedIndexes.append(index)

    switch instructions[index] {
    case .acc(let amount):
        accumulator += amount
        index += 1
    case .jmp(let amount):
        index += amount
    case .nop:
        index += 1
    }
    print("accumulator value: \(accumulator) - index: \(index)")
    runInstruction()
}

runInstruction()



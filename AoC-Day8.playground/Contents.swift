import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n")
inputs = inputs.dropLast()

let regex = try! NSRegularExpression(pattern: "([a-z]{3}) ((\\+|-)\\d+)", options: .caseInsensitive)

enum Instruction: CustomStringConvertible, Equatable {
    case acc(Int)
    case jmp(Int)
    case nop(Int)
    
    var description: String {
        switch self {
        case .acc(let amount):
            return "acc: \(amount)"
        case .jmp(let amount):
            return "jmp: \(amount)"
        case .nop(let amount):
            return "nop: \(amount)"
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
    case "nop": return .nop(amount)
    case "jmp": return .jmp(amount)
    default: return .acc(-99999)
    }
}

var instructions: [Instruction] = inputs.map(getInstructions(input:))
var accumulator = 0
var index = 0
var visitedIndexes = [Int]()
var completed = false

let jmpAndNops: [Int] = instructions.enumerated().compactMap { (index, instruction) in
    if instruction.description.contains("nop") || instruction.description.contains("jmp") {
        return index
    }
    return nil
}

var jmpAndNopsIndex = 0


func runInstruction(_ instructions: [Instruction]) {
    if index >= instructions.count {
        //Day8.5
        print("Instructions completed")
        print("Accumulator value: \(accumulator)")
        completed = true
        return
    }
    
    if visitedIndexes.contains(index) {
        //Day8
        print("Entered infinite loop")
        print("Accumulator value: \(accumulator)")
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
    runInstruction(instructions)
}

func reset() {
    accumulator = 0
    index = 0
    visitedIndexes = []
}

func swap(instruction: Instruction) -> Instruction {
    switch instruction {
    case .acc:
        return instruction
    case .jmp(let number):
        return .nop(number)
    case .nop(let number):
        return .jmp(number)
    }
}

var currentModifiedIndex = 0

while !completed {
    reset()
    var modifiedInstructions = instructions.map { $0 }
    let jmpOrNopIndex = jmpAndNops[currentModifiedIndex]
    modifiedInstructions[jmpOrNopIndex] = swap(instruction: instructions[jmpOrNopIndex])
    
    runInstruction(modifiedInstructions)
    currentModifiedIndex += 1
}

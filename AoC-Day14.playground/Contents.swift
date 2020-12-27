import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n").dropLast()

let pattern = "mem\\[(\\d+)\\] = (\\d+)"

let regex = try? NSRegularExpression(
  pattern: pattern,
  options: .caseInsensitive
)

var programs: [Program] = []
var memory = [Int: Int]()

struct Program {
    let mask: String
    let instructions: [(position: Int, value: Int)]
    
    init(mask: String, instructions: [(Int, Int)], memory: [Int: Int]) {
        self.mask = mask
        self.instructions = instructions
        execute()
    }

    private mutating func execute() {
        instructions.forEach { instruction in
            var binaryRep = Array(String(instruction.value, radix: 2))
            while binaryRep.count < 36 {
                binaryRep.insert("0", at: binaryRep.startIndex)
            }
            
            mask.enumerated().forEach { index, char in
                if char == "1" || char == "0" {
                    binaryRep[index] = char
                }
            }
            
            memory[instruction.position] = Int(String(binaryRep), radix: 2)
        }
    }
}

inputs.enumerated().forEach { (index, row) in
    if row.starts(with: "mask") {
        let maskValue = row.components(separatedBy: " = ")[1]
        var instructions = [(Int, Int)]()
        
        for i in index + 1..<inputs.count{
            let memRow = inputs[i]
            
            guard let match = regex?.firstMatch(
                    in: memRow,
                    options: [],
                    range: NSRange(location: 0, length: memRow.utf16.count)
            ) else {
                break
            }
            
            let positionRange = Range(match.range(at: 1), in: memRow)!
            let valueRange = Range(match.range(at: 2), in: memRow)!
            let position = Int(memRow[positionRange])!
            let value = Int(memRow[valueRange])!
            instructions.append((position, value))
        }
        
        programs.append(Program(mask: maskValue, instructions: instructions, memory: memory))
    }
}

print(memory.reduce(0, {
    $0 + $1.value
}))



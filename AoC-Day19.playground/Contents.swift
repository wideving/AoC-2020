import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
let inputs = data.components(separatedBy: "\n\n")
let messages = inputs[1].split(separator: "\n").map { String($0) }

struct Rule {
    var character: String = ""
    var leftSide: [String] = [String]()
    var rightSide: [String] = [String]()
}

var rules = [Int: Rule]()

inputs[0].split(separator: "\n").forEach { row in
    let split = row.components(separatedBy: ": ")
    let id = Int(split[0])!
    
    if let range = split[1].range(of: "(a|b)", options: .regularExpression) {
        let character: String = String(split[1][range])
        rules[id] = Rule(character: character, leftSide: [], rightSide: [])
    } else {
        let numbers = split[1].components(separatedBy: " | ")
        
        let first = numbers[0].split(separator: " ").compactMap { String($0) }
        
        var second: [String] = []
        if numbers.count > 1 {
            second = numbers[1].split(separator: " ").compactMap { String($0) }
        }
        
        rules[id] = Rule(leftSide: first, rightSide: second)
    }
    
}

func parse(_ pattern: [String]) -> [String] {
    var nextPattern = [String]()
    pattern.enumerated().forEach { index, entry in
        switch entry {
        case "(", "|", ")", "a", "b":
            nextPattern.append(entry)
        default:
            let id = Int(String(entry))!
            let rule = rules[id]!
            let pipe = rule.rightSide.count > 0
            
            if rule.character != "" {
                nextPattern.append(rule.character)
            }
            
            if pipe {
                nextPattern.append("(")
            }
            
            rule.leftSide.forEach { character in
                nextPattern.append(character)
            }
            
            if pipe {
                nextPattern.append("|")
                rule.rightSide.forEach { character in
                    nextPattern.append(character)
                }
                nextPattern.append(")")
            }
        }
    }
    return nextPattern
}

func increment(_ message: String) -> Int {
    return regex.firstMatch(
        in: message,
        options: [],
        range: NSRange(location: 0, length: message.utf16.count)
    ) != nil ? 1 : 0
}

var pattern = [String]()

rules[0]?.leftSide.forEach { pattern.append($0) }
rules[0]?.rightSide.forEach { pattern.append($0) }

while true {
    let parsedPattern = parse(pattern)
    if parsedPattern == pattern {
        pattern.insert("^", at: pattern.startIndex)
        pattern.append("$")
        break
    } else {
        pattern = parsedPattern
    }
}

let regex = try! NSRegularExpression(pattern: pattern.reduce("", +), options: [])

let sum = messages.reduce(0) { result, message in
    return result + increment(message)
}

print(sum) // Part 1

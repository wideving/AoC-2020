import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n\n")

let ranges = inputs[0].split(separator: "\n").map { String($0) }
let myTicket = inputs[1].split(separator: "\n").map { String($0) }
let nearbyTickets = Array(inputs[2].split(separator: "\n").dropFirst()).map {
    Set($0.split(separator: ",").compactMap { Int($0) })
}

print(nearbyTickets)

let pattern = #"\w+: (\d+)-(\d+) or (\d+)-(\d+)"#
let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)


var validNumbers = Set<Int>()

ranges.forEach { row in
    guard
        let match = regex.firstMatch(in: row, options: [], range: NSRange(location: 0, length: row.utf16.count)),
        let firstRange = Range(match.range(at: 1), in: row),
        let secondRange = Range(match.range(at: 2), in: row),
        let thirdRange = Range(match.range(at: 3), in: row),
        let fourthRange = Range(match.range(at: 4), in: row)
    else {
        return
    }
        
    let first = Int(row[firstRange])!
    let second = Int(row[secondRange])!
    let third = Int(row[thirdRange])!
    let fourth = Int(row[fourthRange])!
    
    for i in first...second {
        validNumbers.insert(i)
    }
    
    for i in third...fourth {
        validNumbers.insert(i)
    }
}

print(nearbyTickets.reduce(0, { result, next in
    return result + next.subtracting(validNumbers).reduce(0, +)
}))


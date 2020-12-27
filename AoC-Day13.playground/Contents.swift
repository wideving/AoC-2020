import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n").dropLast()

var time = Int(inputs[0])!
var busIds = inputs[1].split(separator: ",").compactMap { Int($0) }.sorted()
var closestTimes = [Int: Int]()

busIds.forEach { id in
    var next = id
    while next < time {
        next += id
    }
    closestTimes[id] = next
}

let closestTime = closestTimes.min(by: { $0.value < $1.value })!
let difference = closestTime.value - time
let answer = closestTime.key * difference
print(answer)








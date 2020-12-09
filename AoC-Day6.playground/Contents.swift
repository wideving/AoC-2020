import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n\n")

//Day6
print(inputs.reduce(0) {$0 + Set(Array($1.replacingOccurrences(of: "\n", with: ""))).count })

//Day6.5
print(inputs.reduce(0) {
    let split = $1.components(separatedBy: "\n")
    let amountOfPeople = split.count
    let dict = Dictionary.init(grouping: split.joined(), by: { $0 })
    return $0 + dict.reduce(0, { $0 + ($1.value.count == amountOfPeople ? 1 : 0) })
})


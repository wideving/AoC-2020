import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n")

inputs = inputs.dropLast()
inputs = inputs.filter({ !$0.starts(with: "shiny gold") })

//Day7
let bags: [[String]] = inputs.map {
    var items = [String]()
    let components = $0.components(separatedBy: " contain ")
    items.append(components[0])
    
    if components[1].contains("no other bags") {
        return items
    } else {
        let smallerBags = components[1].components(separatedBy: ", ")
        items += smallerBags
    }
    
    return items
    
}

func findBags(from: [String]) -> [String] {
    var foundBags = [String]()
    bags.forEach { row in
        row.forEach { bag in
            from.forEach { goldBag in
                if bag.contains(goldBag) {
                    let bagToAppend = String(row[0].dropLast(5))
                    if !foundBags.contains(bagToAppend) {
                        foundBags.append(bagToAppend)
                    }
                }
            }
        }
    }
    return foundBags
}

var foundBags = ["shiny gold"]

while (true) {
    let newBags = findBags(from: foundBags)
    if newBags.count == foundBags.count {
        break
    }
    foundBags = newBags
    
}

print(foundBags.count)



import Foundation

class Day23 {
    var cups: [Int] = "253149867".compactMap { Int(String($0)) }
    
    var removedCups: [Int] = []
    var currentCup = 2
    var destinationIndex = 1
    
    func solve() {
        (0..<100).forEach {
            print("------ Start round \($0 + 1) ------")
            print("Current cup is: \(currentCup)")
            print("Current cup placement: \(cups)")
            removeCups()
            setDestinationCup()
            placeCups()
            pickNextCup()
            print("------ End round ------")
            print("")
        }
        
        let startIndex = cups.firstIndex(of: 1)!
        var currentIndex = startIndex + 1
        var order = ""

        while (currentIndex != startIndex) {
            order.append(String(cups[currentIndex % cups.count]))
            currentIndex = (currentIndex + 1) % cups.count
        }
        
        //Day 23
        print("Cup placement: \(order)")
    }
    
    func pickNextCup() {
        let nextIndex = (cups.firstIndex(of: currentCup)! + 1) % cups.count
        currentCup = cups[nextIndex]
    }
    
    func placeCups() {
        var previousCupIndex = destinationIndex
        removedCups.forEach {
            cups.insert($0, at: (previousCupIndex + 1))
            previousCupIndex = cups.firstIndex(of: $0)!
        }
        removedCups.removeAll()
    }
    
    func removeCups(){
        var cupsToRemove = [Int]()
        var i = 1
        
        while i < 4 {
            cupsToRemove.append((cups.firstIndex(of: currentCup)! + i) % cups.count)
            i += 1
        }
        
        cupsToRemove.forEach {
            removedCups.append(cups[$0])
        }
        
        removedCups.forEach {
            cups.remove(at: cups.firstIndex(of: $0)!)
        }
        print("Pick up: \(removedCups)")
    }
    
    func setDestinationCup() {
        var found = false
        
        var destinationCup = currentCup - 1

        while !found {
            if cups.contains(destinationCup) {
                found = true
            } else {
                if destinationCup < cups.min()! {
                    destinationCup = cups.max()!
                } else {
                    destinationCup -= 1
                }
            }
        }
        
        destinationIndex = cups.firstIndex(of: destinationCup)!
        print("Destination cup: \(cups[destinationIndex])")
    }
}

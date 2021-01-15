import Foundation

class Day22 {
    var player1: [Int]
    var player2: [Int]
    
    init() {
        let input = data.components(separatedBy: "\n\n")
        player1 = input[0].split(separator: "\n").dropFirst().compactMap { Int($0) }
        player2 = input[1].split(separator: "\n").dropFirst().compactMap { Int($0) }
    }
    
    func solve() {
        while player1.count > 0 && player2.count > 0 {
            let player1Card = player1.removeFirst()
            let player2Card = player2.removeFirst()
            
            if player1Card > player2Card {
                player1.append(contentsOf: [player1Card, player2Card])
            } else {
                player2.append(contentsOf: [player2Card, player1Card])
            }
        }
        
        player1.append(contentsOf: player2)

        let winnerScore = player1.reversed().enumerated().reduce(0, { result, element in
            result + (element.element * (element.offset + 1))
        })
        
        print(winnerScore)
    }
    
    
}

let data = """
Player 1:
4
25
3
11
2
29
41
23
30
21
50
8
1
24
27
10
42
43
38
15
18
13
32
37
34

Player 2:
12
6
36
35
40
47
31
9
46
49
19
16
5
26
39
48
7
44
45
20
17
14
33
28
22
"""

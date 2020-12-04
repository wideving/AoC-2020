import UIKit

// Day2
struct Row {
    let passwordLength: (Int, Int)
    let passwordCharacter: Character
    let password: String
    
    init(data: String) {
        let length = data[data.range(of: #"\d+-\d+"#, options: .regularExpression)!].split(separator: "-")
        passwordLength = (Int(length[0])!, Int(String(length[1]))!)
        passwordCharacter = Character(String(data[data.range(of: "[a-z]:", options: .regularExpression)!].split(separator: ":")[0]))
        password = String(data.split(separator: " ")[2])
    }
    
    func isValid() -> Bool {
        let count: Int = password.reduce(0 ,{ sum, char in
            sum + (char == passwordCharacter ? 1 : 0)
        })
        
        return count >= passwordLength.0 && count <= passwordLength.1
    }
}

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
let inputs = data.split(separator: "\n").map { Row(data: String($0)) }

let validPasswords = inputs.reduce(0, { $0 + ($1.isValid() ? 1 : 0)})
print(validPasswords)







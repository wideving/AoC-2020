import UIKit

struct Row {
    // Day2
    
    let passwordLength: (Int, Int)
    let passwordCharacter: Character
    let password: String
    
    init(data: String) {
        let split = data.split(separator: ":")
        let policy = split[0]
        let policySplit = policy.split(separator: " ")
        let passwordLengthSplit = policySplit[0].split(separator: "-")
        
        password = split[1].trimmingCharacters(in: .whitespacesAndNewlines)
        passwordLength.0 = Int(String(passwordLengthSplit[0]))!
        passwordLength.1 = Int(String(passwordLengthSplit[1]))!
        passwordCharacter = Character(String(policySplit[1]))
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





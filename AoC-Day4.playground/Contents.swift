import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
var inputs = data.components(separatedBy: "\n\n")

// Matches and returns the match and capture groups
extension String {
    func match(_ regex: String) -> [[String]] {
        let nsString = self as NSString
        return (try? NSRegularExpression(pattern: regex, options: []))?.matches(in: self, options: [], range: NSMakeRange(0, count)).map { match in
            (0..<match.numberOfRanges).map { match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0)) }
        } ?? []
    }
}

let rules = [
    "ecl:",
    "pid:",
    "eyr:",
    "hcl:",
    #"byr:(\d{4})"#,
    "iyr:",
    "hgt:",
]

struct RuleValidator {
    private let rules: [String: String] = [
        "byr":#"byr:(\d{4})"#,
        "iyr":#"iyr:(\d{4})"#,
        "eyr":#"eyr:(\d{4})"#,
        "hgt":"hgt:([0-9]{2,3})([a-z]{2})",
        "hcl":"hcl:#[a-f0-9]{6}",
        "ecl":"ecl:(amb|blu|brn|gry|grn|hzl|oth)",
        "pid":#"pid:(\d+)"#,
    ]
    
    let passportData: String
    
    private func validByr() -> Bool {
        let match = passportData.match(rules["byr"]!)
        if match.isEmpty {
            return false
        } else {
            let year = Int(match[0][1])!
            let valid = year >= 1920 && year <= 2002
            return valid
        }
    }
    
    private func validIyr() -> Bool {
        let match = passportData.match(rules["iyr"]!)
        if match.isEmpty {
            return false
        } else {
            let year = Int(match[0][1])!
            let valid = year >= 2010 && year <= 2020
            return valid
        }
    }
    
    private func validEyr() -> Bool {
        let match = passportData.match(rules["eyr"]!)
        if match.isEmpty {
            return false
        } else {
            let year = Int(match[0][1])!
            let valid = year >= 2020 && year <= 2030
            return valid
        }
    }
    
    private func validHgt() -> Bool {
        let match = passportData.match(rules["hgt"]!)
        if match.isEmpty {
            return false
        } else {
            let unit = match[0][2]
            let height = Int(match[0][1])!

            if unit == "cm" {
                return height >= 150 && height <= 193
            } else {
                return height >= 59 && height <= 76
            }
        }
    }
    
    private func validHcl() -> Bool {
        return passportData.match(rules["hcl"]!).count > 0
    }
    
    private func validEcl() -> Bool {
        return passportData.match(rules["ecl"]!).count > 0
    }
    
    private func validPid() -> Bool {
        let match = passportData.match(rules["pid"]!)
        if match.isEmpty { return false }
        return match[0][1].count == 9
    }

    func isValid() -> Bool {
        return validByr() && validIyr() && validEyr() &&
            validHgt() && validHcl() && validEcl() && validPid()
    }
    
}

//Day4
var validPassports = 0

inputs.forEach { passportData in
    var isPassportValid = true
    rules.forEach { rule in
        if passportData.range(of: rule, options: .regularExpression) == nil {
            isPassportValid = false
        }
    }
    if isPassportValid {
        validPassports += 1
    }
}

print(validPassports)

//Day4.5
var newValidPassports = 0

inputs.forEach { passportData in
    if RuleValidator(passportData: String(passportData)).isValid() {
        newValidPassports += 1
    }
}

print(newValidPassports)








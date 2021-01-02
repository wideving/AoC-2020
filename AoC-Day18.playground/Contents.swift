import UIKit

let url = Bundle.main.url(forResource: "data", withExtension: "txt")!
let data = try! String(contentsOf: url)
let inputs = data.components(separatedBy: "\n")

let pattern = #"(\d+) (\+|\*) (\d+)"#
let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)

func getIndex(in string: String, index: Int) -> String.Index {
    return string.index(string.startIndex, offsetBy: index)
}

func evaluate(expression: String) -> Int {
    var sum = 0
    var copy = expression
    var count = -1
    
    while count != 0 {
        
        let matches = regex.matches(
            in: copy,
            options: [],
            range: NSRange(copy.startIndex..<copy.endIndex, in: copy)
        )

        count = matches.count

        if let match = matches.first {
            let firstNumberRange = Range(match.range(at: 1), in: copy)!
            let operatorRange = Range(match.range(at: 2), in: copy)!
            let secondNumberRange = Range(match.range(at: 3), in: copy)!
            
            let firstNumber = Int(copy[firstNumberRange])!
            let op = copy[operatorRange]
            let secondNumber = Int(copy[secondNumberRange])!
            let result = (op == "*" ? firstNumber * secondNumber : firstNumber + secondNumber)
            
            copy.replaceSubrange(Range(match.range(at: 0), in: copy)!, with: String(result))
            sum = result
        }
    }

    return sum
}

func getParentheses(text: String) -> (start: String.Index, end: String.Index)? {
    var startIndex: String.Index? = nil
    var endIndex: String.Index? = nil

    for i in 0..<text.count {
        let char = text[text.index(text.startIndex, offsetBy: i)]
        switch char {
        case "(":
            startIndex = getIndex(in: text, index: i)
        case ")":
            endIndex = getIndex(in: text, index: i)
            guard let startIndex = startIndex, let endIndex = endIndex  else { fatalError("Not in sync") }
            return (start: startIndex, end: endIndex)
        default:
            break
        }
    }
    
    return nil
}

func getSum(text: String) -> Int {
    var expression = text
    
    var hasParentheses = true
    var sum = 0
    while (hasParentheses) {
        if let index = getParentheses(text: expression) {
            let subExpression = String(expression[index.start...index.end])
            let sum = String(evaluate(expression: subExpression))
            expression.replaceSubrange(index.start...index.end, with: sum)
        } else {
            hasParentheses = false
            sum = evaluate(expression: expression)
        }
    }
    
    return sum
}

//Day 18 - Part one
print(inputs.reduce(0, { result, expression in
    result + getSum(text: expression)
}))







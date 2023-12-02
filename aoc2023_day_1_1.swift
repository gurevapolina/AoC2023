import UIKit

let input = """
"""

// Part one

let result = sumOfFirtsAndLastDigits(input: input)
print(result)

// Helpers

func sumOfFirtsAndLastDigits(input: String) -> Int {
    let strings = input.split(separator: "\n")
    let numbers = strings.map({ $0.filter({ $0.isNumber }) })
    let twoDigitNumbers = numbers.map({ String($0.first!) + String($0.last!) })
    print(twoDigitNumbers)
    let intNumbers = twoDigitNumbers.map({ Int($0) ?? 0 })
    return intNumbers.reduce(0, +)
}

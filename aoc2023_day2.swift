import UIKit

let input = """
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
"""

let redCount = 12
let greenCount = 13
let blueCount = 14

struct Game {
    let id: Int
    let reveals: [Reveal]

    init(line: String) {
        let splits = line.split(separator: ":")
        self.id = Int(splits[0].split(separator: " ")[1]) ?? 0
        self.reveals = splits[1].split(separator: ";").map({ Reveal(line: String($0)) })
    }

    func isPossible(r: Int, g: Int, b: Int) -> Bool {
        return reveals.allSatisfy({ $0.isPossible(r: r, g: g, b: b) })
    }

    var power: Int {
        let maxR = reveals.map({ $0.r }).max() ?? 0
        let maxG = reveals.map({ $0.g }).max() ?? 0
        let maxB = reveals.map({ $0.b }).max() ?? 0
        return maxR * maxG * maxB
    }
}

struct Reveal {
    static let blue = "blue"
    static let red = "red"
    static let green = "green"

    let r: Int
    let g: Int
    let b: Int

    init(line: String) {
        let splits = line.split(separator: ",")
        if let redCount = splits.first(where: { $0.contains(Reveal.red) }) {
            let value = Int(redCount.split(separator: " ")[0]) ?? 0
            r = value
        } else {
            r = 0
        }

        if let greenCount = splits.first(where: { $0.contains(Reveal.green) }) {
            let value = Int(greenCount.split(separator: " ")[0]) ?? 0
            g = value
        } else {
            g = 0
        }

        if let blueCount = splits.first(where: { $0.contains(Reveal.blue) }) {
            let value = Int(blueCount.split(separator: " ")[0]) ?? 0
            b = value
        } else {
            b = 0
        }
    }

    func isPossible(r: Int, g: Int, b: Int) -> Bool {
        if self.r > r || self.g > g || self.b > b {
            return false
        } else {
            return true
        }
    }
}

let strings = input.split(separator: "\n").map({ String($0) })
let games = strings.map({ Game(line: $0) })

// Part one

let result1 = games
    .filter({ $0.isPossible(r: redCount, g: greenCount, b: blueCount) })
    .reduce(0, { $0 + $1.id })
print(result1)

// Part two

let result2 = games.reduce(0, { $0 + $1.power })
print(result2)

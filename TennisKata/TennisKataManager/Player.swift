//

import Foundation

enum Result: Equatable {
    case wonSet
    case wonMatch
    case lost
    case draw
    case deuce
    case inProgress
}

enum Score: Int, Equatable {
    case zero = 0
    case fifteen
    case thirty
    case forty
    case advantage

    func scoreText() -> String {
        switch self {
        case .zero:
            return "0"
        case .fifteen:
            return "15"
        case .thirty:
            return "30"
        case .forty:
            return "40"
        case .advantage:
            return "Advantage"
        }
    }
}

class Player: Equatable {
    let name: String
    var score: Score
    var result: Result
    var setsWon: Int

    init(name: String,
         score: Score = .zero,
         result: Result = .inProgress,
         setsWon: Int = 0) {
        self.name = name
        self.score = score
        self.result = result
        self.setsWon = setsWon
    }

    func resetForGame() {
        score = .zero
        result = .inProgress
    }

    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}

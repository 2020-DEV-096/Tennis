//

import Foundation

struct TennisPlayerViewModel: Equatable {
    let name: String
    let score: String
    let setsWon: String
}

struct TennisKataViewModel: Equatable {
    let playerOne: TennisPlayerViewModel
    let playerTwo: TennisPlayerViewModel
}

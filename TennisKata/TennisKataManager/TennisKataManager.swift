//

import Foundation

class TennisKataManager: TennisKataManagerProtocol {
    var playerOne: Player
    var playerTwo: Player
    let setCount: Int
    var currentSet: Int = 1
    var update: Completion?
    var winner: Player? {
        let players = [playerOne, playerTwo]
        return players.filter { $0.result == .wonMatch }.first
    }
    var result: Result = .inProgress {
        didSet {
            update?(result)
        }
    }

    required init(playerOne: Player,
                  playerTwo: Player,
                  setCount: Int,
                  updateCompletion: @escaping Completion) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.setCount = setCount
        self.update = updateCompletion
    }

    func startGame() {
        currentSet = 1
        result = .inProgress
        playerOne.resetForGame()
        playerTwo.resetForGame()
    }

    func pointScoredByPlayerOne() {
        increaseScore(activePlayer: playerOne, inactivePlayer: playerTwo)
    }

    func pointScoredByPlayerTwo() {
        increaseScore(activePlayer: playerTwo, inactivePlayer: playerOne)
    }
}

private extension TennisKataManager {
    func increaseScore(activePlayer: Player, inactivePlayer: Player) {
        switch activePlayer.score {
        case .zero, .fifteen:
            updateScore(for: activePlayer,
                        newScore: Score(rawValue: activePlayer.score.rawValue + 1) ?? activePlayer.score)
        case .thirty:
            updateScore(for: activePlayer, newScore: .forty)
            if inactivePlayer.score == .forty {
                result = .deuce
            }
        case .forty:
            if inactivePlayer.score == .advantage {
                updateScore(for: inactivePlayer, newScore: .forty)
            } else if inactivePlayer.score == .forty {
                updateScore(for: activePlayer, newScore: .advantage)
            } else {
                updateResult(for: activePlayer, newResult: .wonSet)
            }
        case .advantage:
            updateResult(for: activePlayer, newResult: .wonSet)
        }
    }

    func updateScore(for player: Player, newScore: Score) {
        player.score = newScore
        update?(.inProgress)
    }

    func updateResult(for player: Player, newResult: Result) {
        player.result = newResult
        guard newResult == .wonSet else {
            return
        }
        player.setsWon += 1
        if currentSet < setCount {
            startNewSet()
            result = .wonSet
        } else {
            declareWinner()
        }
    }

    func declareWinner() {
        guard playerOne.setsWon != playerTwo.setsWon else {
            result = .draw
            return
        }
        let winner = playerOne.setsWon > playerTwo.setsWon ? playerOne : playerTwo
        winner.result = .wonMatch
        result = .wonMatch
    }

    func startNewSet() {
        currentSet += 1
        playerOne.resetForGame()
        playerTwo.resetForGame()
    }
}

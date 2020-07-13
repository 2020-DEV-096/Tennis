//

import Foundation

protocol TennisKataView {
    func updateResult(_ viewModel: TennisKataViewModel)
    func showResult(_ text: String, shouldClose: Bool)
}

protocol TennisKataPresenterProtocol {
    var view: TennisKataView? { get set }
    var manager: TennisKataManagerProtocol { get }

    init(view: TennisKataView, manager: TennisKataManagerProtocol)
    func startNewMatch()
    func playerOneScored()
    func playerTwoScored()
    func processResult(_ result: Result)
}

class TennisKataPresenter: TennisKataPresenterProtocol {
    var manager: TennisKataManagerProtocol
    var view: TennisKataView?

    required init(view: TennisKataView, manager: TennisKataManagerProtocol) {
        self.view = view
        self.manager = manager
    }

    func startNewMatch() {
        manager.startGame()
        updateForMatchStart()
    }

    func playerOneScored() {
        manager.pointScoredByPlayerOne()
    }

    func playerTwoScored() {
        manager.pointScoredByPlayerTwo()
    }

    func processResult(_ result: Result) {
        switch result {
        case .wonMatch:
            self.updateForResultWonMatch()
        case .wonSet:
            self.updateForResultWonSet()
        case .inProgress:
            self.updateForResultInProgress()
        case .deuce:
            self.updateForResultDeuce()
        case .draw:
            self.updateForResultDraw()
        default:
            break
        }
    }
}

private extension TennisKataPresenter {
    func updateForResultWonMatch() {
        updateStats()
        guard let winner = manager.winner else {
            return
        }
        let detail = "Winner: \(winner.name) 🏆" + "\n" + "Sets won: \(winner.setsWon)"
        view?.showResult(detail, shouldClose:  true)
    }

    func updateForResultWonSet() {
        updateStats()
    }

    func updateForResultDeuce() {
        updateStats()
        view?.showResult("DEUCE", shouldClose:  false)
    }

    func updateForResultDraw() {
        updateStats()
        view?.showResult("Draw", shouldClose:  true)
    }

    func updateForResultInProgress() {
        updateStats()
    }

    func updateForMatchStart() {
        updateStats()
    }

    func updateStats() {
        let playerOne = manager.playerOne.createViewModel()
        let playerTwo = manager.playerTwo.createViewModel()
        let model = TennisKataViewModel(playerOne: playerOne, playerTwo: playerTwo)
        view?.updateResult(model)
    }
}

private extension Player {
    func createViewModel() -> TennisPlayerViewModel {
        return TennisPlayerViewModel(name: "Name - \(name)",
                                     score: "Score - \(score.scoreText())",
                                     setsWon: "Sets won - \(setsWon)")
    }
}

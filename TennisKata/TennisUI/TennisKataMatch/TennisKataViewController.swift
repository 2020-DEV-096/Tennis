//

import UIKit

class TennisKataViewController: BaseViewController {
    @IBOutlet private weak var playerOneNameLabel: UILabel!
    @IBOutlet private weak var playerOneScoreLabel: UILabel!
    @IBOutlet private weak var playerOneScoreButton: UIButton!
    @IBOutlet private weak var playerTwoNameLabel: UILabel!
    @IBOutlet private weak var playerTwoScoreLabel: UILabel!
    @IBOutlet private weak var playerTwoScoreButton: UIButton!
    var setCount: Int = 0
    lazy private var presenter: TennisKataPresenterProtocol! = {
        let playerOne = Player(name: "Player 1")
        let playerTwo = Player(name: "Player 2")
        let manager = TennisKataManager(playerOne: playerOne,
                                        playerTwo: playerTwo,
                                        setCount: setCount) {[weak self] result in
                                            self?.processResult(result)
        }
        return TennisKataPresenter(view: self, manager: manager)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.startNewMatch()
    }

    // MARK: - Actions
    @IBAction private func playerOneScoreTapped() {
        presenter.playerOneScored()
    }

    @IBAction private func playerTwoScoreTapped() {
        presenter.playerTwoScored()
    }

    @IBAction private func didTapCancel() {
        navigationController?.dismiss(animated: true)
    }
}

private extension TennisKataViewController {
    func processResult(_ result: Result) {
        presenter.processResult(result)
    }
}

extension TennisKataViewController: TennisKataView {
    func showResult(_ text: String, shouldClose: Bool) {
        let alert = UIAlertController(title: "",
                                      message: text,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: shouldClose ? "Close" : "Continue",
                                     style: .default,
                                     handler: {[weak self] _ in
            guard shouldClose else  {
                return
            }
            self?.navigationController?.dismiss(animated: true)
        })
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    func updateResult(_ viewModel: TennisKataViewModel) {
        playerOneNameLabel.text =  viewModel.playerOne.name
        playerOneScoreLabel.text = viewModel.playerOne.score + "\n" +  viewModel.playerOne.setsWon

        playerTwoNameLabel.text =  viewModel.playerTwo.name
        playerTwoScoreLabel.text = viewModel.playerTwo.score + "\n" +  viewModel.playerTwo.setsWon
    }
}

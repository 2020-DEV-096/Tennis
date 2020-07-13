//

import UIKit

class TennisLandingViewController: BaseViewController {
    @IBOutlet weak private var countLabel: UILabel!
    @IBOutlet weak private var countStepper: UIStepper!
    @IBOutlet weak private var startGameButton: UIButton!
    lazy private var presenter: TennisLandingPresenterProtocol = {
        return TennisLandingPresenter(self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.updateCount(Int(countStepper.value))
    }

    @IBAction func countChanged(_ sender: Any) {
        presenter.updateCount(Int(countStepper.value))
    }

    @IBAction func didTapStartGame(_ sender: Any) {
        presenter.startGame()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let navController = segue.destination as? UINavigationController,
            let tennisViewController = navController.viewControllers.first as? TennisKataViewController {
            tennisViewController.setCount = presenter.setCount
        }
    }
}

extension TennisLandingViewController: TennisLandingView {
    func updateCountText(_ text: String) {
        countLabel.text = text
    }

    func presentTennisKataView() {
        performSegue(withIdentifier: "TennisKata", sender: self)
    }
}

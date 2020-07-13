//

import Foundation

protocol TennisLandingView {
    func updateCountText(_ text: String)
    func presentTennisKataView()
}

protocol TennisLandingPresenterProtocol {
    var setCount: Int { get set }
    var view: TennisLandingView? { get set }

    init(_ view: TennisLandingView?)
    func updateCount(_ newCount:  Int)
    func startGame()
}

class TennisLandingPresenter: TennisLandingPresenterProtocol {
    var setCount: Int = 1
    var view: TennisLandingView?

    required init(_ view: TennisLandingView?) {
        self.view = view
        updateCount(setCount)
    }

    func updateCount(_ newCount:  Int) {
        setCount = newCount
        view?.updateCountText("Set count - \n\(setCount)")
    }

    func startGame() {
        view?.presentTennisKataView()
    }
}

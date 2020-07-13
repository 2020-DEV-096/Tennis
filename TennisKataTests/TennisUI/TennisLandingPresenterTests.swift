//
@testable import TennisKata
import XCTest

class TennisLandingViewMock: TennisLandingView {
    var countText: String?
    var tennisKataViewPresented: Bool?

    func updateCountText(_ text: String) {
        countText = text
    }

    func presentTennisKataView() {
        tennisKataViewPresented = true
    }
}

class TennisLandingPresenterTests: XCTestCase {
    var tennisLandingViewMock: TennisLandingViewMock!
    var presenterMock: TennisLandingPresenterProtocol!

    override func setUp() {
        tennisLandingViewMock = TennisLandingViewMock()
        presenterMock = TennisLandingPresenter(tennisLandingViewMock)
    }

    func testUpdateSetCount() {
        let count = 4
        presenterMock.updateCount(count)
        XCTAssertEqual(tennisLandingViewMock.countText, "Set count - \n\(count)")
    }

    func testGameStart() {
        presenterMock.startGame()
        XCTAssertEqual(tennisLandingViewMock.tennisKataViewPresented, true)
    }
}

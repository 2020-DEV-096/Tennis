//
@testable import TennisKata
import XCTest

class TennisKataViewMock: TennisKataView {
    var viewModel: TennisKataViewModel?
    var resultText: String?
    var shouldClose: Bool?

    func updateResult(_ viewModel: TennisKataViewModel) {
        self.viewModel = viewModel
    }

    func showResult(_ text: String, shouldClose: Bool) {
        self.resultText = text
        self.shouldClose = shouldClose
    }
}

class TennisKataManagerMock: TennisKataManager {
    var startGameCalled = false
    var pointScoredByPlayerOneCalled = false
    var pointScoredByPlayerTwoCalled = false

    override func startGame() {
        super.startGame()
        startGameCalled = true
    }

    override func pointScoredByPlayerOne() {
        super.pointScoredByPlayerOne()
        pointScoredByPlayerOneCalled = true
    }

    override func pointScoredByPlayerTwo() {
        super.pointScoredByPlayerTwo()
        pointScoredByPlayerTwoCalled = true
    }
}

class TennisKataPresenterTests: XCTestCase {
    var playerOne: Player!
    var playerTwo: Player!
    var managerMock: TennisKataManagerMock!
    var tennisKataViewMock: TennisKataViewMock!
    var presenterMock: TennisKataPresenterProtocol!

    override func setUp() {
        playerOne = Player(name: "Player1", result: .wonMatch, setsWon: 1)
        playerTwo = Player(name: "Player2")
        managerMock = TennisKataManagerMock(playerOne: playerOne,
                                            playerTwo: playerTwo,
                                            setCount: 1,
                                            updateCompletion: { _ in
        })
        tennisKataViewMock = TennisKataViewMock()
        presenterMock = TennisKataPresenter(view: tennisKataViewMock, manager: managerMock)
    }

    func testNewMatch() {
        presenterMock.startNewMatch()
        XCTAssertTrue(managerMock.startGameCalled)
    }

    func testPlayerOneScored() {
        presenterMock.playerOneScored()
        XCTAssertTrue(managerMock.pointScoredByPlayerOneCalled)
    }

    func testPlayerTwoScored() {
        presenterMock.playerTwoScored()
        XCTAssertTrue(managerMock.pointScoredByPlayerTwoCalled)
    }

    func testProcessResultInProgress() {
        presenterMock.processResult(.inProgress)
        checkViewModel()
    }

    func testProcessResultDeuce() {
        presenterMock.processResult(.deuce)
        checkViewModel()
        checkShowResult("DEUCE", shouldClose: false)
    }

    func testProcessResultDraw() {
        presenterMock.processResult(.draw)
        checkViewModel()
        checkShowResult("Draw", shouldClose: true)
    }

    func testProcessResultWonSet() {
        presenterMock.processResult(.wonSet)
        checkViewModel()
    }

    func testProcessResultWonMatch() {
        presenterMock.processResult(.wonMatch)
        checkViewModel()
        checkShowResult("Winner: Player1 🏆" + "\n" + "Sets won: 1", shouldClose: true)
    }

    private func checkViewModel() {
        XCTAssertNotNil(tennisKataViewMock.viewModel)
        XCTAssertEqual(tennisKataViewMock.viewModel?.playerOne.name, "Name - Player1")
        XCTAssertEqual(tennisKataViewMock.viewModel?.playerTwo.name, "Name - Player2")
    }

    private func checkShowResult(_ text: String, shouldClose: Bool) {
        XCTAssertEqual(tennisKataViewMock.resultText, text)
        XCTAssertEqual(tennisKataViewMock.shouldClose, shouldClose)
    }
}

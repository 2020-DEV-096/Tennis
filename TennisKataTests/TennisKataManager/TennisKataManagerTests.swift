//

@testable import TennisKata
import XCTest


class TennisKataManagerTests: XCTestCase {
    var playerOne: Player!
    var playerTwo: Player!
    var setCount = 3
    var completionResult: Result? = nil
    var managerMock: TennisKataManagerProtocol!

    override func setUp() {
        completionResult = nil
        playerOne = Player(name: "Player1")
        playerTwo = Player(name: "Player2")
        managerMock = TennisKataManager(playerOne: playerOne,
                                        playerTwo: playerTwo,
                                        setCount: setCount) {[weak self] result in
                                        self?.completionResult = result
        }
        managerMock.startGame()
    }

    func testInitialisation() {
        XCTAssertEqual(managerMock.playerOne, playerOne)
        XCTAssertEqual(managerMock.playerTwo, playerTwo)
        XCTAssertEqual(managerMock.setCount, 3)
        XCTAssertNil(managerMock.winner)
    }

    func testStartGame() {
        XCTAssertEqual(managerMock.currentSet, 1)
        XCTAssertEqual(managerMock.result, .inProgress)
        XCTAssertEqual(managerMock.playerOne.score, .zero)
        XCTAssertEqual(managerMock.playerOne.result, .inProgress)
        XCTAssertEqual(managerMock.playerTwo.score, .zero)
        XCTAssertEqual(managerMock.playerTwo.result, .inProgress)
    }

    func testScoreIncreasePlayerOne() {
        managerMock.pointScoredByPlayerOne()
        XCTAssertEqual(managerMock.playerOne.score, .fifteen)
        managerMock.pointScoredByPlayerOne()
        XCTAssertEqual(managerMock.playerOne.score, .thirty)
        managerMock.pointScoredByPlayerOne()
        XCTAssertEqual(managerMock.playerOne.score, .forty)
        managerMock.pointScoredByPlayerOne()
        XCTAssertEqual(managerMock.result, .wonSet)
        XCTAssertEqual(managerMock.playerOne.score, .zero)
        XCTAssertEqual(completionResult, .wonSet)
    }

    func testScoreIncreasePlayerTwo() {
        managerMock.pointScoredByPlayerTwo()
        XCTAssertEqual(managerMock.playerTwo.score, .fifteen)
        managerMock.pointScoredByPlayerTwo()
        XCTAssertEqual(managerMock.playerTwo.score, .thirty)
        managerMock.pointScoredByPlayerTwo()
        XCTAssertEqual(managerMock.playerTwo.score, .forty)
        managerMock.pointScoredByPlayerTwo()
        XCTAssertEqual(managerMock.result, .wonSet)
        XCTAssertEqual(managerMock.playerTwo.score, .zero)
        XCTAssertEqual(completionResult, .wonSet)
    }

    func testDeuce() {
        playerOne.score = .forty
        playerTwo.score = .thirty
        managerMock.pointScoredByPlayerTwo()
        XCTAssertEqual(managerMock.result, .deuce)
        XCTAssertEqual(completionResult, .deuce)
    }

    func testPlayerAdvantage() {
        playerOne.score = .forty
        playerTwo.score = .advantage
        managerMock.pointScoredByPlayerOne()
        XCTAssertEqual(managerMock.playerOne.score, .forty)
        XCTAssertEqual(managerMock.playerTwo.score, .forty)
        managerMock.pointScoredByPlayerOne()
        XCTAssertEqual(managerMock.playerOne.score, .advantage)
    }

    func testPlayerOneMatchWin() {
        playerOne.score = .forty
        managerMock.pointScoredByPlayerOne()
        XCTAssertEqual(completionResult, .wonSet)
        playerOne.score = .forty
        managerMock.pointScoredByPlayerOne()
        XCTAssertEqual(completionResult, .wonSet)
        playerOne.score = .forty
        managerMock.pointScoredByPlayerOne()
        XCTAssertEqual(completionResult, .wonMatch)
        XCTAssertEqual(managerMock.winner, playerOne)
    }

    func testPlayerTwoMatchWin() {
        playerTwo.score = .forty
        managerMock.pointScoredByPlayerTwo()
        XCTAssertEqual(completionResult, .wonSet)
        playerTwo.score = .forty
        managerMock.pointScoredByPlayerTwo()
        XCTAssertEqual(completionResult, .wonSet)
        playerTwo.score = .forty
        managerMock.pointScoredByPlayerTwo()
        XCTAssertEqual(completionResult, .wonMatch)
        XCTAssertEqual(managerMock.winner, playerTwo)
    }

    func testDraw() {
        managerMock = TennisKataManager(playerOne: playerOne,
                                        playerTwo: playerTwo,
                                        setCount: 2) {[weak self] result in
                                            self?.completionResult = result
        }
        playerOne.score = .forty
        managerMock.pointScoredByPlayerOne()
        playerTwo.score = .forty
        managerMock.pointScoredByPlayerTwo()
        XCTAssertEqual(managerMock.result, .draw)
        XCTAssertEqual(completionResult, .draw)
    }
}

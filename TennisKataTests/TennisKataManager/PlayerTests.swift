//

@testable import TennisKata
import XCTest

class PlayerTests: XCTestCase {
    var playerMock: Player?

    override func setUp() {
        playerMock = Player(name: "P1")
    }

    func testInitialisation() {
        XCTAssertEqual(playerMock?.name, "P1")
        XCTAssertEqual(playerMock?.result, .inProgress)
        XCTAssertEqual(playerMock?.score, .zero)
        XCTAssertEqual(playerMock?.setsWon, 0)
    }

    func testResetScore() {
        playerMock?.score = .forty
        playerMock?.result = .wonSet
        playerMock?.setsWon = 4
        playerMock?.resetForGame()
        XCTAssertEqual(playerMock?.result, .inProgress)
        XCTAssertEqual(playerMock?.score, .zero)
        XCTAssertEqual(playerMock?.setsWon, 4)
    }

    func testScoreText() {
        XCTAssertEqual(Score.zero.scoreText(), "0")
        XCTAssertEqual(Score.fifteen.scoreText(), "15")
        XCTAssertEqual(Score.thirty.scoreText(), "30")
        XCTAssertEqual(Score.forty.scoreText(), "40")
        XCTAssertEqual(Score.advantage.scoreText(), "Advantage")
    }
}

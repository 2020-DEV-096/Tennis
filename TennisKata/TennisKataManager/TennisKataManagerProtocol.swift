//

import Foundation

protocol TennisKataManagerProtocol {
    typealias Completion = (Result) -> Void
    var playerOne: Player { get }
    var playerTwo: Player { get }
    var winner: Player? { get }
    var setCount: Int { get }
    var currentSet: Int { get }
    var update: Completion? { get }
    var result: Result { get }

    init(playerOne: Player,
         playerTwo: Player,
         setCount: Int,
         updateCompletion: @escaping Completion)
    func startGame()
    func pointScoredByPlayerOne()
    func pointScoredByPlayerTwo()
}

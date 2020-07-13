# TennisKata

TennisKata is a simple app to showcase the wii tennis logic implementation.


## Scoring
1 Game = 1 Set

Number of sets to be played - `Input`

The player wins the max number of sets, wins the match


## Running the sample app

Compile the project in `XCode 11.5`

Language used - `SWIFT 5`

Unit Testing - Using `XCTestCase`


## Working

Inputs - 

```swift
playerOne: Player
playerTwo: Player
setCount: Int
```

```swift
// `TennisKataManager` handles all the computation
TennisKataManager(playerOne: playerOne,
                  playerTwo: playerTwo,
                  setCount: setCount) {
                  // `Completion` closure for updating the UI
}
```

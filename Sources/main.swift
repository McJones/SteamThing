import Foundation

let steamIDs = Array(CommandLine.arguments[1..<CommandLine.arguments.count])

let steamHelper = SteamAPI()
steamHelper.load(playerIDs: steamIDs)

let playerNames = steamHelper.playersInfo.map { return $0.name }
print("\(playerNames.joined(separator: ", ")) all have the following games:")

var games = steamHelper.games.values.filter { $0.count == steamIDs.count }
games.sorted{$0.name < $1.name}.forEach{print($0.name)}

// going through all games that 2 or more peeps own
for i in (2...steamIDs.count - 1).reversed()
{
    var newGames = steamHelper.games.values.filter { $0.count == i }.filter { !games.contains($0) }
    
    print("\nThe following \(newGames.count) games are owned by \(i) players:")
    newGames.sorted { $0.name < $1.name }.forEach { print($0.name) }
    
    // the new list of already shown games
    games = steamHelper.games.values.filter { $0.count >= i }
}

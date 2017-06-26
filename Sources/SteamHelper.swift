//
//  SteamHelper.swift
//  SteamThing
//
//  Created by Tim Nugent on 26/6/17.
//
//

import Foundation
import SwiftyJSON

let apikey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

class SteamAPI
{
    var games = [Int : Game]()
    var playersInfo = [Player]()
    
    func load(playerIDs: [String])
    {
        guard let players = self.getPlayerInfo(steamID: playerIDs) else
        {
            print("failed to load player info")
            return
        }
        for player in players
        {
            //ok go through and run the get games script
            // but modify it so that it returns how many people own that game
            self.getGames(steamID: player.steamID)
        }
        self.playersInfo = players
    }
    private func getGames(steamID : String)
    {
        let urlString = "http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=\(apikey)&steamid=\(steamID)&include_appinfo=1&include_played_free_games=1&format=json"
        if let url = URL(string: urlString)
        {
            do
            {
                let contents = try String(contentsOf: url)
                
                if let jsonData = contents.data(using: .utf8)
                {
                    let json = JSON(data: jsonData)
                    if let gamesList = json["response"]["games"].array
                    {
                        for game in gamesList
                        {
                            let name = game["name"].stringValue
                            let appid = game["appid"].intValue
                            let count = self.games[appid] != nil ? self.games[appid]!.count + 1 : 1
                            
                            self.games[appid] = Game(name: name, appid: appid, count: count)
                        }
                    }
                }
            }
            catch
            {
                print("Error grabbing games list for steam id \(steamID)")
            }
        }
    }
    private func getPlayerInfo(steamID : [String]) -> [Player]?
    {
        var players : [Player]?
        let urlString = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=\(apikey)&steamids=\(steamID.joined(separator: ",")))"
        if let url = URL(string: urlString)
        {
            do
            {
                let contents = try String(contentsOf: url)
                
                if let jsonData = contents.data(using: .utf8)
                {
                    let json = JSON(data: jsonData)
                    if let playerArray = json["response"]["players"].array
                    {
                        for player in playerArray
                        {
                            if let playerInfo = player.dictionary
                            {
                                let id = playerInfo["steamid"]?.stringValue
                                let name = playerInfo["personaname"]?.stringValue
                                let avatar = playerInfo["avatar"]?.stringValue
                                
                                if players == nil
                                {
                                    players = [Player]()
                                }
                                players?.append(Player(steamID: id!, name: name!, avatar: avatar!))
                            }
                        }
                    }
                }
            }
            catch
            {
                print("Error grabbing user information for id \(steamID)")
            }
        }
        return players
    }
}

struct Game
{
    let name : String
    let appid : Int
    var count : Int = 0
}
extension Game : Equatable
{
    static func ==(lhs: Game, rhs: Game) -> Bool
    {
        return lhs.appid == rhs.appid
    }
}
internal struct Player
{
    let steamID : String
    let name : String
    let avatar : String
}

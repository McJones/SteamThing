# SteamThing

A tool I made to see what games people have in common across their steam accounts.
This came about because at LANs there is no easy way to know what games most people have until you get there, and I did this as something to do while home bored, so it might be a bit odd.

## Using it

You will need a Steam API Key before you can use SteamThing, you can get one from [Valve](http://steamcommunity.com/dev).
Once you have that you can plug it into the code at `Sources/SteamHelper.swift` and then you can build SteamThing.

SteamThing uses the Swift package manager so running `swift build` will handle everything.

Once it is built you can run it from the command line, by default the built SteamThing will be inside the `.build/debug` folder, so you can run this like:
```
	.build/debug/SteamThing steamid1 steamid2 steamid3
```
This will spit out a list of games that the users with the steam ids steamid1, steamid2, steamid3 all own as well as games that the majority of players own.
To work out what your/others steam id are, the easiest way is to use the [Steam ID Finder](http://steamidfinder.com).
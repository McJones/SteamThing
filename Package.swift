// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "SteamThing",
    dependencies : [
    .Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", majorVersion:3)
    ]
)

local scripts = {
    "https://raw.githubusercontent.com/kdottcam/relay-scripts/main/scripts/FootballFusion.lua",
    "https://raw.githubusercontent.com/kdottcam/relay-scripts/main/scripts/CleanAllTheLeaves.lua",
    "https://raw.githubusercontent.com/kdottcam/relay-scripts/main/scripts/BladeBall.lua",
    "https://raw.githubusercontent.com/kdottcam/relay-scripts/main/scripts/SpellingBee.lua",
    "https://raw.githubusercontent.com/kdottcam/relay-scripts/main/scripts/UntiltedBoxingGame.lua",
}

for _, url in ipairs(scripts) do
    loadstring(game:HttpGet(url))()
end

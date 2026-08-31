local environment = getgenv()

if script_key then
    environment.script_key = script_key
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function fail(message)
    player:Kick("[sigma] " .. tostring(message))
end

local BASE = "https://raw.githubusercontent.com/kdottcam/relay-scripts/main/scripts/"

local HUBS = {
    [3725359351] = "AnimalHospital",
    [10148749921] = "AnimalHospital",
    [4777817887] = "BladeBall",
    [13772394625] = "BladeBall",
    [10539411000] = "CleanAllTheLeaves",
    [9908641400] = "FootballFusion",
    [6022371481] = "SpellingBee",
    [10144280947] = "Speedmonkey",
    [114697347887839] = "Speedmonkey",
    [833423526] = "Strucid",
    [2377868063] = "Strucid",
    [7128251171] = "SuperstarBaseball",
    [101432174163538] = "SuperstarBaseball",
    [4730278139] = "UntiltedBoxingGame",
    [6969237940] = "UntiltedBoxingGame",
    [4931927012] = "BasketballLegends",
    [7633926880] = "Bloxstrike",
    [114234929420007] = "Bloxstrike",
    [2459091562] = "Rh2",
    [6549794549] = "Rh2",
    [6678600773] = "Rh2",
    [7235817949] = "Rh2",
}

local name = HUBS[game.GameId] or HUBS[game.PlaceId]

if not name then
    return fail(
        ("Unsupported game (GameId: %d, PlaceId: %d)"):format(
            game.GameId,
            game.PlaceId
        )
    )
end

environment.__RELAY_LOADED_GAMES =
    environment.__RELAY_LOADED_GAMES or {}

if environment.__RELAY_LOADED_GAMES[name] then
    return
end

local downloaded, source = pcall(function()
    return game:HttpGet(BASE .. name .. ".lua")
end)

if not downloaded then
    return fail(
        "Could not download " .. name .. ": " .. tostring(source)
    )
end

local compiled, compileError = loadstring(source)

if not compiled then
    return fail(
        "Compile error in " .. name .. ": " .. tostring(compileError)
    )
end

environment.__RELAY_LOADED_GAMES[name] = true

task.spawn(function()
    local ran, runtimeError = pcall(compiled)

    if not ran then
        print(
            "[Relay] Runtime error in "
                .. name
                .. ": "
                .. tostring(runtimeError)
        )
    end
end)

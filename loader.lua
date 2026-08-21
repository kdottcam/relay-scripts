local BASE = "https://raw.githubusercontent.com/kdottcam/relay-scripts/refs/heads/main/scripts/"

local HUBS = {
    [3725359351]        = "AnimalHospital",
    [10148749921]       = "AnimalHospital",
    [4777817887]        = "BladeBall",
    [13772394625]       = "BladeBall",
    [10539411000]       = "CleanAllTheLeaves",
    [9908641400]        = "FootballFusion",
    [6022371481]        = "SpellingBee",
    [833423526]         = "Strucid",
    [2377868063]        = "Strucid",
    [7128251171]        = "SuperstarBaseball",
    [101432174163538]   = "SuperstarBaseball",
    [4730278139]        = "UntiltedBoxingGame",
    [6969237940]        = "UntiltedBoxingGame",
    [4931927012]        = "BasketballLegends",
}

local name = HUBS[game.GameId] or HUBS[game.PlaceId]
if not name then
    return warn(("[Relay] nothing for this game (game %d, place %d)"):format(game.GameId, game.PlaceId))
end

local ok, src = pcall(game.HttpGet, game, BASE .. name .. ".lua")
if not ok then return warn("[Relay] could not download " .. name .. ": " .. tostring(src)) end

local fn, err = loadstring(src)
if not fn then return warn("[Relay] compile error in " .. name .. ": " .. tostring(err)) end

local ran, runErr = pcall(fn)
if not ran then warn("[Relay] runtime error in " .. name .. ": " .. tostring(runErr)) end
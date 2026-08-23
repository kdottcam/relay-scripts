local BASE = "https://raw.githubusercontent.com/kdottcam/relay-scripts/refs/heads/main/scripts/"

-- Keyed by GameId first, which covers every place in a universe, with the
-- odd PlaceId alongside it where a game has a standalone place that reports
-- a different id.
local HUBS = {
    [3725359351]        = "AnimalHospital",
    [10148749921]       = "AnimalHospital",
    [4777817887]        = "BladeBall",
    [13772394625]       = "BladeBall",
    [10539411000]       = "CleanAllTheLeaves",
    [9908641400]        = "FootballFusion",
    [6022371481]        = "SpellingBee",
    [10144280947]       = "SpeedMonkey",
    [114697347887839]   = "SpeedMonkey",
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

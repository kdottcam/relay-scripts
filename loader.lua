local GAMES = {
    [4777817887] = "BladeBall",
    [9908641400] = "FootballFusion",
    [6022371481] = "SpellingBee",
    [4730278139] = "UntiltedBoxingGame",
    [6969237940] = "UntiltedBoxingGame",
}

local name = GAMES[game.GameId]
if not name then
    return warn(("[relay] no script for this game (place %d)"):format(game.PlaceId))
end

local url = ("https://raw.githubusercontent.com/kdottcam/relay-scripts/main/scripts/%s.lua?t=%d"):format(name, tick())

local ok, src = pcall(game.HttpGet, game, url)
if not ok then return warn("[relay] download failed: " .. tostring(src)) end

local fn, err = loadstring(src)
if not fn then return warn("[relay] compile error: " .. tostring(err)) end

local ran, runErr = pcall(fn)
if not ran then warn("[relay] runtime error: " .. tostring(runErr)) end

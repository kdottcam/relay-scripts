local GAMES = {
    [13772394625] = "BladeBall",
    [82866880824588] = "FootballFusion",
    [17590362521] = "SpellingBee",
    [13621938427] = "UntiltedBoxingGame",
    [92637789841354] = "CleanAllTheLeaves",
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

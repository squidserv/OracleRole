local VISION = {}

VISION.Name = "There are how many alive?"
VISION.id = "alive"

if SERVER then
    CreateConVar("ttt_oracle_alive_enemy_only", 0, FCVAR_NONE, "Should only enemies be included in the vision?")
end

function VISION:GetVision()
    local count = 0
    if GetConVar("ttt_oracle_alive_enemy_only"):GetBool() then
        local teams = {player.TeamLivingCount}
        for i, t in ipairs(teams) do
            if i ~= 2 then
                count = count + t
            end
        end
        count = count .. " enemy "
    else
        count = player.LivingCount()
    end
    return "There are " .. count .. " players alive"
end

function VISION:Condition()
    return CRVersion("1.3.1")
end

Oracle:register(VISION)
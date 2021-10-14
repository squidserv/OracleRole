local VISION = {}

VISION.Name = "There are how many alive?"
VISION.id = "alive"

if SERVER then
    CreateConVar("ttt_oracle_alive_mode", 3, FCVAR_NONE, "Should only enemies be included in the vision? 1 = yes, 2 = no, 3 = Either")
end

function VISION:GetVision()
    local mode = GetConVar("ttt_oracle_alive_mode"):GetInt()
    if mode > 2 or mode < 1 then
        mode = math.random(1,2)
    end
    local count = 0
    if mode == 1  then
        local teams = {player.TeamLivingCount()}
        for i, t in ipairs(teams) do
            if i ~= 2 then
                count = count + t
            end
        end
        count = count .. " enemy"
    else
        count = player.LivingCount()
    end
    return "There are " .. count .. " players alive"
end

function VISION:Condition()
    return CRVersion("1.3.1")
end

Oracle:register(VISION)
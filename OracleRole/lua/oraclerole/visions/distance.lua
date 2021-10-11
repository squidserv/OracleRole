local VISION = {}

VISION.Name = "A player is how far away?"
VISION.id = "distance"

CreateConVar("ttt_oracle_distance_unit", 0, FCVAR_NONE, "The distance reported in ft (0) or m (1)")

function VISION:GetVision()
    local p = self:GetRandomEnemy()

    local m = GetConVar("ttt_oracle_distance_unit"):GetBool()

    local distance = "0"
    if p ~= nil then
        local ply = player.GetLivingRole(ROLE_ORACLE)
        if m then
            distance = math.ceil((ply:GetPos():Distance(p:GetPos())) * 0.01905) .. "m"
        else
            distance = math.ceil((ply:GetPos():Distance(p:GetPos())) * 0.0625) .. "ft"
        end
    else
        if m then
            distance = distance .. "m"
        else
            distance = distance .. "ft"
        end
    end
    return "An enemy player is currently " .. distance .. " away!"
end

function VISION:Condition()
    local t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
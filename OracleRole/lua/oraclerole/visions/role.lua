local VISION = {}

VISION.Name = "There is a Role!"
VISION.id = "role"

if SERVER then
    CreateConVar("ttt_oracle_role_enemy_only", 1, FCVAR_NONE, "Should only enemies be included in the vision")
end

function VISION:GetVision()

    local p
    if GetConVar("ttt_oracle_role_enemy_only"):GetBool() then
        p = self:GetRandomEnemy()
    else
        local plys = {}
        for _, ply in ipairs(player.GetAll()) do
            if IsPlayer(ply) and ply:IsActive() and not ply:IsDetectiveTeam() and not ply:IsInnocent() then
                table.insert(plys, ply)
            end
        end
        table.Shuffle(plys)

        local count = table.Count(plys)
        local key = math.random(count)
        p = plys[key]
    end

    local role = "Oracle"
    if p ~= nil then
        role = p:GetRole()
    end
    return "There is a " .. role
end

function VISION:Condition()
    local t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
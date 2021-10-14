local VISION = {}

VISION.Name = "There is a Role!"
VISION.id = "role"

if SERVER then
    CreateConVar("ttt_oracle_role_mode", 1, FCVAR_NONE, "Should only enemies be included in the vision? 1 = yes, 2 = no, 3 = Either")
end

function VISION:GetVision()

    local mode = GetConVar("ttt_oracle_alive_mode"):GetInt()
    if mode > 2 or mode < 1 then
        mode = math.random(1,2)
    end

    local p
    if mode == 1 then
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

    local role = "an Oracle"
    if p ~= nil then
        role = ROLE_STRINGS_EXT[p:GetRole()]
    end
    return "There is " .. role
end

function VISION:Condition()
    local t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
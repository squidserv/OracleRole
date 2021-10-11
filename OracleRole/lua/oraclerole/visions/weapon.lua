local VISION = {}

VISION.Name = "A player is holding?"
VISION.id = "weapon"

function VISION:GetVision()
    local plys = { }
    for _, ply in ipairs(player.GetAll()) do
        if IsPlayer(ply) and (ply:IsActiveTraitorTeam() or ply:IsActiveMonsterTeam() or ply:IsActiveIndependentTeam()
                or ply:IsActiveJesterTeam()) then
            table.insert(plys, ply)
        end
    end
    table.Shuffle(plys)

    local count = table.Count(plys)
    local idx = math.random(count)
    local key = table.GetKeys(plys)[idx]

    local p = plys[key]

    local weapon = "Nothing"
    if p ~= nil then
        local wep = p:GetActiveWeapon()
        if wep ~= nil then
            weapon = p:GetActiveWeapon():GetClass()
        end
    end
    return "An enemy player is currently holding " .. self:RenameWeps(weapon)
end

function VISION:Condition()
    t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
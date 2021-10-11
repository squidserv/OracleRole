local VISION = {}

VISION.Name = "A player is holding?"
VISION.id = "weapon"

function VISION:GetVision()
    local p = self:GetRandomEnemy()

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
    local t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
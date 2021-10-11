local VISION = {}

VISION.Name = "This player hasn't been found"
VISION.id = "body"

function VISION:GetVision()
    local plys = {}

    for _, ply in ipairs(player.GetAll()) do
        if not ply:Alive() and ply:GetNWBool("body_found", false) then
            table.insert(plys, ply)
        end
    end

    table.Shuffle(plys)

    local count = table.Count(plys)
    local idx = math.random(count)
    local key = table.GetKeys(plys)[idx]

    return plys[key]:Nick() .. " is dead!"
end

function VISION:Condition()
    for _, ply in ipairs(player.GetAll()) do
        if not ply:Alive() and ply:GetNWBool("body_found", false) then
            return true
        end
    end
    return false
end

Oracle:register(VISION)
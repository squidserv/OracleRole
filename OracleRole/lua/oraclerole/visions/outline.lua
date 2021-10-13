local VISION = {}

VISION.Name = "Outline all the players."
VISION.id = "outline"

util.AddNetworkString("halovisiontrigger")
util.AddNetworkString("halovisionend")

local ply

function VISION:GetVision()
    ply = player.GetLivingRole(ROLE_ORACLE)
    net.Start("halovisiontrigger")
    net.Send(ply)
    return ""
end

function VISION:EndVision()
    net.Start("halovisionend")
    net.Send(ply)
end

Oracle:register(VISION)
local VISION = {}

VISION.Name = "Outline all the players."
VISION.id = "outline"

util.AddNetworkString("halovisiontrigger")
util.AddNetworkString("halovisionend")

function VISION:GetVision()
    print("start")
    net.Start("halovisiontrigger")
    net.Broadcast()
    return ""
end

function VISION:EndVision()
    print("end")
    net.Start("halovisionend")
    net.Broadcast()
end

Oracle:register(VISION)
local ROLE = {}

ROLE.nameraw = "oracle"
ROLE.name = "Oracle"
ROLE.nameplural = "Oracles"
ROLE.nameext = "An Oracle"
ROLE.nameshort = "orc"

ROLE.desc = [[You are {role}! A member of the {detective} Team!
Every so often you will receive a vision that may help you solve the case.
Be careful, you will be vulnerable during your visions however.
Press {menukey} to receive your special equipment!]]

ROLE.team = ROLE_TEAM_DETECTIVE

ROLE.shop = { "item_armor", "item_radar", "weapon_ttt_health_station" }
ROLE.loadout = {}

ROLE.startingcredits = 1

ROLE.startinghealth = nil
ROLE.maxhealth = nil

ROLE.isactive = function(ply)
    return ply:GetNWBool("OracleActive", false)
end

ROLE.selectionpredicate = nil
ROLE.shouldactlikejester = nil

ROLE.translations = {}

if SERVER then
    CreateConVar("ttt_oracle_blind", 1, FCVAR_NONE, "If the oracle should be blinded during their vision")
    CreateConVar("ttt_oracle_vision_time", 10, FCVAR_NONE, "How long the vision shows on the screen", 5, 120)
    CreateConVar("ttt_oracle_vision_gap", 30, FCVAR_NONE, "The time between getting visions", 10, 120)
    CreateConVar("ttt_oracle_chatbox", 0, FCVAR_NONE, "If the oracle should get the message in their chat box too")

    hook.Add("TTTSyncGlobals", "OracleGlobals", function()
        SetGlobalInt("ttt_oracle_vision_time", GetConVar("ttt_oracle_vision_time"):GetInt())
        SetGlobalBool("ttt_oracle_blind", GetConVar("ttt_oracle_blind"):GetBool())
    end)
end
ROLE.convars = {}
table.insert(ROLE.convars, {
    cvar = "ttt_oracle_blind",
    type = ROLE_CONVAR_TYPE_BOOL,
})
table.insert(ROLE.convars, {
    cvar = "ttt_oracle_vision_time",
    type = ROLE_CONVAR_TYPE_NUM
})
table.insert(ROLE.convars, {
    cvar = "ttt_oracle_vision_gap",
    type = ROLE_CONVAR_TYPE_NUM
})
table.insert(ROLE.convars, {
    cvar = "ttt_oracle_chatbox",
    type = ROLE_CONVAR_TYPE_BOOL
})

if CRVersion("1.3.1") then
    RegisterRole(ROLE)
end

local function AddFile(fil)
    if SERVER then include(fil) end
    if CLIENT then include(fil) end
end

util.AddNetworkString("OracleVision")

Oracle = {}
Oracle.Visions = {}
local oracle_meta = {}
oracle_meta.__index = oracle_meta

local files, _ = file.Find("oraclerole/visions/*.lua", "LUA")
for _, fil in ipairs(files) do
    AddFile("oraclerole/visions/" .. fil)
end

local function DisplayVision(ply, message)
    net.Start("OracleVision")
    net.WriteEntity(ply)
    net.WriteString(message)
    net.Send(ply)
end

local function TriggerVision(ply,vision)
    local message = vision:GetVision()
    local visionTime = GetConVar("ttt_oracle_vision_time"):GetInt()
    ply:SetNWBool("OracleActive", true)
    DisplayVision(ply, message)

    if GetConVar("ttt_oracle_chatbox"):GetBool() then
        ply:PrintMessage(HUD_PRINTTALK, message)
    end

    timer.Create("OracleVision",visionTime,1,function()
        ply:SetNWBool("OracleActive", false)
    end)
end

function Oracle:register(tbl)
    local id = tbl.id
    tbl.Id = id
    tbl.__index = tbl
    setmetatable(tbl,oracle_meta)

    Oracle.Visions[id] = tbl

    CreateConVar("ttt_oracle_"..id, 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
end

local function GetRandomVision(visions)
    table.Shuffle(visions)

    local count = table.Count(visions)
    local idx = math.random(count)
    local key = visions[idx]

    return visions[key]
end

function Oracle:CanVisionRun(vision)
    if type(vision) ~= "table" then
        vision = Oracle.Visions[vision]
    end
    if vision == nil then return false end

    return vision:Enabled() and vision:Condition()
end

function Oracle:TriggerRandomVision(ply)
    local visions = Oracle.Visions

    local found = false
    for _, v in pairs(visions) do
        if Oracle:CanVisionRun(v) then
            found = true
            break
        end
    end

    if found then
        local vision = GetRandomVision(visions)
        while not Oracle:CanVisionRun(vision) do
            vision = GetRandomVision(visions)
        end

        TriggerVision(ply,vision)
    end
end

function oracle_meta:GetVision() end

function oracle_meta:Condition()
    return true
end

function oracle_meta:Enabled()
    if GetConVar("ttt_oracle_"..self.id):GetBool() then
        return true
    else
        return false
    end
end

-- Rename stock weapons so they are readable
function oracle_meta:RenameWeps(name)
    if name == "sipistol_name" then
        return "Silenced Pistol"
    elseif name == "knife_name" then
        return "Knife"
    elseif name == "newton_name" then
        return "Newton Launcher"
    elseif name == "tele_name" then
        return "Teleporter"
    elseif name == "hstation_name" then
        return "Health Station"
    elseif name == "flare_name" then
        return "Flare Gun"
    elseif name == "decoy_name" then
        return "Decoy"
    elseif name == "radio_name" then
        return "Radio"
    elseif name == "polter_name" then
        return "Poltergeist"
    elseif name == "vis_name" then
        return "Visualizer"
    elseif name == "defuser_name" then
        return "Defuser"
    elseif name == "stungun_name" then
        return "UMP Prototype"
    elseif name == "binoc_name" then
        return "Binoculars"
    end

    return name
end

if SERVER then
    AddCSLuaFile()

    local ply

    hook.Add("TTTBeginRound", "OracleRoundStart", function()
        ply = player.GetLivingRole(ROLE_ORACLE)
    end)

    timer.Create("OracleVisionGap", GetConVar("ttt_oracle_vision_gap"):GetInt(), 0, function()
        if player.IsRoleLiving(ROLE_ORACLE) then
            Oracle:TriggerRandomVision(ply)
        else
            ply:SetNWBool("OracleActive", false)
        end
    end)

    hook.Add("TTTEndRound", "OracleEndRound", function()
        timer.Remove("OracleVisionGap")
        timer.Remove("OracleVision")
        ply:SetNWBool("OracleActive", false)
    end)
end

if CLIENT then
    local ply
    local msg

    net.Receive("OracleVision", function()
        ply = net.ReadEntity()
        msg = net.ReadString()
    end)

    hook.Add("HUDPaint", "OracleVision", function()
        if not IsPlayer(ply) then return end
        if not ply:IsActiveOracle() then return end
        if ply:SteamID64() ~= LocalPlayer():SteamID64() then return end
        if not ply:IsRoleActive() then return end
        if msg == nil then return end

        if GetGlobalBool("ttt_oracle_blind") then
            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawRect(0, 0, surface.ScreenWidth(), surface.ScreenHeight())
        end

        local panel = vgui.Create("DNotify")
        panel:SetLife(GetGlobalInt("ttt_oracle_vision_time"))

        surface.CreateFont("OracleVisionMsg", {
            font = "Roboto",
            size = 32
        })
        surface.SetFont("OracleVisionMsg")
        panel:SetSize(surface.GetTextSize(msg))
        panel:Center()
        panel:CenterVertical(0.55)

        local bg = vgui.Create("DPanel", panel)
        bg:SetBackgroundColor(Color(0, 0, 0, 200))
        bg:Dock(FILL)

        local lbl = vgui.Create("DLabel", bg)
        lbl:SetText(msg)
        lbl:SetFont("OracleVisionMsg")
        lbl:SetTextColor(Color(255, 200, 0))
        lbl:SetWrap(true)
        lbl:Dock(FILL)

        lbl:SetText(msg)

        panel:AddItem(bg)
    end)

    hook.Add("TTTTutorialRoleText", "OracleTutorialRoleText", function(role, titleLabel, roleIcon)
        if role == ROLE_ORACLE then
            local roleColor = GetRoleTeamColor(ROLE_TEAM_DETECTIVE)
            local html = "The " .. ROLE_STRINGS[ROLE_ORACLE] .. " is an <span style='color: rgb(" .. roleColor.r .. ", " .. roleColor.g .. ", " .. roleColor.b .. ")'>detective role</span> who Gets visions that will help their team."
            html = html .. "<ul style='position: relative; top: -15px;'>"
            roleColor = GetRoleTeamColor(ROLE_TEAM_TRAITOR)
            html = html .. "<li>Visions will appear on their screen that give them information on the <span style='color: rgb(" .. roleColor.r .. ", " .. roleColor.g .. ", " .. roleColor.b .. ")'>traitors</span>"
            html = html .. "<li>Their screen will go black during their visions"
            return html .. "</ul>"
        end
    end)
end
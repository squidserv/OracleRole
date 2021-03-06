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

RegisterRole(ROLE)

if SERVER then
    AddCSLuaFile()
    util.AddNetworkString("OracleVision")
    include("oraclerole/weapons.lua")
end

local function AddServer(fil)
    if SERVER then include(fil) end
end

local function AddClient(fil)
    if SERVER then AddCSLuaFile(fil) end
    if CLIENT then include(fil) end
end

Oracle = {}
Oracle.Visions = {}
local oracle_meta = {}
oracle_meta.__index = oracle_meta

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

    if GetConVar("ttt_oracle_blind"):GetBool() then
        ply:ScreenFade(SCREENFADE.STAYOUT, Color(0,0,0,255),0, 0)
    end

    if GetConVar("ttt_oracle_chatbox"):GetBool() then
        ply:PrintMessage(HUD_PRINTTALK, message)
    end

    timer.Create("OracleVision",visionTime,1,function()
        if message == "" then
            vision:EndVision()
        end
        ply:ScreenFade(SCREENFADE.PURGE, Color(0,0,0,255),0, 0)
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

    table.insert(ROLE.convars, {
        cvar = "ttt_oracle_"..id,
        type = ROLE_CONVAR_TYPE_BOOL,
    })
end

local function GetRandomVision(visions)
    table.Shuffle(visions)

    local count = table.Count(visions)
    local idx = math.random(count)
    local key = table.GetKeys(visions)[idx]

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

function oracle_meta:EndVision() end

function oracle_meta:Condition()
    return true
end

function oracle_meta:Enabled()
    return GetConVar("ttt_oracle_"..self.id):GetBool()
end

function oracle_meta:GetRandomEnemy()
    local plys = { }
    for _, ply in ipairs(player.GetAll()) do
        if IsPlayer(ply) and (ply:IsActiveTraitorTeam() or ply:IsActiveMonsterTeam() or ply:IsActiveIndependentTeam()
                or ply:IsActiveJesterTeam()) then
            table.insert(plys, ply)
        end
    end
    table.Shuffle(plys)

    local count = table.Count(plys)
    local key = math.random(count)

    return plys[key]
end

-- Rename stock weapons so they are readable
function oracle_meta:RenameWeps(name)
    local weps = {}
    weps = ConvertOracleWeapons()

    for _, wep in ipairs(weps) do
        if wep.class_name == name then
            return wep.sanitized_name
        end
    end

    return name
end

function oracle_meta:GetRoleTeamName(team)
    if team == ROLE_TEAM_TRAITOR then
        return "traitor"
    elseif team == ROLE_TEAM_MONSTER then
        return "monster"
    elseif team == ROLE_TEAM_JESTER then
        return "jester"
    elseif team == ROLE_TEAM_INDEPENDENT then
        return "independent"
    elseif team == ROLE_TEAM_DETECTIVE then
        return "detective"
    end
    return "innocent"
end

local files, _ = file.Find("oraclerole/visions/*.lua", "LUA")
for _, fil in ipairs(files) do
    AddServer("oraclerole/visions/" .. fil)
end

local clientfiles, _ = file.Find("oraclerole/visions/cl_visions/*.lua", "LUA")
for _, fil in ipairs(clientfiles) do
    AddClient("oraclerole/visions/cl_visions/" .. fil)
end

if SERVER then
    local ply

    hook.Add("TTTBeginRound", "OracleRoundStart", function()
        ply = player.GetLivingRole(ROLE_ORACLE)

        timer.Create("OracleVisionGap", GetConVar("ttt_oracle_vision_gap"):GetInt(), 0, function()
            if IsPlayer(ply) then
                if player.IsRoleLiving(ROLE_ORACLE) then
                    Oracle:TriggerRandomVision(ply)
                else
                    ply:SetNWBool("OracleActive", false)
                end
            end
        end)
    end)

    hook.Add("TTTEndRound", "OracleEndRound", function()
        timer.Remove("OracleVisionGap")
        timer.Remove("OracleVision")
        if IsPlayer(ply) then
            ply:SetNWBool("OracleActive", false)
        end
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

        local panel = vgui.Create("DNotify")
        panel:SetLife(1)

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
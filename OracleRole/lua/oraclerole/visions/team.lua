local VISION = {}

VISION.Name = "Is that team alive?"
VISION.id = "team"

if SERVER then
    CreateConVar("ttt_oracle_team_noinno", 0, FCVAR_NONE, "Should innocents be shown in the vision?")
end

function VISION:GetVision()

    local p
    local team = "detective"
    if not GetConVar("ttt_oracle_team_noinno"):GetBool() then
        p = self:GetRandomEnemy()
        team = GetRoleTeamName(p:GetRoleTeam())
    else
        local teams = {player.AreTeamsLiving()}
        local t = math.random(1,5)
        while not teams[t] do
            t = math.random(1,5)
        end
        if t == 1 then
            team = GetRoleTeamName(ROLE_TEAM_TRAITOR)
        elseif t == 2 then
            team = GetRoleTeamName(ROLE_TEAM_INNOCENT)
        elseif t == 3 then
            team = GetRoleTeamName(ROLE_TEAM_INDEPENDENT)
        elseif t == 4 then
            team = GetRoleTeamName(ROLE_TEAM_MONSTER)
        else
            team = GetRoleTeamName(ROLE_TEAM_JESTER)
        end
    end

    return "There is a member of the " .. team .. " team alive."
end

function VISION:Condition()
    local t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
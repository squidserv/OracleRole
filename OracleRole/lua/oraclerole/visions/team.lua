local VISION = {}

VISION.Name = "Is that team alive?"
VISION.id = "team"

if SERVER then
    CreateConVar("ttt_oracle_team_enemy_only", 1, FCVAR_NONE, "Should only enemies be included in the vision?")
end

function VISION:GetVision()

    local p
    local team = ROLE_TEAM_DETECTIVE
    if GetConVar("ttt_oracle_team_enemy_only"):GetBool() then
        p = self:GetRandomEnemy()
        team = p:GetRoleTeam()
    else
        local teams = {player.AreTeamsLiving()}
        local t = math.random(1,5)
        while not teams[t] do
            t = math.random(1,5)
        end
        if t == 1 then
            team = ROLE_TEAM_TRAITOR
        elseif t == 2 then
            team = ROLE_TEAM_INNOCENT
        elseif t == 3 then
            team = ROLE_TEAM_INDEPENDENT
        elseif t == 4 then
            team = ROLE_TEAM_MONSTER
        else
            team = ROLE_TEAM_JESTER
        end
    end

    return "There is a member of the " .. self:GetRoleTeamName(team) .. " team alive."
end

function VISION:Condition()
    local t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
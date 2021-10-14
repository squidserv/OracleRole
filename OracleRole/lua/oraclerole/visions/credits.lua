local VISION = {}

VISION.Name = "There are how many unspent credits?"
VISION.id = "credits"

if SERVER then
    CreateConVar("ttt_oracle_credits_mode", 3, FCVAR_NONE, "Should only one player be included in the vision? 1 = yes, 2 = no, 3 = Either")
end

function VISION:GetVision()
    local mode = GetConVar("ttt_oracle_credits_mode"):GetInt()
    if mode > 2 or mode < 1 then
        mode = math.random(1,2)
    end

    local credits = 0
    local str = ""

    if mode == 1  then
        credits = self:GetRandomEnemy():GetCredits()
        str = "An enemy player has " .. credits .. " credits remaining."
    else
        for _, ply in ipairs(player.GetAll()) do
            if IsPlayer(ply) and (ply:IsActiveTraitorTeam() or ply:IsActiveMonsterTeam() or ply:IsActiveIndependentTeam()
                    or ply:IsActiveJesterTeam()) then
                credits = credits + ply:GetCredits()
            end
        end
        str = "Your enemies have " .. credits .. " total credits remaining"
    end
    return str
end

function VISION:Condition()
    local t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
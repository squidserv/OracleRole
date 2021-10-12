local VISION = {}

VISION.Name = "One of these players is bad."
VISION.id = "reveal"

CreateConVar("ttt_oracle_reveal_players", 4, FCVAR_NONE, "The max number of players selected that could be bad.")
CreateConVar("ttt_oracle_reveal_mode", 2, FCVAR_NONE, "0 = One of, 1 = At least one of, 2 = Either")

function VISION:GetVision()

    local i = 0
    local plys = {}
    local bad = false
    local max = GetConVar("ttt_oracle_reveal_players"):GetInt()
    local mode = GetConVar("ttt_oracle_reveal_mode"):GetInt()
    local oracle = player.GetLivingRole(ROLE_ORACLE)

    if mode > 1 or mode < 0 then
        mode = math.random(0,1)
    end

    for _, ply in ipairs(player.GetAll()) do
        if i >= max and bad then break end
        if not oracle:IsSameTeam(ply) then
            if not bad or mode == 1 then
                table.insert(plys, ply)
            end
            bad = true
        elseif i > max then
            table.insert(plys, ply)
        end
        i = i + 1
    end

    local strings = {"Only one of ", "At least one of "}
    local s = strings[mode]

    for _, p in ipairs(plys) do
        s = s .. p:Nick() .. " "
    end

    return s .. "is bad."
end

function VISION:Condition()
    local t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
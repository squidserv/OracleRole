local VISION = {}

VISION.Name = "One of these players is bad."
VISION.id = "reveal"

if SERVER then
    CreateConVar("ttt_oracle_reveal_players", 4, FCVAR_NONE, "The max number of players selected that could be bad.")
    CreateConVar("ttt_oracle_reveal_mode", 3, FCVAR_NONE, "1 = One of, 2 = At least one of, 3 = Either")
end

function VISION:GetVision()

    local i = 0
    local plys = {}
    local bad = false
    local max = GetConVar("ttt_oracle_reveal_players"):GetInt()
    local mode = GetConVar("ttt_oracle_reveal_mode"):GetInt()
    local oracle = player.GetLivingRole(ROLE_ORACLE)

    if mode > 2 or mode < 1 then
        mode = math.random(1,2)
    end

    for _, ply in ipairs(table.Shuffle(player.GetAll())) do
        if i >= max and bad then break end
        if ply ~= oracle then
            if not oracle:IsSameTeam(ply) then
                if not bad or mode == 2 then
                    table.insert(plys, ply)
                end
                bad = true
            elseif i < max then
                table.insert(plys, ply)
            end
            i = i + 1
        end
    end

    local str1 = {"Only one of ", "At least one of "}
    local str2 = {"is ", "are "}
    local s1 = str1[mode]
    local s2 = str2[mode]

    for i, p in ipairs(plys) do
        s1 = s1 .. p:Nick()
        if i < table.getn(plys) then
            s1 = s1 .. ", "
        else
            s1 = s1 .. " "
        end
    end

    return s1 .. s2 .. "on a different team."
end

function VISION:Condition()
    local t, inno, i, m, j = player.AreTeamsLiving()
    return t or i or m or j
end

Oracle:register(VISION)
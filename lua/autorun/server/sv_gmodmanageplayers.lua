util.AddNetworkString("SendSlaySound")
util.AddNetworkString("SendSlayMenu")
util.AddNetworkString("SendTelePortMenu")

hook.Add("PlayerSay","GPM_PlayerCommand",function(ply,txt)

    if txt == "!gpm" or txt == "!slay" and ply:IsAdmin() then
        net.Start("SendSlayMenu")
        net.Send(ply)
        return ""
    
    elseif string.StartsWith(txt,"!slay ") then

        if !ply:IsAdmin() then
            ply:PrintMessage(HUD_PRINTTALK,"You aren't an admin !") 
            return ""
        end

        local command = string.Explode(" ",txt,false)
        local targetNickname = command[2]
        local allPlayers = player.GetAll()
        local correspondances = 0

        for k,v in ipairs(allPlayers) do
            if v:Nick() == targetNickname then
                v:Kill()
                net.Start("SendSlaySound")
                net.Send(v)
                correspondances = correspondances + 1 
            end
        end

        if correspondances <= 0 then
            ply:PrintMessage(HUD_PRINTTALK,"Can't find \"" .. targetNickname .. "\"")
        else
            ply:PrintMessage(HUD_PRINTTALK,"Player \"" .. targetNickname .. "\" has been slayed")
        end

    return ""

    elseif string.StartsWith(txt,"!tpto ") then

        if !ply:IsAdmin() then
            ply:PrintMessage(HUD_PRINTTALK,"You aren't an admin !") 
            return ""
        end

        local command = string.Explode(" ",txt,false)
        local targetNickname = command[2]
        local allPlayers = player.GetAll()
        local correspondances = 0

        for k,v in ipairs(allPlayers) do
            if v:Nick() == targetNickname then
                local targetPos = v:GetPos()
                targetPos.z = targetPos.z + 100
                ply:SetPos(targetPos)
                correspondances = correspondances + 1 
            end
        end

        if correspondances <= 0 then
            ply:PrintMessage(HUD_PRINTTALK,"Can't find \"" .. targetNickname .. "\"")
        end

    return ""
    end
end
)

net.Receive("SendSlayMenu", function(len,ply)
    if ply:IsAdmin() then
        local userid = net.ReadString()
        local target = Player(userid)
        net.Start("SendSlaySound")
        net.Send(target)
        target:Kill()
    end
end)

net.Receive("SendTelePortMenu", function(len,ply)
    if ply:IsAdmin() then
        local userid = net.ReadString()
        local target = Player(userid)
        local targetPos = target:GetPos()
        targetPos.z = targetPos.z + 100
        ply:SetPos(targetPos)
        EmitSound("common/stuck1.wav",targetPos)
    end
end)
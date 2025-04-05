util.AddNetworkString("SendSlaySound")
util.AddNetworkString("SendSlayMenu")

hook.Add("PlayerSay","SlayCommand",function(ply,txt)
    if txt == "!slay" and ply:IsAdmin() then
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
            ply:PrintMessage(HUD_PRINTTALK,"Player( \"" .. targetNickname .. "\" has been slayed")
        end
    return ""
    end
end
)

net.Receive("SendSlayMenu", function(len,ply)
    if ply:IsAdmin() then
        local steamid = net.ReadString()
        local target = player.GetBySteamID(steamid)
        net.Start("SendSlaySound")
        net.Send(target)
        target:Kill()
    end
end)
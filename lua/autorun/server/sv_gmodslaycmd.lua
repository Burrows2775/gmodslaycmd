util.AddNetworkString("SendSlaySound")

hook.Add("PlayerSay","SlayCommand",function(ply,txt)
    if string.StartsWith(txt,"!slay ") then
        if !ply:IsAdmin() then
            ply:PrintMessage(HUD_PRINTTALK,"Vous n'êtes pas administrateur !") 
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
            ply:PrintMessage(HUD_PRINTTALK,"Joueur \"" .. targetNickname .. "\" introuvable")
        else
            ply:PrintMessage(HUD_PRINTTALK,"Joueur(s) \"" .. targetNickname .. "\" a bien été slay")
        end
    return ""
    end
end
)
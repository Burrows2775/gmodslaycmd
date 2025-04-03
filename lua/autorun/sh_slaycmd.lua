
if SERVER then

    util.AddNetworkString("CmdSlay")
    util.AddNetworkString("CmdSlaySound")

    net.Receive("CmdSlay", function( len, ply )
        if ply:IsAdmin() then
            local PlyToKill = net.ReadEntity()
            net.Start("CmdSlaySound")
            net.Send(PlyToKill)
            PlyToKill:Kill()
        else
            ply:Kill()
        end
    end)
end

if CLIENT then

    hook.Add("OnPlayerChat", "MessageChat", function(ply, text)
        if string.StartsWith(text, "!slay ") and LocalPlayer():IsAdmin() then
            local command = string.Explode(" ", text, false)
            local target = command[2]
            
            local allPlayers = player.GetAll();
            local correspond = 0;

            for k,v in ipairs(allPlayers) do
                if v:Nick() == target then
                    net.Start("CmdSlay")
                    net.WriteEntity(v)
                    net.SendToServer()
                    correspond = correspond + 1
                end
            end

            if correspond <= 0 then
                ply:PrintMessage(HUD_PRINTTALK, "Joueur \"" .. target .. "\" introuvable")
            end

        elseif !LocalPlayer():IsAdmin() then
            ply:PrintMessage(HUD_PRINTTALK, "Vous n'êtes pas admin !")
        end            
    return ""
    end)
    
    net.Receive("CmdSlaySound", function()
        surface.PlaySound("spongebob.wav")
    end)

end

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
        if string.StartsWith(text, "!slay ") then
            local table command = string.Explode(" ", text, false)
            local table allPlayers = player.GetAll()
            for k, v, i in ipairs(allPlayers) do
                if v:Nick() == command[2] then
                    net.Start("CmdSlay")
                    net.WriteEntity(v)
                    net.SendToServer()
                end
            end
        end
    end)
    
    net.Receive("CmdSlaySound", function()
        surface.PlaySound("spongebob.wav")
    end)z

end
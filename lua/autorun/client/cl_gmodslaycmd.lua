local LocPlayer = LocalPlayer()

net.Receive("SendSlaySound",function()
    surface.PlaySound("spongebob.wav")
end)

net.Receive("SendSlayMenu",function()
    local Frame = vgui.Create( "DFrame" )
    Frame:SetTitle("Slay menu")
    Frame:SetSize( ScrW() * 300/1920, ScrH() * 300/1080 )
    Frame:Center()	
    Frame:SetDraggable(true)		
    Frame:MakePopup()
    Frame.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 43, 43, 43, 225) )
        draw.RoundedBox( 0, 0, 0, w, h/12, Color( 73, 3, 3, 195) )
    end

    local AppList = vgui.Create( "DListView", Frame )
    AppList:Dock( FILL )
    AppList:SetMultiSelect( false )
    AppList:AddColumn( "Pseudo" )
    AppList:AddColumn( "STEAMID" )
    for k,v in ipairs(player.GetHumans()) do
        AppList:AddLine( v:Nick(), v:SteamID() )
    end

    AppList.OnRowRightClick = function( panel, rowIndex, row )
        local Menu = DermaMenu()
        local btnWithIcon = Menu:AddOption( "Slay", function()
            net.Start("SendSlayMenu")
            local target = row:GetColumnText(2)
            net.WriteString(target)
            net.SendToServer()
            Frame:Close()
        end
        )
        btnWithIcon:SetIcon( "icon16/gun.png" )	
        Menu:Open()
    end

    AppList.OnRowSelected = function( panel, rowIndex, row )
        local Menu = DermaMenu()
        local btnWithIcon = Menu:AddOption( "Slay", function()
            net.Start("SendSlayMenu")
            local target = row:GetColumnText(2)
            net.WriteString(target)
            net.SendToServer()
            Frame:Close()
        end
        )
        btnWithIcon:SetIcon( "icon16/gun.png" )	
        Menu:Open()
    end
end)
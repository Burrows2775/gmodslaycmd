local LocPlayer = LocalPlayer()

net.Receive("SendSlaySound",function()
    surface.PlaySound("spongebob.wav")
end)

net.Receive("SendSlayMenu", function()

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
    AppList:AddColumn( "Name" )
    AppList:AddColumn( "USERID" )
    for k,v in ipairs(player.GetAll()) do
        AppList:AddLine( v:Nick(), v:UserID() )
    end

    AppList.OnRowRightClick = function( panel, rowIndex, row )
        local Menu = DermaMenu()
        local btnSlay = Menu:AddOption("Slay", function()
            net.Start("SendSlayMenu")
            local target = row:GetColumnText(2)
            net.WriteString(target)
            net.SendToServer()
            Frame:Close()
        end)
        btnSlay:SetIcon( "icon16/gun.png" )	

        local btnTelePort = Menu:AddOption( "Teleport to", function()
            net.Start("SendTelePortMenu")
            local target = row:GetColumnText(2)
            net.WriteString(target)
            net.SendToServer()
            Frame:Close()
        end)
        btnTelePort:SetIcon( "icon16/world_go.png" )	

        Menu:Open()
    end

    AppList.OnRowSelected = function( panel, rowIndex, row )
        local Menu = DermaMenu()
        local btnSlay = Menu:AddOption("Slay", function()
            net.Start("SendSlayMenu")
            local target = row:GetColumnText(2)
            net.WriteString(target)
            net.SendToServer()
            Frame:Close()
        end)
        btnSlay:SetIcon( "icon16/gun.png" )	

        local btnTelePort = Menu:AddOption( "Teleport to", function()
            net.Start("SendTelePortMenu")
            local target = row:GetColumnText(2)
            net.WriteString(target)
            net.SendToServer()
            Frame:Close()
        end)
        btnTelePort:SetIcon( "icon16/world_go.png" )	

        Menu:Open()
    end
end)

-- derma_icon_browser
-- common/stuck1.wav

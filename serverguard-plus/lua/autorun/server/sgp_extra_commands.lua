include( "sgp_init.lua" )

util.AddNetworkString( "RollMessage" )

if( SGPlus.Extra.Enabled ) then

    -- START SAVE DATA ADMIN SIT
    SGPlus.Extra.AdminSitDataDir = "sgplus/admin_sit/"
    SGPlus.Extra.AdminSitData = SGPlus.Extra.AdminSitDataDir .. "admin_sit.txt"

    file.CreateDir( SGPlus.Extra.AdminSitDataDir )

    -- Prevent value error.
    if not file.Exists( SGPlus.Extra.AdminSitData, "DATA" ) then
        file.Write( SGPlus.Extra.AdminSitData, "0 0 0" )
    end
    -- END SAVE DATA ADMIN SIT


    local function sgp_extra_commands( ply, message )
        
        -- Roll a number between 1 - 100.
        if( message == SGPlus.Extra.Prefix .. SGPlus.Extra.Roll ) then
            net.Start( "RollMessage" )
            net.WriteString( string.format( "%s rolled %s", ply:Nick(), math.random( 1, 100 ) ) )
            net.Broadcast()
            return SGPlus.Extra.DisplayChat

        -- Get position of player.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.GetPos and player:IsAdmin() ) then
            ply:PrintMessage( 3, tostring( ply:GetPos() ) )
            return SGPlus.Extra.DisplayChat

        -- Send player to admin sit spot.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.AdminSit and SGPlus.Staff.HasPermissions( ply ) ) then
            -- Inform user if admin sit position is not set.
            if( file.Read( SGPlus.Extra.AdminSitData, "DATA" ) == "0 0 0" ) then
                serverguard.Notify( ply, SERVERGUARD.NOTIFY.RED, 
                    string.format( "You have not set an admin sit position, do so by running %s%s",
                    SGPlus.Extra.Prefix, SGPlus.Extra.SetSit ) )
            end

            local spawndata = Vector( file.Read( SGPlus.Extra.AdminSitData, "DATA" ) )
            ply:SetPos( spawndata )
            return SGPlus.Extra.DisplayChat
        
        -- Sets new admin sit position.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.SetSit and ply:IsAdmin() ) then
            local playerpos = tostring( ply:GetPos() )
            file.Write( SGPlus.Extra.AdminSitData, playerpos )

            local response = "Admin sit position has been updated!"
            serverguard.Notify( ply, SERVERGUARD.NOTIFY.WHITE, response )
            SGPlus.PrintConsole( SGPlus.WHITE, response )
            return SGPlus.Extra.DisplayChat
        end
    end

    hook.Add( "PlayerSay", "extra_commands", sgp_extra_commands )
end

include( "sgp_init.lua" )

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


    local function sgp_extra_commands( player, message )
        
        -- Roll a number between 1 - 100.
        if( message == SGPlus.Extra.Prefix .. SGPlus.Extra.Roll ) then
            serverguard.Notify( player, SERVERGUARD.NOTIFY.RED, 
                string.format( "%s rolled %s",
                player:Nick(), math.random( 1, 100 ) ) )
            return SGPlus.Extra.DisplayChat

        -- Get position of player.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.GetPos and player:IsAdmin() ) then
            player:PrintMessage( 3, tostring( player:GetPos() ) )
            return SGPlus.Extra.DisplayChat

        -- Send player to admin sit spot.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.AdminSit and SGPlus.Staff.HasPermissions( player ) ) then
            -- Inform user if admin sit position is not set.
            if( file.Read( SGPlus.Extra.AdminSitData, "DATA" ) == "0 0 0" ) then
                serverguard.Notify( player, SERVERGUARD.NOTIFY.RED, 
                    string.format( "You have not set an admin sit position, do so by running %s%s",
                    SGPlus.Extra.Prefix, SGPlus.Extra.SetSit ) )
            end

            local spawndata = Vector( file.Read( SGPlus.Extra.AdminSitData, "DATA" ) )
            player:SetPos( spawndata )
            return SGPlus.Extra.DisplayChat
        
        -- Sets new admin sit position.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.SetSit and player:IsAdmin() ) then
            local playerpos = tostring( player:GetPos() )
            file.Write( SGPlus.Extra.AdminSitData, playerpos )

            local response = "Admin sit position has been updated!"
            serverguard.Notify( player, SERVERGUARD.NOTIFY.WHITE, response )
            SGPlus.PrintConsole( SGPlus.WHITE, response )
            return SGPlus.Extra.DisplayChat
        end
    end

    hook.Add( "PlayerSay", "extra_commands", sgp_extra_commands )
end
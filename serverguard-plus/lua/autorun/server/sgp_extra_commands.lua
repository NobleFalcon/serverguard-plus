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
        local arguments = string.Split( message, " " )

        -- Roll a number between 1 - 100.
        if( message == SGPlus.Extra.Prefix .. SGPlus.Extra.Roll && !SGPlus.IsDisabled.Roll) then
            net.Start( "RollMessage" )
            net.WriteString( string.format( "%s rolled %s", ply:Nick(), math.random( 1, 100 ) ) )
            net.Broadcast()
            return SGPlus.Extra.DisplayChat

        -- Get position of player.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.GetPos and ply:IsAdmin() && !SGPlus.IsDisabled.GetPos) then
            ply:PrintMessage( 3, tostring( ply:GetPos() ) )
            return SGPlus.Extra.DisplayChat

        -- Send player to admin sit spot.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.AdminSit and SGPlus.Staff.HasPermissions( ply ) && !SGPlus.IsDisabled.AdminSit ) then
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
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.SetSit and ply:IsAdmin() && !SGPlus.IsDisabled.AdminSit ) then
            local playerpos = tostring( ply:GetPos() )
            file.Write( SGPlus.Extra.AdminSitData, playerpos )

            local response = "Admin sit position has been updated!"
            serverguard.Notify( ply, SERVERGUARD.NOTIFY.WHITE, response )
            SGPlus.PrintConsole( SGPlus.WHITE, response )
            return SGPlus.Extra.DisplayChat
        
        -- Set model of a player.
        elseif ( arguments[1] == SGPlus.Extra.Prefix .. SGPlus.Extra.Model and ply:IsAdmin() && SGPlus.Extra.BetaModeEnabled && !SGPlus.IsDisabled.Model) then
            local playerNick = arguments[2]
            local model = arguments[3]
            local playerList = player.GetAll()
            local translatedModel = player_manager.TranslatePlayerModel( model )
            local modelName = player_manager.TranslateToPlayerModelName( translatedModel )
            local response = string.format( "%s has set their model to %s", ply:Nick(), modelName )
            local errorMessage = "Something went wrong, make sure you enter "
            local playerNameExist = false

            if ( playerNick && model && (modelName != "kleiner" || model == "kleiner") ) then
                for _, plyer in pairs( playerList ) do
                    if ( string.lower( plyer:Nick() ) == string.lower( playerNick ) ) then
                        playerNameExist = true
                        plyer:SetModel( translatedModel )
                    end
                end
                if ( playerNameExist ) then
                    serverguard.Notify( ply, SGPlus.GREEN, response)
                    SGPlus.PrintConsole( SGPlus.WHITE, response )
                elseif (!playerNameExist) then
                    serverguard.Notify( ply, SGPlus.LIGHTRED, "Player not found!" )
                elseif ( false ) then
                    serverguard.Notify( ply, SGPlus.LIGHTRED, "Invalid model name!")
                end
            elseif ( !playerNick && !model) then
                serverguard.Notify( ply, SGPlus.LIGHTRED, SGPlus.Extra.Prefix .. SGPlus.Extra.Model .. " <player name> <model>" )
            elseif ( !model ) then
                serverguard.Notify( ply, SGPlus.LIGHTRED, "You didn't provide a model name!" )
            else
                serverguard.Notify( ply, SGPlus.LIGHTRED, "Model not found!" )
            end
            return SGPlus.Extra.DisplayChat
        end
    end

    hook.Add( "PlayerSay", "extra_commands", sgp_extra_commands )
end

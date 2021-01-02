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
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.GetPos && ply:IsAdmin() && !SGPlus.IsDisabled.GetPos) then
            ply:PrintMessage( 3, tostring( ply:GetPos() ) )
            return SGPlus.Extra.DisplayChat

        -- Send player to admin sit spot.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.AdminSit && SGPlus.Staff.HasPermissions( ply ) && !SGPlus.IsDisabled.AdminSit ) then
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
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.SetSit && ply:IsAdmin() && !SGPlus.IsDisabled.AdminSit ) then
            local playerpos = tostring( ply:GetPos() )
            file.Write( SGPlus.Extra.AdminSitData, playerpos )

            local response = "Admin sit position has been updated!"
            serverguard.Notify( ply, SERVERGUARD.NOTIFY.WHITE, response )
            SGPlus.PrintConsole( SGPlus.WHITE, response )
            return SGPlus.Extra.DisplayChat
        
        -- Set model of a player.
        elseif ( arguments[1] == SGPlus.Extra.Prefix .. SGPlus.Extra.Model && ply:IsAdmin() && SGPlus.Extra.BetaModeEnabled && !SGPlus.IsDisabled.Model) then
            -- Code needs to be rewritten from scratch.
            local playerNick = string.lower( arguments[2] or "" )
            local model = arguments[3] or ""
            local translatedModelName = player_manager.TranslateToPlayerModelName( model )
            local modelName = player_manager.TranslatePlayerModel( translatedModelName )
            local playerNameExist = false

            if ( playerNick != "" && model != "" ) then
                for _, plyer in pairs( player.GetAll() ) do
                    if ( string.lower( plyer:Nick() ) == playerNick ) then
                        playerNameExist = true
                        if ( translatedModelName != "kleiner" || model == "models/player/kleiner.mdl" ) then
                            plyer:SetModel( modelName )
                        elseif ( model != "kleiner" || translatedModelName == "kleiner" && model == "kleiner" ) then
                            modelName = player_manager.TranslatePlayerModel( model )
                            plyer:SetModel( modelName )
                            translatedModelName = player_manager.TranslateToPlayerModelName( modelName )
                        end
                    end
                end
                if ( playerNameExist ) then
                    local playerNickCapitalized = SGPlus.Capitalize( playerNick )
                    local successRunMessage = string.format( "%s has set %s's model to %s", ply:Nick(), playerNickCapitalized, translatedModelName )
                    serverguard.Notify( ply, SGPlus.GREEN, ply:Nick(), SGPlus.WHITE, " has set ", SGPlus.LIGHTRED, playerNickCapitalized .. "'s", SGPlus.WHITE, " model to ", SGPlus.GREEN, translatedModelName)
                    SGPlus.PrintConsole( SGPlus.WHITE, successRunMessage )
                elseif (!playerNameExist) then
                    serverguard.Notify( ply, SGPlus.LIGHTRED, "Player not found!" )
                end
            elseif ( playerNick == "" && model == "") then
                serverguard.Notify( ply, SGPlus.LIGHTRED, SGPlus.Extra.Prefix .. SGPlus.Extra.Model .. " <player name> <model>" )
            elseif ( model == "" ) then
                serverguard.Notify( ply, SGPlus.LIGHTRED, "You didn't provide a model name!" )
            end
            return SGPlus.Extra.DisplayChat
        end
    end

    hook.Add( "PlayerSay", "extra_commands", sgp_extra_commands )
end

include( "sgp_config.lua" );

SGPlus.Extra = Extra or {};
-- Setup
SGPlus.Extra.Enabled = true; -- Disable or enable all extra commands.
SGPlus.Extra.DisplayChat = false; -- Display chat message when command is recognized.
SGPlus.Extra.Prefix = "!"; -- Command prefix.
SGPlus.Extra.SpawnPoint = Vector( 0, 0, 0 ) -- Sends player to spesified position.

-- Commands
SGPlus.Extra.SetSit = "setsit";
SGPlus.Extra.AdminSit = "asit"; -- Sends player to selected coordinates.
SGPlus.Extra.GetPos = "getpos"; -- Gets position in vector.
SGPlus.Extra.Roll = "roll"; -- Rolls random number and broadcast's in chat.

-- DO NOT TOUCH ANY CODE BENEATH IF YOU DON'T KNOW WHAT YOU ARE DOING!!
if( SGPlus.Extra.Enabled ) then
    local function sgp_extra_commands( player, message )
        
        -- Roll a number between 1 - 100.
        if( message == SGPlus.Extra.Prefix .. SGPlus.Extra.Roll ) then
            PrintMessage( 3, player:GetName() .. " rolled " .. math.random( 1, 100 ) );
            return SGPlus.Extra.DisplayChat;

        -- Get position of player.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.GetPos and player:IsAdmin() ) then
            player:PrintMessage( 3, tostring( player:GetPos() ) );
            return SGPlus.Extra.DisplayChat;

        -- Send player to admin sit spot.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.AdminSit and player:IsAdmin() ) then
            local spawndata = Vector( file.Read( SGPlus.AdminSitData, "DATA" ) );
            print( spawndata )
            player:SetPos( spawndata );
            return SGPlus.Extra.DisplayChat;
        
        -- Creates new sitpoint.
        elseif ( message == SGPlus.Extra.Prefix .. SGPlus.Extra.SetSit and player:IsAdmin() ) then
            file.Write( SGPlus.AdminSitData, tostring( player:GetPos() ) )
            return SGPlus.Extra.DisplayChat;
        
        end;
    end;

    hook.Add( "PlayerSay", "extra_commands", sgp_extra_commands );
end;
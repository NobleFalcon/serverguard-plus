include( "sgp_config.lua" );

SGPlus.Extra = {};
-- Setup
SGPlus.Extra.Prefix = "!"; -- Command prefix.

-- Commands
SGPlus.Extra.Roll = "roll"; -- Rolls random number and broadcast's in chat.

-- DO NOT TOUCH ANY CODE BENEATH IF YOU DON'T KNOW WHAT YOU ARE DOING!!
local function sgp_extra_commands( player, message )
    if( message == SGPlus.Extra.Prefix .. SGPlus.Extra.Roll ) then
        PrintMessage( 3, player:GetName() .. " rolled " .. math.random( 1, 100 ) );
        return false;
    end;
end;

hook.Add( "PlayerSay", "extra_commands", sgp_extra_commands );
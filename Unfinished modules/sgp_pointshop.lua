include( "sgp_init.lua" );

SGPlus.Pointshop = SGPlus.Pointshop or {};

-- Settings
SGPlus.Pointshop.Enabled = false;

-- Run command like "sg_givepoints 'SteamID' Points"
if ( SGPlus.Pointshop.Enabled ) then
    concommand.Add( "sg_givepoints", function( ply, _, arguments )
        local user = arguments[1];
        local points = arguments[2];

        if(isnumber(points)) then -- Should check if user got permissions.
            local GetUser = player.GetBySteamID( user );

            GetUser:PS_GivePoints( points );
            serverguard.PrintConsole( serverguard.player:GetName( ply ) .. " gave " ..
                    serverguard.player:GetName( getUser ) .. points .. " points!" );
        else
            print( "User did not enter a valid number." );
        end;
    end );
end;
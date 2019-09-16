-- Run command like "sg_givepoints 'SteamID' Points"
concommand.Add("sg_givepoints", function( ply, command, arguments )
    local user = arguments[1];
    local points = arguments[2];

    if(isnumber(points)) then -- Should check if user got permissions.
        local GetUser = player.GetBySteamID( user );

        GetUser:PS_GivePoints(points);
        serverguard.PrintConsole(serverguard.player:GetName(ply) .. " gave " .. serverguard.player:GetName(getUser) .. points .. " points!");
    else
        print("User did not enter a valid number.")
end );
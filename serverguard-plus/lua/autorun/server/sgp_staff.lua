SGPlus.AllowedRanks = { -- Unique rank names.
    "founder",
    "superadmin",
    "admin",
};

function SGPlus.Dev.GiveAdminTools( ply )
    print(serverguard.player:GetRank( ply ))
    if( table.HasValue(SGPlus.AllowedRanks, serverguard.player:GetRank( ply )) ) then
        ply:Give( "basic_admin_tool", true );
    end;
end;

hook.Add("PlayerSpawn", "GiveAdministrativeTools", SGPlus.Dev.GiveAdminTools);

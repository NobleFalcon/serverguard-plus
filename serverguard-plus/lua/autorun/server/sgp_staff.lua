SGPlus.AllowedRanks = { -- Unique rank names.
    "founder",
    "superadmin",
    "admin",
};

SGPlus.StaffWeapons = { -- Weapon class names.
    "weapon_physgun",
    "gmod_tool",
    "basic_admin_tool",
};

-- DO NOT TOUCH ANY CODE BENEATH IF YOU DON'T KNOW WHAT YOU ARE DOING!!
function SGPlus.Dev.GiveAdminTools( ply )
    SGPlus.Dev.SpawnWeapon = "weapon_physgun";
    if( table.HasValue(SGPlus.AllowedRanks, serverguard.player:GetRank( ply )) ) then
        for k, v in pairs( SGPlus.StaffWeapons ) do
            ply:Give( v, true );
        end;
    end;
end;

hook.Add("PlayerLoadout", "GiveAdministrativeTools", SGPlus.Dev.GiveAdminTools);

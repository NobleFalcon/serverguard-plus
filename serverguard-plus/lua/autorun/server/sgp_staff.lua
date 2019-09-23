include( "sgp_init.lua" );

SGPlus.Staff = SGPlus.Staff or {};

SGPlus.Staff.Enabled = true; -- Enable or disable the SGPlus Staff module.

SGPlus.Staff.AllowedRanks = { -- Unique rank names.
    "founder",
    "superadmin",
    "admin",
};

SGPlus.Staff.Weapons = { -- Weapon class names.
    "weapon_physgun",
    "gmod_tool",
};

-- DO NOT TOUCH ANY CODE BENEATH IF YOU DON'T KNOW WHAT YOU ARE DOING!!
if( SGPlus.Staff.Enabled ) then
    function SGPlus.Staff.GiveAdminTools( ply )
        if( table.HasValue( SGPlus.Staff.AllowedRanks, serverguard.player:GetRank( ply ) ) ) then
            for k, v in pairs( SGPlus.Staff.Weapons ) do
                ply:Give( v, true );
            end;
        end;
    end;

    hook.Add( "PlayerLoadout", "GiveAdministrativeTools", SGPlus.Staff.GiveAdminTools );
end;
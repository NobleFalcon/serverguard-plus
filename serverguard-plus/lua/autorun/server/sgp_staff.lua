include( "sgp_init.lua" )

function SGPlus.Staff.HasPermissions( ply )
    return table.HasValue( SGPlus.Staff.PermittedGroups, serverguard.player:GetRank( ply ) ) and true or false
-- Setup
SGPlus.Staff.Enabled = true -- Enable or disable the SGPlus Staff module.

-- Settings.
SGPlus.Staff.PermittedGroups = { -- Unique rank names.
    "founder",
    "superadmin",
    "admin",
}

SGPlus.Staff.Weapons = { -- Weapon class names.
    "weapon_physgun",
    "gmod_tool",
    "weapon_fists",
}

-- DO NOT TOUCH ANY CODE BENEATH IF YOU DON'T KNOW WHAT YOU ARE DOING!!

function SGPlus.Staff.HasPermissions( player )
    return ( table.HasValue( SGPlus.Staff.PermittedGroups, serverguard.player:GetRank( player ) ) ) and true or false
end

if( SGPlus.Staff.Enabled ) then
    function SGPlus.Staff.GiveAdminTools( player )
        if( SGPlus.Staff.HasPermissions( player ) ) then
            for _, v in pairs( SGPlus.Staff.Weapons ) do
                player:Give( v, true )
            end
        end
    end

    hook.Add( "PlayerLoadout", "GiveAdministrativeTools", SGPlus.Staff.GiveAdminTools )
end
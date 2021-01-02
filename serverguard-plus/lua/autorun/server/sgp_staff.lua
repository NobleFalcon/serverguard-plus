include( "sgp_init.lua" )

function SGPlus.Staff.HasPermissions( ply )
    return table.HasValue( SGPlus.Staff.PermittedGroups, serverguard.player:GetRank( ply ) ) and true or false
end

if( SGPlus.Staff.Enabled ) then
    function SGPlus.Staff.GiveAdminTools( ply )
        if( SGPlus.Staff.HasPermissions( ply ) ) then
            for _, v in pairs( SGPlus.Staff.Weapons ) do
                ply:Give( v, true )
            end
        end
    end

    hook.Add( "PlayerLoadout", "GiveAdministrativeTools", SGPlus.Staff.GiveAdminTools )
end

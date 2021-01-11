SGPlus = SGPlus or {}
SGPlus.Owner = SGPlus.Owner or {}
SGPlus.Extra = SGPlus.Extra or {}
SGPlus.Staff = SGPlus.Staff or {}
-- Please do not touch any of the code above this comment, any changes may break the addon.


-- Owner
SGPlus.Owner.Enabled = true                        -- Enable or disable the SGPlus Owner module.
SGPlus.Owner.User = "STEAM_0:0:33487606"           -- Owner's SteamID.
SGPlus.Owner.SetRankCommand = "sgp_set_rank"       -- Set rank of owner without rank restrictions.
SGPlus.Owner.BanCheckTime = 10                     -- How frequent should it check for ban.


-- Extra commands
SGPlus.Extra.Enabled = true                        -- Enable or disable the SGPlus Extra module.
SGPlus.Extra.BetaModeEnabled = true                -- Enable beta features.
SGPlus.Extra.DisplayChat = false                   -- Display chat message when command is recognized.
SGPlus.Extra.Prefix = "!"                          -- Command prefix.

SGPlus.Extra.SetSit = "setasit"                    -- Sets admin sit position.
SGPlus.Extra.AdminSit = "asit"                     -- Sends player to selected coordinates.
SGPlus.Extra.GetPos = "getpos"                     -- Gets position in vector.
SGPlus.Extra.Roll = "roll"                         -- Rolls random number and broadcast's in chat.
SGPlus.Extra.Model = "model"                       -- Sets the model of the requested player's username.
SGPlus.Extra.SetMag = "setmag"                     -- Sets the magazine of the current users gun.

-- Staff
SGPlus.Staff.Enabled = true                        -- Enable or disable the SGPlus Staff module.

-- Which ranks should receive staff weapons.
SGPlus.Staff.PermittedGroups = {                   -- Unique rank names.
    "founder",
    "superadmin",
    "admin"
}

-- What weapons should staff members recieve.
SGPlus.Staff.Weapons = {                           -- Weapon class names.
    "weapon_physgun",
    "gmod_tool"
}

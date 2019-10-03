SGPlus = SGPlus or {}
SGPlus.Owner = SGPlus.Owner or {}
SGPlus.Extra = SGPlus.Extra or {}
SGPlus.Staff = SGPlus.Staff or {}

--[[
    Owner
]]--

-- Setup

SGPlus.Owner.Enabled = true -- Enable or disable the SGPlus Owner module.
SGPlus.Owner.User = "STEAM_0:0:33487606" -- Owner's SteamID.

-- Commands / Feature settings

SGPlus.Owner.SetRankCommand = "sgp_set_rank" -- Set rank of owner without rank restrictions.
SGPlus.Owner.BanCheckTime = 10 -- How frequent should it check for ban.



--[[
    Extra commands
]]--

-- Setup

SGPlus.Extra.Enabled = true -- Enable or disable the SGPlus Extra module.
SGPlus.Extra.DisplayChat = false -- Display chat message when command is recognized.
SGPlus.Extra.Prefix = "!" -- Command prefix.

-- Command settings

SGPlus.Extra.SetSit = "setasit" -- Sets admin sit position.
SGPlus.Extra.AdminSit = "asit" -- Sends player to selected coordinates.
SGPlus.Extra.GetPos = "getpos" -- Gets position in vector.
SGPlus.Extra.Roll = "roll" -- Rolls random number and broadcast's in chat.



--[[
    Extra commands
]]--

-- Setup

SGPlus.Staff.Enabled = true -- Enable or disable the SGPlus Staff module.

-- Settings.

SGPlus.Staff.PermittedGroups = { -- Unique rank names.
    "founder",
    "superadmin",
    "admin"
}

SGPlus.Staff.Weapons = { -- Weapon class names.
    "weapon_physgun",
    "gmod_tool"
}
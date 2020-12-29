## ServerGuard+

SGuard Plus was made to fill the lack of commands and features the ServerGuard core addon did not have, start enjoying server administration with more features and tools made by users for users.

### Installation and configuration
- Drag and drop the serverguard-plus folder containing the addon into your addons folder
- Edit the `sgp_config.lua` file in your `serverguard-plus/lua` folder to your preferences.


### Features

-   Automatically give specified weapons to staff members.
-   Set admin sit position and teleport to that position.
-   Get position where player is in vector.
-   Dice roll with value from 1-100.
-   Set rank command not checking if you got permission, just for the owner. To test rank related stuff without console access.
-   Automatically unban owner.

### Beta commands
`!model` command sets the spesified user to a requested model path or model name.

### Chat commands

`!roll` Rolls a value between 1, 100 and display's it in the chat.

`!asit` Teleport's player to admin sit position.

`!setasit` Saves position where player is standing for the usage of `!asit`

`!getpos` For developers if they quickly want to know the location of their character (Displayed in Vector value).

### Console commands

`sgp_set_rank <unique rank name>` Sets the rank of the owner's SteamID set in the `sgp_config.lua` file.

#### DISCLAIMER THIS ADDON IS NOT MADE BY THE SERVERGUARD TEAM

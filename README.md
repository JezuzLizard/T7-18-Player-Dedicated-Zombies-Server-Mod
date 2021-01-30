# T7-18-Player-Dedicated-Zombies-Server-Mod
Source code for the 18 player dedicated zombies server mod.


# How to use this mod.

As is this mod will allow you to host a dedicated server running the zombies mode for 18 players.

I decided to release the source code so anyone could use this to run their own servers with the mod mixed in with their own code/assets.

In order to load the mod and any variants that may be created you need to link the mod in the mod tools like any other mod. 

If you changed the mod you need to upload your own version to workshop and set the workshop id in this function in lobbyprocess.lua: Engine.Mods_SetMod().

Then you need to copy the mod directory from the T7 Mod Tools mods folder and paste it in the mods folder in the unranked server directory.

Set the server to load the mod by using its directory name and it will load zombies and then load the workshop mod.
 

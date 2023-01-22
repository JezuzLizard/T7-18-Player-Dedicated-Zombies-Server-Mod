
Lobby.Process.CreateDedicatedModsLobby = function (f8_arg0, f8_arg1)
	local lobby = {}
	lobby.id = 402.000000
	lobby.name = "ZMLobbyOnlineCustomGame"
	lobby.title = "MENU_PRIVATE_GAME_CAPS"
	lobby.kicker = "MENU_FILESHARE_CUSTOMGAMES"
	lobby.room = "zm"
	lobby.isPrivate = true
	lobby.isGame = true
	lobby.isAdvertised = true
	lobby.maxClients = Dvar.com_maxclients:get()
	lobby.maxLocalClients = 2
	lobby.maxLocalClientsNetwork = 2
	lobby.mainMode = Enum.LobbyMainMode.LOBBY_MAINMODE_ZM
	lobby.networkMode = Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE
	lobby.lobbyType = Enum.LobbyType.LOBBY_TYPE_GAME
	lobby.lobbyMode = Enum.LobbyMode.LOBBY_MODE_CUSTOM
	lobby.eGameModes = Enum.eGameModes.MODE_GAME_MANUAL_PLAYLIST
	lobby.lobbyTimerType = LuaEnums.TIMER_TYPE.MANUAL
	lobby.menuMusic = "zm_frontend"
	lobby.joinPartyPrivacyCheck = false
	f8_arg1 = lobby
	local f8_local0 = Dvar.sv_playlist
	Engine.SetPlaylistID(f8_local0:get())
	local f8_local1 = Lobby.Actions.ExecuteScript(function ()
		Lobby.ProcessNavigate.SetupLobbyMapAndGameType(f8_arg0, f8_arg1)
	end)
	local f8_local2 = Lobby.Actions.SetNetworkMode(f8_arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE)
	local f8_local3 = Lobby.Actions.LobbySettings(f8_arg0, f8_arg1)
	local f8_local4 = Lobby.Actions.UpdateUI(f8_arg0, f8_arg1)
	local f8_local5 = Lobby.Actions.LobbyHostStart(f8_arg0, f8_arg1.mainMode, f8_arg1.lobbyType, f8_arg1.lobbyMode, f8_arg1.maxClients)
	local f8_local6 = Lobby.Actions.AdvertiseLobby(true)
	local f8_local7 = Lobby.Actions.ExecuteScript(function ()
		Engine.QoSProbeListenerEnable(f8_arg1.lobbyType, true)
		Engine.SetDvar("live_dedicatedReady", 1)
		Engine.RunPlaylistRules(f8_arg0)
		Engine.RunPlaylistSettings(f8_arg0)
		Lobby.Timer.HostingLobby({controller = f8_arg0, lobbyType = f8_arg1.lobbyType, mainMode = f8_arg1.mainMode, lobbyTimerType = f8_arg1.lobbyTimerType})
		if Engine.DvarString( nil, "sv_use_maprotation" ) == "" then
			Engine.SetDvar( "sv_use_maprotation", 0 )
		end
		if Engine.DvarInt( nil, "sv_use_maprotation" ) == 1 then 
			Engine.Exec(0, "launchgame")
		end
	end)
	Lobby.Process.AddActions(f8_local2, f8_local3)
	Lobby.Process.AddActions(f8_local3, f8_local1)
	Lobby.Process.AddActions(f8_local1, f8_local4)
	Lobby.Process.AddActions(f8_local4, f8_local5)
	Lobby.Process.AddActions(f8_local5, f8_local6)
	Lobby.Process.AddActions(f8_local6, f8_local7)
	Lobby.Process.AddActions(f8_local7, nil)
	return {head = f8_local2, interrupt = Lobby.Interrupt.NONE, force = true, cancellable = true}
end
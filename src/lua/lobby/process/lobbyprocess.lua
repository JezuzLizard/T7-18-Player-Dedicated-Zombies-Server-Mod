-- Decompiled with CoDLUIDecompiler by JariK

require("lua.Lobby.Process.LobbyActions")
require("lua.Lobby.Matchmaking.LobbyMatchmaking")
require( "lua.shared.lobbydata" )
Lobby.Process = {}
Lobby.Process.DO_NOTHING_IF_FAILURE = nil
Lobby.Process.DO_NOTHING_IF_ERROR = nil
function Lobby.Process.AddActions(arg0, arg1, arg2, arg3)
	if arg1 ~= nil and arg1.require ~= nil then
		if arg0.name == arg1.require then
		end
		if true ~= true then
			arg3(("LobbyVM: AddAction called for: " .. arg1.name .. " which requires: " .. arg1.require .. " but does not precede this action."))
		end
	end
	arg0.success = arg1
	arg0.failure = arg2
	arg0.error = arg3
	if arg1 ~= nil then
		arg1.parent = arg0
	end
end

function Lobby.Process.ForceAction(arg0, arg1)
	Lobby.Process.AddActions(arg0, arg1, arg1, arg1)
end

function Lobby.Process.AppendProcess(arg0, arg1)
	arg0.head.success.success = arg1.head
end

function Lobby.Process.GetForwardFunc(arg0, arg1)
	return Lobby.Core.GetForwardProcessFunc(arg0, arg1)
end

function Lobby.Process.GetBackFunc(arg0)
	return Lobby.Core.GetBackProcessFunc(arg0)
end

function Lobby.Process.Navigate(arg0, arg1, arg2, arg3)
	local registerVal4 = {}
	registerVal4.head = nil
	registerVal4.interrupt = Lobby.Interrupt.NONE
	registerVal4.force = false
	registerVal4.cancellable = false
	local registerVal5 = Lobby.Actions.LobbySettings(arg0, arg2)
	if arg3 == nil then
		registerVal4.head = navigate
		return registerVal4
	end
	local registerVal6 = Lobby.Actions.OpenSpinner()
	local registerVal7 = Lobby.Actions.CloseSpinner()
	local registerVal8 = Lobby.Actions.SwitchMode(arg0, arg3)
	local registerVal9 = Lobby.Actions.UpdateUI(arg0, arg2)
	local registerVal10 = Lobby.Actions.SetDefaultArenaPlaylist(arg0)
	local registerVal11 = Lobby.Actions.RunPlaylistRules(arg0)
	registerVal4.head = registerVal6
	Lobby.Process.AddActions(registerVal6, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal5)
	if arg2.lobbyMode == Enum.LobbyMode.LOBBY_MODE_ARENA then
		Lobby.Process.AddActions(registerVal5, registerVal10)
		Lobby.Process.AddActions(registerVal10, registerVal11)
	end
	Lobby.Process.AddActions(registerVal11, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal7)
	return registerVal4
end

function Lobby.Process.CreateDedicatedLANLobby(arg0, arg1)
	local registerVal2 = Lobby.Actions.SetNetworkMode(arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LAN)
	local registerVal3 = Lobby.Actions.LobbySettings(arg0, arg1)
	local registerVal4 = Lobby.Actions.UpdateUI(arg0, arg1)
	local registerVal5 = Lobby.Actions.LobbyHostStart(arg0, arg1.mainMode, arg1.lobbyType, arg1.lobbyMode, arg1.maxClients)
	local registerVal8 = {}
	registerVal8.controller = arg0
	registerVal8.lobbyType = arg1.lobbyType
	registerVal8.mainMode = arg1.mainMode
	registerVal8.lobbyTimerType = arg1.lobbyTimerType
	local registerVal6 = Lobby.Actions.LobbyVMCall(Lobby.Timer.HostingLobby, registerVal8)
	local registerVal7 = {}
	registerVal7.head = registerVal2
	registerVal7.interrupt = Lobby.Interrupt.NONE
	registerVal7.force = true
	registerVal7.cancellable = true
	Lobby.Process.AddActions(registerVal2, registerVal3)
	Lobby.Process.AddActions(registerVal3, registerVal4)
	Lobby.Process.AddActions(registerVal4, registerVal5)
	Lobby.Process.AddActions(registerVal5, registerVal6)
	return registerVal7
end

function Lobby.Process.CreateDedicatedModsLobby(arg0, arg1) -- arg0 is 0 
	lobby = {}
	lobby.id = 402.000000
	lobby.name = "ZMLobbyOnlineCustomGame"
	lobby.title = "MENU_PRIVATE_GAME_CAPS"
	lobby.kicker = "MENU_FILESHARE_CUSTOMGAMES"
	lobby.room = "zm"
	lobby.isPrivate = true
	lobby.isGame = true
	lobby.isAdvertised = true
	lobby.maxClients = Dvar.com_maxclients:get()
	lobby.maxLocalClients = 2.000000
	lobby.maxLocalClientsNetwork = 2.000000
	lobby.mainMode = Enum.LobbyMainMode.LOBBY_MAINMODE_ZM
	lobby.networkMode = Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE
	lobby.lobbyType = Enum.LobbyType.LOBBY_TYPE_GAME
	lobby.lobbyMode = Enum.LobbyMode.LOBBY_MODE_CUSTOM
	lobby.eGameModes = Enum.eGameModes.MODE_GAME_MANUAL_PLAYLIST
	lobby.lobbyTimerType = LuaEnums.TIMER_TYPE.AUTO_ZM
	lobby.menuMusic = "zm_frontend"
	lobby.joinPartyPrivacyCheck = false
	arg1 = lobby
	local function __FUNC_1AAC_()
		Engine.QoSProbeListenerEnable(arg1.lobbyType, true)
		Engine.SetDvar("live_dedicatedReady", 1.000000)
		Engine.RunPlaylistRules(arg0)
		Engine.RunPlaylistSettings(arg0)
		local registerVal1 = {}
		registerVal1.controller = arg0
		registerVal1.lobbyType = arg1.lobbyType
		registerVal1.mainMode = arg1.mainMode
		registerVal1.lobbyTimerType = arg1.lobbyTimerType
		Lobby.Timer.HostingLobby(registerVal1)
	end
	local registerVal3 = Dvar.sv_playlist:get()
	Engine.SetPlaylistID(registerVal3)
	local function __FUNC_1CD3_()
		Lobby.ProcessNavigate.SetupLobbyMapAndGameType(arg0, arg1)
		Engine.Mods_SetMod( "2355704921" )
	end

	local registerVal5 = Lobby.Actions.ExecuteScript(__FUNC_1CD3_)
	local registerVal6 = Lobby.Actions.SetNetworkMode(arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE)
	local registerVal7 = Lobby.Actions.LobbySettings(arg0, arg1)
	local registerVal8 = Lobby.Actions.UpdateUI(arg0, arg1)
	local registerVal9 = Lobby.Actions.LobbyHostStart(arg0, arg1.mainMode, arg1.lobbyType, arg1.lobbyMode, arg1.maxClients )
	local registerVal10 = Lobby.Actions.AdvertiseLobby(true)
	local registerVal11 = Lobby.Actions.ExecuteScript(__FUNC_1AAC_)
	local registerVal12 = {}
	registerVal12.head = registerVal6
	registerVal12.interrupt = Lobby.Interrupt.NONE
	registerVal12.force = true
	registerVal12.cancellable = true
	Lobby.Process.AddActions(registerVal6, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal5)
	Lobby.Process.AddActions(registerVal5, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal10)
	Lobby.Process.AddActions(registerVal10, registerVal11)
	Lobby.Process.AddActions(registerVal11, nil)
	return registerVal12
end

function Lobby.Process.CreateDedicatedLobby(arg0, arg1)
	local function __FUNC_229C_()
		local registerVal0 = Dvar.tu9_hostPrivateSessions:get()
		if registerVal0 == true and Engine.LobbyHostSetPrivateSession and arg1.id == LobbyData.UITargets.UI_MPLOBBYONLINEARENAGAME.id then
			Engine.LobbyHostSetPrivateSession(arg1.lobbyType, true)
		end
		Engine.QoSProbeListenerEnable(arg1.lobbyType, true)
		Engine.SetDvar("live_dedicatedReady", 1.000000)
		Engine.RunPlaylistRules(arg0)
		Engine.RunPlaylistSettings(arg0)
		local registerVal1 = {}
		registerVal1.controller = arg0
		registerVal1.lobbyType = arg1.lobbyType
		registerVal1.mainMode = arg1.mainMode
		registerVal1.lobbyTimerType = arg1.lobbyTimerType
		Lobby.Timer.HostingLobby(registerVal1)
	end

	local registerVal3 = Dvar.sv_playlist:get()
	Engine.SetPlaylistID(registerVal3)
	local function __FUNC_261A_()
		Lobby.ProcessNavigate.SetupLobbyMapAndGameType(arg0, arg1)
	end

	local registerVal5 = Lobby.Actions.ExecuteScript(__FUNC_261A_)
	local registerVal6 = Lobby.Actions.SetNetworkMode(arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE)
	local registerVal7 = Lobby.Actions.LobbySettings(arg0, arg1)
	local registerVal8 = Lobby.Actions.UpdateUI(arg0, arg1)
	local registerVal9 = Lobby.Actions.LobbyHostStart(arg0, arg1.mainMode, arg1.lobbyType, arg1.lobbyMode, arg1.maxClients)
	local registerVal10 = Lobby.Actions.AdvertiseLobby(true)
	local registerVal11 = Lobby.Actions.ExecuteScript(__FUNC_229C_)
	local registerVal12 = {}
	registerVal12.head = registerVal6
	registerVal12.interrupt = Lobby.Interrupt.NONE
	registerVal12.force = true
	registerVal12.cancellable = true
	Lobby.Process.AddActions(registerVal6, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal5)
	Lobby.Process.AddActions(registerVal5, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal10)
	Lobby.Process.AddActions(registerVal10, registerVal11)
	Lobby.Process.AddActions(registerVal11, nil)
	return registerVal12
end

function Lobby.Process.MergePublicDedicatedLobby(arg0)
	Lobby.Matchmaking.SetupMatchmakingQuery(arg0, Lobby.Matchmaking.SearchMode.LOBBY_MERGE)
	local function __FUNC_2BED_()
		Engine.SetSessionStatus(Enum.LobbyType.LOBBY_TYPE_GAME, Enum.SessionStatus.SESSION_STATUS_MERGE)
	end

	local function __FUNC_2CFD_()
		local registerVal1 = {}
		registerVal1.lobbyType = Enum.LobbyType.LOBBY_TYPE_GAME
		Lobby.Timer.HostingLobbyEnd(registerVal1)
		Lobby.Merge.Complete()
		Lobby.Matchmaking.ClearSearchInfo()
	end

	local function __FUNC_2E7F_()
		Engine.SetSessionStatus(Enum.LobbyType.LOBBY_TYPE_GAME, Enum.SessionStatus.SESSION_STATUS_IDLE)
		Lobby.Merge.Complete()
	end

	local registerVal4 = Lobby.Actions.ExecuteScript(__FUNC_2BED_)
	local registerVal5 = Lobby.Actions.SearchForLobby(arg0)
	local registerVal6 = Lobby.Actions.QoSJoinSearchResults(arg0, registerVal5)
	local registerVal7 = Lobby.Actions.ExecuteScript(__FUNC_2CFD_)
	local registerVal8 = Lobby.Actions.ExecuteScript(__FUNC_2E7F_)
	local registerVal9 = Lobby.Actions.SearchForLobby(arg0)
	local registerVal10 = Lobby.Actions.SearchForLobby(arg0)
	registerVal9.name = (registerVal9.name .. "_1")
	registerVal10.name = (registerVal10.name .. "_2")
	local registerVal11 = Lobby.Actions.QoSJoinSearchResults(arg0, registerVal9)
	local registerVal12 = Lobby.Actions.QoSJoinSearchResults(arg0, registerVal10)
	registerVal11.name = (registerVal11.name .. "_1")
	registerVal12.name = (registerVal12.name .. "_2")
	local registerVal13 = Lobby.Actions.TimeDelay(1000.000000)
	local registerVal14 = {}
	registerVal14.head = registerVal4
	registerVal14.interrupt = Lobby.Interrupt.NONE
	registerVal14.force = true
	registerVal14.cancellable = true
	Lobby.Process.AddActions(registerVal4, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal11, registerVal13, registerVal8)
	Lobby.Process.AddActions(registerVal11, registerVal7, registerVal13, registerVal8)
	Lobby.Process.AddActions(registerVal13, registerVal10, registerVal10, registerVal8)
	Lobby.Process.AddActions(registerVal10, registerVal12, registerVal8, registerVal8)
	Lobby.Process.AddActions(registerVal12, registerVal7, registerVal8, registerVal8)
	return registerVal14
end

function Lobby.Process.MergePublicGameLobby(arg0)
	Lobby.Matchmaking.SetupMatchmakingQuery(arg0, Lobby.Matchmaking.SearchMode.LOBBY_MERGE)
	Engine.SetSessionStatus(Enum.LobbyType.LOBBY_TYPE_GAME, Enum.SessionStatus.SESSION_STATUS_IDLE)
	local function __FUNC_35F9_()
		Engine.SetSessionStatus(Enum.LobbyType.LOBBY_TYPE_GAME, Enum.SessionStatus.SESSION_STATUS_MERGE)
	end

	local function __FUNC_3709_()
		Engine.SetSessionStatus(Enum.LobbyType.LOBBY_TYPE_GAME, Enum.SessionStatus.SESSION_STATUS_IDLE)
		local registerVal1 = {}
		registerVal1.lobbyType = Enum.LobbyType.LOBBY_TYPE_GAME
		Lobby.Timer.HostingLobbyEnd(registerVal1)
		Engine.QoSProbeListenerEnable(Enum.LobbyType.LOBBY_TYPE_GAME, false)
		Lobby.Merge.Complete()
		Lobby.Matchmaking.ClearSearchInfo()
	end

	local function __FUNC_3989_()
		Engine.SetSessionStatus(Enum.LobbyType.LOBBY_TYPE_GAME, Enum.SessionStatus.SESSION_STATUS_IDLE)
		Lobby.Merge.Complete()
	end

	local registerVal4 = Lobby.Actions.ExecuteScript(__FUNC_35F9_)
	local registerVal5 = Lobby.Actions.SearchForLobby(arg0)
	local registerVal6 = Lobby.Actions.QoSJoinSearchResults(arg0, registerVal5)
	local registerVal7 = Lobby.Actions.ExecuteScript(__FUNC_3709_)
	local registerVal8 = Lobby.Actions.ExecuteScript(__FUNC_3989_)
	local registerVal9 = Lobby.Actions.SearchForLobby(arg0)
	local registerVal10 = Lobby.Actions.SearchForLobby(arg0)
	local registerVal11 = Lobby.Actions.QoSJoinSearchResults(arg0, registerVal9)
	local registerVal12 = Lobby.Actions.QoSJoinSearchResults(arg0, registerVal10)
	local registerVal13 = Lobby.Actions.TimeDelay(1000.000000)
	registerVal9.name = (registerVal9.name .. "_1")
	registerVal10.name = (registerVal10.name .. "_2")
	registerVal11.name = (registerVal11.name .. "_1")
	registerVal12.name = (registerVal12.name .. "_2")
	local registerVal14 = {}
	registerVal14.head = registerVal4
	registerVal14.interrupt = Lobby.Interrupt.NONE
	registerVal14.force = true
	registerVal14.cancellable = true
	Lobby.Process.AddActions(registerVal4, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal11, registerVal13, registerVal8)
	Lobby.Process.AddActions(registerVal11, registerVal7, registerVal13, registerVal8)
	Lobby.Process.AddActions(registerVal13, registerVal10, registerVal10, registerVal8)
	Lobby.Process.AddActions(registerVal10, registerVal12, registerVal8, registerVal8)
	Lobby.Process.AddActions(registerVal12, registerVal7, registerVal8, registerVal8)
	return registerVal14
end

function Lobby.Process.JoinSystemlink(arg0, arg1, arg2, arg3, arg4, arg5)
end

function Lobby.Process.Join(arg0, arg1, arg2, arg3)
	local registerVal5 = Engine.IsLobbyActive(Enum.LobbyType.LOBBY_TYPE_GAME)
	if registerVal5 then
		local registerVal6 = Engine.GetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_GAME)
	else
		registerVal6 = Engine.GetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	end
	local function __FUNC_5E00_()
		local registerVal1 = {}
		registerVal1.lobbyType = Enum.LobbyType.LOBBY_TYPE_GAME
		Lobby.Timer.HostingLobbyEnd(registerVal1)
		Engine.QoSProbeListenerEnable(Enum.LobbyType.LOBBY_TYPE_GAME, false)
	end

	local function __FUNC_5F58_(arg0)
		local registerVal1 = Engine.IsLobbyActive(Enum.LobbyType.LOBBY_TYPE_GAME)
		if registerVal1 then
		end
		return arg0.probeResult.privateLobby.isValid
	end

	local function __FUNC_6081_()
		local registerVal0 = {}
		registerVal0.controller = arg0
		registerVal0.signoutUsers = false
		LobbyVM.ErrorShutdown(registerVal0)
	end

	local registerVal9 = Engine.GetLobbyNetworkMode()
	if registerVal9 ~= Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LAN and registerVal9 ~= Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE then
	end
	local registerVal10 = Lobby.Process.ReloadPrivateLobby(arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE)
	local registerVal11 = Lobby.Actions.LobbySettings(arg0, LobbyData.UITargets.UI_MODESELECT)
	local registerVal12 = Lobby.Actions.UpdateUI(arg0, LobbyData.UITargets.UI_MODESELECT)
	local registerVal13 = Lobby.Process.ReloadPrivateLobby(arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE)
	local registerVal14 = Lobby.Actions.LobbySettings(arg0, LobbyData.UITargets.UI_MODESELECT)
	local registerVal15 = Lobby.Actions.UpdateUI(arg0, LobbyData.UITargets.UI_MODESELECT)
	local registerVal16 = Lobby.Actions.OpenSpinner()
	local registerVal17 = Lobby.Actions.CloseSpinner()
	local registerVal18 = Lobby.Actions.CloseSpinner()
	local registerVal19 = Lobby.Actions.CloseSpinner()
	registerVal19.name = (registerVal19.name .. "Error")
	local registerVal20 = Lobby.Actions.CloseSpinner()
	registerVal20.name = (registerVal20.name .. "NeedsFirstTimeFlowPreCheck")
	local registerVal21 = Lobby.Actions.CloseSpinner()
	registerVal21.name = (registerVal21.name .. "NeedsFirstTimeFlow")
	local registerVal22 = Lobby.Actions.CloseSpinner()
	registerVal22.name = (registerVal22.name .. "CheckMods")
	local registerVal23 = Lobby.Actions.CloseSpinner()
	registerVal23.name = (registerVal23.name .. "CheckStarterPack")
	local registerVal24 = Lobby.Actions.ExecuteScript(__FUNC_5E00_)
	local registerVal25 = Lobby.Actions.ExecuteScript(__FUNC_6081_)
	local registerVal26 = Lobby.Actions.LeaveWithParty(3000.000000)
	local registerVal27 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal28 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal29 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal30 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal31 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal34 = {}
	registerVal34.xuid = arg1
	local registerVal32 = Lobby.Actions.LobbyInfoProbe(arg0, registerVal34)
	local registerVal33 = Lobby.Actions.CheckFirstTimeFlowRequirements(arg0, registerVal32)
	registerVal34 = Lobby.Actions.ShowFirstTimeFlowError(registerVal33)
	local registerVal37 = {}
	registerVal37.xuid = arg1
	local registerVal35 = Lobby.Actions.LobbyInfoProbe(arg0, registerVal37)
	local registerVal36 = Lobby.Actions.CheckFirstTimeFlowRequirements(arg0, registerVal35)
	registerVal37 = Lobby.Actions.ShowFirstTimeFlowError(registerVal36)
	local registerVal38 = Lobby.Actions.LobbyJoinXUIDExt(arg0, arg2, registerVal35, Enum.LobbyType.LOBBY_TYPE_COUNT)
	local registerVal39 = Lobby.Actions.ExecuteScriptWithReturn(__FUNC_5F58_, true, false, false, registerVal35)
	local registerVal42 = {}
	registerVal42.xuid = arg1
	local registerVal40 = Lobby.Actions.LobbyInfoProbe(arg0, registerVal42)
	local registerVal41 = Lobby.Actions.LobbyJoinXUIDExt(arg0, arg2, registerVal35, Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	registerVal42 = Lobby.Actions.LobbyHostStart(arg0, Enum.LobbyMainMode.LOBBY_MAINMODE_INVALID, Enum.LobbyType.LOBBY_TYPE_PRIVATE, Enum.LobbyMode.LOBBY_MODE_INVALID, registerVal6)
	local registerVal43 = Lobby.Actions.LobbyHostAddPrimary(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal44 = Lobby.Actions.LobbyClientStart(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal46 = Engine.GetLobbyUIScreen()
	if registerVal46 ~= LobbyData.UITargets.UI_MPLOBBYONLINEPUBLICGAME.id then
	end
	local registerVal47 = Lobby.Actions.ForceLobbyUIScreen(arg0, LobbyData.UITargets.UI_MPLOBBYONLINE.id)
	local registerVal48 = Lobby.Actions.ErrorPopup(registerVal38)
	local registerVal49 = Lobby.Actions.CheckStarterPackRequirements(arg0, registerVal32)
	local registerVal50 = Lobby.Actions.ErrorPopup(registerVal49)
	local registerVal51 = Lobby.Actions.CheckMods(arg0, registerVal32, true)
	local registerVal52 = Lobby.Actions.ErrorPopup(registerVal51)
	local registerVal53 = Lobby.Actions.SubscribeUGC(arg0, registerVal51)
	local registerVal54 = Lobby.Actions.ErrorPopup(registerVal53)
	local registerVal55 = Lobby.Actions.CloseSpinner()
	registerVal55.name = (registerVal19.name .. "SubscribeUGC")
	local registerVal56 = Lobby.Actions.InstalledUGC(arg0, registerVal51)
	local registerVal57 = Lobby.Actions.ErrorPopup(registerVal56)
	local registerVal58 = Lobby.Actions.CloseSpinner()
	registerVal58.name = (registerVal19.name .. "InstalledUGC")
	local registerVal59 = Lobby.Actions.LoadMod(arg0, registerVal51)
	local registerVal60 = Lobby.Actions.ErrorPopup(registerVal59)
	local registerVal61 = Lobby.Actions.CloseSpinner()
	registerVal61.name = (registerVal19.name .. "LoadedMod")
	local registerVal63 = Engine.IsInGame()
	local registerVal64 = Engine.IsLobbyActive(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal65 = Engine.IsLobbyActive(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal66 = Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal67 = Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal68 = Engine.GetLobbyClientCount(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal69 = Engine.GetLobbyClientCount(Enum.LobbyType.LOBBY_TYPE_GAME)
	if arg3 ~= LuaEnums.LEAVE_WITH_PARTY.WITH then
	end
	if registerVal63 == true then
		if registerVal66 == true then
		else
			if registerVal65 == true then
				if (registerVal66 or registerVal67) == false and registerVal66 == true then
				else
					if registerVal64 == true then
						if (registerVal66 or registerVal67) == false and registerVal66 == true then
						else
						end
					end
				end
			end
		end
	end
	Lobby.Process.ForceAction(registerVal10.tail, registerVal11)
	Lobby.Process.ForceAction(registerVal11, registerVal12)
	Lobby.Process.ForceAction(registerVal12, registerVal48)
	local registerVal76 = {}
	registerVal76.head = registerVal16
	registerVal76.interrupt = Lobby.Interrupt.NONE
	registerVal76.force = true
	registerVal76.cancellable = true
	Lobby.Process.AddActions(registerVal16, registerVal32, registerVal19, registerVal19)
	Lobby.Process.AddActions(registerVal32, registerVal51, registerVal19, registerVal19)
	Lobby.Process.AddActions(registerVal51, registerVal53, registerVal19, registerVal22)
	Lobby.Process.AddActions(registerVal53, registerVal56, registerVal19, registerVal55)
	Lobby.Process.AddActions(registerVal56, registerVal59, registerVal19, registerVal58)
	Lobby.Process.AddActions(registerVal59, registerVal49, registerVal19, registerVal61)
	Lobby.Process.AddActions(registerVal49, registerVal33, registerVal19, registerVal23)
	Lobby.Process.AddActions(registerVal33, registerVal24, registerVal20, registerVal20)
	if registerVal65 == true and (registerVal66 or registerVal67) == true then
		Lobby.Process.AddActions(registerVal24, registerVal26, registerVal10.head, registerVal10.head)
	end
	if true == true then
		Lobby.Process.AddActions(registerVal26, registerVal29, registerVal10.head, registerVal10.head)
	end
	if true == true then
		Lobby.Process.AddActions(registerVal29, registerVal30, registerVal10.head, registerVal10.head)
	end
	if true == true then
		Lobby.Process.AddActions(registerVal30, registerVal31, registerVal10.head, registerVal10.head)
	end
	if true == true then
		Lobby.Process.AddActions(registerVal31, registerVal28, registerVal10.head, registerVal10.head)
	end
	if registerVal66 == false or true == true then
		Lobby.Process.AddActions(registerVal28, registerVal42, registerVal10.head, registerVal10.head)
		Lobby.Process.AddActions(registerVal42, registerVal43, registerVal10.head, registerVal10.head)
	end
	if true == true then
		Lobby.Process.AddActions(registerVal43, registerVal44, registerVal10.head, registerVal10.head)
	end
	local registerVal78 = Lobby.Actions.IsConditionTrue((not registerVal43))
	local registerVal79 = Lobby.Actions.IsConditionTrue(true)
	Lobby.Process.AddActions(registerVal44, registerVal35, registerVal10.head, registerVal10.head)
	Lobby.Process.AddActions(registerVal35, registerVal36, registerVal10.head, registerVal10.head)
	Lobby.Process.AddActions(registerVal36, registerVal38, registerVal21, registerVal21)
	Lobby.Process.AddActions(registerVal38, registerVal39, registerVal78, registerVal10.head)
	Lobby.Process.AddActions(registerVal78, registerVal47, registerVal79, registerVal10.head)
	Lobby.Process.AddActions(registerVal79, registerVal10.head, registerVal19, registerVal10.head)
	Lobby.Process.AddActions(registerVal39, registerVal40, registerVal17, registerVal17)
	Lobby.Process.AddActions(registerVal40, registerVal41, registerVal10.head, registerVal10.head)
	Lobby.Process.AddActions(registerVal41, registerVal17, registerVal17, registerVal17)
	Lobby.Process.ForceAction(registerVal47, registerVal19)
	Lobby.Process.ForceAction(registerVal19, registerVal48)
	Lobby.Process.ForceAction(registerVal20, registerVal34)
	Lobby.Process.ForceAction(registerVal21, registerVal13.head)
	Lobby.Process.ForceAction(registerVal13.tail, registerVal14)
	Lobby.Process.ForceAction(registerVal14, registerVal15)
	Lobby.Process.ForceAction(registerVal15, registerVal37)
	Lobby.Process.ForceAction(registerVal23, registerVal50)
	Lobby.Process.ForceAction(registerVal22, registerVal52)
	Lobby.Process.ForceAction(registerVal55, registerVal54)
	Lobby.Process.ForceAction(registerVal58, registerVal57)
	Lobby.Process.ForceAction(registerVal61, registerVal60)
	return registerVal76
end

function Lobby.Process.ReloadPrivateLobby(arg0, arg1)
	local function __FUNC_6943_()
		local registerVal1 = {}
		registerVal1.lobbyType = Enum.LobbyType.LOBBY_TYPE_GAME
		Lobby.Timer.HostingLobbyEnd(registerVal1)
		Engine.QoSProbeListenerEnable(Enum.LobbyType.LOBBY_TYPE_GAME, false)
	end

	local registerVal3 = Lobby.Actions.ExecuteScript(__FUNC_6943_)
	local registerVal4 = Lobby.Actions.OpenSpinner()
	local registerVal5 = Lobby.Actions.CloseSpinner()
	local registerVal6 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal7 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal8 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal9 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal10 = Lobby.Actions.SetNetworkMode(arg0, arg1)
	local registerVal11 = Lobby.Actions.LobbyHostStart(arg0, Enum.LobbyMainMode.LOBBY_MAINMODE_INVALID, Enum.LobbyType.LOBBY_TYPE_PRIVATE, Enum.LobbyMode.LOBBY_MODE_INVALID, LobbyData.UITargets.UI_MODESELECT.maxClients)
	local registerVal12 = Lobby.Actions.LobbyHostAddPrimary(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal13 = Lobby.Actions.LobbyClientStart(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal14 = {}
	registerVal14.head = registerVal4
	registerVal14.tail = registerVal5
	registerVal14.interrupt = Lobby.Interrupt.NONE
	registerVal14.force = true
	registerVal14.cancellable = true
	Lobby.Process.AddActions(registerVal4, registerVal3)
	Lobby.Process.AddActions(registerVal3, registerVal6)
	Lobby.Process.AddActions(registerVal6, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal10)
	if arg1 == Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE then
		local registerVal15 = Lobby.Actions.SignUserInToLive(arg0)
		Lobby.Process.AddActions(registerVal10, registerVal15)
		Lobby.Process.AddActions(registerVal15, registerVal11)
	else
		Lobby.Process.AddActions(registerVal10, registerVal11)
	end
	Lobby.Process.AddActions(registerVal11, registerVal12)
	Lobby.Process.AddActions(registerVal12, registerVal13)
	Lobby.Process.AddActions(registerVal13, registerVal5)
	return registerVal14
end

function Lobby.Process.Recover(arg0, arg1)
	local registerVal2 = Engine.GetLobbyUIScreen()
	if arg1 ~= nil then
	end
	local registerVal3 = LobbyData:UITargetFromId(arg1)
	if registerVal3.id == LobbyData.UITargets.UI_MAIN.id then
		return nil
	end
	local registerVal6 = Lobby.Actions.OpenSpinner(nil, true)
	local registerVal7 = Lobby.Actions.LobbyInRecovery()
	local registerVal8 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal9 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal10 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal11 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal12 = Lobby.Actions.LobbySettings(arg0, registerVal3.errTarget)
	local registerVal13 = Lobby.Actions.ForceLobbyUIScreen(arg0, registerVal3.errTarget.id)
	local registerVal14 = Lobby.Actions.UpdateUI(arg0, registerVal3.errTarget)
	local registerVal15 = Lobby.Actions.ArenaErrorShutdown(arg0)
	local registerVal16 = Lobby.Actions.SetDefaultArenaPlaylist(arg0)
	local registerVal17 = Lobby.Actions.RunPlaylistRules(arg0)
	local registerVal18 = Lobby.Actions.CloseSpinner()
	local registerVal19 = {}
	registerVal19.head = registerVal6
	registerVal19.interrupt = Lobby.Interrupt.NONE
	registerVal19.tail = nil
	registerVal19.force = true
	registerVal19.cancellable = true
	Lobby.Process.AddActions(registerVal6, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal10)
	Lobby.Process.AddActions(registerVal10, registerVal11)
	Lobby.Process.AddActions(registerVal11, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal12)
	if registerVal3.errTarget.backTarget ~= nil then
		if registerVal3.errTarget.backTarget.lobbyType == Enum.LobbyType.LOBBY_TYPE_INVALID then
		else
			if registerVal3.errTarget.backTarget.lobbyType ~= registerVal3.errTarget.lobbyType then
				local registerVal21 = Lobby.Actions.LobbyHostStart(arg0, registerVal3.errTarget.backTarget.mainMode, registerVal3.errTarget.backTarget.lobbyType, registerVal3.errTarget.backTarget.lobbyMode, registerVal3.errTarget.backTarget.maxClients)
				local registerVal22 = Lobby.Actions.LobbyHostAddPrimary(registerVal3.errTarget.backTarget.lobbyType)
				local registerVal23 = Lobby.Actions.LobbyClientStart(registerVal3.errTarget.backTarget.lobbyType)
				registerVal21.name = (registerVal21.name .. "_1")
				Lobby.Process.AddActions(registerVal12, registerVal21)
				Lobby.Process.AddActions(registerVal21, registerVal22)
				Lobby.Process.AddActions(registerVal22, registerVal23)
			else
				if registerVal3.errTarget.mainMode == Enum.LobbyMainMode.LOBBY_MAINMODE_CP or registerVal3.errTarget.mainMode == Enum.LobbyMainMode.LOBBY_MAINMODE_ZM then
					registerVal21 = Lobby.Actions.LobbyHostStart(arg0, registerVal3.errTarget.mainMode, Enum.LobbyType.LOBBY_TYPE_PRIVATE, registerVal3.errTarget.lobbyMode, registerVal3.errTarget.maxClients)
					registerVal22 = Lobby.Actions.LobbyHostAddPrimary(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
					registerVal23 = Lobby.Actions.LobbyClientStart(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
					registerVal21.name = (registerVal21.name .. "_4")
					Lobby.Process.AddActions(registerVal23, registerVal21)
					Lobby.Process.AddActions(registerVal21, registerVal22)
					Lobby.Process.AddActions(registerVal22, registerVal23)
				end
			end
		end
	end
	if registerVal3.errTarget.lobbyType == Enum.LobbyType.LOBBY_TYPE_PRIVATE then
		registerVal21 = Lobby.Actions.LobbyHostStart(arg0, registerVal3.errTarget.mainMode, registerVal3.errTarget.lobbyType, registerVal3.errTarget.lobbyMode, registerVal3.errTarget.maxClients)
		registerVal22 = Lobby.Actions.LobbyHostAddPrimary(registerVal3.errTarget.lobbyType)
		registerVal23 = Lobby.Actions.LobbyClientStart(registerVal3.errTarget.lobbyType)
		registerVal21.name = (registerVal21.name .. "_2")
		Lobby.Process.AddActions(registerVal23, registerVal21)
		Lobby.Process.AddActions(registerVal21, registerVal22)
		Lobby.Process.AddActions(registerVal22, registerVal23)
	else
		if registerVal3.errTarget.lobbyType == Enum.LobbyType.LOBBY_TYPE_GAME then
			local function __FUNC_7E2F_()
				local registerVal0 = Dvar.party_maxplayers:get()
				Engine.SetLobbyMaxClients(registerVal3.errTarget.lobbyType, registerVal0)
			end

			registerVal22 = Lobby.Actions.LobbyHostStart(arg0, registerVal3.errTarget.mainMode, registerVal3.errTarget.lobbyType, registerVal3.errTarget.lobbyMode, registerVal3.errTarget.maxClients)
			local registerVal25 = {}
			local registerVal26 = Engine.GetXUID64(arg0)
			registerVal25.xuid = registerVal26
			registerVal23 = Lobby.Actions.LobbyInfoProbe(arg0, registerVal25)
			registerVal26 = {}
			local registerVal27 = Engine.GetXUID64(arg0)
			registerVal26.xuid = registerVal27
			local registerVal24 = Lobby.Actions.LobbyJoinXUID(arg0, registerVal26, Enum.JoinType.JOIN_TYPE_PARTY)
			registerVal27 = {}
			registerVal27.controller = arg0
			registerVal27.lobbyType = registerVal3.errTarget.lobbyType
			registerVal27.mainMode = registerVal3.errTarget.mainMode
			registerVal27.lobbyTimerType = registerVal3.errTarget.lobbyTimerType
			registerVal25 = Lobby.Actions.LobbyVMCall(Lobby.Timer.HostingLobby, registerVal27)
			registerVal22.name = (registerVal22.name .. "_3")
			registerVal26 = Lobby.Actions.RunPlaylistSettings(arg0)
			registerVal27 = Lobby.Actions.AdvertiseLobby(true)
			local registerVal28 = Lobby.Actions.ExecuteScript(__FUNC_7E2F_)
			Lobby.Process.AddActions(registerVal23, registerVal22)
			Lobby.Process.AddActions(registerVal22, registerVal23)
			Lobby.Process.AddActions(registerVal23, registerVal24)
			if registerVal3.errTarget.lobbyMode == Enum.LobbyMode.LOBBY_MODE_PUBLIC or registerVal3.errTarget.lobbyMode == Enum.LobbyMode.LOBBY_MODE_ARENA then
				Lobby.Process.AddActions(registerVal24, registerVal26)
				Lobby.Process.AddActions(registerVal26, registerVal27)
				Lobby.Process.AddActions(registerVal27, registerVal28)
			end
			Lobby.Process.AddActions(registerVal28, registerVal25)
		end
	end
	if registerVal3.errTarget.lobbyMode == Enum.LobbyMode.LOBBY_MODE_ARENA then
		Lobby.Process.AddActions(registerVal25, registerVal16)
		Lobby.Process.AddActions(registerVal16, registerVal17)
	end
	Lobby.Process.AddActions(registerVal17, registerVal15)
	Lobby.Process.AddActions(registerVal15, registerVal13)
	Lobby.Process.AddActions(registerVal13, registerVal14)
	Lobby.Process.AddActions(registerVal14, registerVal18)
	Lobby.Process.AddActions(registerVal18, nil)
	registerVal19.tail = registerVal18
	return registerVal19
end

function Lobby.Process.ForceToMenu(arg0, arg1, arg2)
	local registerVal7 = Lobby.Actions.LobbySettings(arg0, arg1)
	local registerVal8 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal9 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal10 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal11 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal12 = Lobby.Actions.ForceLobbyUIScreen(arg0, arg1.id)
	local registerVal13 = Lobby.Actions.UpdateUI(arg0, arg1)
	local registerVal14 = {}
	registerVal14.head = registerVal7
	registerVal14.interrupt = Lobby.Interrupt.NONE
	registerVal14.force = true
	registerVal14.cancellable = true
	Lobby.Process.AddActions(registerVal7, registerVal10)
	Lobby.Process.AddActions(registerVal10, registerVal11)
	Lobby.Process.AddActions(registerVal11, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal9)
	if arg1.isPrivate == true then
		local registerVal16 = Lobby.Actions.LobbyHostStart(arg0, arg1.mainMode, Enum.LobbyType.LOBBY_TYPE_PRIVATE, arg1.lobbyMode, arg1.maxClients)
		local registerVal17 = Lobby.Actions.LobbyHostAddPrimary(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
		local registerVal18 = Lobby.Actions.LobbyClientStart(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
		Lobby.Process.AddActions(registerVal11, registerVal16)
		Lobby.Process.AddActions(registerVal16, registerVal17)
		Lobby.Process.AddActions(registerVal17, registerVal18)
	end
	Lobby.Process.AddActions(registerVal18, registerVal12)
	Lobby.Process.AddActions(registerVal12, registerVal13)
	if arg2 ~= nil then
		registerVal16 = Lobby.Actions.ErrorPopupMsg(arg2)
		Lobby.Process.AddActions(registerVal13, registerVal16)
	end
	return registerVal14
end

function Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(arg0, arg1, arg2)
	local registerVal3 = Engine.GetLobbyUIScreen()
	local registerVal4 = LobbyData:UITargetFromId(registerVal3)
	local registerVal5 = Lobby.Actions.OpenSpinner(true)
	local registerVal6 = Lobby.Actions.CloseSpinner()
	local registerVal7 = Lobby.Actions.CloseSpinner()
	local registerVal8 = Lobby.Actions.LobbyHostStart(arg0, arg1, Enum.LobbyType.LOBBY_TYPE_PRIVATE, registerVal4.lobbyMode, arg2)
	local registerVal9 = Lobby.Actions.LobbyHostAddPrimary(registerVal8.lobbyType)
	local registerVal10 = Lobby.Actions.LobbyClientStart(registerVal8.lobbyType)
	local registerVal11 = Lobby.Actions.ErrorPopup(registerVal8)
	local registerVal12 = {}
	registerVal12.head = registerVal5
	registerVal12.interrupt = Lobby.Interrupt.NONE
	registerVal12.force = true
	registerVal12.cancellable = true
	Lobby.Process.AddActions(registerVal5, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal10)
	Lobby.Process.AddActions(registerVal10, registerVal6)
	Lobby.Process.AddActions(registerVal7, registerVal11)
	return registerVal12
end

function Lobby.Process.PromoteClientToPrivateLobbyHost(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	local registerVal9 = Engine.GetLobbyUIScreen()
	local registerVal10 = LobbyData:UITargetFromId(registerVal9)
	local registerVal11 = Lobby.Actions.PromoteToHostDone(arg0, arg2, arg8, arg7)
	local registerVal12 = Lobby.Actions.LobbyHostStartMigratedInfo(arg0, arg1, arg2, arg3, arg4, arg5)
	local registerVal13 = {}
	registerVal13.head = registerVal11
	registerVal13.interrupt = Lobby.Interrupt.NONE
	registerVal13.force = true
	registerVal13.cancellable = true
	local registerVal14 = Engine.IsLobbyHost(arg2)
	if registerVal14 == false then
		registerVal13.head = registerVal12
		Lobby.Process.AddActions(registerVal12, registerVal11)
		Lobby.Process.AddActions(registerVal11, nil)
	end
	return registerVal13
end

function Lobby.Process.TransferDataFromClientModuleToHostModule()
	Engine.ComError( Enum.errorCode.ERROR_SCRIPT, "Mode is:." )
	local registerVal0 = Engine.LobbyGetSessionClients(Enum.LobbyModule.LOBBY_MODULE_CLIENT, Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal1, registerVal2, registerVal3 = ipairs(registerVal0.sessionClients)
	for index4,value5 in registerVal1, registerVal2, registerVal3 do
		Engine.LobbyHostAssignMapVoteToClient(value5.xuid, value5.mapVote)
		Engine.LobbyHostAssignTeamToClient(value5.xuid, value5.team)
	end
end

function Lobby.Process.PromoteClientToGameLobbyHost(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	local registerVal9 = Engine.GetLobbyUIScreen()
	local registerVal10 = LobbyData:UITargetFromId(registerVal9)
	local registerVal11, registerVal12 = Engine.GetGameLobbyStatusInfo()
	local function __FUNC_967C_()
		local registerVal0 = Engine.IsInGame()
		if not registerVal0 and registerVal10.lobbyTimerType ~= LuaEnums.TIMER_TYPE.INVALID then
			local registerVal1 = {}
			registerVal1.controller = arg0
			registerVal1.lobbyType = arg2
			registerVal1.mainMode = arg1
			registerVal1.lobbyTimerType = registerVal10.lobbyTimerType
			registerVal1.status = registerVal11
			registerVal1.statusValue = registerVal12
			Lobby.Timer.HostingLobby(registerVal1)
		end
		if registerVal10.isAdvertised == true then
			if arg3 ~= Enum.LobbyMode.LOBBY_MODE_PUBLIC and arg3 ~= Enum.LobbyMode.LOBBY_MODE_ARENA then
			end
			Engine.QoSProbeListenerEnable(arg2, true)
		end
		Lobby.Process.TransferDataFromClientModuleToHostModule()
	end
	local registerVal14 = Lobby.Actions.PromoteToHostDone(arg0, arg2, arg8, arg7)
	local registerVal15 = Lobby.Actions.LobbyHostStartMigratedInfo(arg0, arg1, arg2, arg3, arg4, arg5)
	local registerVal16 = Lobby.Actions.ExecuteScript(__FUNC_967C_)
	local registerVal17 = Lobby.Actions.AdvertiseLobby(true)
	local registerVal18 = Lobby.Actions.LobbySettings(arg0, registerVal10)
	local registerVal19 = Lobby.Actions.RunPlaylistSettings(arg0)
	local registerVal20 = {}
	registerVal20.head = registerVal14
	registerVal20.interrupt = Lobby.Interrupt.NONE
	registerVal20.force = true
	registerVal20.cancellable = true
	local registerVal21 = Engine.IsLobbyHost(arg2)
	registerVal20.head = registerVal15
	Lobby.Process.AddActions(registerVal15, registerVal14)
	Lobby.Process.AddActions(registerVal14, registerVal16)
	Lobby.Process.AddActions(registerVal16, registerVal17)
	if registerVal21 == false and registerVal10.isAdvertised == true and arg7 == false then
		Lobby.Process.AddActions(registerVal17, registerVal18)
	end
	return registerVal20
end

function Lobby.Process.PromoteClientToHost(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	if arg2 == Enum.LobbyType.LOBBY_TYPE_PRIVATE then
		local registerVal10 = Lobby.Process.PromoteClientToPrivateLobbyHost(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	else
		if arg2 == Enum.LobbyType.LOBBY_TYPE_GAME then
			registerVal10 = Lobby.Process.PromoteClientToGameLobbyHost(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
		end
	end
	return registerVal10
end

function Lobby.Process.LocalClientLeave(arg0, arg1)
	local registerVal2 = Lobby.Actions.LobbyLocalClientLeave(Enum.LobbyType.LOBBY_TYPE_PRIVATE, arg0, arg1)
	local registerVal3 = Lobby.Actions.LobbyLocalClientLeave(Enum.LobbyType.LOBBY_TYPE_GAME, arg0, arg1)
	local registerVal4 = {}
	registerVal4.head = registerVal3
	registerVal4.interrupt = Lobby.Interrupt.NONE
	registerVal4.force = true
	registerVal4.cancellable = false
	Lobby.Process.AddActions(registerVal3, registerVal2)
	Lobby.Process.AddActions(registerVal2)
	return registerVal4
end

function Lobby.Process.LeaveWithParty(arg0, arg1, arg2)
	local registerVal3 = Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal4 = Engine.IsLobbyActive(Enum.LobbyType.LOBBY_TYPE_GAME)
	if arg0 ~= Enum.LobbyModule.LOBBY_MODULE_CLIENT or registerVal4 == false then
		return 
	end
	local registerVal6 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal7 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal8 = Lobby.Actions.CloseSpinner()
	local registerVal9 = {}
	registerVal9.head = registerVal6
	registerVal9.interrupt = Lobby.Interrupt.NONE
	registerVal9.force = false
	registerVal9.cancellable = true
	if registerVal3 == true then
		Lobby.Process.ForceAction(registerVal6, registerVal7)
	end
	Lobby.Process.ForceAction(registerVal7, registerVal8)
	return registerVal9
end

function Lobby.Process.ManagePartyLeave(arg0)
	local registerVal1 = LobbyData:UITargetFromId(LobbyData.GetLobbyNav())
	if registerVal1 == nil then
		error(("LobbyVM: No menu called '" .. currentMenu .. "' found."))
	end
	local registerVal2 = Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal3 = Engine.IsLobbyActive(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	if registerVal2 == false or registerVal3 == false then
		return nil
	end
	local registerVal4 = Engine.GetLobbyMainMode()
	local registerVal5 = Engine.GetLobbyMode(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal6 = Engine.GetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal7 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal8 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal9 = Lobby.Actions.LobbyHostStart(arg0, registerVal4, Enum.LobbyType.LOBBY_TYPE_PRIVATE, registerVal5, registerVal6)
	local registerVal10 = Lobby.Actions.LobbyHostAddPrimary(registerVal9.lobbyType)
	local registerVal11 = Lobby.Actions.LobbyClientStart(registerVal9.lobbyType)
	local registerVal12 = {}
	registerVal12.head = registerVal7
	registerVal12.interrupt = Lobby.Interrupt.NONE
	registerVal12.force = true
	registerVal12.cancellable = true
	Lobby.Process.AddActions(registerVal7, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal10)
	Lobby.Process.AddActions(registerVal10, registerVal11)
	return registerVal12
end

function Lobby.Process.NonFatalError(arg0)
	local registerVal1 = Engine.GetLobbyUIScreen()
	local registerVal2 = LobbyData:UITargetFromId(registerVal1)
	local registerVal3 = Lobby.Actions.ErrorPopupMsg(arg0)
	local registerVal4 = {}
	registerVal4.head = registerVal3
	registerVal4.interrupt = Lobby.Interrupt.NONE
	registerVal4.force = true
	registerVal4.cancellable = true
	return registerVal4
end

function Lobby.Process.FatalError(arg0)
	local registerVal1 = Engine.GetPrimaryController()
	local registerVal2 = Engine.GetLobbyUIScreen()
	local registerVal3 = LobbyData:UITargetFromId(registerVal2)
	local registerVal5 = Lobby.Actions.OpenSpinner()
	local registerVal6 = Lobby.Actions.CloseSpinner()
	local registerVal7 = Lobby.Actions.LobbySettings(registerVal1, LobbyData.UITargets.UI_MAIN)
	local registerVal8 = Lobby.Actions.UpdateUI(registerVal1, LobbyData.UITargets.UI_MAIN)
	local registerVal9 = Lobby.Actions.ErrorPopupMsg(arg0)
	local registerVal10 = {}
	registerVal10.head = registerVal5
	registerVal10.interrupt = Lobby.Interrupt.NONE
	registerVal10.force = true
	registerVal10.cancellable = true
	Lobby.Process.AddActions(registerVal5, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal6)
	Lobby.Process.AddActions(registerVal6, registerVal9)
	return registerVal10
end

function Lobby.Process.Reset()
	local registerVal0 = Engine.GetPrimaryController()
	local registerVal1 = Engine.GetLobbyUIScreen()
	local registerVal2 = LobbyData:UITargetFromId(registerVal1)
	local registerVal4 = Lobby.Actions.CloseSpinner()
	local registerVal5 = Lobby.Actions.CloseSpinner()
	local registerVal6 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal7 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal8 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal9 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal10 = Lobby.Actions.LobbySettings(registerVal0, LobbyData.UITargets.UI_MAIN)
	local registerVal11 = Lobby.Actions.UpdateUI(registerVal0, LobbyData.UITargets.UI_MAIN)
	local registerVal12 = {}
	registerVal12.head = registerVal9
	registerVal12.interrupt = Lobby.Interrupt.NONE
	registerVal12.force = true
	registerVal12.cancellable = true
	Lobby.Process.AddActions(registerVal4, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal6)
	Lobby.Process.AddActions(registerVal6, registerVal10)
	Lobby.Process.AddActions(registerVal10, registerVal11)
	Lobby.Process.AddActions(registerVal11, registerVal5)
	return registerVal12
end

function Lobby.Process.DevmapClient(arg0)
	local registerVal6 = Lobby.Actions.LobbySettings(arg0, LobbyData.UITargets.UI_MODESELECT, nil, true)
	local registerVal7 = Lobby.Actions.UpdateUI(arg0, LobbyData.UITargets.UI_MODESELECT)
	local registerVal8 = Lobby.Actions.SetNetworkMode(arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LAN)
	local registerVal9 = Lobby.Actions.LobbyHostStart(arg0, LobbyData.UITargets.UI_MODESELECT.mainMode, LobbyData.UITargets.UI_MODESELECT.lobbyType, LobbyData.UITargets.UI_MODESELECT.lobbyMode, LobbyData.UITargets.UI_MODESELECT.maxClients)
	local registerVal10 = Lobby.Actions.LobbyHostAddPrimary(LobbyData.UITargets.UI_MODESELECT.lobbyType)
	local registerVal11 = Lobby.Actions.LobbyClientStart(LobbyData.UITargets.UI_MODESELECT.lobbyType)
	local registerVal12 = {}
	registerVal12.head = registerVal6
	registerVal12.interrupt = Lobby.Interrupt.NONE
	registerVal12.force = true
	registerVal12.cancellable = true
	Lobby.Process.AddActions(registerVal6, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal9)
	Lobby.Process.AddActions(registerVal9, registerVal10)
	Lobby.Process.AddActions(registerVal10, registerVal11)
	return registerVal12
end

function Lobby.Process.Devmap(arg0, arg1)
	if arg1 == Enum.LobbyMainMode.LOBBY_MAINMODE_CP then
	else
		if arg1 == Enum.LobbyMainMode.LOBBY_MAINMODE_ZM then
		else
			if arg1 == Enum.LobbyMainMode.LOBBY_MAINMODE_MP then
			end
		end
	end
	local registerVal4 = Dvar.ui_gametype:get()
	if LobbyData.UITargets.UI_MPLOBBYLANGAME == LobbyData.UITargets.UI_CPLOBBYLANGAME and registerVal4 == "cpzm" then
	end
	local registerVal12 = Lobby.Actions.LobbySettings(arg0, LobbyData.UITargets.UI_CP2LOBBYLANGAME, nil, true)
	local registerVal13 = Lobby.Actions.UpdateUI(arg0, LobbyData.UITargets.UI_CP2LOBBYLANGAME)
	local registerVal14 = Lobby.Actions.SetNetworkMode(arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LAN)
	local registerVal15 = Lobby.Actions.LobbyHostStart(arg0, LobbyData.UITargets.UI_MODESELECT.mainMode, LobbyData.UITargets.UI_MODESELECT.lobbyType, LobbyData.UITargets.UI_MODESELECT.lobbyMode, LobbyData.UITargets.UI_MODESELECT.maxClients)
	local registerVal16 = Lobby.Actions.LobbyHostAddPrimary(LobbyData.UITargets.UI_MODESELECT.lobbyType)
	local registerVal17 = Lobby.Actions.LobbyClientStart(LobbyData.UITargets.UI_MODESELECT.lobbyType)
	local registerVal18 = Lobby.Actions.LobbyHostStart(arg0, LobbyData.UITargets.UI_CP2LOBBYLANGAME.mainMode, LobbyData.UITargets.UI_CP2LOBBYLANGAME.lobbyType, LobbyData.UITargets.UI_CP2LOBBYLANGAME.lobbyMode, LobbyData.UITargets.UI_CP2LOBBYLANGAME.maxClients)
	local registerVal19 = Lobby.Actions.LobbyHostAddPrimary(LobbyData.UITargets.UI_CP2LOBBYLANGAME.lobbyType)
	local registerVal20 = Lobby.Actions.LobbyClientStart(LobbyData.UITargets.UI_CP2LOBBYLANGAME.lobbyType)
	local registerVal24 = Dvar.ui_gametype:get()
	local registerVal21 = Lobby.Actions.SetGameAndTypeMapName(arg0, lobbyType, registerVal24, Dvar.ui_mapname:get())
	local registerVal22 = {}
	registerVal22.head = registerVal12
	registerVal22.interrupt = Lobby.Interrupt.NONE
	registerVal22.force = true
	registerVal22.cancellable = true
	Lobby.Process.AddActions(registerVal12, registerVal13)
	Lobby.Process.AddActions(registerVal13, registerVal14)
	Lobby.Process.AddActions(registerVal14, registerVal15)
	Lobby.Process.AddActions(registerVal15, registerVal16)
	Lobby.Process.AddActions(registerVal16, registerVal17)
	Lobby.Process.AddActions(registerVal17, registerVal18)
	Lobby.Process.AddActions(registerVal18, registerVal21)
	Lobby.Process.AddActions(registerVal21, registerVal19)
	local registerVal23 = Dvar.splitscreen:get()
	registerVal23 = Dvar.splitscreen_playerCount:get()
	if registerVal23 == true and 1.000000 < registerVal23 then
		registerVal23 = Lobby.Actions.LobbyHostAddLocal(1.000000, LobbyData.UITargets.UI_CP2LOBBYLANGAME.lobbyType)
		Lobby.Process.AddActions(registerVal19, registerVal23)
		Lobby.Process.AddActions(registerVal23, registerVal20)
	else
		Lobby.Process.AddActions(registerVal19, registerVal20)
	end
	return registerVal22
end

function Lobby.Process.PrimaryControllerSignedIn(arg0)
	local registerVal1 = Engine.GetLobbyUIScreen()
	local registerVal2 = LobbyData:UITargetFromId(registerVal1)
	local registerVal4 = Lobby.Actions.OpenSpinner()
	local registerVal5 = Lobby.Actions.CloseSpinner()
	local registerVal6 = Lobby.Actions.LobbySettings(arg0, LobbyData.UITargets.UI_MAIN)
	local registerVal7 = Lobby.Actions.UpdateUI(arg0, LobbyData.UITargets.UI_MAIN)
	local registerVal8 = Lobby.Actions.SignUserInToLive(arg0)
	local registerVal9 = Lobby.Actions.ErrorPopupMsg("XBOXLIVE_SIGNEDOUT")
	local registerVal10 = Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal11 = Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal12 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal13 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal14 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal15 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal16 = {}
	registerVal16.head = registerVal4
	registerVal16.interrupt = Lobby.Interrupt.NONE
	registerVal16.force = true
	registerVal16.cancellable = true
	Lobby.Process.AddActions(registerVal4, registerVal6)
	Lobby.Process.AddActions(registerVal6, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal14)
	Lobby.Process.AddActions(registerVal14, registerVal15)
	Lobby.Process.AddActions(registerVal15, registerVal12)
	Lobby.Process.AddActions(registerVal12, registerVal13)
	Lobby.Process.AddActions(registerVal13, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal5)
	Lobby.Process.AddActions(registerVal5, registerVal9)
	return registerVal16
end

function Lobby.Process.PrimaryControllerSignedOut(arg0)
	local registerVal1 = Engine.GetLobbyUIScreen()
	local registerVal2 = LobbyData:UITargetFromId(registerVal1)
	local registerVal4 = Lobby.Actions.OpenSpinner()
	local registerVal5 = Lobby.Actions.CloseSpinner()
	local registerVal6 = Lobby.Actions.LobbySettings(arg0, LobbyData.UITargets.UI_MAIN)
	local registerVal7 = Lobby.Actions.UpdateUI(arg0, LobbyData.UITargets.UI_MAIN)
	local registerVal8 = Lobby.Actions.SignUserOutOfLive(arg0)
	local registerVal9 = Lobby.Actions.ErrorPopupMsg("XBOXLIVE_SIGNEDOUT")
	local registerVal10 = Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal11 = Engine.IsLobbyHost(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal12 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal13 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_PRIVATE)
	local registerVal14 = Lobby.Actions.LobbyClientEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal15 = Lobby.Actions.LobbyHostEnd(Enum.LobbyType.LOBBY_TYPE_GAME)
	local registerVal16 = {}
	registerVal16.head = registerVal4
	registerVal16.interrupt = Lobby.Interrupt.NONE
	registerVal16.force = true
	registerVal16.cancellable = true
	Lobby.Process.AddActions(registerVal4, registerVal6)
	Lobby.Process.AddActions(registerVal6, registerVal7)
	Lobby.Process.AddActions(registerVal7, registerVal14)
	Lobby.Process.AddActions(registerVal14, registerVal15)
	Lobby.Process.AddActions(registerVal15, registerVal12)
	Lobby.Process.AddActions(registerVal12, registerVal13)
	Lobby.Process.AddActions(registerVal13, registerVal8)
	Lobby.Process.AddActions(registerVal8, registerVal5)
	Lobby.Process.AddActions(registerVal5, registerVal9)
	return registerVal16
end

function Lobby.Process.ReAdvertiseLobby(arg0)
	local function __FUNC_CFCF_()
		Dvar.lobbyAdvertiseDirty:set(true)
	end

	local registerVal2 = Lobby.Actions.AdvertiseLobby(false)
	local registerVal3 = Lobby.Actions.AdvertiseLobby(true)
	local registerVal4 = Lobby.Actions.ExecuteScript(__FUNC_CFCF_)
	local registerVal5 = {}
	registerVal5.head = registerVal2
	registerVal5.interrupt = Lobby.Interrupt.NONE
	registerVal5.force = true
	registerVal5.cancellable = false
	Lobby.Process.ForceAction(registerVal2, registerVal3)
	Lobby.Process.ForceAction(registerVal3, registerVal4)
	return registerVal5
end

function Lobby.Process.LoadMod(arg0, arg1)
	local registerVal2 = Lobby.Actions.OpenSpinner()
	local registerVal3 = Lobby.Actions.CloseSpinner()
	local registerVal4 = Lobby.Actions.CloseSpinner()
	registerVal4.name = (registerVal4.name .. "Error")
	local registerVal6 = Lobby.Actions.CheckMods(arg0, {probeResult = {}, probeResult = arg1}, false)
	local registerVal7 = Lobby.Actions.ErrorPopup(registerVal6)
	local registerVal8 = Lobby.Actions.CloseSpinner()
	registerVal8.name = (registerVal8.name .. "CheckMods")
	local registerVal9 = Lobby.Actions.LoadMod(arg0, registerVal6)
	local registerVal10 = Lobby.Actions.ErrorPopup(registerVal9)
	local registerVal11 = Lobby.Actions.CloseSpinner()
	registerVal11.name = (registerVal4.name .. "LoadedMod")
	local registerVal12 = {}
	registerVal12.head = registerVal2
	registerVal12.interrupt = Lobby.Interrupt.NONE
	registerVal12.force = false
	registerVal12.cancellable = true
	registerVal12.doesNotCancelOthers = true
	Lobby.Process.AddActions(registerVal2, registerVal6, registerVal4, registerVal4)
	Lobby.Process.AddActions(registerVal6, registerVal9, registerVal4, registerVal8)
	Lobby.Process.AddActions(registerVal9, registerVal3, registerVal4, registerVal11)
	Lobby.Process.ForceAction(registerVal8, registerVal7)
	Lobby.Process.ForceAction(registerVal11, registerVal10)
	return registerVal12
end

function Lobby.Process.NeedInstallUGC(arg0, arg1)
	local registerVal2 = Lobby.Actions.OpenSpinner()
	local registerVal3 = Lobby.Actions.CloseSpinner()
	local registerVal4 = Lobby.Actions.CloseSpinner()
	registerVal4.name = (registerVal4.name .. "Error")
	local registerVal6 = Lobby.Actions.CheckMods(arg0, {probeResult = {}, probeResult = arg1}, false)
	local registerVal7 = Lobby.Actions.ErrorPopup(registerVal6)
	local registerVal8 = Lobby.Actions.CloseSpinner()
	registerVal8.name = (registerVal8.name .. "CheckMods")
	local registerVal9 = Lobby.Actions.SubscribeUGC(arg0, registerVal6)
	local registerVal10 = Lobby.Actions.ErrorPopup(registerVal9)
	local registerVal11 = Lobby.Actions.CloseSpinner()
	registerVal11.name = (registerVal4.name .. "SubscribeUGC")
	local registerVal12 = Lobby.Actions.InstalledUGC(arg0, registerVal6)
	local registerVal13 = Lobby.Actions.ErrorPopup(registerVal12)
	local registerVal14 = Lobby.Actions.CloseSpinner()
	registerVal14.name = (registerVal4.name .. "InstalledUGC")
	local registerVal15 = Lobby.Actions.LoadMod(arg0, registerVal6)
	local registerVal16 = Lobby.Actions.ErrorPopup(registerVal15)
	local registerVal17 = Lobby.Actions.CloseSpinner()
	registerVal17.name = (registerVal4.name .. "LoadedMod")
	local registerVal18 = Engine.GetLobbyNetworkMode()
	if registerVal18 ~= Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LAN and registerVal18 ~= Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE then
	end
	local registerVal19 = Lobby.Process.ReloadPrivateLobby(arg0, Enum.LobbyNetworkMode.LOBBY_NETWORKMODE_LIVE)
	local registerVal20 = Lobby.Actions.LobbySettings(arg0, LobbyData.UITargets.UI_MODESELECT)
	local registerVal21 = Lobby.Actions.UpdateUI(arg0, LobbyData.UITargets.UI_MODESELECT)
	Lobby.Process.ForceAction(registerVal19.tail, registerVal20)
	Lobby.Process.ForceAction(registerVal20, registerVal21)
	local registerVal23 = {}
	registerVal23.head = registerVal6
	registerVal23.interrupt = Lobby.Interrupt.NONE
	registerVal23.force = false
	registerVal23.cancellable = true
	registerVal23.doesNotCancelOthers = true
	if arg1.waitForInstall then
		registerVal23.head = registerVal2
		Lobby.Process.AddActions(registerVal2, registerVal6, registerVal4, registerVal4)
	end
	Lobby.Process.AddActions(registerVal6, registerVal9, registerVal4, registerVal8)
	Lobby.Process.AddActions(registerVal9, registerVal12, registerVal4, registerVal11)
	Lobby.Process.AddActions(registerVal12, registerVal15, registerVal4, registerVal14)
	Lobby.Process.AddActions(registerVal15, registerVal3, registerVal4, registerVal17)
	Lobby.Process.ForceAction(registerVal8, registerVal7)
	Lobby.Process.ForceAction(registerVal7, registerVal19.head)
	Lobby.Process.ForceAction(registerVal11, registerVal10)
	Lobby.Process.ForceAction(registerVal10, registerVal19.head)
	Lobby.Process.ForceAction(registerVal14, registerVal13)
	Lobby.Process.ForceAction(registerVal13, registerVal19.head)
	Lobby.Process.ForceAction(registerVal17, registerVal16)
	Lobby.Process.ForceAction(registerVal16, registerVal19.head)
	return registerVal23
end

function Lobby.Process.LoadMod2(arg0)
	local registerVal2 = Engine.GetPrimaryController()
	local registerVal1 = Lobby.Process.LoadMod(registerVal2, arg0)
	if registerVal1 ~= nil then
		Lobby.ProcessQueue.AddToQueue("LoadMod", registerVal1)
	end
end
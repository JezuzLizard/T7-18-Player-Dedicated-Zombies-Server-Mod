require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyMemberBubbleGumBuffs")
require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyMemberPartyMemberIconNew")
require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyLeaderIcon")
require("ui.uieditor.widgets.Lobby.Common.FE_MemberBlurPanelContainer")
require("ui.uieditor.widgets.Lobby.Common.FE_ButtonPanel")
require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyMemberTeamColor")
require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyRank")
require("ui.uieditor.widgets.Lobby.Common.FE_FocusBarContainer")
require("ui.uieditor.widgets.Lobby.Lists.Members.IconControllerContainer")
require("ui.uieditor.widgets.Lobby.Lists.Members.IconJoinable")
require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyMemberGamertag")
require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyMemberTeamSwitcher")
require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyMemberScore")
require("ui.uieditor.widgets.Lobby.Lists.Members.SearchingForPlayer")
require("ui.uieditor.widgets.Lobby.Lists.Members.SearchingForPlayer_Flipped")
require("ui.uieditor.widgets.Lobby.Lists.Members.AnonymousPlayer")
require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyMemberReady")
require("ui.uieditor.widgets.Lobby.Lists.Members.LobbyMemberMP45")
local f0_local0 = function (f1_arg0, f1_arg1, f1_arg2)
	f1_arg0:registerEventHandler("team_switch", function (Sender, Event)
		local f3_local0 = Event.controller
		local f3_local1 = Event.switchTeam
		local f3_local2 = Event.xuid
		if not f3_local2 then
			f3_local2 = Engine.GetXUID64(f3_local0)
		end
		local f3_local3 = DataSources.LobbyList.getItem(f3_local0, Sender.gridInfoTable.parentGrid, Sender.gridInfoTable.zeroBasedIndex + 1)
		if f3_local2 ~= Engine.GetModelValue(Engine.GetModel(f3_local3, "xuid")) then
			return 
		else
			Engine.SetModelValue(Engine.CreateModel(f3_local3, "teamSwitch"), f3_local1)
			Sender.LobbyMemberTeamColor:SetupTeamSwitch(f3_local1)
			Sender.TeamSwitcher:SetupTeamSwitch(f3_local1)
		end
	end)
	f1_arg0:linkToElementModel(f1_arg0, "team", true, function (ModelRef)
		if ModelRef then
			local f4_local0 = f1_arg0
			Engine.SetModelValue(Engine.CreateModel(f4_local0:getModel(), "teamSwitch"), Engine.GetModelValue(ModelRef))
			f1_arg0.LobbyMemberTeamColor:SetupTeamColorBackground(Engine.GetModelValue(ModelRef))
		end
	end)
	f1_arg0:linkToElementModel(f1_arg0, "teamColor", true, function (ModelRef)
		if ModelRef then
			local f5_local0 = f1_arg0
			local f5_local1 = Engine.GetModel(f5_local0:getModel(), "team")
			if f5_local1 then
				Engine.ForceNotifyModelSubscriptions(f5_local1)
			end
		end
	end)
	if CoD.isPC then
		f1_arg0:setForceMouseEventDispatch(true)
		LUI.OverrideFunction_CallOriginalFirst(f1_arg0, "setState", function (f6_arg0, f6_arg1)
			if IsSelfInState(f1_arg0, "AnonymousPlayer") then
				f1_arg0.LobbyMemberMP45:setAlpha(0)
			else
				local f6_local0 = f1_arg0
				local f6_local1 = Engine.GetModel(f6_local0:getModel(), "isStarterPack")
				if f6_local1 then
					f1_arg0.LobbyMemberMP45:setAlpha(Engine.GetModelValue(f6_local1))
				end
			end
		end)
	end
end

CoD.LobbyMember = InheritFrom(LUI.UIElement)
CoD.LobbyMember.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	if PreLoadFunc then
		PreLoadFunc(Widget, InstanceRef)
	end
	Widget:setUseStencil(false)
	Widget:setClass(CoD.LobbyMember)
	Widget.id = "LobbyMember"
	Widget.soundSet = "default"
	Widget:setLeftRight(true, false, 0, 490)
	Widget:setTopBottom(true, false, 0, 27)
	Widget:makeFocusable()
	Widget:setHandleMouse(true)
	Widget.anyChildUsesUpdateState = true
	local f2_local1 = LUI.UIImage.new()
	f2_local1:setLeftRight(true, false, 0, 490)
	f2_local1:setTopBottom(true, false, 0, 91)
	f2_local1:setAlpha(0)
	Widget:addElement(f2_local1)
	Widget.sizeElement = f2_local1
	
	--[[local f2_local2 = CoD.LobbyMemberBubbleGumBuffs.new(HudRef, InstanceRef)
	f2_local2:setLeftRight(true, false, 60, 408)
	f2_local2:setTopBottom(true, false, 27, 91)
	f2_local2:linkToElementModel(Widget, nil, false, function (ModelRef)
		f2_local2:setModel(ModelRef, InstanceRef)
	end)
	Widget:addElement(f2_local2)
	Widget.LobbyMemberBubbleGumBuffs = f2_local2]]--
	
	local f2_local3 = CoD.LobbyMemberPartyMemberIconNew.new(HudRef, InstanceRef)
	f2_local3:setLeftRight(true, false, 412, 422)
	f2_local3:setTopBottom(true, false, 0, 25)
	f2_local3:linkToElementModel(Widget, nil, false, function (ModelRef)
		f2_local3:setModel(ModelRef, InstanceRef)
	end)
	f2_local3:mergeStateConditions({{stateName = "PartyMemberTopOrMiddle", condition = function (HudRef, ItemRef, UpdateTable)
		return IsSelfModelValueTrue(ItemRef, InstanceRef, "isPartyMemberTopOrMiddle")
	end}, {stateName = "PartyMember", condition = function (HudRef, ItemRef, UpdateTable)
		return IsSelfModelValueTrue(ItemRef, InstanceRef, "isPartyMember")
	end}, {stateName = "OtherPartyMemberTopOrMiddle", condition = function (HudRef, ItemRef, UpdateTable)
		return IsSelfModelValueTrue(ItemRef, InstanceRef, "isOtherMemberTopOrMiddle")
	end}, {stateName = "OtherPartyMember", condition = function (HudRef, ItemRef, UpdateTable)
		return IsSelfModelValueTrue(ItemRef, InstanceRef, "isOtherMember")
	end}})
	f2_local3:linkToElementModel(f2_local3, "isPartyMemberTopOrMiddle", true, function (ModelRef)
		HudRef:updateElementState(f2_local3, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "isPartyMemberTopOrMiddle"})
	end)
	f2_local3:linkToElementModel(f2_local3, "isPartyMember", true, function (ModelRef)
		HudRef:updateElementState(f2_local3, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "isPartyMember"})
	end)
	f2_local3:linkToElementModel(f2_local3, "isOtherMemberTopOrMiddle", true, function (ModelRef)
		HudRef:updateElementState(f2_local3, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "isOtherMemberTopOrMiddle"})
	end)
	f2_local3:linkToElementModel(f2_local3, "isOtherMember", true, function (ModelRef)
		HudRef:updateElementState(f2_local3, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "isOtherMember"})
	end)
	Widget:addElement(f2_local3)
	Widget.PartyMemberIconNew = f2_local3
	
	local f2_local4 = CoD.LobbyLeaderIcon.new(HudRef, InstanceRef)
	f2_local4:setLeftRight(true, false, 411, 435)
	f2_local4:setTopBottom(true, false, 1, 26)
	f2_local4:linkToElementModel(Widget, "isMemberLeader", true, function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			f2_local4.Leader:setAlpha(ModelValue)
		end
	end)
	Widget:addElement(f2_local4)
	Widget.LobbyLeaderIcon = f2_local4
	
	local f2_local5 = CoD.FE_MemberBlurPanelContainer.new(HudRef, InstanceRef)
	f2_local5:setLeftRight(true, true, 60, -82)
	f2_local5:setTopBottom(false, false, -14, 13.5)
	f2_local5:setRGB(0.5, 0.5, 0.5)
	f2_local5.FEMemberBlurPanel0:setShaderVector(0, 0, 3, 0, 0)
	Widget:addElement(f2_local5)
	Widget.FEMemberBlurPanelContainer0 = f2_local5
	
	local f2_local6 = CoD.FE_ButtonPanel.new(HudRef, InstanceRef)
	f2_local6:setLeftRight(true, true, 60, -82)
	f2_local6:setTopBottom(false, false, -14, 13.5)
	f2_local6:setRGB(0.19, 0.19, 0.19)
	f2_local6:setAlpha(0)
	Widget:addElement(f2_local6)
	Widget.VSpanel = f2_local6
	
	local f2_local7 = CoD.FE_ButtonPanel.new(HudRef, InstanceRef)
	f2_local7:setLeftRight(true, false, 60, 408)
	f2_local7:setTopBottom(true, false, -0.5, 27)
	f2_local7:setRGB(0.15, 0.15, 0.15)
	f2_local7:setAlpha(0)
	Widget:addElement(f2_local7)
	Widget.LobbyMemberBacking = f2_local7
	
	local f2_local8 = CoD.LobbyMemberTeamColor.new(HudRef, InstanceRef)
	f2_local8:setLeftRight(true, false, 60, 408)
	f2_local8:setTopBottom(true, false, -0.5, 27.5)
	f2_local8:linkToElementModel(Widget, nil, false, function (ModelRef)
		f2_local8:setModel(ModelRef, InstanceRef)
	end)
	Widget:addElement(f2_local8)
	Widget.LobbyMemberTeamColor = f2_local8
	
	local f2_local9 = CoD.LobbyRank.new(HudRef, InstanceRef)
	f2_local9:setLeftRight(false, true, -428, -378)
	f2_local9:setTopBottom(true, false, 1, 26)
	f2_local9:linkToElementModel(Widget, nil, false, function (ModelRef)
		f2_local9:setModel(ModelRef, InstanceRef)
	end)
	Widget:addElement(f2_local9)
	Widget.rank = f2_local9
	
	local f2_local10 = LUI.UITightText.new()
	f2_local10:setLeftRight(true, false, 108, 176)
	f2_local10:setTopBottom(true, false, 3, 24)
	f2_local10:setRGB(0.96, 1, 0.33)
	f2_local10:setAlpha(0)
	f2_local10:setTTF("fonts/RefrigeratorDeluxe-Regular.ttf")
	Widget:addElement(f2_local10)
	Widget.clanTag = f2_local10
	
	local f2_local11 = LUI.UIText.new()
	f2_local11:setLeftRight(true, false, 116, 321)
	f2_local11:setTopBottom(true, false, 15, 31)
	f2_local11:setRGB(0.87, 0.9, 0.9)
	f2_local11:setAlpha(0)
	f2_local11:setText(Engine.Localize("Group Here"))
	f2_local11:setTTF("fonts/RefrigeratorDeluxe-Regular.ttf")
	f2_local11:setLetterSpacing(1)
	f2_local11:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
	f2_local11:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_TOP)
	Widget:addElement(f2_local11)
	Widget.PrimaryGroup = f2_local11
	
	local f2_local12 = LUI.UIText.new()
	f2_local12:setLeftRight(true, false, 61, 461)
	f2_local12:setTopBottom(true, false, 2.5, 19.5)
	f2_local12:setRGB(0.42, 0.52, 0.62)
	f2_local12:setAlpha(0)
	f2_local12:setZoom(10)
	f2_local12:setText(Engine.Localize("PLATFORM_FEEDER_SECONDARY_CONTROLLER_PLUGIN"))
	f2_local12:setTTF("fonts/UnitedSansSmCdMd.ttf")
	f2_local12:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_LEFT)
	f2_local12:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_TOP)
	Widget:addElement(f2_local12)
	Widget.addControllerText = f2_local12
	
	local f2_local13 = LUI.UIText.new()
	f2_local13:setLeftRight(true, false, 19, 509)
	f2_local13:setTopBottom(true, false, 2.5, 19.5)
	f2_local13:setRGB(0.42, 0.52, 0.62)
	f2_local13:setAlpha(0)
	f2_local13:setZoom(10)
	f2_local13:setText(Engine.Localize("MENU_LOBBY_MORECOUNT"))
	f2_local13:setTTF("fonts/UnitedSansSmCdMd.ttf")
	f2_local13:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_CENTER)
	f2_local13:setAlignment(Enum.LUIAlignment.LUI_ALIGNMENT_TOP)
	Widget:addElement(f2_local13)
	Widget.MorePlaying = f2_local13
	
	local f2_local14 = LUI.UITightText.new()
	f2_local14:setLeftRight(true, false, 61, 333)
	f2_local14:setTopBottom(true, false, 7, 24)
	f2_local14:setRGB(0.42, 0.52, 0.62)
	f2_local14:setAlpha(0)
	f2_local14:setText(Engine.Localize("MENU_LOBBY_PLAYERCOUNT"))
	f2_local14:setTTF("fonts/UnitedSansSmCdMd.ttf")
	Widget:addElement(f2_local14)
	Widget.playerCountText = f2_local14
	
	local f2_local15 = CoD.FE_FocusBarContainer.new(HudRef, InstanceRef)
	f2_local15:setLeftRight(true, false, 58, 410)
	f2_local15:setTopBottom(true, false, 26, 29)
	f2_local15:setAlpha(0)
	f2_local15:setZoom(1)
	Widget:addElement(f2_local15)
	Widget.FocusBarB = f2_local15
	
	local f2_local16 = CoD.FE_FocusBarContainer.new(HudRef, InstanceRef)
	f2_local16:setLeftRight(true, false, 58, 410)
	f2_local16:setTopBottom(true, false, -4, 0)
	f2_local16:setAlpha(0)
	f2_local16:setZoom(1)
	Widget:addElement(f2_local16)
	Widget.FocusBarT = f2_local16
	
	local f2_local17 = CoD.IconControllerContainer.new(HudRef, InstanceRef)
	f2_local17:setLeftRight(true, false, 2, 59)
	f2_local17:setTopBottom(true, false, -3, 29)
	f2_local17:setRGB(0.74, 0.78, 0.79)
	f2_local17:linkToElementModel(Widget, nil, false, function (ModelRef)
		f2_local17:setModel(ModelRef, InstanceRef)
	end)
	Widget:addElement(f2_local17)
	Widget.IconControllerContainer = f2_local17
	
	local f2_local18 = CoD.IconJoinable.new(HudRef, InstanceRef)
	f2_local18:setLeftRight(true, false, 389, 413)
	f2_local18:setTopBottom(true, false, 1.5, 26.5)
	f2_local18:setAlpha(0)
	Widget:addElement(f2_local18)
	Widget.IconJoinable = f2_local18
	
	local f2_local19 = CoD.LobbyMemberGamertag.new(HudRef, InstanceRef)
	f2_local19:setLeftRight(true, false, 115, 386)
	f2_local19:setTopBottom(true, false, 1, 26)
	f2_local19:setRGB(0.96, 1, 0.33)
	f2_local19:linkToElementModel(Widget, nil, false, function (ModelRef)
		f2_local19:setModel(ModelRef, InstanceRef)
	end)
	Widget:addElement(f2_local19)
	Widget.gamertag = f2_local19
	
	local f2_local20 = CoD.LobbyMemberTeamSwitcher.new(HudRef, InstanceRef)
	f2_local20:setLeftRight(true, false, 245, 408)
	f2_local20:setTopBottom(true, false, 0, 26)
	Widget:addElement(f2_local20)
	Widget.TeamSwitcher = f2_local20
	
	local f2_local21 = CoD.LobbyLeaderIcon.new(HudRef, InstanceRef)
	f2_local21:setLeftRight(true, false, 411, 435)
	f2_local21:setTopBottom(true, false, 1, 26)
	f2_local21:setAlpha(0)
	f2_local21:linkToElementModel(Widget, "isMemberLeader", true, function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			f2_local21.Leader:setAlpha(ModelValue)
		end
	end)
	f2_local21:mergeStateConditions({{stateName = "TopOrMiddleZM", condition = function (HudRef, ItemRef, UpdateTable)
		local f23_local0 = IsSelfModelValueTrue(ItemRef, InstanceRef, "isPartyMemberTopOrMiddle")
		if f23_local0 then
			f23_local0 = IsZM()
			if f23_local0 then
				f23_local0 = LobbyHas4PlayersOrLess()
			end
		end
		return f23_local0
	end}, {stateName = "TopOrMiddle", condition = function (HudRef, ItemRef, UpdateTable)
		return IsSelfModelValueTrue(ItemRef, InstanceRef, "isPartyMemberTopOrMiddle")
	end}, {stateName = "Invisible", condition = function (HudRef, ItemRef, UpdateTable)
		return AlwaysFalse()
	end}})
	f2_local21:linkToElementModel(f2_local21, "isPartyMemberTopOrMiddle", true, function (ModelRef)
		HudRef:updateElementState(f2_local21, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "isPartyMemberTopOrMiddle"})
	end)
	f2_local21:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyMainMode"), function (ModelRef)
		HudRef:updateElementState(f2_local21, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.lobbyMainMode"})
	end)
	f2_local21:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyNav"), function (ModelRef)
		HudRef:updateElementState(f2_local21, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.lobbyNav"})
	end)
	if f2_local21.m_eventHandlers.on_client_added then
		local f2_local22 = f2_local21.m_eventHandlers.on_client_added
		f2_local21:registerEventHandler("on_client_added", function (Sender, Event)
			local f29_local0 = Event.menu
			if not f29_local0 then
				f29_local0 = HudRef
			end
			Event.menu = f29_local0
			Sender:updateState(Event)
			return f2_local22(Sender, Event)
		end)
	else
		f2_local21:registerEventHandler("on_client_added", LUI.UIElement.updateState)
	end
	if f2_local21.m_eventHandlers.on_client_removed then
		local f2_local22 = f2_local21.m_eventHandlers.on_client_removed
		f2_local21:registerEventHandler("on_client_removed", function (Sender, Event)
			local f30_local0 = Event.menu
			if not f30_local0 then
				f30_local0 = HudRef
			end
			Event.menu = f30_local0
			Sender:updateState(Event)
			return f2_local22(Sender, Event)
		end)
	else
		f2_local21:registerEventHandler("on_client_removed", LUI.UIElement.updateState)
	end
	Widget:addElement(f2_local21)
	Widget.LobbyLeaderIcon0 = f2_local21
	
	local f2_local22 = CoD.LobbyMemberScore.new(HudRef, InstanceRef)
	f2_local22:setLeftRight(true, false, 354.5, 409.5)
	f2_local22:setTopBottom(true, false, 1, 26)
	f2_local22:linkToElementModel(Widget, nil, false, function (ModelRef)
		f2_local22:setModel(ModelRef, InstanceRef)
	end)
	f2_local22:mergeStateConditions({{stateName = "Hidden2", condition = function (HudRef, ItemRef, UpdateTable)
		return IsCustomLobby()
	end}})
	f2_local22:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyNav"), function (ModelRef)
		HudRef:updateElementState(f2_local22, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.lobbyNav"})
	end)
	Widget:addElement(f2_local22)
	Widget.LobbyMemberScore = f2_local22
	
	local f2_local23 = CoD.SearchingForPlayer.new(HudRef, InstanceRef)
	f2_local23:setLeftRight(true, false, 115, 386)
	f2_local23:setTopBottom(true, false, 1, 26)
	f2_local23:setAlpha(0)
	Widget:addElement(f2_local23)
	Widget.SearchingForPlayer = f2_local23
	
	local f2_local24 = CoD.SearchingForPlayer_Flipped.new(HudRef, InstanceRef)
	f2_local24:setLeftRight(true, false, 115, 386)
	f2_local24:setTopBottom(true, false, 1, 26)
	f2_local24:setAlpha(0)
	Widget:addElement(f2_local24)
	Widget.SearchingForPlayerFlipped = f2_local24
	
	local f2_local25 = CoD.AnonymousPlayer.new(HudRef, InstanceRef)
	f2_local25:setLeftRight(true, false, 115, 386)
	f2_local25:setTopBottom(true, false, 1, 26)
	f2_local25:setAlpha(0)
	Widget:addElement(f2_local25)
	Widget.AnonymousPlayer = f2_local25
	
	local f2_local26 = CoD.LobbyMemberReady.new(HudRef, InstanceRef)
	f2_local26:setLeftRight(true, false, 13, 38)
	f2_local26:setTopBottom(true, false, 1, 26)
	f2_local26:linkToElementModel(Widget, nil, false, function (ModelRef)
		f2_local26:setModel(ModelRef, InstanceRef)
	end)
	f2_local26:mergeStateConditions({{stateName = "Invisible", condition = function (HudRef, ItemRef, UpdateTable)
		return not IsReadyUpVisible(ItemRef, InstanceRef)
	end}})
	f2_local26:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyNetworkMode"), function (ModelRef)
		HudRef:updateElementState(f2_local26, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.lobbyNetworkMode"})
	end)
	f2_local26:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyNav"), function (ModelRef)
		HudRef:updateElementState(f2_local26, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.lobbyNav"})
	end)
	f2_local26:linkToElementModel(f2_local26, "isReady", true, function (ModelRef)
		HudRef:updateElementState(f2_local26, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "isReady"})
	end)
	Widget:addElement(f2_local26)
	Widget.LobbyMemberReady = f2_local26
	
	local f2_local27 = CoD.LobbyMemberMP45.new(HudRef, InstanceRef)
	f2_local27:setLeftRight(true, false, 384, 408)
	f2_local27:setTopBottom(true, false, 1, 26)
	Widget:addElement(f2_local27)
	Widget.LobbyMemberMP45 = f2_local27
	
	Widget.clanTag:linkToElementModel(Widget, "clanTag", true, function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			f2_local10:setText(ModelValue)
		end
	end)
	Widget.LobbyMemberMP45:linkToElementModel(Widget, "isStarterPack", true, function (ModelRef)
		local ModelValue = Engine.GetModelValue(ModelRef)
		if ModelValue then
			f2_local27:setAlpha(ModelValue)
		end
	end)
	Widget.clipsPerState = {DefaultState = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(1)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(1)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -0.5, 27)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.5)
		Widget.VSpanel:setAlpha(0.5)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(1)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.96, 1, 0.33)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(1)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.96, 1, 0.33)
		Widget.gamertag:setAlpha(1)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(1)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(1)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(0)
		Widget.clipFinished(f2_local26, {})
	end, Focus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -5, 32)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -7, 33)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		Widget.clipFinished(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, GainFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -14, 14)
		Widget.FEMemberBlurPanelContainer0:setAlpha(0)
		local f68_local0 = function (f206_arg0, f206_arg1)
			if not f206_arg1.interrupted then
				f206_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f206_arg0:setLeftRight(true, true, 60, -82)
			f206_arg0:setTopBottom(false, false, -18, 18)
			f206_arg0:setAlpha(1)
			if f206_arg1.interrupted then
				Widget.clipFinished(f206_arg0, f206_arg1)
			else
				f206_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		Widget.VSpanel:setAlpha(0.5)
		local f68_local1 = function (f207_arg0, f207_arg1)
			if not f207_arg1.interrupted then
				f207_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f207_arg0:setLeftRight(true, true, 60, -82)
			f207_arg0:setTopBottom(false, false, -18, 18)
			f207_arg0:setAlpha(0.5)
			if f207_arg1.interrupted then
				Widget.clipFinished(f207_arg0, f207_arg1)
			else
				f207_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setZoom(0)
		local f68_local2 = function (f208_arg0, f208_arg1)
			if not f208_arg1.interrupted then
				f208_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f208_arg0:setLeftRight(true, false, 60, 408)
			f208_arg0:setTopBottom(true, false, -4.5, 31.5)
			f208_arg0:setZoom(0)
			if f208_arg1.interrupted then
				Widget.clipFinished(f208_arg0, f208_arg1)
			else
				f208_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f68_local3 = function (f209_arg0, f209_arg1)
			if not f209_arg1.interrupted then
				f209_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f209_arg0:setLeftRight(true, false, 60, 408)
			f209_arg0:setTopBottom(true, false, -5, 32)
			f209_arg0:setZoom(0)
			if f209_arg1.interrupted then
				Widget.clipFinished(f209_arg0, f209_arg1)
			else
				f209_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 12, 15)
		Widget.FocusBarB:setAlpha(0)
		local f68_local4 = function (f210_arg0, f210_arg1)
			if not f210_arg1.interrupted then
				f210_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f210_arg0:setLeftRight(true, false, 58, 410)
			f210_arg0:setTopBottom(true, false, 29, 33)
			f210_arg0:setAlpha(1)
			if f210_arg1.interrupted then
				Widget.clipFinished(f210_arg0, f210_arg1)
			else
				f210_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local4(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 59, 410)
		Widget.FocusBarT:setTopBottom(true, false, 12, 16)
		Widget.FocusBarT:setAlpha(0)
		local f68_local5 = function (f211_arg0, f211_arg1)
			if not f211_arg1.interrupted then
				f211_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f211_arg0:setLeftRight(true, false, 58, 410)
			f211_arg0:setTopBottom(true, false, -6, -2)
			f211_arg0:setAlpha(1)
			if f211_arg1.interrupted then
				Widget.clipFinished(f211_arg0, f211_arg1)
			else
				f211_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local5(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, LoseFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -4.5, 31.5)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		local f69_local0 = function (f212_arg0, f212_arg1)
			if not f212_arg1.interrupted then
				f212_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f212_arg0:setLeftRight(true, false, 60, 408)
			f212_arg0:setTopBottom(true, false, -0.5, 27.5)
			f212_arg0:setAlpha(0)
			if f212_arg1.interrupted then
				Widget.clipFinished(f212_arg0, f212_arg1)
			else
				f212_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.VSpanel:setAlpha(0.5)
		local f69_local1 = function (f213_arg0, f213_arg1)
			if not f213_arg1.interrupted then
				f213_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f213_arg0:setLeftRight(true, true, 60, -82)
			f213_arg0:setTopBottom(false, false, -14, 13.8)
			f213_arg0:setAlpha(0.5)
			if f213_arg1.interrupted then
				Widget.clipFinished(f213_arg0, f213_arg1)
			else
				f213_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -4.5, 31.5)
		Widget.LobbyMemberBacking:setZoom(0)
		local f69_local2 = function (f214_arg0, f214_arg1)
			if not f214_arg1.interrupted then
				f214_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f214_arg0:setLeftRight(true, false, 60, 408)
			f214_arg0:setTopBottom(true, false, -0.5, 27)
			f214_arg0:setZoom(0)
			if f214_arg1.interrupted then
				Widget.clipFinished(f214_arg0, f214_arg1)
			else
				f214_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -5, 32)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f69_local3 = function (f215_arg0, f215_arg1)
			if not f215_arg1.interrupted then
				f215_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f215_arg0:setLeftRight(true, false, 60, 408)
			f215_arg0:setTopBottom(true, false, -0.5, 27.5)
			f215_arg0:setZoom(0)
			if f215_arg1.interrupted then
				Widget.clipFinished(f215_arg0, f215_arg1)
			else
				f215_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		local f69_local4 = function (f216_arg0, f216_arg1)
			if not f216_arg1.interrupted then
				f216_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f216_arg0:setScale(1)
			if f216_arg1.interrupted then
				Widget.clipFinished(f216_arg0, f216_arg1)
			else
				f216_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local4(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		local f69_local5 = function (f217_arg0, f217_arg1)
			if not f217_arg1.interrupted then
				f217_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f217_arg0:setLeftRight(true, false, 58, 410)
			f217_arg0:setTopBottom(true, false, 12, 15)
			f217_arg0:setAlpha(0)
			if f217_arg1.interrupted then
				Widget.clipFinished(f217_arg0, f217_arg1)
			else
				f217_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local5(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		local f69_local6 = function (f218_arg0, f218_arg1)
			if not f218_arg1.interrupted then
				f218_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f218_arg0:setLeftRight(true, false, 59, 410)
			f218_arg0:setTopBottom(true, false, 12, 16)
			f218_arg0:setAlpha(0)
			if f218_arg1.interrupted then
				Widget.clipFinished(f218_arg0, f218_arg1)
			else
				f218_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local6(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, Intro = function ()
		Widget:setupElementClipCounter(8)
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		local f70_local0 = function (f219_arg0, f219_arg1)
			if not f219_arg1.interrupted then
				f219_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f219_arg0:setAlpha(1)
			if f219_arg1.interrupted then
				Widget.clipFinished(f219_arg0, f219_arg1)
			else
				f219_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f70_local0(f2_local4, {})
		f2_local9:completeAnimation()
		Widget.rank:setAlpha(0)
		local f70_local1 = function (f220_arg0, f220_arg1)
			local f220_local0 = function (f224_arg0, f224_arg1)
				if not f224_arg1.interrupted then
					f224_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f224_arg0:setAlpha(1)
				if f224_arg1.interrupted then
					Widget.clipFinished(f224_arg0, f224_arg1)
				else
					f224_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f220_arg1.interrupted then
				f220_local0(f220_arg0, f220_arg1)
				return 
			else
				f220_arg0:beginAnimation("keyframe", 70, false, false, CoD.TweenType.Linear)
				f220_arg0:registerEventHandler("transition_complete_keyframe", f220_local0)
			end
		end

		f70_local1(f2_local9, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		local f70_local2 = function (f221_arg0, f221_arg1)
			if not f221_arg1.interrupted then
				f221_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f221_arg0:setAlpha(1)
			if f221_arg1.interrupted then
				Widget.clipFinished(f221_arg0, f221_arg1)
			else
				f221_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f70_local2(f2_local17, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setAlpha(0)
		local f70_local3 = function (f222_arg0, f222_arg1)
			local f222_local0 = function (f225_arg0, f225_arg1)
				if not f225_arg1.interrupted then
					f225_arg0:beginAnimation("keyframe", 299, false, false, CoD.TweenType.Bounce)
				end
				f225_arg0:setAlpha(1)
				if f225_arg1.interrupted then
					Widget.clipFinished(f225_arg0, f225_arg1)
				else
					f225_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f222_arg1.interrupted then
				f222_local0(f222_arg0, f222_arg1)
				return 
			else
				f222_arg0:beginAnimation("keyframe", 119, false, false, CoD.TweenType.Linear)
				f222_arg0:registerEventHandler("transition_complete_keyframe", f222_local0)
			end
		end

		f70_local3(f2_local19, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		local f70_local4 = function (f223_arg0, f223_arg1)
			local f223_local0 = function (f226_arg0, f226_arg1)
				if not f226_arg1.interrupted then
					f226_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f226_arg0:setAlpha(1)
				if f226_arg1.interrupted then
					Widget.clipFinished(f226_arg0, f226_arg1)
				else
					f226_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f223_arg1.interrupted then
				f223_local0(f223_arg0, f223_arg1)
				return 
			else
				f223_arg0:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
				f223_arg0:registerEventHandler("transition_complete_keyframe", f223_local0)
			end
		end

		f70_local4(f2_local21, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end}, IsSelfZombies = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(1)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(1)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -0.5, 27)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.5)
		Widget.VSpanel:setAlpha(0.5)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(1)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.96, 1, 0.33)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(1)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.96, 1, 0.33)
		Widget.gamertag:setAlpha(1)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(1)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(1)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(0)
		Widget.clipFinished(f2_local26, {})
	end, Focus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -5, 32)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -7, 33)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		Widget.clipFinished(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, GainFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -14, 14)
		Widget.FEMemberBlurPanelContainer0:setAlpha(0)
		local f68_local0 = function (f206_arg0, f206_arg1)
			if not f206_arg1.interrupted then
				f206_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f206_arg0:setLeftRight(true, true, 60, -82)
			f206_arg0:setTopBottom(false, false, -18, 18)
			f206_arg0:setAlpha(1)
			if f206_arg1.interrupted then
				Widget.clipFinished(f206_arg0, f206_arg1)
			else
				f206_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		Widget.VSpanel:setAlpha(0.5)
		local f68_local1 = function (f207_arg0, f207_arg1)
			if not f207_arg1.interrupted then
				f207_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f207_arg0:setLeftRight(true, true, 60, -82)
			f207_arg0:setTopBottom(false, false, -18, 18)
			f207_arg0:setAlpha(0.5)
			if f207_arg1.interrupted then
				Widget.clipFinished(f207_arg0, f207_arg1)
			else
				f207_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setZoom(0)
		local f68_local2 = function (f208_arg0, f208_arg1)
			if not f208_arg1.interrupted then
				f208_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f208_arg0:setLeftRight(true, false, 60, 408)
			f208_arg0:setTopBottom(true, false, -4.5, 31.5)
			f208_arg0:setZoom(0)
			if f208_arg1.interrupted then
				Widget.clipFinished(f208_arg0, f208_arg1)
			else
				f208_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f68_local3 = function (f209_arg0, f209_arg1)
			if not f209_arg1.interrupted then
				f209_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f209_arg0:setLeftRight(true, false, 60, 408)
			f209_arg0:setTopBottom(true, false, -5, 32)
			f209_arg0:setZoom(0)
			if f209_arg1.interrupted then
				Widget.clipFinished(f209_arg0, f209_arg1)
			else
				f209_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 12, 15)
		Widget.FocusBarB:setAlpha(0)
		local f68_local4 = function (f210_arg0, f210_arg1)
			if not f210_arg1.interrupted then
				f210_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f210_arg0:setLeftRight(true, false, 58, 410)
			f210_arg0:setTopBottom(true, false, 29, 33)
			f210_arg0:setAlpha(1)
			if f210_arg1.interrupted then
				Widget.clipFinished(f210_arg0, f210_arg1)
			else
				f210_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local4(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 59, 410)
		Widget.FocusBarT:setTopBottom(true, false, 12, 16)
		Widget.FocusBarT:setAlpha(0)
		local f68_local5 = function (f211_arg0, f211_arg1)
			if not f211_arg1.interrupted then
				f211_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f211_arg0:setLeftRight(true, false, 58, 410)
			f211_arg0:setTopBottom(true, false, -6, -2)
			f211_arg0:setAlpha(1)
			if f211_arg1.interrupted then
				Widget.clipFinished(f211_arg0, f211_arg1)
			else
				f211_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local5(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, LoseFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -4.5, 31.5)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		local f69_local0 = function (f212_arg0, f212_arg1)
			if not f212_arg1.interrupted then
				f212_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f212_arg0:setLeftRight(true, false, 60, 408)
			f212_arg0:setTopBottom(true, false, -0.5, 27.5)
			f212_arg0:setAlpha(0)
			if f212_arg1.interrupted then
				Widget.clipFinished(f212_arg0, f212_arg1)
			else
				f212_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.VSpanel:setAlpha(0.5)
		local f69_local1 = function (f213_arg0, f213_arg1)
			if not f213_arg1.interrupted then
				f213_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f213_arg0:setLeftRight(true, true, 60, -82)
			f213_arg0:setTopBottom(false, false, -14, 13.8)
			f213_arg0:setAlpha(0.5)
			if f213_arg1.interrupted then
				Widget.clipFinished(f213_arg0, f213_arg1)
			else
				f213_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -4.5, 31.5)
		Widget.LobbyMemberBacking:setZoom(0)
		local f69_local2 = function (f214_arg0, f214_arg1)
			if not f214_arg1.interrupted then
				f214_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f214_arg0:setLeftRight(true, false, 60, 408)
			f214_arg0:setTopBottom(true, false, -0.5, 27)
			f214_arg0:setZoom(0)
			if f214_arg1.interrupted then
				Widget.clipFinished(f214_arg0, f214_arg1)
			else
				f214_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -5, 32)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f69_local3 = function (f215_arg0, f215_arg1)
			if not f215_arg1.interrupted then
				f215_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f215_arg0:setLeftRight(true, false, 60, 408)
			f215_arg0:setTopBottom(true, false, -0.5, 27.5)
			f215_arg0:setZoom(0)
			if f215_arg1.interrupted then
				Widget.clipFinished(f215_arg0, f215_arg1)
			else
				f215_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		local f69_local4 = function (f216_arg0, f216_arg1)
			if not f216_arg1.interrupted then
				f216_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f216_arg0:setScale(1)
			if f216_arg1.interrupted then
				Widget.clipFinished(f216_arg0, f216_arg1)
			else
				f216_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local4(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		local f69_local5 = function (f217_arg0, f217_arg1)
			if not f217_arg1.interrupted then
				f217_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f217_arg0:setLeftRight(true, false, 58, 410)
			f217_arg0:setTopBottom(true, false, 12, 15)
			f217_arg0:setAlpha(0)
			if f217_arg1.interrupted then
				Widget.clipFinished(f217_arg0, f217_arg1)
			else
				f217_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local5(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		local f69_local6 = function (f218_arg0, f218_arg1)
			if not f218_arg1.interrupted then
				f218_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f218_arg0:setLeftRight(true, false, 59, 410)
			f218_arg0:setTopBottom(true, false, 12, 16)
			f218_arg0:setAlpha(0)
			if f218_arg1.interrupted then
				Widget.clipFinished(f218_arg0, f218_arg1)
			else
				f218_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local6(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, Intro = function ()
		Widget:setupElementClipCounter(8)
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		local f70_local0 = function (f219_arg0, f219_arg1)
			if not f219_arg1.interrupted then
				f219_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f219_arg0:setAlpha(1)
			if f219_arg1.interrupted then
				Widget.clipFinished(f219_arg0, f219_arg1)
			else
				f219_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f70_local0(f2_local4, {})
		f2_local9:completeAnimation()
		Widget.rank:setAlpha(0)
		local f70_local1 = function (f220_arg0, f220_arg1)
			local f220_local0 = function (f224_arg0, f224_arg1)
				if not f224_arg1.interrupted then
					f224_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f224_arg0:setAlpha(1)
				if f224_arg1.interrupted then
					Widget.clipFinished(f224_arg0, f224_arg1)
				else
					f224_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f220_arg1.interrupted then
				f220_local0(f220_arg0, f220_arg1)
				return 
			else
				f220_arg0:beginAnimation("keyframe", 70, false, false, CoD.TweenType.Linear)
				f220_arg0:registerEventHandler("transition_complete_keyframe", f220_local0)
			end
		end

		f70_local1(f2_local9, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		local f70_local2 = function (f221_arg0, f221_arg1)
			if not f221_arg1.interrupted then
				f221_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f221_arg0:setAlpha(1)
			if f221_arg1.interrupted then
				Widget.clipFinished(f221_arg0, f221_arg1)
			else
				f221_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f70_local2(f2_local17, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setAlpha(0)
		local f70_local3 = function (f222_arg0, f222_arg1)
			local f222_local0 = function (f225_arg0, f225_arg1)
				if not f225_arg1.interrupted then
					f225_arg0:beginAnimation("keyframe", 299, false, false, CoD.TweenType.Bounce)
				end
				f225_arg0:setAlpha(1)
				if f225_arg1.interrupted then
					Widget.clipFinished(f225_arg0, f225_arg1)
				else
					f225_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f222_arg1.interrupted then
				f222_local0(f222_arg0, f222_arg1)
				return 
			else
				f222_arg0:beginAnimation("keyframe", 119, false, false, CoD.TweenType.Linear)
				f222_arg0:registerEventHandler("transition_complete_keyframe", f222_local0)
			end
		end

		f70_local3(f2_local19, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		local f70_local4 = function (f223_arg0, f223_arg1)
			local f223_local0 = function (f226_arg0, f226_arg1)
				if not f226_arg1.interrupted then
					f226_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f226_arg0:setAlpha(1)
				if f226_arg1.interrupted then
					Widget.clipFinished(f226_arg0, f226_arg1)
				else
					f226_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f223_arg1.interrupted then
				f223_local0(f223_arg0, f223_arg1)
				return 
			else
				f223_arg0:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
				f223_arg0:registerEventHandler("transition_complete_keyframe", f223_local0)
			end
		end

		f70_local4(f2_local21, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end}, IsPartyMemberZombies = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(1)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(1)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -0.5, 27)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.5)
		Widget.VSpanel:setAlpha(0.5)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(1)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.96, 1, 0.33)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(1)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.96, 1, 0.33)
		Widget.gamertag:setAlpha(1)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(1)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(1)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(0)
		Widget.clipFinished(f2_local26, {})
	end, Focus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -5, 32)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -7, 33)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		Widget.clipFinished(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, GainFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -14, 14)
		Widget.FEMemberBlurPanelContainer0:setAlpha(0)
		local f68_local0 = function (f206_arg0, f206_arg1)
			if not f206_arg1.interrupted then
				f206_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f206_arg0:setLeftRight(true, true, 60, -82)
			f206_arg0:setTopBottom(false, false, -18, 18)
			f206_arg0:setAlpha(1)
			if f206_arg1.interrupted then
				Widget.clipFinished(f206_arg0, f206_arg1)
			else
				f206_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		Widget.VSpanel:setAlpha(0.5)
		local f68_local1 = function (f207_arg0, f207_arg1)
			if not f207_arg1.interrupted then
				f207_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f207_arg0:setLeftRight(true, true, 60, -82)
			f207_arg0:setTopBottom(false, false, -18, 18)
			f207_arg0:setAlpha(0.5)
			if f207_arg1.interrupted then
				Widget.clipFinished(f207_arg0, f207_arg1)
			else
				f207_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setZoom(0)
		local f68_local2 = function (f208_arg0, f208_arg1)
			if not f208_arg1.interrupted then
				f208_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f208_arg0:setLeftRight(true, false, 60, 408)
			f208_arg0:setTopBottom(true, false, -4.5, 31.5)
			f208_arg0:setZoom(0)
			if f208_arg1.interrupted then
				Widget.clipFinished(f208_arg0, f208_arg1)
			else
				f208_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f68_local3 = function (f209_arg0, f209_arg1)
			if not f209_arg1.interrupted then
				f209_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f209_arg0:setLeftRight(true, false, 60, 408)
			f209_arg0:setTopBottom(true, false, -5, 32)
			f209_arg0:setZoom(0)
			if f209_arg1.interrupted then
				Widget.clipFinished(f209_arg0, f209_arg1)
			else
				f209_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 12, 15)
		Widget.FocusBarB:setAlpha(0)
		local f68_local4 = function (f210_arg0, f210_arg1)
			if not f210_arg1.interrupted then
				f210_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f210_arg0:setLeftRight(true, false, 58, 410)
			f210_arg0:setTopBottom(true, false, 29, 33)
			f210_arg0:setAlpha(1)
			if f210_arg1.interrupted then
				Widget.clipFinished(f210_arg0, f210_arg1)
			else
				f210_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local4(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 59, 410)
		Widget.FocusBarT:setTopBottom(true, false, 12, 16)
		Widget.FocusBarT:setAlpha(0)
		local f68_local5 = function (f211_arg0, f211_arg1)
			if not f211_arg1.interrupted then
				f211_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f211_arg0:setLeftRight(true, false, 58, 410)
			f211_arg0:setTopBottom(true, false, -6, -2)
			f211_arg0:setAlpha(1)
			if f211_arg1.interrupted then
				Widget.clipFinished(f211_arg0, f211_arg1)
			else
				f211_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local5(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, LoseFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -4.5, 31.5)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		local f69_local0 = function (f212_arg0, f212_arg1)
			if not f212_arg1.interrupted then
				f212_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f212_arg0:setLeftRight(true, false, 60, 408)
			f212_arg0:setTopBottom(true, false, -0.5, 27.5)
			f212_arg0:setAlpha(0)
			if f212_arg1.interrupted then
				Widget.clipFinished(f212_arg0, f212_arg1)
			else
				f212_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.VSpanel:setAlpha(0.5)
		local f69_local1 = function (f213_arg0, f213_arg1)
			if not f213_arg1.interrupted then
				f213_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f213_arg0:setLeftRight(true, true, 60, -82)
			f213_arg0:setTopBottom(false, false, -14, 13.8)
			f213_arg0:setAlpha(0.5)
			if f213_arg1.interrupted then
				Widget.clipFinished(f213_arg0, f213_arg1)
			else
				f213_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -4.5, 31.5)
		Widget.LobbyMemberBacking:setZoom(0)
		local f69_local2 = function (f214_arg0, f214_arg1)
			if not f214_arg1.interrupted then
				f214_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f214_arg0:setLeftRight(true, false, 60, 408)
			f214_arg0:setTopBottom(true, false, -0.5, 27)
			f214_arg0:setZoom(0)
			if f214_arg1.interrupted then
				Widget.clipFinished(f214_arg0, f214_arg1)
			else
				f214_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -5, 32)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f69_local3 = function (f215_arg0, f215_arg1)
			if not f215_arg1.interrupted then
				f215_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f215_arg0:setLeftRight(true, false, 60, 408)
			f215_arg0:setTopBottom(true, false, -0.5, 27.5)
			f215_arg0:setZoom(0)
			if f215_arg1.interrupted then
				Widget.clipFinished(f215_arg0, f215_arg1)
			else
				f215_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		local f69_local4 = function (f216_arg0, f216_arg1)
			if not f216_arg1.interrupted then
				f216_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f216_arg0:setScale(1)
			if f216_arg1.interrupted then
				Widget.clipFinished(f216_arg0, f216_arg1)
			else
				f216_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local4(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		local f69_local5 = function (f217_arg0, f217_arg1)
			if not f217_arg1.interrupted then
				f217_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f217_arg0:setLeftRight(true, false, 58, 410)
			f217_arg0:setTopBottom(true, false, 12, 15)
			f217_arg0:setAlpha(0)
			if f217_arg1.interrupted then
				Widget.clipFinished(f217_arg0, f217_arg1)
			else
				f217_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local5(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		local f69_local6 = function (f218_arg0, f218_arg1)
			if not f218_arg1.interrupted then
				f218_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f218_arg0:setLeftRight(true, false, 59, 410)
			f218_arg0:setTopBottom(true, false, 12, 16)
			f218_arg0:setAlpha(0)
			if f218_arg1.interrupted then
				Widget.clipFinished(f218_arg0, f218_arg1)
			else
				f218_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local6(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, Intro = function ()
		Widget:setupElementClipCounter(8)
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		local f70_local0 = function (f219_arg0, f219_arg1)
			if not f219_arg1.interrupted then
				f219_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f219_arg0:setAlpha(1)
			if f219_arg1.interrupted then
				Widget.clipFinished(f219_arg0, f219_arg1)
			else
				f219_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f70_local0(f2_local4, {})
		f2_local9:completeAnimation()
		Widget.rank:setAlpha(0)
		local f70_local1 = function (f220_arg0, f220_arg1)
			local f220_local0 = function (f224_arg0, f224_arg1)
				if not f224_arg1.interrupted then
					f224_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f224_arg0:setAlpha(1)
				if f224_arg1.interrupted then
					Widget.clipFinished(f224_arg0, f224_arg1)
				else
					f224_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f220_arg1.interrupted then
				f220_local0(f220_arg0, f220_arg1)
				return 
			else
				f220_arg0:beginAnimation("keyframe", 70, false, false, CoD.TweenType.Linear)
				f220_arg0:registerEventHandler("transition_complete_keyframe", f220_local0)
			end
		end

		f70_local1(f2_local9, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		local f70_local2 = function (f221_arg0, f221_arg1)
			if not f221_arg1.interrupted then
				f221_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f221_arg0:setAlpha(1)
			if f221_arg1.interrupted then
				Widget.clipFinished(f221_arg0, f221_arg1)
			else
				f221_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f70_local2(f2_local17, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setAlpha(0)
		local f70_local3 = function (f222_arg0, f222_arg1)
			local f222_local0 = function (f225_arg0, f225_arg1)
				if not f225_arg1.interrupted then
					f225_arg0:beginAnimation("keyframe", 299, false, false, CoD.TweenType.Bounce)
				end
				f225_arg0:setAlpha(1)
				if f225_arg1.interrupted then
					Widget.clipFinished(f225_arg0, f225_arg1)
				else
					f225_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f222_arg1.interrupted then
				f222_local0(f222_arg0, f222_arg1)
				return 
			else
				f222_arg0:beginAnimation("keyframe", 119, false, false, CoD.TweenType.Linear)
				f222_arg0:registerEventHandler("transition_complete_keyframe", f222_local0)
			end
		end

		f70_local3(f2_local19, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		local f70_local4 = function (f223_arg0, f223_arg1)
			local f223_local0 = function (f226_arg0, f226_arg1)
				if not f226_arg1.interrupted then
					f226_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f226_arg0:setAlpha(1)
				if f226_arg1.interrupted then
					Widget.clipFinished(f226_arg0, f226_arg1)
				else
					f226_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f223_arg1.interrupted then
				f223_local0(f223_arg0, f223_arg1)
				return 
			else
				f223_arg0:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
				f223_arg0:registerEventHandler("transition_complete_keyframe", f223_local0)
			end
		end

		f70_local4(f2_local21, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end}, IsDOA = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(1)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(1)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -0.5, 27)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.5)
		Widget.VSpanel:setAlpha(0.5)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(1)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.96, 1, 0.33)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(1)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.96, 1, 0.33)
		Widget.gamertag:setAlpha(1)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(1)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(1)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(1)
		Widget.clipFinished(f2_local26, {})
	end, Focus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -5, 32)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -7, 33)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		Widget.clipFinished(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, GainFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -14, 14)
		Widget.FEMemberBlurPanelContainer0:setAlpha(0)
		local f58_local0 = function (f164_arg0, f164_arg1)
			if not f164_arg1.interrupted then
				f164_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f164_arg0:setLeftRight(true, true, 60, -82)
			f164_arg0:setTopBottom(false, false, -18, 18)
			f164_arg0:setAlpha(1)
			if f164_arg1.interrupted then
				Widget.clipFinished(f164_arg0, f164_arg1)
			else
				f164_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f58_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		Widget.VSpanel:setAlpha(0.5)
		local f58_local1 = function (f165_arg0, f165_arg1)
			if not f165_arg1.interrupted then
				f165_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f165_arg0:setLeftRight(true, true, 60, -82)
			f165_arg0:setTopBottom(false, false, -18, 18)
			f165_arg0:setAlpha(0.5)
			if f165_arg1.interrupted then
				Widget.clipFinished(f165_arg0, f165_arg1)
			else
				f165_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f58_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setZoom(0)
		local f58_local2 = function (f166_arg0, f166_arg1)
			if not f166_arg1.interrupted then
				f166_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f166_arg0:setLeftRight(true, false, 60, 408)
			f166_arg0:setTopBottom(true, false, -4.5, 31.5)
			f166_arg0:setZoom(0)
			if f166_arg1.interrupted then
				Widget.clipFinished(f166_arg0, f166_arg1)
			else
				f166_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f58_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f58_local3 = function (f167_arg0, f167_arg1)
			if not f167_arg1.interrupted then
				f167_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f167_arg0:setLeftRight(true, false, 60, 408)
			f167_arg0:setTopBottom(true, false, -5, 32)
			f167_arg0:setZoom(0)
			if f167_arg1.interrupted then
				Widget.clipFinished(f167_arg0, f167_arg1)
			else
				f167_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f58_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 12, 15)
		Widget.FocusBarB:setAlpha(0)
		local f58_local4 = function (f168_arg0, f168_arg1)
			if not f168_arg1.interrupted then
				f168_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f168_arg0:setLeftRight(true, false, 58, 410)
			f168_arg0:setTopBottom(true, false, 29, 33)
			f168_arg0:setAlpha(1)
			if f168_arg1.interrupted then
				Widget.clipFinished(f168_arg0, f168_arg1)
			else
				f168_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f58_local4(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 59, 410)
		Widget.FocusBarT:setTopBottom(true, false, 12, 16)
		Widget.FocusBarT:setAlpha(0)
		local f58_local5 = function (f169_arg0, f169_arg1)
			if not f169_arg1.interrupted then
				f169_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f169_arg0:setLeftRight(true, false, 58, 410)
			f169_arg0:setTopBottom(true, false, -6, -2)
			f169_arg0:setAlpha(1)
			if f169_arg1.interrupted then
				Widget.clipFinished(f169_arg0, f169_arg1)
			else
				f169_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f58_local5(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, LoseFocus = function ()
		Widget:setupElementClipCounter(11)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -18.5, 18.5)
		local f44_local0 = function (f111_arg0, f111_arg1)
			if not f111_arg1.interrupted then
				f111_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f111_arg0:setLeftRight(true, true, 60, -82)
			f111_arg0:setTopBottom(false, false, -14, 13.5)
			if f111_arg1.interrupted then
				Widget.clipFinished(f111_arg0, f111_arg1)
			else
				f111_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f44_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		local f44_local1 = function (f112_arg0, f112_arg1)
			if not f112_arg1.interrupted then
				f112_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f112_arg0:setLeftRight(true, true, 60, -82)
			f112_arg0:setTopBottom(false, false, -14, 13.8)
			if f112_arg1.interrupted then
				Widget.clipFinished(f112_arg0, f112_arg1)
			else
				f112_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f44_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -5, 32)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		local f44_local2 = function (f113_arg0, f113_arg1)
			if not f113_arg1.interrupted then
				f113_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f113_arg0:setLeftRight(true, false, 60, 408)
			f113_arg0:setTopBottom(true, false, -0.5, 27)
			f113_arg0:setAlpha(0)
			f113_arg0:setZoom(0)
			if f113_arg1.interrupted then
				Widget.clipFinished(f113_arg0, f113_arg1)
			else
				f113_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f44_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -5, 32)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f44_local3 = function (f114_arg0, f114_arg1)
			if not f114_arg1.interrupted then
				f114_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f114_arg0:setLeftRight(true, false, 60, 408)
			f114_arg0:setTopBottom(true, false, -0.5, 27.5)
			f114_arg0:setZoom(0)
			if f114_arg1.interrupted then
				Widget.clipFinished(f114_arg0, f114_arg1)
			else
				f114_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f44_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		local f44_local4 = function (f115_arg0, f115_arg1)
			if not f115_arg1.interrupted then
				f115_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f115_arg0:setScale(1)
			if f115_arg1.interrupted then
				Widget.clipFinished(f115_arg0, f115_arg1)
			else
				f115_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f44_local4(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		local f44_local5 = function (f116_arg0, f116_arg1)
			if not f116_arg1.interrupted then
				f116_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f116_arg0:setLeftRight(true, false, 58, 410)
			f116_arg0:setTopBottom(true, false, 12, 15)
			f116_arg0:setAlpha(0)
			if f116_arg1.interrupted then
				Widget.clipFinished(f116_arg0, f116_arg1)
			else
				f116_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f44_local5(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		local f44_local6 = function (f117_arg0, f117_arg1)
			if not f117_arg1.interrupted then
				f117_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f117_arg0:setLeftRight(true, false, 59, 410)
			f117_arg0:setTopBottom(true, false, 12, 16)
			f117_arg0:setAlpha(0)
			if f117_arg1.interrupted then
				Widget.clipFinished(f117_arg0, f117_arg1)
			else
				f117_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f44_local6(f2_local16, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setAlpha(1)
		Widget.clipFinished(f2_local19, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, Intro = function ()
		Widget:setupElementClipCounter(8)
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		local f60_local0 = function (f177_arg0, f177_arg1)
			if not f177_arg1.interrupted then
				f177_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f177_arg0:setAlpha(1)
			if f177_arg1.interrupted then
				Widget.clipFinished(f177_arg0, f177_arg1)
			else
				f177_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f60_local0(f2_local4, {})
		f2_local9:completeAnimation()
		Widget.rank:setAlpha(0)
		local f60_local1 = function (f178_arg0, f178_arg1)
			local f178_local0 = function (f182_arg0, f182_arg1)
				if not f182_arg1.interrupted then
					f182_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f182_arg0:setAlpha(1)
				if f182_arg1.interrupted then
					Widget.clipFinished(f182_arg0, f182_arg1)
				else
					f182_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f178_arg1.interrupted then
				f178_local0(f178_arg0, f178_arg1)
				return 
			else
				f178_arg0:beginAnimation("keyframe", 70, false, false, CoD.TweenType.Linear)
				f178_arg0:registerEventHandler("transition_complete_keyframe", f178_local0)
			end
		end

		f60_local1(f2_local9, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		local f60_local2 = function (f179_arg0, f179_arg1)
			if not f179_arg1.interrupted then
				f179_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f179_arg0:setAlpha(1)
			if f179_arg1.interrupted then
				Widget.clipFinished(f179_arg0, f179_arg1)
			else
				f179_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f60_local2(f2_local17, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setAlpha(0)
		local f60_local3 = function (f180_arg0, f180_arg1)
			local f180_local0 = function (f183_arg0, f183_arg1)
				if not f183_arg1.interrupted then
					f183_arg0:beginAnimation("keyframe", 299, false, false, CoD.TweenType.Bounce)
				end
				f183_arg0:setAlpha(1)
				if f183_arg1.interrupted then
					Widget.clipFinished(f183_arg0, f183_arg1)
				else
					f183_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f180_arg1.interrupted then
				f180_local0(f180_arg0, f180_arg1)
				return 
			else
				f180_arg0:beginAnimation("keyframe", 119, false, false, CoD.TweenType.Linear)
				f180_arg0:registerEventHandler("transition_complete_keyframe", f180_local0)
			end
		end

		f60_local3(f2_local19, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		local f60_local4 = function (f181_arg0, f181_arg1)
			local f181_local0 = function (f184_arg0, f184_arg1)
				if not f184_arg1.interrupted then
					f184_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f184_arg0:setAlpha(1)
				if f184_arg1.interrupted then
					Widget.clipFinished(f184_arg0, f184_arg1)
				else
					f184_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f181_arg1.interrupted then
				f181_local0(f181_arg0, f181_arg1)
				return 
			else
				f181_arg0:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
				f181_arg0:registerEventHandler("transition_complete_keyframe", f181_local0)
			end
		end

		f60_local4(f2_local21, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end}, IsPartyMemberDOA = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(1)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(1)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -14, 13.5)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.5)
		Widget.VSpanel:setAlpha(0.5)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(1)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.96, 1, 0.33)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(1)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.96, 1, 0.33)
		Widget.gamertag:setAlpha(1)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(1)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(1)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(1)
		Widget.clipFinished(f2_local26, {})
	end, Focus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -5, 32)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -7, 33)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		Widget.clipFinished(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, GainFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -14, 14)
		Widget.FEMemberBlurPanelContainer0:setAlpha(0)
		local f63_local0 = function (f185_arg0, f185_arg1)
			if not f185_arg1.interrupted then
				f185_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f185_arg0:setLeftRight(true, true, 60, -82)
			f185_arg0:setTopBottom(false, false, -18, 18)
			f185_arg0:setAlpha(1)
			if f185_arg1.interrupted then
				Widget.clipFinished(f185_arg0, f185_arg1)
			else
				f185_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f63_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		Widget.VSpanel:setAlpha(0.5)
		local f63_local1 = function (f186_arg0, f186_arg1)
			if not f186_arg1.interrupted then
				f186_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f186_arg0:setLeftRight(true, true, 60, -82)
			f186_arg0:setTopBottom(false, false, -18, 18)
			f186_arg0:setAlpha(0.5)
			if f186_arg1.interrupted then
				Widget.clipFinished(f186_arg0, f186_arg1)
			else
				f186_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f63_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setZoom(0)
		local f63_local2 = function (f187_arg0, f187_arg1)
			if not f187_arg1.interrupted then
				f187_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f187_arg0:setLeftRight(true, false, 60, 408)
			f187_arg0:setTopBottom(true, false, -4.5, 31.5)
			f187_arg0:setZoom(0)
			if f187_arg1.interrupted then
				Widget.clipFinished(f187_arg0, f187_arg1)
			else
				f187_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f63_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f63_local3 = function (f188_arg0, f188_arg1)
			if not f188_arg1.interrupted then
				f188_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f188_arg0:setLeftRight(true, false, 60, 408)
			f188_arg0:setTopBottom(true, false, -5, 32)
			f188_arg0:setZoom(0)
			if f188_arg1.interrupted then
				Widget.clipFinished(f188_arg0, f188_arg1)
			else
				f188_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f63_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 12, 15)
		Widget.FocusBarB:setAlpha(0)
		local f63_local4 = function (f189_arg0, f189_arg1)
			if not f189_arg1.interrupted then
				f189_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f189_arg0:setLeftRight(true, false, 58, 410)
			f189_arg0:setTopBottom(true, false, 29, 33)
			f189_arg0:setAlpha(1)
			if f189_arg1.interrupted then
				Widget.clipFinished(f189_arg0, f189_arg1)
			else
				f189_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f63_local4(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 59, 410)
		Widget.FocusBarT:setTopBottom(true, false, 12, 16)
		Widget.FocusBarT:setAlpha(0)
		local f63_local5 = function (f190_arg0, f190_arg1)
			if not f190_arg1.interrupted then
				f190_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f190_arg0:setLeftRight(true, false, 58, 410)
			f190_arg0:setTopBottom(true, false, -6, -2)
			f190_arg0:setAlpha(1)
			if f190_arg1.interrupted then
				Widget.clipFinished(f190_arg0, f190_arg1)
			else
				f190_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f63_local5(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, LoseFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -4.5, 31.5)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		local f64_local0 = function (f191_arg0, f191_arg1)
			if not f191_arg1.interrupted then
				f191_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f191_arg0:setLeftRight(true, false, 60, 408)
			f191_arg0:setTopBottom(true, false, -0.5, 27.5)
			f191_arg0:setAlpha(0)
			if f191_arg1.interrupted then
				Widget.clipFinished(f191_arg0, f191_arg1)
			else
				f191_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f64_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.VSpanel:setAlpha(0.5)
		local f64_local1 = function (f192_arg0, f192_arg1)
			if not f192_arg1.interrupted then
				f192_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f192_arg0:setLeftRight(true, true, 60, -82)
			f192_arg0:setTopBottom(false, false, -14, 13.8)
			f192_arg0:setAlpha(0.5)
			if f192_arg1.interrupted then
				Widget.clipFinished(f192_arg0, f192_arg1)
			else
				f192_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f64_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -4.5, 31.5)
		Widget.LobbyMemberBacking:setZoom(0)
		local f64_local2 = function (f193_arg0, f193_arg1)
			if not f193_arg1.interrupted then
				f193_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f193_arg0:setLeftRight(true, false, 60, 408)
			f193_arg0:setTopBottom(true, false, -0.5, 27)
			f193_arg0:setZoom(0)
			if f193_arg1.interrupted then
				Widget.clipFinished(f193_arg0, f193_arg1)
			else
				f193_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f64_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -5, 32)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f64_local3 = function (f194_arg0, f194_arg1)
			if not f194_arg1.interrupted then
				f194_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f194_arg0:setLeftRight(true, false, 60, 408)
			f194_arg0:setTopBottom(true, false, -0.5, 27.5)
			f194_arg0:setZoom(0)
			if f194_arg1.interrupted then
				Widget.clipFinished(f194_arg0, f194_arg1)
			else
				f194_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f64_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		local f64_local4 = function (f195_arg0, f195_arg1)
			if not f195_arg1.interrupted then
				f195_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f195_arg0:setScale(1)
			if f195_arg1.interrupted then
				Widget.clipFinished(f195_arg0, f195_arg1)
			else
				f195_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f64_local4(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		local f64_local5 = function (f196_arg0, f196_arg1)
			if not f196_arg1.interrupted then
				f196_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f196_arg0:setLeftRight(true, false, 58, 410)
			f196_arg0:setTopBottom(true, false, 12, 15)
			f196_arg0:setAlpha(0)
			if f196_arg1.interrupted then
				Widget.clipFinished(f196_arg0, f196_arg1)
			else
				f196_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f64_local5(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		local f64_local6 = function (f197_arg0, f197_arg1)
			if not f197_arg1.interrupted then
				f197_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f197_arg0:setLeftRight(true, false, 59, 410)
			f197_arg0:setTopBottom(true, false, 12, 16)
			f197_arg0:setAlpha(0)
			if f197_arg1.interrupted then
				Widget.clipFinished(f197_arg0, f197_arg1)
			else
				f197_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f64_local6(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, Intro = function ()
		Widget:setupElementClipCounter(8)
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		local f65_local0 = function (f198_arg0, f198_arg1)
			if not f198_arg1.interrupted then
				f198_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f198_arg0:setAlpha(1)
			if f198_arg1.interrupted then
				Widget.clipFinished(f198_arg0, f198_arg1)
			else
				f198_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f65_local0(f2_local4, {})
		f2_local9:completeAnimation()
		Widget.rank:setAlpha(0)
		local f65_local1 = function (f199_arg0, f199_arg1)
			local f199_local0 = function (f203_arg0, f203_arg1)
				if not f203_arg1.interrupted then
					f203_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f203_arg0:setAlpha(1)
				if f203_arg1.interrupted then
					Widget.clipFinished(f203_arg0, f203_arg1)
				else
					f203_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f199_arg1.interrupted then
				f199_local0(f199_arg0, f199_arg1)
				return 
			else
				f199_arg0:beginAnimation("keyframe", 70, false, false, CoD.TweenType.Linear)
				f199_arg0:registerEventHandler("transition_complete_keyframe", f199_local0)
			end
		end

		f65_local1(f2_local9, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		local f65_local2 = function (f200_arg0, f200_arg1)
			if not f200_arg1.interrupted then
				f200_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f200_arg0:setAlpha(1)
			if f200_arg1.interrupted then
				Widget.clipFinished(f200_arg0, f200_arg1)
			else
				f200_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f65_local2(f2_local17, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setAlpha(0)
		local f65_local3 = function (f201_arg0, f201_arg1)
			local f201_local0 = function (f204_arg0, f204_arg1)
				if not f204_arg1.interrupted then
					f204_arg0:beginAnimation("keyframe", 299, false, false, CoD.TweenType.Bounce)
				end
				f204_arg0:setAlpha(1)
				if f204_arg1.interrupted then
					Widget.clipFinished(f204_arg0, f204_arg1)
				else
					f204_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f201_arg1.interrupted then
				f201_local0(f201_arg0, f201_arg1)
				return 
			else
				f201_arg0:beginAnimation("keyframe", 119, false, false, CoD.TweenType.Linear)
				f201_arg0:registerEventHandler("transition_complete_keyframe", f201_local0)
			end
		end

		f65_local3(f2_local19, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		local f65_local4 = function (f202_arg0, f202_arg1)
			local f202_local0 = function (f205_arg0, f205_arg1)
				if not f205_arg1.interrupted then
					f205_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f205_arg0:setAlpha(1)
				if f205_arg1.interrupted then
					Widget.clipFinished(f205_arg0, f205_arg1)
				else
					f205_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f202_arg1.interrupted then
				f202_local0(f202_arg0, f202_arg1)
				return 
			else
				f202_arg0:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
				f202_arg0:registerEventHandler("transition_complete_keyframe", f202_local0)
			end
		end

		f65_local4(f2_local21, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end}, IsSelf = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(1)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(1)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -0.5, 27)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.5)
		Widget.VSpanel:setAlpha(0.5)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(1)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.96, 1, 0.33)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(1)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.96, 1, 0.33)
		Widget.gamertag:setAlpha(1)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(1)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(1)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(0)
		Widget.clipFinished(f2_local26, {})
	end, Focus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -5, 32)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -7, 33)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		Widget.clipFinished(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, GainFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -14, 14)
		Widget.FEMemberBlurPanelContainer0:setAlpha(0)
		local f68_local0 = function (f206_arg0, f206_arg1)
			if not f206_arg1.interrupted then
				f206_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f206_arg0:setLeftRight(true, true, 60, -82)
			f206_arg0:setTopBottom(false, false, -18, 18)
			f206_arg0:setAlpha(1)
			if f206_arg1.interrupted then
				Widget.clipFinished(f206_arg0, f206_arg1)
			else
				f206_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		Widget.VSpanel:setAlpha(0.5)
		local f68_local1 = function (f207_arg0, f207_arg1)
			if not f207_arg1.interrupted then
				f207_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f207_arg0:setLeftRight(true, true, 60, -82)
			f207_arg0:setTopBottom(false, false, -18, 18)
			f207_arg0:setAlpha(0.5)
			if f207_arg1.interrupted then
				Widget.clipFinished(f207_arg0, f207_arg1)
			else
				f207_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setZoom(0)
		local f68_local2 = function (f208_arg0, f208_arg1)
			if not f208_arg1.interrupted then
				f208_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f208_arg0:setLeftRight(true, false, 60, 408)
			f208_arg0:setTopBottom(true, false, -4.5, 31.5)
			f208_arg0:setZoom(0)
			if f208_arg1.interrupted then
				Widget.clipFinished(f208_arg0, f208_arg1)
			else
				f208_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f68_local3 = function (f209_arg0, f209_arg1)
			if not f209_arg1.interrupted then
				f209_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f209_arg0:setLeftRight(true, false, 60, 408)
			f209_arg0:setTopBottom(true, false, -5, 32)
			f209_arg0:setZoom(0)
			if f209_arg1.interrupted then
				Widget.clipFinished(f209_arg0, f209_arg1)
			else
				f209_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 12, 15)
		Widget.FocusBarB:setAlpha(0)
		local f68_local4 = function (f210_arg0, f210_arg1)
			if not f210_arg1.interrupted then
				f210_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f210_arg0:setLeftRight(true, false, 58, 410)
			f210_arg0:setTopBottom(true, false, 29, 33)
			f210_arg0:setAlpha(1)
			if f210_arg1.interrupted then
				Widget.clipFinished(f210_arg0, f210_arg1)
			else
				f210_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local4(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 59, 410)
		Widget.FocusBarT:setTopBottom(true, false, 12, 16)
		Widget.FocusBarT:setAlpha(0)
		local f68_local5 = function (f211_arg0, f211_arg1)
			if not f211_arg1.interrupted then
				f211_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f211_arg0:setLeftRight(true, false, 58, 410)
			f211_arg0:setTopBottom(true, false, -6, -2)
			f211_arg0:setAlpha(1)
			if f211_arg1.interrupted then
				Widget.clipFinished(f211_arg0, f211_arg1)
			else
				f211_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f68_local5(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, LoseFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -4.5, 31.5)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		local f69_local0 = function (f212_arg0, f212_arg1)
			if not f212_arg1.interrupted then
				f212_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f212_arg0:setLeftRight(true, false, 60, 408)
			f212_arg0:setTopBottom(true, false, -0.5, 27.5)
			f212_arg0:setAlpha(0)
			if f212_arg1.interrupted then
				Widget.clipFinished(f212_arg0, f212_arg1)
			else
				f212_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		Widget.VSpanel:setAlpha(0.5)
		local f69_local1 = function (f213_arg0, f213_arg1)
			if not f213_arg1.interrupted then
				f213_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f213_arg0:setLeftRight(true, true, 60, -82)
			f213_arg0:setTopBottom(false, false, -14, 13.8)
			f213_arg0:setAlpha(0.5)
			if f213_arg1.interrupted then
				Widget.clipFinished(f213_arg0, f213_arg1)
			else
				f213_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -4.5, 31.5)
		Widget.LobbyMemberBacking:setZoom(0)
		local f69_local2 = function (f214_arg0, f214_arg1)
			if not f214_arg1.interrupted then
				f214_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f214_arg0:setLeftRight(true, false, 60, 408)
			f214_arg0:setTopBottom(true, false, -0.5, 27)
			f214_arg0:setZoom(0)
			if f214_arg1.interrupted then
				Widget.clipFinished(f214_arg0, f214_arg1)
			else
				f214_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -5, 32)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f69_local3 = function (f215_arg0, f215_arg1)
			if not f215_arg1.interrupted then
				f215_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f215_arg0:setLeftRight(true, false, 60, 408)
			f215_arg0:setTopBottom(true, false, -0.5, 27.5)
			f215_arg0:setZoom(0)
			if f215_arg1.interrupted then
				Widget.clipFinished(f215_arg0, f215_arg1)
			else
				f215_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		local f69_local4 = function (f216_arg0, f216_arg1)
			if not f216_arg1.interrupted then
				f216_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f216_arg0:setScale(1)
			if f216_arg1.interrupted then
				Widget.clipFinished(f216_arg0, f216_arg1)
			else
				f216_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local4(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		local f69_local5 = function (f217_arg0, f217_arg1)
			if not f217_arg1.interrupted then
				f217_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f217_arg0:setLeftRight(true, false, 58, 410)
			f217_arg0:setTopBottom(true, false, 12, 15)
			f217_arg0:setAlpha(0)
			if f217_arg1.interrupted then
				Widget.clipFinished(f217_arg0, f217_arg1)
			else
				f217_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local5(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		local f69_local6 = function (f218_arg0, f218_arg1)
			if not f218_arg1.interrupted then
				f218_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f218_arg0:setLeftRight(true, false, 59, 410)
			f218_arg0:setTopBottom(true, false, 12, 16)
			f218_arg0:setAlpha(0)
			if f218_arg1.interrupted then
				Widget.clipFinished(f218_arg0, f218_arg1)
			else
				f218_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f69_local6(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, Intro = function ()
		Widget:setupElementClipCounter(8)
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		local f70_local0 = function (f219_arg0, f219_arg1)
			if not f219_arg1.interrupted then
				f219_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f219_arg0:setAlpha(1)
			if f219_arg1.interrupted then
				Widget.clipFinished(f219_arg0, f219_arg1)
			else
				f219_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f70_local0(f2_local4, {})
		f2_local9:completeAnimation()
		Widget.rank:setAlpha(0)
		local f70_local1 = function (f220_arg0, f220_arg1)
			local f220_local0 = function (f224_arg0, f224_arg1)
				if not f224_arg1.interrupted then
					f224_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f224_arg0:setAlpha(1)
				if f224_arg1.interrupted then
					Widget.clipFinished(f224_arg0, f224_arg1)
				else
					f224_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f220_arg1.interrupted then
				f220_local0(f220_arg0, f220_arg1)
				return 
			else
				f220_arg0:beginAnimation("keyframe", 70, false, false, CoD.TweenType.Linear)
				f220_arg0:registerEventHandler("transition_complete_keyframe", f220_local0)
			end
		end

		f70_local1(f2_local9, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		local f70_local2 = function (f221_arg0, f221_arg1)
			if not f221_arg1.interrupted then
				f221_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f221_arg0:setAlpha(1)
			if f221_arg1.interrupted then
				Widget.clipFinished(f221_arg0, f221_arg1)
			else
				f221_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f70_local2(f2_local17, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setAlpha(0)
		local f70_local3 = function (f222_arg0, f222_arg1)
			local f222_local0 = function (f225_arg0, f225_arg1)
				if not f225_arg1.interrupted then
					f225_arg0:beginAnimation("keyframe", 299, false, false, CoD.TweenType.Bounce)
				end
				f225_arg0:setAlpha(1)
				if f225_arg1.interrupted then
					Widget.clipFinished(f225_arg0, f225_arg1)
				else
					f225_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f222_arg1.interrupted then
				f222_local0(f222_arg0, f222_arg1)
				return 
			else
				f222_arg0:beginAnimation("keyframe", 119, false, false, CoD.TweenType.Linear)
				f222_arg0:registerEventHandler("transition_complete_keyframe", f222_local0)
			end
		end

		f70_local3(f2_local19, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		local f70_local4 = function (f223_arg0, f223_arg1)
			local f223_local0 = function (f226_arg0, f226_arg1)
				if not f226_arg1.interrupted then
					f226_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f226_arg0:setAlpha(1)
				if f226_arg1.interrupted then
					Widget.clipFinished(f226_arg0, f226_arg1)
				else
					f226_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f223_arg1.interrupted then
				f223_local0(f223_arg0, f223_arg1)
				return 
			else
				f223_arg0:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear)
				f223_arg0:registerEventHandler("transition_complete_keyframe", f223_local0)
			end
		end

		f70_local4(f2_local21, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end}, IsPartyMember = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(1)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(1)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -0.5, 27)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.5)
		Widget.VSpanel:setAlpha(0.5)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(1)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.96, 1, 0.33)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(1)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.87, 0.9, 0.9)
		Widget.gamertag:setAlpha(1)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(1)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(1)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(0)
		Widget.clipFinished(f2_local26, {})
	end, Focus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -4, 31)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -21, 19)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -7.25, 33.25)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -7.5, 33)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		Widget.clipFinished(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, GainFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, 0, 27.5)
		local f73_local0 = function (f227_arg0, f227_arg1)
			if not f227_arg1.interrupted then
				f227_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f227_arg0:setLeftRight(true, false, 60, 408)
			f227_arg0:setTopBottom(true, false, -4.5, 31.5)
			if f227_arg1.interrupted then
				Widget.clipFinished(f227_arg0, f227_arg1)
			else
				f227_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f73_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		local f73_local1 = function (f228_arg0, f228_arg1)
			if not f228_arg1.interrupted then
				f228_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f228_arg0:setLeftRight(true, true, 60, -82)
			f228_arg0:setTopBottom(false, false, -18, 18)
			if f228_arg1.interrupted then
				Widget.clipFinished(f228_arg0, f228_arg1)
			else
				f228_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f73_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setZoom(0)
		local f73_local2 = function (f229_arg0, f229_arg1)
			if not f229_arg1.interrupted then
				f229_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f229_arg0:setLeftRight(true, false, 60, 408)
			f229_arg0:setTopBottom(true, false, -5, 32)
			f229_arg0:setZoom(0)
			if f229_arg1.interrupted then
				Widget.clipFinished(f229_arg0, f229_arg1)
			else
				f229_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f73_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f73_local3 = function (f230_arg0, f230_arg1)
			if not f230_arg1.interrupted then
				f230_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f230_arg0:setLeftRight(true, false, 60, 408)
			f230_arg0:setTopBottom(true, false, -4, 31)
			f230_arg0:setZoom(0)
			if f230_arg1.interrupted then
				Widget.clipFinished(f230_arg0, f230_arg1)
			else
				f230_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f73_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 12, 15)
		Widget.FocusBarB:setAlpha(0)
		local f73_local4 = function (f231_arg0, f231_arg1)
			if not f231_arg1.interrupted then
				f231_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f231_arg0:setLeftRight(true, false, 58, 410)
			f231_arg0:setTopBottom(true, false, 29, 33)
			f231_arg0:setAlpha(1)
			if f231_arg1.interrupted then
				Widget.clipFinished(f231_arg0, f231_arg1)
			else
				f231_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f73_local4(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 59, 410)
		Widget.FocusBarT:setTopBottom(true, false, 12, 16)
		Widget.FocusBarT:setAlpha(0)
		local f73_local5 = function (f232_arg0, f232_arg1)
			if not f232_arg1.interrupted then
				f232_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f232_arg0:setLeftRight(true, false, 58, 410)
			f232_arg0:setTopBottom(true, false, -6, -2)
			f232_arg0:setAlpha(1)
			if f232_arg1.interrupted then
				Widget.clipFinished(f232_arg0, f232_arg1)
			else
				f232_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f73_local5(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, LoseFocus = function ()
		Widget:setupElementClipCounter(10)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -4.5, 31.5)
		local f74_local0 = function (f233_arg0, f233_arg1)
			if not f233_arg1.interrupted then
				f233_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f233_arg0:setLeftRight(true, false, 60, 408)
			f233_arg0:setTopBottom(true, false, 0, 27.5)
			if f233_arg1.interrupted then
				Widget.clipFinished(f233_arg0, f233_arg1)
			else
				f233_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f74_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -18, 18)
		local f74_local1 = function (f234_arg0, f234_arg1)
			if not f234_arg1.interrupted then
				f234_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f234_arg0:setLeftRight(true, true, 60, -82)
			f234_arg0:setTopBottom(false, false, -14, 13.8)
			if f234_arg1.interrupted then
				Widget.clipFinished(f234_arg0, f234_arg1)
			else
				f234_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f74_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -5, 32)
		Widget.LobbyMemberBacking:setZoom(0)
		local f74_local2 = function (f235_arg0, f235_arg1)
			if not f235_arg1.interrupted then
				f235_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f235_arg0:setLeftRight(true, false, 60, 408)
			f235_arg0:setTopBottom(true, false, -0.5, 27)
			f235_arg0:setZoom(0)
			if f235_arg1.interrupted then
				Widget.clipFinished(f235_arg0, f235_arg1)
			else
				f235_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f74_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -4, 31)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f74_local3 = function (f236_arg0, f236_arg1)
			if not f236_arg1.interrupted then
				f236_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f236_arg0:setLeftRight(true, false, 60, 408)
			f236_arg0:setTopBottom(true, false, -0.5, 27.5)
			f236_arg0:setZoom(0)
			if f236_arg1.interrupted then
				Widget.clipFinished(f236_arg0, f236_arg1)
			else
				f236_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f74_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		local f74_local4 = function (f237_arg0, f237_arg1)
			if not f237_arg1.interrupted then
				f237_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f237_arg0:setScale(1)
			if f237_arg1.interrupted then
				Widget.clipFinished(f237_arg0, f237_arg1)
			else
				f237_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f74_local4(f2_local9, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 29, 33)
		Widget.FocusBarB:setAlpha(1)
		local f74_local5 = function (f238_arg0, f238_arg1)
			if not f238_arg1.interrupted then
				f238_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f238_arg0:setLeftRight(true, false, 58, 410)
			f238_arg0:setTopBottom(true, false, 12, 15)
			f238_arg0:setAlpha(0)
			if f238_arg1.interrupted then
				Widget.clipFinished(f238_arg0, f238_arg1)
			else
				f238_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f74_local5(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -6, -2)
		Widget.FocusBarT:setAlpha(1)
		local f74_local6 = function (f239_arg0, f239_arg1)
			if not f239_arg1.interrupted then
				f239_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f239_arg0:setLeftRight(true, false, 59, 410)
			f239_arg0:setTopBottom(true, false, 12, 16)
			f239_arg0:setAlpha(0)
			if f239_arg1.interrupted then
				Widget.clipFinished(f239_arg0, f239_arg1)
			else
				f239_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f74_local6(f2_local16, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, Intro = function ()
		Widget:setupElementClipCounter(8)
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		local f75_local0 = function (f240_arg0, f240_arg1)
			local f240_local0 = function (f245_arg0, f245_arg1)
				if not f245_arg1.interrupted then
					f245_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f245_arg0:setAlpha(1)
				if f245_arg1.interrupted then
					Widget.clipFinished(f245_arg0, f245_arg1)
				else
					f245_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f240_arg1.interrupted then
				f240_local0(f240_arg0, f240_arg1)
				return 
			else
				f240_arg0:beginAnimation("keyframe", 159, false, false, CoD.TweenType.Linear)
				f240_arg0:registerEventHandler("transition_complete_keyframe", f240_local0)
			end
		end

		f75_local0(f2_local4, {})
		f2_local9:completeAnimation()
		Widget.rank:setAlpha(0)
		local f75_local1 = function (f241_arg0, f241_arg1)
			local f241_local0 = function (f246_arg0, f246_arg1)
				if not f246_arg1.interrupted then
					f246_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f246_arg0:setAlpha(1)
				if f246_arg1.interrupted then
					Widget.clipFinished(f246_arg0, f246_arg1)
				else
					f246_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f241_arg1.interrupted then
				f241_local0(f241_arg0, f241_arg1)
				return 
			else
				f241_arg0:beginAnimation("keyframe", 39, false, false, CoD.TweenType.Linear)
				f241_arg0:registerEventHandler("transition_complete_keyframe", f241_local0)
			end
		end

		f75_local1(f2_local9, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		local f75_local2 = function (f242_arg0, f242_arg1)
			if not f242_arg1.interrupted then
				f242_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f242_arg0:setAlpha(1)
			if f242_arg1.interrupted then
				Widget.clipFinished(f242_arg0, f242_arg1)
			else
				f242_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f75_local2(f2_local17, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setAlpha(0)
		local f75_local3 = function (f243_arg0, f243_arg1)
			local f243_local0 = function (f247_arg0, f247_arg1)
				if not f247_arg1.interrupted then
					f247_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f247_arg0:setAlpha(1)
				if f247_arg1.interrupted then
					Widget.clipFinished(f247_arg0, f247_arg1)
				else
					f247_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f243_arg1.interrupted then
				f243_local0(f243_arg0, f243_arg1)
				return 
			else
				f243_arg0:beginAnimation("keyframe", 79, false, false, CoD.TweenType.Linear)
				f243_arg0:registerEventHandler("transition_complete_keyframe", f243_local0)
			end
		end

		f75_local3(f2_local19, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		local f75_local4 = function (f244_arg0, f244_arg1)
			if not f244_arg1.interrupted then
				f244_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f244_arg0:setAlpha(1)
			if f244_arg1.interrupted then
				Widget.clipFinished(f244_arg0, f244_arg1)
			else
				f244_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f75_local4(f2_local21, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end}, IsInGroup = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(1)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(1)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -0.5, 27)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.5)
		Widget.VSpanel:setAlpha(0.5)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(1)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.96, 1, 0.33)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(1)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.87, 0.9, 0.9)
		Widget.gamertag:setAlpha(1)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(1)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(1)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(0)
		Widget.clipFinished(f2_local26, {})
	end, Focus = function ()
		Widget:setupElementClipCounter(12)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -21.5, 21.5)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -21, 21)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -8, 35)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -8, 35)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(1)
		Widget.clipFinished(f2_local11, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 33, 36)
		Widget.FocusBarB:setAlpha(1)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -9, -5)
		Widget.FocusBarT:setAlpha(1)
		Widget.clipFinished(f2_local16, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, -5, 20)
		Widget.clipFinished(f2_local19, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, GainFocus = function ()
		Widget:setupElementClipCounter(12)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -13.5, 14)
		local f78_local0 = function (f248_arg0, f248_arg1)
			if not f248_arg1.interrupted then
				f248_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f248_arg0:setLeftRight(true, true, 60, -82)
			f248_arg0:setTopBottom(false, false, -21.5, 21.5)
			if f248_arg1.interrupted then
				Widget.clipFinished(f248_arg0, f248_arg1)
			else
				f248_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f78_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		local f78_local1 = function (f249_arg0, f249_arg1)
			if not f249_arg1.interrupted then
				f249_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f249_arg0:setLeftRight(true, true, 60, -82)
			f249_arg0:setTopBottom(false, false, -21, 21)
			if f249_arg1.interrupted then
				Widget.clipFinished(f249_arg0, f249_arg1)
			else
				f249_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f78_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setZoom(0)
		local f78_local2 = function (f250_arg0, f250_arg1)
			if not f250_arg1.interrupted then
				f250_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f250_arg0:setLeftRight(true, false, 60, 408)
			f250_arg0:setTopBottom(true, false, -8, 35)
			f250_arg0:setZoom(0)
			if f250_arg1.interrupted then
				Widget.clipFinished(f250_arg0, f250_arg1)
			else
				f250_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f78_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f78_local3 = function (f251_arg0, f251_arg1)
			if not f251_arg1.interrupted then
				f251_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f251_arg0:setLeftRight(true, false, 60, 408)
			f251_arg0:setTopBottom(true, false, -8, 35)
			f251_arg0:setZoom(0)
			if f251_arg1.interrupted then
				Widget.clipFinished(f251_arg0, f251_arg1)
			else
				f251_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f78_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		local f78_local4 = function (f252_arg0, f252_arg1)
			if not f252_arg1.interrupted then
				f252_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f252_arg0:setAlpha(1)
			if f252_arg1.interrupted then
				Widget.clipFinished(f252_arg0, f252_arg1)
			else
				f252_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f78_local4(f2_local11, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 12, 15)
		Widget.FocusBarB:setAlpha(0)
		local f78_local5 = function (f253_arg0, f253_arg1)
			if not f253_arg1.interrupted then
				f253_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f253_arg0:setLeftRight(true, false, 58, 410)
			f253_arg0:setTopBottom(true, false, 33, 36)
			f253_arg0:setAlpha(1)
			if f253_arg1.interrupted then
				Widget.clipFinished(f253_arg0, f253_arg1)
			else
				f253_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f78_local5(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 59, 410)
		Widget.FocusBarT:setTopBottom(true, false, 12, 16)
		Widget.FocusBarT:setAlpha(0)
		local f78_local6 = function (f254_arg0, f254_arg1)
			if not f254_arg1.interrupted then
				f254_arg0:beginAnimation("keyframe", 50, true, false, CoD.TweenType.Linear)
			end
			f254_arg0:setLeftRight(true, false, 58, 410)
			f254_arg0:setTopBottom(true, false, -9, -5)
			f254_arg0:setAlpha(1)
			if f254_arg1.interrupted then
				Widget.clipFinished(f254_arg0, f254_arg1)
			else
				f254_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f78_local6(f2_local16, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		local f78_local7 = function (f255_arg0, f255_arg1)
			if not f255_arg1.interrupted then
				f255_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f255_arg0:setLeftRight(true, false, 115, 386)
			f255_arg0:setTopBottom(true, false, -6, 19)
			if f255_arg1.interrupted then
				Widget.clipFinished(f255_arg0, f255_arg1)
			else
				f255_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f78_local7(f2_local19, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, LoseFocus = function ()
		Widget:setupElementClipCounter(12)
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -21.5, 21.5)
		local f79_local0 = function (f256_arg0, f256_arg1)
			if not f256_arg1.interrupted then
				f256_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f256_arg0:setLeftRight(true, true, 60, -82)
			f256_arg0:setTopBottom(false, false, -13.5, 14)
			if f256_arg1.interrupted then
				Widget.clipFinished(f256_arg0, f256_arg1)
			else
				f256_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f79_local0(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -21, 21)
		local f79_local1 = function (f257_arg0, f257_arg1)
			if not f257_arg1.interrupted then
				f257_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f257_arg0:setLeftRight(true, true, 60, -82)
			f257_arg0:setTopBottom(false, false, -14, 13.8)
			if f257_arg1.interrupted then
				Widget.clipFinished(f257_arg0, f257_arg1)
			else
				f257_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f79_local1(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -8, 35)
		Widget.LobbyMemberBacking:setZoom(0)
		local f79_local2 = function (f258_arg0, f258_arg1)
			if not f258_arg1.interrupted then
				f258_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f258_arg0:setLeftRight(true, false, 60, 408)
			f258_arg0:setTopBottom(true, false, -0.5, 27)
			f258_arg0:setZoom(0)
			if f258_arg1.interrupted then
				Widget.clipFinished(f258_arg0, f258_arg1)
			else
				f258_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f79_local2(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -8, 35)
		Widget.LobbyMemberTeamColor:setZoom(0)
		local f79_local3 = function (f259_arg0, f259_arg1)
			if not f259_arg1.interrupted then
				f259_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f259_arg0:setLeftRight(true, false, 60, 408)
			f259_arg0:setTopBottom(true, false, -0.5, 26.5)
			f259_arg0:setZoom(0)
			if f259_arg1.interrupted then
				Widget.clipFinished(f259_arg0, f259_arg1)
			else
				f259_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f79_local3(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setScale(1)
		local f79_local4 = function (f260_arg0, f260_arg1)
			if not f260_arg1.interrupted then
				f260_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f260_arg0:setScale(1)
			if f260_arg1.interrupted then
				Widget.clipFinished(f260_arg0, f260_arg1)
			else
				f260_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f79_local4(f2_local9, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(1)
		local f79_local5 = function (f261_arg0, f261_arg1)
			if not f261_arg1.interrupted then
				f261_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f261_arg0:setAlpha(0)
			if f261_arg1.interrupted then
				Widget.clipFinished(f261_arg0, f261_arg1)
			else
				f261_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f79_local5(f2_local11, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 33, 36)
		Widget.FocusBarB:setAlpha(1)
		local f79_local6 = function (f262_arg0, f262_arg1)
			if not f262_arg1.interrupted then
				f262_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f262_arg0:setLeftRight(true, false, 58, 410)
			f262_arg0:setTopBottom(true, false, 12, 15)
			f262_arg0:setAlpha(0)
			if f262_arg1.interrupted then
				Widget.clipFinished(f262_arg0, f262_arg1)
			else
				f262_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f79_local6(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -9, -5)
		Widget.FocusBarT:setAlpha(1)
		local f79_local7 = function (f263_arg0, f263_arg1)
			if not f263_arg1.interrupted then
				f263_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f263_arg0:setLeftRight(true, false, 59, 410)
			f263_arg0:setTopBottom(true, false, 12, 16)
			f263_arg0:setAlpha(0)
			if f263_arg1.interrupted then
				Widget.clipFinished(f263_arg0, f263_arg1)
			else
				f263_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f79_local7(f2_local16, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, -6, 19)
		local f79_local8 = function (f264_arg0, f264_arg1)
			if not f264_arg1.interrupted then
				f264_arg0:beginAnimation("keyframe", 50, false, false, CoD.TweenType.Linear)
			end
			f264_arg0:setLeftRight(true, false, 115, 386)
			f264_arg0:setTopBottom(true, false, 1, 26)
			if f264_arg1.interrupted then
				Widget.clipFinished(f264_arg0, f264_arg1)
			else
				f264_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f79_local8(f2_local19, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end, Intro = function ()
		Widget:setupElementClipCounter(8)
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		local f80_local0 = function (f265_arg0, f265_arg1)
			local f265_local0 = function (f270_arg0, f270_arg1)
				if not f270_arg1.interrupted then
					f270_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f270_arg0:setAlpha(1)
				if f270_arg1.interrupted then
					Widget.clipFinished(f270_arg0, f270_arg1)
				else
					f270_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f265_arg1.interrupted then
				f265_local0(f265_arg0, f265_arg1)
				return 
			else
				f265_arg0:beginAnimation("keyframe", 159, false, false, CoD.TweenType.Linear)
				f265_arg0:registerEventHandler("transition_complete_keyframe", f265_local0)
			end
		end

		f80_local0(f2_local4, {})
		f2_local9:completeAnimation()
		Widget.rank:setAlpha(0)
		local f80_local1 = function (f266_arg0, f266_arg1)
			local f266_local0 = function (f271_arg0, f271_arg1)
				if not f271_arg1.interrupted then
					f271_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f271_arg0:setAlpha(1)
				if f271_arg1.interrupted then
					Widget.clipFinished(f271_arg0, f271_arg1)
				else
					f271_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f266_arg1.interrupted then
				f266_local0(f266_arg0, f266_arg1)
				return 
			else
				f266_arg0:beginAnimation("keyframe", 39, false, false, CoD.TweenType.Linear)
				f266_arg0:registerEventHandler("transition_complete_keyframe", f266_local0)
			end
		end

		f80_local1(f2_local9, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		local f80_local2 = function (f267_arg0, f267_arg1)
			if not f267_arg1.interrupted then
				f267_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f267_arg0:setAlpha(1)
			if f267_arg1.interrupted then
				Widget.clipFinished(f267_arg0, f267_arg1)
			else
				f267_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f80_local2(f2_local17, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setAlpha(0)
		local f80_local3 = function (f268_arg0, f268_arg1)
			local f268_local0 = function (f272_arg0, f272_arg1)
				if not f272_arg1.interrupted then
					f272_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
				end
				f272_arg0:setAlpha(1)
				if f272_arg1.interrupted then
					Widget.clipFinished(f272_arg0, f272_arg1)
				else
					f272_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
				end
			end

			if f268_arg1.interrupted then
				f268_local0(f268_arg0, f268_arg1)
				return 
			else
				f268_arg0:beginAnimation("keyframe", 79, false, false, CoD.TweenType.Linear)
				f268_arg0:registerEventHandler("transition_complete_keyframe", f268_local0)
			end
		end

		f80_local3(f2_local19, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		local f80_local4 = function (f269_arg0, f269_arg1)
			if not f269_arg1.interrupted then
				f269_arg0:beginAnimation("keyframe", 300, false, false, CoD.TweenType.Bounce)
			end
			f269_arg0:setAlpha(1)
			if f269_arg1.interrupted then
				Widget.clipFinished(f269_arg0, f269_arg1)
			else
				f269_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f80_local4(f2_local21, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
	end}, SearchingForPlayer = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(0)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -14, 13.5)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		Widget.VSpanel:setAlpha(0)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(0)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.87, 0.9, 0.9)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.87, 0.9, 0.9)
		Widget.gamertag:setAlpha(0)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(0)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(0)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(1)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(0)
		Widget.clipFinished(f2_local26, {})
	end}, SearchingForPlayer_Flipped = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(0)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, false, 60, 408)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(true, false, -0.5, 27)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		Widget.VSpanel:setAlpha(0)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(0)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.87, 0.9, 0.9)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.87, 0.9, 0.9)
		Widget.gamertag:setAlpha(0)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(0)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(0)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(1)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(0)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(0)
		Widget.clipFinished(f2_local26, {})
	end}, AnonymousPlayer = {DefaultClip = function ()
		Widget:setupElementClipCounter(26)
		f2_local1:completeAnimation()
		Widget.sizeElement:setLeftRight(true, false, 0, 490)
		Widget.sizeElement:setTopBottom(true, false, 0, 27)
		Widget.sizeElement:setAlpha(0)
		Widget.clipFinished(f2_local1, {})
		--[[f2_local2:completeAnimation()
		Widget.LobbyMemberBubbleGumBuffs:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBubbleGumBuffs:setTopBottom(true, false, 27, 91)
		Widget.LobbyMemberBubbleGumBuffs:setAlpha(0)
		Widget.clipFinished(f2_local2, {})]]
		f2_local3:completeAnimation()
		Widget.PartyMemberIconNew:setLeftRight(true, false, 412, 422)
		Widget.PartyMemberIconNew:setTopBottom(true, false, 0, 25)
		Widget.PartyMemberIconNew:setAlpha(0)
		Widget.clipFinished(f2_local3, {})
		f2_local4:completeAnimation()
		Widget.LobbyLeaderIcon:setAlpha(0)
		Widget.clipFinished(f2_local4, {})
		f2_local5:completeAnimation()
		Widget.FEMemberBlurPanelContainer0:setLeftRight(true, true, 60, -82)
		Widget.FEMemberBlurPanelContainer0:setTopBottom(false, false, -14, 13.5)
		Widget.FEMemberBlurPanelContainer0:setAlpha(1)
		Widget.FEMemberBlurPanelContainer0:setZoom(0)
		Widget.clipFinished(f2_local5, {})
		f2_local6:completeAnimation()
		Widget.VSpanel:setLeftRight(true, true, 60, -82)
		Widget.VSpanel:setTopBottom(false, false, -14, 13.8)
		Widget.VSpanel:setAlpha(0)
		Widget.clipFinished(f2_local6, {})
		f2_local7:completeAnimation()
		Widget.LobbyMemberBacking:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberBacking:setTopBottom(true, false, -0.5, 27)
		Widget.LobbyMemberBacking:setAlpha(0)
		Widget.LobbyMemberBacking:setZoom(0)
		Widget.clipFinished(f2_local7, {})
		f2_local8:completeAnimation()
		Widget.LobbyMemberTeamColor:setLeftRight(true, false, 60, 408)
		Widget.LobbyMemberTeamColor:setTopBottom(true, false, -0.5, 27.5)
		Widget.LobbyMemberTeamColor:setAlpha(1)
		Widget.LobbyMemberTeamColor:setZoom(0)
		Widget.clipFinished(f2_local8, {})
		f2_local9:completeAnimation()
		Widget.rank:setRGB(1, 1, 1)
		Widget.rank:setAlpha(0)
		Widget.rank:setZoom(0)
		Widget.rank:setScale(1)
		Widget.clipFinished(f2_local9, {})
		f2_local10:completeAnimation()
		Widget.clanTag:setRGB(0.87, 0.9, 0.9)
		Widget.clanTag:setAlpha(0)
		Widget.clanTag:setZoom(0)
		Widget.clipFinished(f2_local10, {})
		f2_local11:completeAnimation()
		Widget.PrimaryGroup:setAlpha(0)
		Widget.clipFinished(f2_local11, {})
		f2_local12:completeAnimation()
		Widget.addControllerText:setAlpha(0)
		Widget.clipFinished(f2_local12, {})
		f2_local13:completeAnimation()
		Widget.MorePlaying:setAlpha(0)
		Widget.clipFinished(f2_local13, {})
		f2_local14:completeAnimation()
		Widget.playerCountText:setAlpha(0)
		Widget.clipFinished(f2_local14, {})
		f2_local15:completeAnimation()
		Widget.FocusBarB:setLeftRight(true, false, 58, 410)
		Widget.FocusBarB:setTopBottom(true, false, 26, 29)
		Widget.FocusBarB:setAlpha(0)
		Widget.clipFinished(f2_local15, {})
		f2_local16:completeAnimation()
		Widget.FocusBarT:setLeftRight(true, false, 58, 410)
		Widget.FocusBarT:setTopBottom(true, false, -4, 0)
		Widget.FocusBarT:setAlpha(0)
		Widget.clipFinished(f2_local16, {})
		f2_local17:completeAnimation()
		Widget.IconControllerContainer:setAlpha(0)
		Widget.clipFinished(f2_local17, {})
		f2_local18:completeAnimation()
		Widget.IconJoinable:setAlpha(0)
		Widget.clipFinished(f2_local18, {})
		f2_local19:completeAnimation()
		Widget.gamertag:setLeftRight(true, false, 115, 386)
		Widget.gamertag:setTopBottom(true, false, 1, 26)
		Widget.gamertag:setRGB(0.87, 0.9, 0.9)
		Widget.gamertag:setAlpha(0)
		Widget.gamertag:setZoom(0)
		Widget.clipFinished(f2_local19, {})
		f2_local20:completeAnimation()
		Widget.TeamSwitcher:setAlpha(0)
		Widget.clipFinished(f2_local20, {})
		f2_local21:completeAnimation()
		Widget.LobbyLeaderIcon0:setAlpha(0)
		Widget.clipFinished(f2_local21, {})
		f2_local22:completeAnimation()
		Widget.LobbyMemberScore:setAlpha(0)
		Widget.clipFinished(f2_local22, {})
		f2_local23:completeAnimation()
		Widget.SearchingForPlayer:setAlpha(0)
		Widget.clipFinished(f2_local23, {})
		f2_local24:completeAnimation()
		Widget.SearchingForPlayerFlipped:setAlpha(0)
		Widget.clipFinished(f2_local24, {})
		f2_local25:completeAnimation()
		Widget.AnonymousPlayer:setAlpha(1)
		Widget.clipFinished(f2_local25, {})
		f2_local26:completeAnimation()
		Widget.LobbyMemberReady:setAlpha(0)
		Widget.clipFinished(f2_local26, {})
	end}}
	Widget:mergeStateConditions({{stateName = "IsSelfZombies", condition = function (HudRef, ItemRef, UpdateTable)
		local f84_local0 = IsSelfItem(ItemRef, InstanceRef)
		if f84_local0 then
			f84_local0 = IsZM()
			if f84_local0 then
				f84_local0 = LobbyHas4PlayersOrLess()
			end
		end
		return f84_local0
	end}, {stateName = "IsPartyMemberZombies", condition = function (HudRef, ItemRef, UpdateTable)
		local f85_local0 = IsZM()
		if f85_local0 then
			f85_local0 = LobbyHas4PlayersOrLess()
		end
		return f85_local0
	end}, {stateName = "IsDOA", condition = function (HudRef, ItemRef, UpdateTable)
		local f86_local0 = IsSelfModelValueTrue(ItemRef, InstanceRef, "validClient")
		if f86_local0 then
			f86_local0 = IsGlobalModelValueEqualTo(ItemRef, InstanceRef, "lobbyRoot.lobbyNav", LobbyData.UITargets.UI_DOALOBBYONLINEPUBLICGAME.id)
			if f86_local0 then
				f86_local0 = IsSelfItem(ItemRef, InstanceRef)
				if f86_local0 then
					f86_local0 = IsGameTypeDOA()
				end
			end
		end
		return f86_local0
	end}, {stateName = "IsPartyMemberDOA", condition = function (HudRef, ItemRef, UpdateTable)
		local f87_local0 = IsGlobalModelValueEqualTo(ItemRef, InstanceRef, "lobbyRoot.lobbyNav", LobbyData.UITargets.UI_DOALOBBYONLINEPUBLICGAME.id)
		if f87_local0 then
			f87_local0 = IsGameTypeDOA()
			if f87_local0 then
				f87_local0 = IsSelfModelValueTrue(ItemRef, InstanceRef, "validClient")
			end
		end
		return f87_local0
	end}, {stateName = "IsSelf", condition = function (HudRef, ItemRef, UpdateTable)
		local f88_local0 = IsSelfItem(ItemRef, InstanceRef)
		if f88_local0 then
			f88_local0 = IsSelfModelValueTrue(ItemRef, InstanceRef, "validClient")
		end
		return f88_local0
	end}, {stateName = "IsPartyMember", condition = function (HudRef, ItemRef, UpdateTable)
		return AlwaysFalse()
	end}, {stateName = "IsInGroup", condition = function (HudRef, ItemRef, UpdateTable)
		return AlwaysFalse()
	end}, {stateName = "SearchingForPlayer", condition = function (HudRef, ItemRef, UpdateTable)
		local f91_local0
		if not IsSelfModelValueTrue(ItemRef, InstanceRef, "validClient") then
			f91_local0 = not IsCurrentLanguageReversed()
		else
			f91_local0 = false
		end
		return f91_local0
	end}, {stateName = "SearchingForPlayer_Flipped", condition = function (HudRef, ItemRef, UpdateTable)
		local f92_local0
		if not IsSelfModelValueTrue(ItemRef, InstanceRef, "validClient") then
			f92_local0 = IsCurrentLanguageReversed()
		else
			f92_local0 = false
		end
		return f92_local0
	end}, {stateName = "AnonymousPlayer", condition = function (HudRef, ItemRef, UpdateTable)
		local f93_local0 = IsArenaMode()
		if f93_local0 then
			f93_local0 = IsSelfModelValueNilOrZero(ItemRef, InstanceRef, "isMember")
			if f93_local0 then
				if not IsGlobalModelValueTrue(ItemRef, InstanceRef, "lobbyRoot.lobbyLockedIn") then
					f93_local0 = not MapVoteInState("3")
				else
					f93_local0 = false
				end
			end
		end
		return f93_local0
	end}})
	Widget:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyMainMode"), function (ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.lobbyMainMode"})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyNav"), function (ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.lobbyNav"})
	end)
	if Widget.m_eventHandlers.on_client_added then
		local f2_local28 = Widget.m_eventHandlers.on_client_added
		Widget:registerEventHandler("on_client_added", function (Sender, Event)
			local f96_local0 = Event.menu
			if not f96_local0 then
				f96_local0 = HudRef
			end
			Event.menu = f96_local0
			Sender:updateState(Event)
			return f2_local28(Sender, Event)
		end)
	else
		Widget:registerEventHandler("on_client_added", LUI.UIElement.updateState)
	end
	if Widget.m_eventHandlers.on_client_removed then
		local f2_local28 = Widget.m_eventHandlers.on_client_removed
		Widget:registerEventHandler("on_client_removed", function (Sender, Event)
			local f97_local0 = Event.menu
			if not f97_local0 then
				f97_local0 = HudRef
			end
			Event.menu = f97_local0
			Sender:updateState(Event)
			return f2_local28(Sender, Event)
		end)
	else
		Widget:registerEventHandler("on_client_removed", LUI.UIElement.updateState)
	end
	Widget:linkToElementModel(Widget, "validClient", true, function (ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "validClient"})
	end)
	Widget:linkToElementModel(Widget, "isMember", true, function (ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "isMember"})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyLockedIn"), function (ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.lobbyLockedIn"})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.mapVote"), function (ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.mapVote"})
	end)
	LUI.OverrideFunction_CallOriginalFirst(Widget, "setState", function (f102_arg0, f102_arg1)
		if IsSelfInState(Widget, "AnonymousPlayer") then
			RestrictVoiceChatForClient(Widget, f102_arg0, InstanceRef)
		elseif not IsSelfInState(Widget, "AnonymousPlayer") then
			AllowVoiceChatForClient(Widget, f102_arg0, InstanceRef)
		end
	end)
	f2_local26.id = "LobbyMemberReady"
	Widget:registerEventHandler("gain_focus", function (Sender, Event)
		if Sender.m_focusable then
			local f103_local0 = Sender.LobbyMemberReady
			if f103_local0:processEvent(Event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(Sender, Event)
	end)
	LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function (Sender)
		--Sender.LobbyMemberBubbleGumBuffs:close()
		Sender.PartyMemberIconNew:close()
		Sender.LobbyLeaderIcon:close()
		Sender.FEMemberBlurPanelContainer0:close()
		Sender.VSpanel:close()
		Sender.LobbyMemberBacking:close()
		Sender.LobbyMemberTeamColor:close()
		Sender.rank:close()
		Sender.FocusBarB:close()
		Sender.FocusBarT:close()
		Sender.IconControllerContainer:close()
		Sender.IconJoinable:close()
		Sender.gamertag:close()
		Sender.TeamSwitcher:close()
		Sender.LobbyLeaderIcon0:close()
		Sender.LobbyMemberScore:close()
		Sender.SearchingForPlayer:close()
		Sender.SearchingForPlayerFlipped:close()
		Sender.AnonymousPlayer:close()
		Sender.LobbyMemberReady:close()
		Sender.LobbyMemberMP45:close()
		Sender.clanTag:close()
	end)
	if f0_local0 then
		f0_local0(Widget, InstanceRef, HudRef)
	end
	return Widget
end


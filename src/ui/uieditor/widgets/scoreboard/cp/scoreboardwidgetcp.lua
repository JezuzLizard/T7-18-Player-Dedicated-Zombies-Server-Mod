require("ui.uieditor.widgets.Scoreboard.CP.ScoreboardHeaderWidgetCP")
require("ui.uieditor.widgets.Scoreboard.ScoreboardFactionScoresList")
require("ui.uieditor.widgets.Scoreboard.ScoreboardWidgetButtonContainer")
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0.ScoreboardFactionScoresListCP0.Team1:subscribeToModel(Engine.CreateModel(Engine.GetModelForController(f1_arg1), "updateScoreboard"), function (ModelRef)
		CoD.ScoreboardUtility.UpdateScoreboardTeamScores(f1_arg1)
	end)
	f1_arg0:subscribeToModel(Engine.GetModel(Engine.GetModelForController(f1_arg1), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), function (ModelRef)
		f1_arg0.m_inputDisabled = not Engine.GetModelValue(ModelRef)
	end)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	CoD.ScoreboardUtility.SetScoreboardUIModels(f2_arg1)
end

CoD.ScoreboardWidgetCP = InheritFrom(LUI.UIElement)
CoD.ScoreboardWidgetCP.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	if f0_local1 then
		f0_local1(Widget, InstanceRef)
	end
	Widget:setUseStencil(false)
	Widget:setClass(CoD.ScoreboardWidgetCP)
	Widget.id = "ScoreboardWidgetCP"
	Widget.soundSet = "default"
	Widget:setLeftRight(true, false, 0, 1006)
	--Widget:setTopBottom(true, false, 0, 526)
	Widget:setTopBottom(true, false, 0, 550)
	Widget:makeFocusable()
	Widget.onlyChildrenFocusable = true
	Widget.anyChildUsesUpdateState = true
	local f3_local1 = CoD.ScoreboardHeaderWidgetCP.new(HudRef, InstanceRef)
	f3_local1:setLeftRight(true, false, 88, 893.5)
	f3_local1:setTopBottom(true, false, 10, 47)
	f3_local1:setAlpha(0)
	f3_local1:subscribeToGlobalModel(InstanceRef, "Scoreboard", nil, function (ModelRef)
		f3_local1:setModel(ModelRef, InstanceRef)
	end)
	Widget:addElement(f3_local1)
	Widget.ScoreboardHeaderWidgetCP0 = f3_local1
	
	local f3_local2 = CoD.ScoreboardFactionScoresList.new(HudRef, InstanceRef)
	f3_local2:setLeftRight(true, false, 88.5, 914.5)
	--f3_local2:setTopBottom(true, false, 47, 515)
	f3_local2:setTopBottom(true, false, 47, 539)
	local mapname = Engine.GetCurrentMap()
	if ( mapname == "zm_zod" or mapname == "zm_castle" or mapname == "zm_stalingrad" or mapname == "zm_genesis" or mapname == "zm_tomb" ) then
		f3_local2.Team1:setVerticalCount(12)
	else 
		f3_local2.Team1:setVerticalCount(18)
	end
	f3_local2.Team2:setAlpha(0)
	f3_local2.Team2:setVerticalCount(1)
	f3_local2:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "forceScoreboard"), function (ModelRef)
		local f7_local0 = {controller = InstanceRef, name = "model_validation", modelValue = Engine.GetModelValue(ModelRef), modelName = "forceScoreboard"}
		CoD.Menu.UpdateButtonShownState(f3_local2, HudRef, InstanceRef, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
	end)
	f3_local2:registerEventHandler("list_item_gain_focus", function (Sender, Event)
		UpdateScoreboardClientMuteButtonPrompt(Sender, InstanceRef)
		return nil
	end)
	f3_local2:registerEventHandler("gain_focus", function (Sender, Event)
		local f9_local0 = nil
		if Sender.gainFocus then
			f9_local0 = Sender:gainFocus(Event)
		elseif Sender.super.gainFocus then
			f9_local0 = Sender:gainFocus(Event)
		end
		CoD.Menu.UpdateButtonShownState(Sender, HudRef, InstanceRef, Enum.LUIButton.LUI_KEY_XBA_PSCROSS)
		return f9_local0
	end)
	f3_local2:registerEventHandler("lose_focus", function (Sender, Event)
		local f10_local0 = nil
		if Sender.loseFocus then
			f10_local0 = Sender:loseFocus(Event)
		elseif Sender.super.loseFocus then
			f10_local0 = Sender:loseFocus(Event)
		end
		return f10_local0
	end)
	HudRef:AddButtonCallbackFunction(f3_local2, InstanceRef, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, nil, function (f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		if ScoreboardVisible(f11_arg2) then
			BlockGameFromKeyEvent(f11_arg2)
			return true
		else

		end
	end, function (f12_arg0, f12_arg1, f12_arg2)
		if ScoreboardVisible(f12_arg2) then
			CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton.LUI_KEY_XBA_PSCROSS, "")
			return false
		else
			return false
		end
	end, false)
	Widget:addElement(f3_local2)
	Widget.ScoreboardFactionScoresListCP0 = f3_local2
	
	local f3_local3 = CoD.ScoreboardWidgetButtonContainer.new(HudRef, InstanceRef)
	f3_local3:setLeftRight(true, false, 88.5, 533.5)
	f3_local3:setTopBottom(true, false, 152, 184)
	Widget:addElement(f3_local3)
	Widget.ScoreboardWidgetButtonContainer = f3_local3
	
	Widget.clipsPerState = {DefaultState = {DefaultClip = function ()
		Widget:setupElementClipCounter(3)
		f3_local1:completeAnimation()
		Widget.ScoreboardHeaderWidgetCP0:setAlpha(0)
		Widget.clipFinished(f3_local1, {})
		f3_local2:completeAnimation()
		Widget.ScoreboardFactionScoresListCP0:setAlpha(0)
		Widget.clipFinished(f3_local2, {})
		f3_local3:completeAnimation()
		Widget.ScoreboardWidgetButtonContainer:setAlpha(0)
		Widget.clipFinished(f3_local3, {})
	end, Intro = function ()
		Widget:setupElementClipCounter(2)
		f3_local1:completeAnimation()
		Widget.ScoreboardHeaderWidgetCP0:setAlpha(0)
		local f14_local0 = function (f28_arg0, f28_arg1)
			if not f28_arg1.interrupted then
				f28_arg0:beginAnimation("keyframe", 189, false, false, CoD.TweenType.Linear)
			end
			f28_arg0:setAlpha(1)
			if f28_arg1.interrupted then
				Widget.clipFinished(f28_arg0, f28_arg1)
			else
				f28_arg0:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end

		f14_local0(f3_local1, {})
		f3_local2:beginAnimation("keyframe", 119, false, false, CoD.TweenType.Linear)
		f3_local2:setAlpha(0)
		f3_local2:registerEventHandler("transition_complete_keyframe", function (Sender, Event)
			if not Event.interrupted then
				Sender:beginAnimation("keyframe", 289, false, false, CoD.TweenType.Bounce)
			end
			Sender:setAlpha(1)
			if Event.interrupted then
				Widget.clipFinished(Sender, Event)
			else
				Sender:registerEventHandler("transition_complete_keyframe", Widget.clipFinished)
			end
		end)
	end}, ArabicZombieAAR = {DefaultClip = function ()
		Widget:setupElementClipCounter(3)
		f3_local1:completeAnimation()
		Widget.ScoreboardHeaderWidgetCP0:setLeftRight(true, false, 152.5, 954.5)
		Widget.ScoreboardHeaderWidgetCP0:setTopBottom(true, false, 0, 32)
		Widget.ScoreboardHeaderWidgetCP0:setAlpha(1)
		Widget.clipFinished(f3_local1, {})
		f3_local2:completeAnimation()
		Widget.ScoreboardFactionScoresListCP0:setAlpha(1)
		Widget.clipFinished(f3_local2, {})
		f3_local3:completeAnimation()
		Widget.ScoreboardWidgetButtonContainer:setAlpha(0)
		Widget.clipFinished(f3_local3, {})
	end}, Visible = {DefaultClip = function ()
		Widget:setupElementClipCounter(3)
		f3_local1:completeAnimation()
		Widget.ScoreboardHeaderWidgetCP0:setAlpha(1)
		Widget.clipFinished(f3_local1, {})
		f3_local2:completeAnimation()
		Widget.ScoreboardFactionScoresListCP0:setAlpha(1)
		Widget.clipFinished(f3_local2, {})
		f3_local3:completeAnimation()
		Widget.ScoreboardWidgetButtonContainer:setAlpha(1)
		Widget.clipFinished(f3_local3, {})
	end}, ForceVisible = {DefaultClip = function ()
		Widget:setupElementClipCounter(3)
		f3_local1:completeAnimation()
		Widget.ScoreboardHeaderWidgetCP0:setAlpha(1)
		Widget.clipFinished(f3_local1, {})
		f3_local2:completeAnimation()
		Widget.ScoreboardFactionScoresListCP0:setAlpha(1)
		Widget.clipFinished(f3_local2, {})
		f3_local3:completeAnimation()
		Widget.ScoreboardWidgetButtonContainer:setAlpha(1)
		Widget.clipFinished(f3_local3, {})
	end}, Frontend = {DefaultClip = function ()
		Widget:setupElementClipCounter(3)
		f3_local1:completeAnimation()
		Widget.ScoreboardHeaderWidgetCP0:setAlpha(0)
		Widget.clipFinished(f3_local1, {})
		f3_local2:completeAnimation()
		Widget.ScoreboardFactionScoresListCP0:setAlpha(1)
		Widget.clipFinished(f3_local2, {})
		f3_local3:completeAnimation()
		Widget.ScoreboardWidgetButtonContainer:setAlpha(1)
		Widget.clipFinished(f3_local3, {})
	end}}
	Widget:mergeStateConditions({{stateName = "ArabicZombieAAR", condition = function (HudRef, ItemRef, UpdateTable)
		local f19_local0 = IsCurrentLanguageArabic()
		if f19_local0 then
			f19_local0 = IsZombies()
			if f19_local0 then
				f19_local0 = AlwaysFalse()
			end
		end
		return f19_local0
	end}, {stateName = "Visible", condition = function (HudRef, ItemRef, UpdateTable)
		return Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN)
	end}, {stateName = "ForceVisible", condition = function (HudRef, ItemRef, UpdateTable)
		return IsModelValueEqualTo(InstanceRef, "forceScoreboard", 1)
	end}, {stateName = "Frontend", condition = function (HudRef, ItemRef, UpdateTable)
		return not IsInGame()
	end}})
	Widget:subscribeToModel(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.lobbyNav"), function (ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "lobbyRoot.lobbyNav"})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), function (ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN})
	end)
	Widget:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "forceScoreboard"), function (ModelRef)
		HudRef:updateElementState(Widget, {name = "model_validation", menu = HudRef, modelValue = Engine.GetModelValue(ModelRef), modelName = "forceScoreboard"})
	end)
	f3_local2.id = "ScoreboardFactionScoresListCP0"
	f3_local3:setModel(HudRef.buttonModel, InstanceRef)
	Widget:registerEventHandler("gain_focus", function (Sender, Event)
		if Sender.m_focusable then
			local f26_local0 = Sender.ScoreboardFactionScoresListCP0
			if f26_local0:processEvent(Event) then
				return true
			end
		end
		return LUI.UIElement.gainFocus(Sender, Event)
	end)
	LUI.OverrideFunction_CallOriginalSecond(Widget, "close", function (Sender)
		Sender.ScoreboardHeaderWidgetCP0:close()
		Sender.ScoreboardFactionScoresListCP0:close()
		Sender.ScoreboardWidgetButtonContainer:close()
	end)
	if f0_local0 then
		f0_local0(Widget, InstanceRef, HudRef)
	end
	return Widget
end


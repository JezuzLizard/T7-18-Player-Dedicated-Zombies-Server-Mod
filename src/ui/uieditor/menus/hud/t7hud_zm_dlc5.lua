require("ui.uieditor.widgets.HUD.ZM_Perks.ZMPerksContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_RoundWidget.ZmRndContainer")
require("ui.uieditor.widgets.HUD.ZM_AmmoWidgetFactory.ZmAmmoContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_Score.ZMScr")
require("ui.uieditor.widgets.DynamicContainerWidget")
require("ui.uieditor.widgets.Notifications.Notification")
require("ui.uieditor.widgets.HUD.ZM_NotifFactory.ZmNotifBGB_ContainerFactory")
require("ui.uieditor.widgets.HUD.ZM_CursorHint.ZMCursorHint")
require("ui.uieditor.widgets.HUD.CenterConsole.CenterConsole")
require("ui.uieditor.widgets.HUD.DeadSpectate.DeadSpectate")
require("ui.uieditor.widgets.MPHudWidgets.ScorePopup.MPScr")
require("ui.uieditor.widgets.HUD.ZM_PrematchCountdown.ZM_PrematchCountdown")
require("ui.uieditor.widgets.Scoreboard.CP.ScoreboardWidgetCP")
require("ui.uieditor.widgets.HUD.ZM_TimeBar.ZM_BeastmodeTimeBarWidget")
require("ui.uieditor.widgets.Chat.inGame.IngameChatClientContainer")
require("ui.uieditor.widgets.BubbleGumBuffs.BubbleGumPackInGame")
require("ui.uieditor.widgets.ZM_InventoryFactory.SidequestIconInventoryWidget")
require("ui.uieditor.widgets.ZM_InventoryFactory.SidequestIconNotificationWidget")
CoD.Zombie.CommonHudRequire()
local f0_local0 = function (f1_arg0, f1_arg1)
	CoD.Zombie.CommonPreLoadHud(f1_arg0, f1_arg1)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	CoD.Zombie.CommonPostLoadHud(f2_arg0, f2_arg1)
end

LUI.createMenu.T7Hud_zm_dlc5 = function (InstanceRef)
	local HudRef = CoD.Menu.NewForUIEditor("T7Hud_zm_dlc5")
	if f0_local0 then
		f0_local0(HudRef, InstanceRef)
	end
	HudRef.soundSet = "HUD"
	HudRef:setOwner(InstanceRef)
	HudRef:setLeftRight(true, true, 0, 0)
	HudRef:setTopBottom(true, true, 0, 0)
	HudRef:playSound("menu_open", InstanceRef)
	HudRef.buttonModel = Engine.CreateModel(Engine.GetModelForController(InstanceRef), "T7Hud_zm_dlc5.buttonPrompts")
	local f3_local1 = HudRef
	HudRef.anyChildUsesUpdateState = true
	local f3_local2 = CoD.ZMPerksContainerFactory.new(f3_local1, InstanceRef)
	f3_local2:setLeftRight(true, false, 130, 281)
	f3_local2:setTopBottom(false, true, -62, -26)
	HudRef:addElement(f3_local2)
	HudRef.ZMPerksContainerFactory = f3_local2
	
	local f3_local3 = CoD.ZmRndContainer.new(f3_local1, InstanceRef)
	f3_local3:setLeftRight(true, false, -32, 192)
	f3_local3:setTopBottom(false, true, -174, 18)
	f3_local3:setScale(0.8)
	HudRef:addElement(f3_local3)
	HudRef.Rounds = f3_local3
	
	local f3_local4 = CoD.ZmAmmoContainerFactory.new(f3_local1, InstanceRef)
	f3_local4:setLeftRight(false, true, -427, 3)
	f3_local4:setTopBottom(false, true, -232, 0)
	HudRef:addElement(f3_local4)
	HudRef.Ammo = f3_local4
	
	-- local f3_local5 = CoD.ZMScr.new(f3_local1, InstanceRef)
	-- f3_local5:setLeftRight(true, false, 30, 164)
	-- f3_local5:setTopBottom(false, true, -256, -128)
	-- f3_local5:setYRot(30)
	-- f3_local5:mergeStateConditions({{stateName = "HudStart", condition = function (HudRef, ItemRef, UpdateTable)
	-- 	local f4_local0 = IsModelValueTrue(InstanceRef, "hudItems.playerSpawned")
	-- 	if f4_local0 then
	-- 		if Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_GAME_ENDED) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_KILLCAM) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_SCOPED) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_VEHICLE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC) then
	-- 			f4_local0 = not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_EMP_ACTIVE)
	-- 		else
	-- 			f4_local0 = false
	-- 		end
	-- 	end
	-- 	return f4_local0
	-- end}})
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "hudItems.playerSpawned"), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "hudItems.playerSpawned"})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_WEAPON_HUD_VISIBLE})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_GAME_ENDED})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_CAMERA_MODE_MOVIECAM})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_DEMO_ALL_GAME_HUD_HIDDEN})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_KILLCAM})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_SCOPED})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_VEHICLE})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SCOREBOARD_OPEN})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_REMOTE_KILLSTREAK_STATIC})
	-- end)
	-- f3_local5:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE), function (ModelRef)
	-- 	f3_local1:updateElementState(f3_local5, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_EMP_ACTIVE})
	-- end)
	-- HudRef:addElement(f3_local5)
	-- HudRef.Score = f3_local5
	
	local f3_local6 = CoD.DynamicContainerWidget.new(f3_local1, InstanceRef)
	f3_local6:setLeftRight(false, false, -640, 640)
	f3_local6:setTopBottom(false, false, -360, 360)
	HudRef:addElement(f3_local6)
	HudRef.fullscreenContainer = f3_local6
	
	local f3_local7 = CoD.Notification.new(f3_local1, InstanceRef)
	f3_local7:setLeftRight(true, true, 0, 0)
	f3_local7:setTopBottom(true, true, 0, 0)
	HudRef:addElement(f3_local7)
	HudRef.Notifications = f3_local7
	
	local f3_local8 = CoD.ZmNotifBGB_ContainerFactory.new(f3_local1, InstanceRef)
	f3_local8:setLeftRight(false, false, -156, 156)
	f3_local8:setTopBottom(true, false, -6, 247)
	f3_local8:setScale(0.75)
	f3_local8:subscribeToGlobalModel(InstanceRef, "PerController", "scriptNotify", function (ModelRef)
		local f21_local0 = f3_local8
		if IsParamModelEqualToString(ModelRef, "zombie_bgb_token_notification") then
			AddZombieBGBTokenNotification(HudRef, f21_local0, InstanceRef, ModelRef)
		elseif IsParamModelEqualToString(ModelRef, "zombie_bgb_notification") then
			AddZombieBGBNotification(HudRef, f21_local0, ModelRef)
		elseif IsParamModelEqualToString(ModelRef, "zombie_notification") then
			AddZombieNotification(HudRef, f21_local0, ModelRef)
		end
	end)
	HudRef:addElement(f3_local8)
	HudRef.ZmNotifBGBContainerFactory = f3_local8
	
	local f3_local9 = CoD.ZMCursorHint.new(f3_local1, InstanceRef)
	f3_local9:setLeftRight(false, false, -250, 250)
	f3_local9:setTopBottom(true, false, 522, 616)
	f3_local9:mergeStateConditions({{stateName = "Active_1x1", condition = function (HudRef, ItemRef, UpdateTable)
		local f22_local0 = IsCursorHintActive(InstanceRef)
		if f22_local0 then
			if not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) or not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) or Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(InstanceRef), "cursorHintIconRatio")) ~= 1 then
				f22_local0 = false
			else
				f22_local0 = true
			end
		end
		return f22_local0
	end}, {stateName = "Active_2x1", condition = function (HudRef, ItemRef, UpdateTable)
		local f23_local0 = IsCursorHintActive(InstanceRef)
		if f23_local0 then
			if not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) or not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) or Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(InstanceRef), "cursorHintIconRatio")) ~= 2 then
				f23_local0 = false
			else
				f23_local0 = true
			end
		end
		return f23_local0
	end}, {stateName = "Active_4x1", condition = function (HudRef, ItemRef, UpdateTable)
		local f24_local0 = IsCursorHintActive(InstanceRef)
		if f24_local0 then
			if not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) or not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) or not not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) or Engine.GetModelValue(Engine.GetModel(DataSources.HUDItems.getModel(InstanceRef), "cursorHintIconRatio")) ~= 4 then
				f24_local0 = false
			else
				f24_local0 = true
			end
		end
		return f24_local0
	end}, {stateName = "Active_NoImage", condition = function (HudRef, ItemRef, UpdateTable)
		local f25_local0 = IsCursorHintActive(InstanceRef)
		if f25_local0 then
			if not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_HARDCORE) and Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_HUD_VISIBLE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT) and not Engine.IsVisibilityBitSet(InstanceRef, Enum.UIVisibilityBit.BIT_UI_ACTIVE) then
				f25_local0 = IsModelValueEqualTo(InstanceRef, "hudItems.cursorHintIconRatio", 0)
			else
				f25_local0 = false
			end
		end
		return f25_local0
	end}})
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "hudItems.showCursorHint"), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "hudItems.showCursorHint"})
	end)
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_HARDCORE})
	end)
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_HUD_VISIBLE})
	end)
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IN_GUIDED_MISSILE})
	end)
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_DEMO_PLAYING})
	end)
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_IS_FLASH_BANGED})
	end)
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SELECTING_LOCATIONAL_KILLSTREAK})
	end)
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_SPECTATING_CLIENT})
	end)
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit.BIT_UI_ACTIVE})
	end)
	f3_local9:subscribeToModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "hudItems.cursorHintIconRatio"), function (ModelRef)
		f3_local1:updateElementState(f3_local9, {name = "model_validation", menu = f3_local1, modelValue = Engine.GetModelValue(ModelRef), modelName = "hudItems.cursorHintIconRatio"})
	end)
	HudRef:addElement(f3_local9)
	HudRef.CursorHint = f3_local9
	
	local f3_local10 = CoD.CenterConsole.new(f3_local1, InstanceRef)
	f3_local10:setLeftRight(false, false, -370, 370)
	f3_local10:setTopBottom(true, false, 68.5, 166.5)
	HudRef:addElement(f3_local10)
	HudRef.ConsoleCenter = f3_local10
	
	local f3_local11 = CoD.DeadSpectate.new(f3_local1, InstanceRef)
	f3_local11:setLeftRight(false, false, -150, 150)
	f3_local11:setTopBottom(false, true, -180, -120)
	HudRef:addElement(f3_local11)
	HudRef.DeadSpectate = f3_local11
	
	local f3_local12 = CoD.MPScr.new(f3_local1, InstanceRef)
	f3_local12:setLeftRight(false, false, -50, 50)
	f3_local12:setTopBottom(true, false, 233.5, 258.5)
	f3_local12:subscribeToGlobalModel(InstanceRef, "PerController", "scriptNotify", function (ModelRef)
		if IsParamModelEqualToString(ModelRef, "score_event") and PropertyIsTrue(HudRef, "menuLoaded") then
			PlayClipOnElement(HudRef, {elementName = "MPScore", clipName = "NormalScore"}, InstanceRef)
			SetMPScoreText(f3_local1, f3_local12, InstanceRef, ModelRef)
		end
	end)
	HudRef:addElement(f3_local12)
	HudRef.MPScore = f3_local12
	
	local f3_local13 = CoD.ZM_PrematchCountdown.new(f3_local1, InstanceRef)
	f3_local13:setLeftRight(false, false, -640, 640)
	f3_local13:setTopBottom(false, false, -360, 360)
	HudRef:addElement(f3_local13)
	HudRef.ZMPrematchCountdown0 = f3_local13
	
	local f3_local14 = CoD.ScoreboardWidgetCP.new(f3_local1, InstanceRef)
	f3_local14:setLeftRight(false, false, -503, 503)
	f3_local14:setTopBottom(true, false, 247, 773)
	HudRef:addElement(f3_local14)
	HudRef.ScoreboardWidget = f3_local14
	
	local f3_local15 = CoD.ZM_BeastmodeTimeBarWidget.new(f3_local1, InstanceRef)
	f3_local15:setLeftRight(false, false, -242.5, 321.5)
	f3_local15:setTopBottom(false, true, -174, -18)
	f3_local15:setScale(0.7)
	HudRef:addElement(f3_local15)
	HudRef.ZMBeastBar = f3_local15
	
	local f3_local16 = CoD.IngameChatClientContainer.new(f3_local1, InstanceRef)
	f3_local16:setLeftRight(true, false, 0, 360)
	f3_local16:setTopBottom(true, false, -2.5, 717.5)
	HudRef:addElement(f3_local16)
	HudRef.IngameChatClientContainer = f3_local16
	
	local f3_local17 = CoD.IngameChatClientContainer.new(f3_local1, InstanceRef)
	f3_local17:setLeftRight(true, false, 0, 360)
	f3_local17:setTopBottom(true, false, -2.5, 717.5)
	HudRef:addElement(f3_local17)
	HudRef.IngameChatClientContainer0 = f3_local17
	
	local f3_local18 = CoD.BubbleGumPackInGame.new(f3_local1, InstanceRef)
	f3_local18:setLeftRight(false, false, -184, 184)
	f3_local18:setTopBottom(true, false, 36, 185)
	HudRef:addElement(f3_local18)
	HudRef.BubbleGumPackInGame = f3_local18
	
	local f3_local19 = CoD.SidequestIconInventoryWidget.new(f3_local1, InstanceRef)
	f3_local19:setLeftRight(false, false, -201.5, 201.5)
	f3_local19:setTopBottom(false, true, -106, -12)
	HudRef:addElement(f3_local19)
	HudRef.SidequestIconInventoryWidget = f3_local19
	
	local f3_local20, f3_local21 = nil
	local f3_local22 = LUI.GridLayout.new(f3_local1, InstanceRef, false, 0, 0, 2, 0, f3_local20, f3_local21, false, false, 0, 0, false, false)
	f3_local22:setLeftRight(true, false, -2, 94)
	f3_local22:setTopBottom(false, false, -344.5, 45.5)
	f3_local22:setScale(0.87)
	f3_local22:setWidgetType(CoD.SidequestIconNotificationWidget)
	f3_local22:setVerticalCount(4)
	f3_local22:setDataSource("ZMSidequestIconList")
	f3_local22:mergeStateConditions({{stateName = "Scoreboard", condition = function (HudRef, ItemRef, UpdateTable)
		return AlwaysFalse()
	end}})
	HudRef:addElement(f3_local22)
	HudRef.SidequestNotificationList = f3_local22
	
	-- f3_local5.navigation = {up = f3_local14, right = f3_local14}
	-- f3_local14.navigation = {left = f3_local5, down = f3_local5}
	CoD.Menu.AddNavigationHandler(f3_local1, HudRef, InstanceRef)
	HudRef:registerEventHandler("menu_loaded", function (Sender, Event)
		local f38_local0 = nil
		SizeToSafeArea(Sender, InstanceRef)
		SetProperty(HudRef, "menuLoaded", true)
		if not f38_local0 then
			f38_local0 = Sender:dispatchEventToChildren(Event)
		end
		return f38_local0
	end)
	-- f3_local5.id = "Score"
	f3_local14.id = "ScoreboardWidget"
	HudRef:processEvent({name = "menu_loaded", controller = InstanceRef})
	HudRef:processEvent({name = "update_state", menu = f3_local1})
	if not HudRef:restoreState() then
		HudRef.ScoreboardWidget:processEvent({name = "gain_focus", controller = InstanceRef})
	end
	LUI.OverrideFunction_CallOriginalSecond(HudRef, "close", function (Sender)
		Sender.ZMPerksContainerFactory:close()
		Sender.Rounds:close()
		Sender.Ammo:close()
		Sender.Score:close()
		Sender.fullscreenContainer:close()
		Sender.Notifications:close()
		Sender.ZmNotifBGBContainerFactory:close()
		Sender.CursorHint:close()
		Sender.ConsoleCenter:close()
		Sender.DeadSpectate:close()
		Sender.MPScore:close()
		Sender.ZMPrematchCountdown0:close()
		Sender.ScoreboardWidget:close()
		Sender.ZMBeastBar:close()
		Sender.IngameChatClientContainer:close()
		Sender.IngameChatClientContainer0:close()
		Sender.BubbleGumPackInGame:close()
		Sender.SidequestIconInventoryWidget:close()
		Sender.SidequestNotificationList:close()
		Engine.UnsubscribeAndFreeModel(Engine.GetModel(Engine.GetModelForController(InstanceRef), "T7Hud_zm_dlc5.buttonPrompts"))
	end)
	if f0_local1 then
		f0_local1(HudRef, InstanceRef)
	end
	return HudRef
end


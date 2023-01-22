require( "ui_mp.t6.hud.loadingog" )

LUI.createMenu.Loading = function ( f5_arg0 )
	local f5_local0 = CoD.Menu.NewFromState( "Loading", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	} )
	f5_local0.id = "loadingMenu"
	f5_local0:setOwner( f5_arg0 )
	f5_local0:registerEventHandler( "start_loading", CoD.Loading.StartLoading )
	f5_local0:registerEventHandler( "start_spinner", CoD.Loading.StartSpinner )
	f5_local0:registerEventHandler( "fade_in_map_location", CoD.Loading.FadeInMapLocation )
	f5_local0:registerEventHandler( "fade_in_gametype", CoD.Loading.FadeInGametype )
	f5_local0:registerEventHandler( "fade_in_map_image", CoD.Loading.FadeInMapImage )
	local f5_local1 = false
	local f5_local2 = Engine.GetCurrentMap()
	local f5_local3 = Engine.GetCurrentGameType()
	local f5_local4 = CoD.GetMapValue( f5_local2, "loadingImage", "black" )
	if CoD.isZombie then
		-- if f5_local2 ~= nil and f5_local2 == "zm_island" and IsJapaneseSku() and CoD.LANGUAGE_JAPANESE == Dvar.loc_language:get() then
		-- 	f5_local1 = false
		-- elseif f5_local2 ~= nil and (f5_local2 == "zm_asylum" or f5_local2 == "zm_cosmodrome" or f5_local2 == "zm_moon" or f5_local2 == "zm_sumpf" or f5_local2 == "zm_temple") then
		-- 	f5_local1 = false
		-- elseif Engine.IsDemoPlaying() or Engine.IsSplitscreen() then
		-- 	f5_local1 = false
		-- elseif Engine.GetLobbyClientCount( Enum.LobbyType.LOBBY_TYPE_GAME ) <= 1 then
		-- 	f5_local1 = true
		-- 	local f5_local5 = CoD.GetMapValue( f5_local2, "introMovie" )
		-- 	if f5_local5 == nil and Mods_IsUsingUsermap() then
		-- 		f5_local5 = f5_local2 .. "_load"
		-- 	end
		-- 	if f5_local5 ~= nil and not Engine.IsCinematicPlaying() then
		-- 		Engine.StartLoadingCinematic( f5_local5 )
		-- 	end
		-- 	f5_local1 = true
		-- else
		-- 	f5_local1 = false
		-- end
		if not f5_local1 then
			Engine.PlayMenuMusic( "load_" .. f5_local2 )
		end
	else
		if true == Dvar.ui_useloadingmovie:get() or CoD.isCampaign then
			if true == Engine.IsCampaignModeZombies() then
				f5_local2 = f5_local2 .. "_nightmares"
			end
			local f5_local6 = CoD.GetMapValue( f5_local2, "introMovie" )
			if f5_local2 ~= nil and f5_local2 == "cp_sh_singapore" and Dvar.cp_queued_level:get() == "cp_mi_sing_blackstation" then
				f5_local6 = "CP_safehouse_load_loadingmovie"
			end
			if f5_local6 ~= nil and not Engine.IsCinematicPlaying() then
				Engine.StartLoadingCinematic( f5_local6 )
			end
			Engine.SetDvar( "ui_useloadingmovie", 0 )
		end
		f5_local1 = false
		if Dvar.art_review:get() ~= "1" and (CoD.isCampaign or CoD.isZombie) and Engine.IsCinematicStarted() then
			f5_local1 = true
		end
	end
	if f5_local1 then
		if CoD.GetMapValue( f5_local2, "fadeToWhite" ) == 1 then
			local f5_local7 = "$white"
		end
		f5_local4 = f5_local7 or "black"
	else
		Engine.SetDvar( "ui_useloadingmovie", 0 )
		if f5_local4 == nil or f5_local4 == "" or CoD.isMultiplayer then
			f5_local4 = "black"
		end
	end
	if Engine.IsLevelPreloaded( f5_local2 ) then
		f5_local0.addLoadingElement = function ( f6_arg0, f6_arg1 )
			
		end
		
	else
		f5_local0.addLoadingElement = function ( f7_arg0, f7_arg1 )
			f7_arg0:addElement( f7_arg1 )
		end
		
	end
	f5_local0.mapImage = LUI.UIStreamedImage.new()
	f5_local0.mapImage.id = "mapImage"
	f5_local0.mapImage:setLeftRight( false, false, -640, 640 )
	f5_local0.mapImage:setTopBottom( false, false, -360, 360 )
	f5_local0.mapImage:setMaterial( LUI.UIImage.GetCachedMaterial( "ui_normal" ) )
	f5_local0.mapImage:setImage( RegisterImage( f5_local4 ) )
	f5_local0:addElement( f5_local0.mapImage )
	if f5_local1 == true then
		f5_local0.mapImage:setShaderVector( 0, 0, 0, 0, 0 )
		f5_local0.mapImage.ismp4 = false
	end
	local f5_local6 = 10
	local f5_local5 = 70
	local f5_local8 = "Big"
	local f5_local9 = CoD.fonts[f5_local8]
	local f5_local10 = CoD.textSize[f5_local8]
	local f5_local11 = "Condensed"
	local f5_local12 = CoD.fonts[f5_local11]
	local f5_local13 = CoD.textSize[f5_local11]
	f5_local0.mapNameLabel = LUI.UIText.new()
	f5_local0.mapNameLabel.id = "mapNameLabel"
	f5_local0.mapNameLabel:setLeftRight( true, false, f5_local5, f5_local5 + 1 )
	f5_local0.mapNameLabel:setTopBottom( true, false, f5_local6, f5_local6 + f5_local10 )
	f5_local0.mapNameLabel:setFont( f5_local9 )
	f5_local0.mapNameLabel:setRGB( CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b )
	f5_local0.mapNameLabel:setAlpha( 0 )
	f5_local0.mapNameLabel:registerEventHandler( "transition_complete_map_name_fade_in", CoD.Loading.MapNameFadeInComplete )
	f5_local0:addLoadingElement( f5_local0.mapNameLabel )
	f5_local6 = f5_local6 + f5_local10 - 5
	f5_local0.mapLocationLabel = LUI.UIText.new()
	f5_local0.mapLocationLabel.id = "mapLocationLabel"
	f5_local0.mapLocationLabel:setLeftRight( true, false, f5_local5, f5_local5 + 1 )
	f5_local0.mapLocationLabel:setTopBottom( true, false, f5_local6, f5_local6 + f5_local13 )
	f5_local0.mapLocationLabel:setFont( f5_local12 )
	f5_local0.mapLocationLabel:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	f5_local0.mapLocationLabel:setAlpha( 0 )
	f5_local0.mapLocationLabel:registerEventHandler( "transition_complete_map_location_fade_in", CoD.Loading.MapLocationFadeInComplete )
	f5_local0:addLoadingElement( f5_local0.mapLocationLabel )
	f5_local6 = f5_local6 + f5_local13 - 2
	f5_local0.gametypeLabel = LUI.UIText.new()
	f5_local0.gametypeLabel.id = "gametypeLabel"
	f5_local0.gametypeLabel:setLeftRight( true, false, f5_local5, f5_local5 + 1 )
	f5_local0.gametypeLabel:setTopBottom( true, false, f5_local6, f5_local6 + f5_local13 )
	f5_local0.gametypeLabel:setFont( f5_local12 )
	f5_local0.gametypeLabel:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	f5_local0.gametypeLabel:setAlpha( 0 )
	f5_local0.gametypeLabel:registerEventHandler( "transition_complete_gametype_fade_in", CoD.Loading.GametypeFadeInComplete )
	f5_local0:addLoadingElement( f5_local0.gametypeLabel )
	f5_local6 = f5_local6 + f5_local13 + 5
	local DemoTitle = Engine.Localize( "MPUI_TITLE_CAPS" ) .. ":"
	local f6_local14_1, f6_local14_2, f6_local14_3, f6_local14_4 = GetTextDimensions(DemoTitle, f5_local12, f5_local13)
	local DemoDuration = Engine.Localize( "MPUI_DURATION_CAPS" ) .. ":"
	local f6_local16_1, f6_local16_2, f6_local16_3, f6_local16_4 = GetTextDimensions(DemoDuration, f5_local12, f5_local13)
	local DemoAuthor = Engine.Localize( "MPUI_AUTHOR_CAPS" ) .. ":"
	local f6_local18_1, f6_local18_2, f6_local18_3, f6_local18_4 = GetTextDimensions(DemoAuthor, f5_local12, f5_local13)
	local f5_local20 = math.max(f6_local14_3, f6_local16_3, f6_local18_3) + 10
	local f5_local21 = 0
	if not Engine.IsLevelPreloaded( f5_local2 ) then
		f5_local0.demoInfoContainer = LUI.UIElement.new()
		f5_local0.demoInfoContainer:setLeftRight( true, false, f5_local5, 600 )
		f5_local0.demoInfoContainer:setTopBottom( true, false, f5_local6, f5_local6 + 600 )
		f5_local0.demoInfoContainer:setAlpha( 0 )
		f5_local0:addLoadingElement( f5_local0.demoInfoContainer )
		f5_local0.demoTitleTitle = LUI.UIText.new()
		f5_local0.demoTitleTitle:setLeftRight( true, true, 0, 0 )
		f5_local0.demoTitleTitle:setTopBottom( true, false, f5_local21, f5_local21 + f5_local13 )
		f5_local0.demoTitleTitle:setFont( f5_local12 )
		f5_local0.demoTitleTitle:setRGB( CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b )
		f5_local0.demoTitleTitle:setAlignment( LUI.Alignment.Left )
		f5_local0.demoTitleTitle:setText( DemoTitle )
		SetupAutoHorizontalAlignArabicText( f5_local0.demoTitleTitle )
		f5_local0.demoInfoContainer:addElement( f5_local0.demoTitleTitle )
		f5_local0.demoTitleLabel = LUI.UIText.new()
		f5_local0.demoTitleLabel:setLeftRight( true, true, f5_local20, 0 )
		f5_local0.demoTitleLabel:setTopBottom( true, false, f5_local21, f5_local21 + f5_local13 )
		f5_local0.demoTitleLabel:setFont( f5_local12 )
		f5_local0.demoTitleLabel:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
		f5_local0.demoTitleLabel:setAlignment( LUI.Alignment.Left )
		SetupAutoHorizontalAlignArabicText( f5_local0.demoTitleLabel )
		f5_local0.demoInfoContainer:addElement( f5_local0.demoTitleLabel )
		f5_local21 = f5_local21 + f5_local13 - 2
		f5_local0.demoDurationTitle = LUI.UIText.new()
		f5_local0.demoDurationTitle:setLeftRight( true, true, 0, 0 )
		f5_local0.demoDurationTitle:setTopBottom( true, false, f5_local21, f5_local21 + f5_local13 )
		f5_local0.demoDurationTitle:setFont( f5_local12 )
		f5_local0.demoDurationTitle:setRGB( CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b )
		f5_local0.demoDurationTitle:setAlignment( LUI.Alignment.Left )
		f5_local0.demoDurationTitle:setText( DemoDuration )
		SetupAutoHorizontalAlignArabicText( f5_local0.demoDurationTitle )
		f5_local0.demoInfoContainer:addElement( f5_local0.demoDurationTitle )
		f5_local0.demoDurationLabel = LUI.UIText.new()
		f5_local0.demoDurationLabel:setLeftRight( true, true, f5_local20, 0 )
		f5_local0.demoDurationLabel:setTopBottom( true, false, f5_local21, f5_local21 + f5_local13 )
		f5_local0.demoDurationLabel:setFont( f5_local12 )
		f5_local0.demoDurationLabel:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
		f5_local0.demoDurationLabel:setAlignment( LUI.Alignment.Left )
		SetupAutoHorizontalAlignArabicText( f5_local0.demoDurationLabel )
		f5_local0.demoInfoContainer:addElement( f5_local0.demoDurationLabel )
		f5_local21 = f5_local21 + f5_local13 - 2
		f5_local0.demoAuthorTitle = LUI.UIText.new()
		f5_local0.demoAuthorTitle:setLeftRight( true, true, 0, 0 )
		f5_local0.demoAuthorTitle:setTopBottom( true, false, f5_local21, f5_local21 + f5_local13 )
		f5_local0.demoAuthorTitle:setFont( f5_local12 )
		f5_local0.demoAuthorTitle:setRGB( CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b )
		f5_local0.demoAuthorTitle:setAlignment( LUI.Alignment.Left )
		f5_local0.demoAuthorTitle:setText( DemoAuthor )
		SetupAutoHorizontalAlignArabicText( f5_local0.demoAuthorTitle )
		f5_local0.demoInfoContainer:addElement( f5_local0.demoAuthorTitle )
		f5_local0.demoAuthorLabel = LUI.UIText.new()
		f5_local0.demoAuthorLabel:setLeftRight( true, true, f5_local20, 0 )
		f5_local0.demoAuthorLabel:setTopBottom( true, false, f5_local21, f5_local21 + f5_local13 )
		f5_local0.demoAuthorLabel:setFont( f5_local12 )
		f5_local0.demoAuthorLabel:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
		f5_local0.demoAuthorLabel:setAlignment( LUI.Alignment.Left )
		SetupAutoHorizontalAlignArabicText( f5_local0.demoAuthorLabel )
		f5_local0.demoInfoContainer:addElement( f5_local0.demoAuthorLabel )
	end
	local f5_local22 = 3
	local f5_local23 = CoD.Loading.DYKFontHeight + f5_local22 * 2
	local f5_local24 = 2
	local f5_local25 = f5_local23 + 1 + f5_local24 + CoD.Loading.DYKFontHeight - f5_local6
	local f5_local26 = CoD.Menu.Width - 5 * 2
	local f5_local27 = -200
	local f5_local28 = 0
	local f5_local29 = 2
	local f5_local30 = f5_local23 - f5_local29 * 2
	local f5_local31 = 6
	f5_local0.loadingBarContainer = LUI.UIElement.new()
	f5_local0.loadingBarContainer.id = "loadingBarContainer"
	f5_local0.loadingBarContainer:setLeftRight( false, false, -f5_local26 / 2, f5_local26 / 2 )
	f5_local0.loadingBarContainer:setTopBottom( false, true, f5_local27 - f5_local25, f5_local27 )
	f5_local0.loadingBarContainer:setAlpha( 0 )
	f5_local0:addElement( f5_local0.loadingBarContainer )
	f5_local0.dykContainer = LUI.UIElement.new()
	f5_local0.dykContainer.id = "dykContainer"
	f5_local0.dykContainer:setLeftRight( true, true, 0, 0 )
	f5_local0.dykContainer:setTopBottom( true, false, f5_local28, f5_local28 + f5_local23 )
	f5_local0.dykContainer.containerHeight = f5_local23
	f5_local0.dykContainer.textAreaWidth = f5_local26 - f5_local22 - f5_local31 - f5_local29 - f5_local30 - 1
	f5_local31 = 0
	f5_local28 = f5_local28 + f5_local23 + 1
	f5_local0.spinner = LUI.UIImage.new()
	f5_local0.spinner.id = "spinner"
	f5_local29 = 110
	f5_local30 = f5_local30 * 5
	f5_local0.spinner:setLeftRight( false, true, -(f5_local29 + f5_local30 / 2), -(f5_local29 - f5_local30 / 2) )
	f5_local0.spinner:setTopBottom( false, true, -(f5_local29 + f5_local30 / 2), -(f5_local29 - f5_local30 / 2) )
	f5_local0.spinner:setImage( RegisterMaterial( "lui_loader" ) )
	f5_local0.spinner:setShaderVector( 0, 0, 0, 0, 0 )
	f5_local0.spinner:setAlpha( 0 )
	f5_local0.spinner:setPriority( 200 )
	f5_local0:addElement( f5_local0.spinner )
	local self = LUI.UIImage.new()
	self.id = "loadingBarBackground"
	self:setLeftRight( true, true, 1, -1 )
	self:setTopBottom( true, false, f5_local28, f5_local28 + f5_local24 )
	self:setRGB( 0.1, 0.1, 0.1 )
	f5_local0.loadingBarContainer:addElement( self )
	local self = LUI.UIImage.new()
	self:setLeftRight( true, true, 1, -1 )
	self:setTopBottom( true, false, f5_local28, f5_local28 + f5_local24 )
	self:setRGB( CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b )
	f5_local0.loadingBarContainer:addElement( self )
	local f5_local34 = 1
	local self = LUI.UIImage.new()
	self:setLeftRight( true, true, 2, -2 )
	self:setTopBottom( true, false, f5_local28, f5_local28 + f5_local34 )
	self:setRGB( 1, 1, 1 )
	self:setAlpha( 0.5 )
	f5_local0.loadingBarContainer:addElement( self )
	self:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe" ) )
	self:setShaderVector( 1, 0, 0, 0, 0 )
	self:setShaderVector( 2, 1, 0, 0, 0 )
	self:setShaderVector( 3, 0, 0, 0, 0 )
	self:setShaderVector( 1, 0, 0, 0, 0 )
	self:setShaderVector( 2, 1, 0, 0, 0 )
	self:setShaderVector( 3, 0, 0, 0, 0 )
	self:subscribeToGlobalModel( f5_arg0, "LoadingScreenTeamInfo", "loadedFraction", function ( modelRef )
		local loadedFraction = Engine.GetModelValue( modelRef )
		if loadedFraction then
			self:setShaderVector( 0, loadedFraction, 0, 0, 0 )
			self:setShaderVector( 0, loadedFraction, 0, 0, 0 )
		end
	end )
	LUI.OverrideFunction_CallOriginalSecond( f5_local0, "close", function ( element )
		self:close()
	end )
	f5_local28 = f5_local28 + f5_local24
	f5_local0.statusLabel = LUI.UIText.new()
	f5_local0.statusLabel:setLeftRight( true, true, f5_local22 + f5_local31, 0 )
	f5_local0.statusLabel:setTopBottom( true, false, f5_local28, f5_local28 + CoD.Loading.DYKFontHeight )
	f5_local0.statusLabel:setAlpha( 0.55 )
	f5_local0.statusLabel:setFont( CoD.Loading.DYKFont )
	f5_local0.statusLabel:setAlignment( LUI.Alignment.Left )
	f5_local0.statusLabel:setupLoadingStatusText()
	f5_local0.loadingBarContainer:addElement( f5_local0.statusLabel )
	CoD.Loading.StartLoading( f5_local0 )
	f5_local0:addElement( LUI.UITimer.new( CoD.Loading.SpinnerDelayTime, "start_spinner", true, f5_local0 ) )
	return f5_local0
end


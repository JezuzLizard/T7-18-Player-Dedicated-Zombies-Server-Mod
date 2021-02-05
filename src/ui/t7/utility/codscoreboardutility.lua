CoD.ScoreboardUtility = {}
CoD.ScoreboardUtility.MinRowsToShowOnEachTeam = 16
CoD.ScoreboardUtility.MinRowsToShowOnEachTeamForFFA = 16
CoD.ScoreboardUtility.GetScoreboardTeamTable = function (f1_arg0, f1_arg1)
	local f1_local0 = Engine.GetTeamPositions(f1_arg0, Engine.GetCurrentTeamCount())
	if Engine.GetCurrentTeamCount() < 2 and f1_arg1 == 2 then
		return {}
	end
	local f1_local1 = f1_local0[f1_arg1].team
	local f1_local2 = 0
	local f1_local3 = 0
	if f1_local1 ~= Enum.team_t.TEAM_FREE then
		f1_local2 = Engine.GetScoreboardTeamClientCount(Enum.team_t.TEAM_ALLIES)
		f1_local3 = Engine.GetScoreboardTeamClientCount(Enum.team_t.TEAM_AXIS)
	else
		f1_local2 = Engine.GetScoreboardTeamClientCount(Enum.team_t.TEAM_FREE)
	end
	local f1_local4 = CoD.ScoreboardUtility.MinRowsToShowOnEachTeam
	if Engine.GetCurrentTeamCount() < 2 then
		f1_local4 = CoD.ScoreboardUtility.MinRowsToShowOnEachTeamForFFA
	end
	local f1_local5 = {}
	for f1_local6 = 1, math.max(f1_local4, math.max(f1_local2, f1_local3)), 1 do
		local f1_local7 = "team: " .. f1_local1 .. " client: " .. f1_local6 - 1
		local f1_local8 = -1
		if Engine.GetScoreboardTeamClientCount(f1_local1) < f1_local6 then
			f1_local7 = "team: " .. f1_local1 .. " client: -1"
		else
			f1_local8 = Engine.GetScoreboardPlayerData(f1_local6 - 1, f1_local1, Enum.scoreBoardColumns_e.SCOREBOARD_COLUMN_CLIENTNUM)
		end
		table.insert(f1_local5, {models = {clientInfo = f1_local7 .. " " .. Engine.milliseconds(), clientNum = tonumber(f1_local8)}})
	end
	return f1_local5
end

CoD.ScoreboardUtility.UpdateScoreboardTeamScores = function (f2_arg0)
	local f2_local0 = Engine.GetCurrentTeamCount()
	local f2_local1 = Engine.GetTeamPositions(f2_arg0, f2_local0)
	local f2_local2 = {}
	for f2_local3 = 1, f2_local0, 1 do
		local f2_local4 = {}
		local f2_local5 = f2_local1[f2_local3].team
		f2_local4.FactionName = ""
		f2_local4.FactionIcon = ""
		f2_local4.Score = f2_local1[f2_local3].score
		if f2_local5 ~= Enum.team_t.TEAM_FREE then
			f2_local4.FactionName = CoD.GetTeamNameCaps(f2_local5)
			f2_local4.FactionIcon = CoD.GetTeamFactionIcon(f2_local5)
			f2_local4.FactionColor = CoD.GetTeamFactionColor(f2_local5)
		end
		table.insert(f2_local2, f2_local4)
	end
	for f2_local11, f2_local4 in ipairs(f2_local2) do
		for f2_local8, f2_local9 in pairs(f2_local4) do
			Engine.SetModelValue(Engine.CreateModel(Engine.CreateModel(Engine.GetModelForController(f2_arg0), "scoreboardInfo"), "team" .. f2_local11 .. f2_local8), f2_local9)
		end
	end
end

CoD.ScoreboardUtility.GetTeamEnumAndClientIndex = function (f3_arg0)
	local f3_local0, f3_local1, f3_local2, f3_local3 = string.match(f3_arg0, "(%a+):%s*(%d+)%s+(%a+):%s*(-*%d+)")
	return tonumber(f3_local1), tonumber(f3_local3)
end

CoD.ScoreboardUtility.SetNemesisInfoModels = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.GetPlayerStats(f4_arg0)
	local f4_local1 = f4_local0.AfterActionReportStats
	local f4_local2 = f4_local1.nemesisKills
	local f4_local3 = f4_local1.nemesisKilledBy
	local f4_local4 = f4_local1.nemesisXuid
	Engine.SetModelValue(Engine.CreateModel(f4_arg1, "nemesisXuid"), Engine.StringToXUIDDecimal(f4_local4:get()))
	Engine.SetModelValue(Engine.CreateModel(f4_arg1, "nemesisKills"), f4_local2:get())
	Engine.SetModelValue(Engine.CreateModel(f4_arg1, "nemesisKilledBy"), f4_local3:get())
end

CoD.ScoreboardUtility.SetScoreboardUIModels = function (f5_arg0)
	local f5_local0 = Engine.GetCurrentTeamCount()
	local f5_local1 = Engine.GetModelForController(f5_arg0)
	local f5_local2 = Engine.CreateModel(f5_local1, "scoreboardInfo")
	local f5_local3 = Engine.CreateModel(Engine.GetModelForController(0), "scoreboardInfo")
	if not Engine.GetModel(f5_local1, "forceScoreboard") then
		Engine.SetModelValue(Engine.CreateModel(f5_local1, "forceScoreboard"), 0)
	end
	Engine.SetModelValue(Engine.CreateModel(Engine.GetModelForController(f5_arg0), "updateClientDeadStatus"), 0)
	Engine.SetModelValue(Engine.CreateModel(f5_local2, "muteButtonPromptVisible"), false)
	Engine.SetModelValue(Engine.CreateModel(f5_local2, "muteButtonPromptText"), "")
	local f5_local4 = CoD.GetMapValue(Engine.GetCurrentMapName(), "mapNameCaps", "")
	Engine.SetModelValue(Engine.CreateModel(f5_local2, "mapName"), f5_local4)
	Engine.SetModelValue(Engine.CreateModel(f5_local3, "mapName"), f5_local4)
	if Engine.IsMultiplayerGame() then
		if not Engine.IsInGame() then
			CoD.ScoreboardUtility.SetNemesisInfoModels(f5_arg0, f5_local2)
		end
		local f5_local5 = Engine.GetTeamPositions(f5_arg0, f5_local0)
		local f5_local6 = {}
		for f5_local7 = 1, f5_local0, 1 do
			local f5_local8 = {}
			local f5_local9 = f5_local5[f5_local7].team
			f5_local8.FactionName = ""
			f5_local8.FactionIcon = ""
			f5_local8.Score = f5_local5[f5_local7].score
			if f5_local9 ~= Enum.team_t.TEAM_FREE then
				f5_local8.FactionName = CoD.GetTeamNameCaps(f5_local9)
				f5_local8.FactionIcon = CoD.GetTeamFactionIcon(f5_local9)
				f5_local8.FactionColor = CoD.GetTeamFactionColor(f5_local9)
			end
			table.insert(f5_local6, f5_local8)
		end
		for f5_local15, f5_local8 in ipairs(f5_local6) do
			for f5_local12, f5_local13 in pairs(f5_local8) do
				Engine.SetModelValue(Engine.CreateModel(f5_local2, "team" .. f5_local15 .. f5_local12), f5_local13)
			end
		end
		f5_local7 = Engine.StructTableLookupString(CoDShared.gametypesStructTable, "name", Engine.GetCurrentGameType(), "name_ref_caps")
		Engine.SetModelValue(Engine.CreateModel(f5_local2, "gameType"), f5_local7)
		Engine.SetModelValue(Engine.CreateModel(f5_local3, "gameType"), f5_local7)
		if f5_local0 < 2 then
			f5_local10 = Engine.GetModel(f5_local1, "gameScore.playerScore")
			if f5_local10 then
				Engine.SetModelValue(Engine.CreateModel(f5_local2, "team1Score"), Engine.GetModelValue(f5_local10))
			else
				for f5_local6 = 1, 5, 1 do
					Engine.SetModelValue(Engine.CreateModel(f5_local2, "column" .. f5_local6 .. "Header"), Engine.GetScoreboardColumnHeader(f5_arg0, f5_local6 - 1))
				end
			end
		else
			for f5_local6 = 1, 5, 1 do
				Engine.SetModelValue(Engine.CreateModel(f5_local2, "column" .. f5_local6 .. "Header"), Engine.GetScoreboardColumnHeader(f5_arg0, f5_local6 - 1))
			end
		end
	end
	for f5_local6 = 1, 5, 1 do
		Engine.SetModelValue(Engine.CreateModel(f5_local2, "column" .. f5_local6 .. "Header"), Engine.GetScoreboardColumnHeader(f5_arg0, f5_local6 - 1))
	end
end


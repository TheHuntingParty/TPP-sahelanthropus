local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local sequences = {}




this.ENABLE_DEFAULT_HELI_MISSION_CLEAR = true

this.EQUIP_MISSION_BLOCK_GROUP_SIZE = 1500000




this.SHOT_SKULL_TIME = 15
this.FLASHBACK_TIME = 0.5
this.MAX_SHOT_COUNT = 3		

local SUPPORT_BULLET_POS = {
	
	trap_supportPos_AREA01 =  Vector3(0, 0, 0),
	trap_supportPos_AREA02 =  Vector3(-27, -49, 271),
	trap_supportPos_AREA03 =  Vector3(364, -49, -48),
	trap_supportPos_AREA04 =  Vector3(334, 88, 396,4),
	trap_supportPos_AREA05 =  Vector3(0, 0, 0),
	trap_supportPos_AREA06 =  Vector3(0, 0, 0),
	trap_supportPos_AREA07 =  Vector3(0, 0, 0),
	trap_supportPos_AREA08 =  Vector3(0, 0, 0),
}




this.missionObjectiveEnum = Tpp.Enum {
	"default_area_Sahelan",
	"default_photo_Sahelan",

	"missionTask_break_Sahelan",
	"firstBonus_MissionTask",
	"secondBonus_MissionTask",
	"clear_missionTask_break_Sahelan",
	"clear_firstBonus_MissionTask",
	"clear_secondBonus_MissionTask",

	"announce_destroyTarget",
	"announce_achieveAllObjectives",

}



this.NPC_ENTRY_POINT_SETTING = {
	[TppDefine.INIT_HELI_ROUTE] = {
		[EntryBuddyType.VEHICLE] = { Vector3(0, 0, 0), TppMath.DegreeToRadian( 281 ) }, 
		[EntryBuddyType.BUDDY] = { Vector3(0, 0, 0), TppMath.DegreeToRadian( 275 ) }, 
	},
}




this.specialBonus = {
	first = {
		missionTask = { taskNo = 1 },
	},
	second = {
		missionTask = { taskNo = 2 },
	},
}




this.rankLimitedSetting = {
	permitSupportHelicopterAttack = true,	
	permitFireSupport = true,				
}








function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences{

		
		
		"Seq_Game_BattleSahelan",			
				
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
end






this.saveVarsList = {
	isPreliminaryFlag01			= false,	
	isPreliminaryFlag02			= false,	
	isPreliminaryFlag03			= false,	
	isPreliminaryFlag04			= false,	
	isPreliminaryFlag05			= false,	
	isPreliminaryFlag06			= false,	
	isPreliminaryFlag07			= false,	
	isPreliminaryFlag08			= false,	
	isPreliminaryFlag09			= false,	
	isPreliminaryFlag10			= false,	
	isPreliminaryFlag11			= false,	
	isPreliminaryFlag12			= false,	
	isPreliminaryFlag13			= false,	
	isPreliminaryFlag14			= false,	
	isPreliminaryFlag15			= false,	
	isPreliminaryFlag16			= false,	
	isPreliminaryFlag17			= false,	
	isPreliminaryFlag18			= false,	
	isPreliminaryFlag19			= false,	
	isPreliminaryFlag20			= false,	

	PreliminaryValue01			= 0,		
	PreliminaryValue02			= 0,		
	PreliminaryValue03			= 0,		
	PreliminaryValue04			= 0,		
	PreliminaryValue05			= 0,		
	PreliminaryValue06			= 0,		
	PreliminaryValue07			= 0,		
	PreliminaryValue08			= 0,		
	PreliminaryValue09			= 0,		
	PreliminaryValue10			= 0,		
	
	isCleardS10151			= false,	
}




this.checkPointList = {
	"CHK_BattleSahelan",	
	"CHK_Ending",			
	nil
}


this.baseList = {
	nil
}











function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")
	
	mvars.EscapeCount = 0


end




function this.OnRestoreSVars()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " OnRestoreSVars ***")

	
end


function this.RegiserMissionSystemCallback()
	Fox.Log("!!!! s10151_mission.RegiserMissionSystemCallback !!!!")

	
	
	local systemCallbackTable ={

		OnEstablishMissionClear = this.ReserveMissionClear,
		OnEndMissionCredit = this.ReserveMissionClear,
		OnEndMissionReward = this.ReserveMissionClear,

		OnGameOver = this.OnGameOver,
		nil
	}
	
	TppMission.RegiserMissionSystemCallback(systemCallbackTable)

end



this.OnEstablishMissionClear = function(missionClearType)

	local missionName = TppMission.GetMissionName()
	if missionName == "s13500" then	
		TppUiStatusManager.SetStatus( "MissionTelop", "RESULT_SKIP_CAST" )
	end
end


this.OnEndMissionCredit = function()

	Fox.Log("TppMission.Reload OnEndFadeOut")	

	local missionName = TppMission.GetMissionName()
	if missionName == "s13501" then
		TppSequence.ReserveNextSequence( "Seq_Demo_Ending1", { isExecMissionClear = true })
		
		TppScriptBlock.LoadDemoBlock(
			"Demo_Ending1",
			false 
		)
		TppMission.VarSaveOnUpdateCheckPoint()
		TppMission.DisablePauseForShowResult()
		TppMission.Reload{
			isNoFade = true,								
			showLoadingTips = false,
			missionPackLabelName = "OkbEnding", 			
			locationCode = TppDefine.LOCATION_ID.MTBS, 		
			layoutCode	= TppDefine.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
			clusterId	= TppDefine.CLUSTER_DEFINE.Develop,
		}
	else
		
		TppMission.ShowMissionReward()
	end
end


this.OnEndMissionReward = function()
	local missionName = TppMission.GetMissionName()
	
	if missionName ~= "s13501" then	
		TppMission.MissionFinalize()	

	end
end

function this.ReserveMissionClear()

	local missionName = TppMission.GetMissionName()
	if missionName == "s13500" then
		TppMission.ReserveMissionClear{
			missionClearType = TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,
			nextMissionId = TppDefine.SYS_MISSION_ID.MTBS_FREE
		}
	else
		
		TppMission.ReserveMissionClear{
			missionClearType = TppDefine.TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,
			nextMissionId = TppDefine.SYS_MISSION_ID.AFGH_HELI
		}
	end

end




function this.OnTerminate()
	Fox.Log("____________________________________s13500_sequence.OnTerminate()")

		
		TppUiStatusManager.ClearStatus("AnnounceLog")	

		TppUI.UnsetOverrideFadeInGameStatus()
		TppUiCommand.SetAllInvalidMbSoundControllerVoice( false ) 

		TppGameStatus.Reset( "s13500","S_ENABLE_TUTORIAL_PAUSE" )
		
		TppUiCommand.LyricTexture( "release" ) 

		TppEffectUtility.SetDirtyModelMemoryStrategy("Default")

		
		TppUI.SetFadeColorToBlack()
		
		
		TppEffectUtility.ClearFxCutLevelMaximum()
end


this.OnEndMissionPrepareSequence = function ()

	
	

	if TppSequence.GetMissionStartSequenceName() == "Seq_Game_BattleSahelan" then
		this.CreateEffectSmoke(true)
	end

end







this.missionObjectiveDefine = {

	default_area_Sahelan = {
		
		
		
		
		
	},

	default_photo_Sahelan = {
		photoId	= 10, addFirst = true, photoRadioName = "s0150_mirg0040",
	},

	
	missionTask_break_Sahelan = {
		missionTask = { taskNo=0, isNew=true, isComplete=false },
	},
	clear_missionTask_break_Sahelan = {
		missionTask = { taskNo=0, isNew=true, isComplete=true },
	},

	
	firstBonus_MissionTask = {
		missionTask = { taskNo=1, isNew=true, isComplete=false, isFirstHide=true },
	},
	secondBonus_MissionTask = {
		missionTask = { taskNo=2, isNew=true, isComplete=false, isFirstHide=true },
	},

	clear_firstBonus_MissionTask = {
		missionTask = { taskNo=1, isNew=true},
	},
	clear_secondBonus_MissionTask = {
		missionTask = { taskNo=2, isNew=true },
	},

	
	announce_destroyTarget = {
		announceLog = "destroyTarget",
	},
	announce_achieveAllObjectives = {
		announceLog = "achieveAllObjectives",
	},
}



this.missionObjectiveTree = {
	default_area_Sahelan = {},
	default_photo_Sahelan = {},
	clear_missionTask_break_Sahelan = {
		missionTask_break_Sahelan = {},
	},
	clear_firstBonus_MissionTask = {
		firstBonus_MissionTask = {},
	},
	clear_secondBonus_MissionTask = {
		secondBonus_MissionTask = {},
	},
	announce_destroyTarget = {},
	announce_achieveAllObjectives = {},
}




this.missionStartPosition = {
		helicopterRouteList = {

		},
		orderBoxList = {

		},
}








function this.Messages()
	local messageTable = {
		GameObject = {
			{
				msg = "SahelanAllDead",
				func = function ()
					Fox.Log("SahelanAllDead message received.")		
					
				end,
				option = { isExecMissionClear = true }
			},
			nil
		},
	}
	return
	StrCode32Table( messageTable )
end






local objectiveGroup = {

	MissionStart = function()
		TppMission.UpdateObjective{
			objectives = {
				"default_photo_Sahelan",
				"missionTask_break_Sahelan",
				"firstBonus_MissionTask",
				"secondBonus_MissionTask",
			},
		}

		TppMission.UpdateObjective{
			radio = {
				
				radioGroups = "s0150_rtrg0160",
			},
			objectives = {
				"default_area_Sahelan",
			},
		}

		TppRadio.SetOptionalRadio( "Set_s0150_oprg0030" )
	end,

	BreakSahelan = function()
		TppMission.UpdateObjective{
			objectives = { "announce_destroyTarget" },
		}

		TppMission.UpdateObjective{
			objectives = { "announce_achieveAllObjectives" },
		}

		TppMission.UpdateObjective{
			objectives = {
				"clear_missionTask_break_Sahelan",
			},
		}
	end,

	BreakSahelanHead = function()

		TppMission.UpdateObjective{
			objectives = {
				"clear_firstBonus_MissionTask",
			},
		}

		
		TppResult.AcquireSpecialBonus{
				first = { isComplete = true },
		}

	end,

	HitMaints = function()


		TppMission.UpdateObjective{
			objectives = {
				"clear_secondBonus_MissionTask",
			},
		}

		
		TppResult.AcquireSpecialBonus{
				second = { isComplete = true },
		}

	end,


}


this.UpdateObjectives = function( objectiveName )
	Fox.Log("__________s13500_sequence.UpdateObjectives()  / " .. tostring(objectiveName))
	local Func = objectiveGroup[ objectiveName ]
	if Func and Tpp.IsTypeFunc( Func ) then
		Func()
	end
end



this.SetVisibleUIStatus =function()

	local exceptGameStatus = {}
	for key, value in pairs( TppDefine.GAME_STATUS_TYPE_ALL ) do
		exceptGameStatus[key] = false
	end
	for key, value in pairs( TppDefine.UI_STATUS_TYPE_ALL ) do
		exceptGameStatus[key] = false
	end
	
	exceptGameStatus["PauseMenu"] = nil

	TppUI.OverrideFadeInGameStatus(exceptGameStatus)
end


this.CreateEffectSmoke = function(enabled)
	Fox.Log("______________s13500_sequence.CreateEffectSmoke()")
	



	if enabled then
		TppDataUtility.CreateEffectFromGroupId("BattleFx")

		
		TppDataUtility.CreateEffectFromId("pp_ash")
	else
		TppDataUtility.DestroyEffectFromGroupId("BattleFx")

		
		
	end

end


this.KillAiSahelan = function()
	Fox.Log("______________s13500_sequence.KillAiSahelan()")
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = { id = "SetStopSahelan" }
	GameObject.SendCommand(gameObjectId, command)
end






sequences.Seq_Game_BattleSahelan = {

	Messages = function( self ) 
		
		
		local messageTable = {
			GameObject = {
				{
					msg = "Dead",
					func = function(id)
						Fox.Log("______________s10151_sequence.Seq_Game_BattleSahelan.Messages Dead________________"..tostring(id))
						if id == GameObject.GetGameObjectId("Sahelanthropus") then
							Fox.Log("_______________Sahelanthropus Dead________________")
							self.StopRedStorm()
							self.FuncSahelanDead()
						end
					end,
				},
				{
					msg = "SahelanAllDead",
					func = function ()
						Fox.Log("______________s10151_sequence.Seq_Game_BattleSahelan.Messages SahelanAllDead________________"..tostring(id))
						
						
					end,
					option = { isExecMissionClear = true }
				},
				{
					msg = "Damage",
					func = function (id)
						Fox.Log("______________s10151_sequence.Messages Damage________________"..tostring(id))
						if id == GameObject.GetGameObjectId("Mantis") then
							Fox.Log("_______________MANTIS DAMAGED________________")
							this.UpdateObjectives("HitMaints")

						end
					end,
				},
				{
					msg = "SahelanHeadBroken",
					func = function()
						Fox.Log("______________s10151_sequence.Messages SahelanHeadBroken________________")
						this.UpdateObjectives("BreakSahelanHead")

					end,
				},

				{	
					msg = "SahelanEnableHeliAttack",
					func = function()
						Fox.Log("______________s10151_sequence.Messages SahelanEnableHeliAttack________________")

						
						self.StopRedStorm()
						
						
						GameObject.SendCommand( { type="TppHeli2", index=0, }, { id="SetAntiSahelanEventEnabled", enabled=true } )

						
						
					end,
				},

				{	
					msg = "SahelanGrenadeExplosion",
					func = function()
						Fox.Log("______________s10151_sequence.Messages SahelanGrenadeExplosion________________")
						if mvars.isNormal then
							self.StartRedStrom(60)
						else
							self.StartRedStrom(90)
						end
						
						
					end,
				},
				
				{	
					msg = "SahelanChangePhase",
					func = function(id,phaseName)
						Fox.Log("______________s10151_sequence.Messages SahelanChangePhase________________: "..phaseName)
						
						mvars.SahelanPhase = phaseName
						
						if phaseName == TppSahelan2.SAHELAN2_PHASE_2ND  then 
							s13500_enemy.StartHeliAntiSahelan()

						
						elseif phaseName == TppSahelan2.SAHELAN2_PHASE_7TH then 
							

						elseif phaseName == TppSahelan2.SAHELAN2_PHASE_8TH then 
							
							
	
						end
					end,
				},
				{	
					msg = "Sahelan1stRailGun",
					func = function()
						Fox.Log("______________s10151_sequence.Messages Sahelan1stRailGun________________: ")
						
						mvars.is1stRailGun = true
						
						
						
						
						GameObject.SendCommand( { type="TppHeli2", index=0, }, { id="SetAntiSahelanEventEnabled", enabled=false } )
						
						GameObject.SendCommand( { type="TppHeli2", index=0, }, { id="PullOut" } )  -- makes the heli leave when sahe goes rex mode
					end,
				},
				{	
					msg = "SahelanReturned1stRailGun",
					func = function()
						Fox.Log("______________s10151_sequence.Messages SahelanReturned1stRailGun________________: ")
						
						TppMusicManager.PostSceneSwitchEvent( "Set_Switch_bgm_s10151_up" )	-- after sahe leaves rex mode, music changes here
						
						s13500_radio.SahelanFinalPhase()
					end,
				},
				{	
					msg = "SahelanEnableSuportAttack",
					func = function()
						Fox.Log("______________s10151_sequence.Messages SahelanEnableSuportAttack________________: ")
						if mvars.isNormal then
							self.CallSupportAttack() -- auto call for heli support
						end
					end,
				},
				
				{	
					msg = "SahelanPartsBroken",
					func = function()
						Fox.Log("______________s10151_sequence.Messages SahelanPartsBroken________________: ")
						s13500_radio.PartsBroken() -- when you break a sahe part, ocelot/miller says something
					end,
				},
				
				{	
					msg = "SahelanBlastDamageToWeakPoint",
					func = function()
						Fox.Log("______________s10151_sequence.Messages SahelanBlastDamageToWeakPoint________________: ")
						
						if mvars.CleanHitCount % 3 == 0 then
							s13500_radio.CleanHit()
						end
						
						mvars.CleanHitCount = mvars.CleanHitCount + 1

					end,
				},
				
				{	
					msg = "SahelanSearchMissileToHeli",
					func = function()
						Fox.Log("______________s10151_sequence.Messages SahelanSearchMissileToHeli________________: ")
						s13500_radio.HelpSuportHeli()
						
						--radio call of sahe attacking heli
						self.StopRedStorm()
					end,
				},
				
				
			},

			Player ={
				{
					msg = "OnAmmoStackEmpty",
					func = function()
						Fox.Log("______________s10151_sequence.Messages OnAmmoStackEmpty________________")
						
						self.CallSupportBullet() -- no ammo = auto suply drop
						
					end,
				},
				{
					msg = "StartPlayerBrainFilter", -- no idea what this is
					func = function(id,reasonID)
						Fox.Log("______________s13500_sequence.Messages StartPlayerBrainFilter________________")
						if reasonID == GameObject.GetGameObjectId("Sahelanthropus") then
							mvars.BrainFilterCount = mvars.BrainFilterCount + 1
							Fox.Log("_____mvars.BrainFilterCount : "..tostring(mvars.BrainFilterCount).."_____reasonID : "..tostring(reasonID))

							if mvars.BrainFilterCount % 2 == 0 then
								
								if mvars.isNormal and mvars.SahelanPhase < TppSahelan2.SAHELAN2_PHASE_7TH then
									Fox.Log("_____Sahelan SetSupportAttack")
									local gameObjectId = {type="TppSahelan2", group=0, index=0}
									local command = { id = "SetSupportAttack" }
									GameObject.SendCommand(gameObjectId, command)
								end
							end

						end
					end,
				},

			},

			Timer = {
				{
					msg = "Finish",
					sender = "RedStromTimer",
					func = function()
						self.StopRedStorm()
					end
				},
				
				
				{
					msg = "Finish", -- what happens after sahe dies
					sender = "FadeOutTimer",
					func = function ()
						Fox.Log("______________s10151_sequence.Seq_Game_BattleSahelan.Messages FadeOutTimer________________")
					
					--	TppUI.SetFadeColorToWhite()
					--	TppUI.FadeOut(0.2)
					end,
					option = { isExecMissionClear = true }
				},
				{
					msg = "Finish",
					sender = "SahelanAllDeadTimer",
					func = function ()
						Fox.Log("______________s10151_sequence.Seq_Game_BattleSahelan.Messages SahelanAllDeadTimer________________")
						
						TppMission.FinishBossBattle()
						
						this.ReserveMissionClear()
						
					end,
					option = { isExecMissionClear = true }
				},
			},
			Weather = {
				{	
					msg = "ChangeWeather",
					func = function()
						self.StopRedStorm()
					end
				},
			},
			Trap ={},
			nil
		}
		
		for trapName,s_pos in pairs ( SUPPORT_BULLET_POS ) do
			local trapTableSuppoertPos= {
				msg = "Enter",	sender = trapName,
				func = function ()
					Fox.Log("______s10151_sequence.trapTableSuppoertPos() : ".. tostring(s_pos))
					mvars.SupportPos =  s_pos
				end
			}
			table.insert( messageTable.Trap, trapTableSuppoertPos )
		end
		return StrCode32Table( messageTable )	
	end,

	OnEnter = function(self)
		mvars.SupportPos = SUPPORT_BULLET_POS.trap_supportPos_AREA03	
		mvars.isNormal = false
		mvars.isFirstSupportBullet = false 
		
		local missionName = TppMission.GetMissionName()
		if missionName == "s13500" then	
			mvars.isNormal = true
		end
		
		mvars.BrainFilterCount = 0
		mvars.SahelanPhase = TppSahelan2.SAHELAN2_PHASE_1ST
		mvars.is1stRailGun = false
		mvars.CleanHitCount = 0	
		mvars.isFirstRedFog = false	

		
		mvars.mis_isAlertOutOfMissionArea = false
		TppMission.DisableAlertOutOfMissionArea()

		
		TppTelop.StartMissionObjective()
		
		
		TppMarker.Enable("Sahelanthropus", 0, "attack", "map_and_world_only_icon", 0, false, false , "s0150_mprg0030" )


		
		TppSound.SetSceneBGM( "bgm_sahelan_02")
		
		TppMusicManager.PostSceneSwitchEvent( "Set_Switch_bgm_s13500_normal" )


		this.UpdateObjectives("MissionStart")

		s13500_enemy.SetUpSahelan()

		
		s13500_enemy.SetUpSupportHeli()
		
		
		WeatherManager.RequestTag("Sahelan_fog", 40 )
		
		
		TppWeather.SetWeatherProbabilitiesAfghNoSandStorm()
		
		
		TppMission.StartBossBattle()
		
		
		vars.playerDisableActionFlag = PlayerDisableAction.TIME_CIGARETTE

	end,

	OnLeave = function ()
		TppDataUtility.DestroyEffectFromId( "pp_ash" )

		TppSound.StopSceneBGM()

		s13500_enemy.DisableSupportHeli()

		
		TppMission.UpdateCheckPointAtCurrentPosition()

		
		TppUI.SetFadeColorToBlack()

		
		Player.StopTargetConstrainCamera()
		
		
		this.KillAiSahelan()
	end,


	FuncSahelanDead = function()
	
		GkEventTimerManager.Start( "SahelanAllDeadTimer", 2.2 )
		GkEventTimerManager.Start( "FadeOutTimer", 2.0 )
		
	
		this.UpdateObjectives("BreakSahelan")

		
		TppMission.CanMissionClear()
		
		
	

		
		
	end,

	CallSupportBullet = function()
		Fox.Log("______s13500_sequence.CallSupportBullet()")
		
		

		
		if mvars.isFirstSupportBullet == false then
			mvars.isFirstSupportBullet = true
			TppSupportRequest.RequestDropBullet{ waitLevel=7 }
		else
			TppSupportRequest.RequestDropBullet{ pos = mvars.SupportPos }
		end
		
		
		s13500_radio.HelpSupportBullet()

	end,

	CallSupportAttack = function()
		Fox.Log("______s13500_sequence.CallSupportAttack()")

		s13500_radio.HelpSupportAttack()

		local gameObjectId = {type="TppSahelan2", group=0, index=0}
		local command = { id = "GetPosition" }
		local position = GameObject.SendCommand( gameObjectId, command )

		
		

		TppSupportRequest.RequestSupportAttack{ attackType="BOMBARDMENT_TO_SAHELAN", pos=Vector3(position), attackLevel=5, waitTime=0.0 ,isIgnoreSectionFunc = true }
	end,

	StartRedStrom = function(stormTime)
		Fox.Log("______s10151_sequence.StartRedStrom()")
		WeatherManager.RequestTag("Sahelan_RedFog",7) 
		
		GameObject.SendCommand( { type="TppHeli2", index=0, }, { id="PullOut" } ) 
		
		
		TppSoundDaemon.PostEvent("env_para_storm")
		
		GkEventTimerManager.Start( "RedStromTimer", stormTime )
		
		
		TppMarker.Disable( "Sahelanthropus","",true ) 
		
		
		local gameObjectId = {type="TppSahelan2", group=0, index=0}
		local command = { id = "SetParasiteEffect" }
		GameObject.SendCommand(gameObjectId, command)
		
		
		if mvars.isFirstRedFog == false then
			mvars.isFirstRedFog = true
			for i = 1, 5 do
				local testID = { type="TppVehicle2", index=i }
			
			end
		end
	end,
	
	StopRedStorm = function()
		Fox.Log("______s10151_sequence.StopRedStorm()")
		WeatherManager.RequestTag("Sahelan_fog", 3 )
		
		
		TppMarker.Enable("Sahelanthropus", 0, "attack", "map_and_world_only_icon", 0, false, false , "s0150_mprg0030" )
		
		
		TppSoundDaemon.PostEvent("env_para_storm_end")
	
		
		if not mvars.is1stRailGun then
			s13500_enemy.StartHeliAntiSahelan()
		end
		
		local gameObjectId = {type="TppSahelan2", group=0, index=0}
		local command = { id = "ResetParasiteEffect" }
		GameObject.SendCommand(gameObjectId, command)
	end,


}



return this

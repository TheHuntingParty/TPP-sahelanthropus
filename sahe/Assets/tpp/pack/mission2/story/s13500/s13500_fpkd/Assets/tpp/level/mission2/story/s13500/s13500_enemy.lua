local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}







local SAHELAN_MAX_LIFE = 23000*1.5 



this.sahelanLifeTable = {
	
	Body 	=	12000,	
	Bp 		=	840,	
	Head 	=	3000,	
	ArmR 	=	840,	
	ArmL 	=	840,	
	ThighR 	=	840,	
	ThighL 	=	840,	
	LegR 	=	840,	
	LegL 	=	840,	
	RGun	=	1200,	
	Ldr 	=	840,	
	Tnk		=	840,	
	Shield 	=	SAHELAN_MAX_LIFE * 0,	
	PTLF 	=	96, 
	PTRF 	=	96,
	PTLB 	=	96,
	PTRB 	=	96,
}


local SAHELAN_MAX_LIFE_EX = 44880 



this.sahelanLifeTableEx = {
	
	Body 	=	12000,	
	Bp 		=	900,	
	Head 	=	3500,	
	ArmR 	=	900,	
	ArmL 	=	900,	
	ThighR 	=	900,	
	ThighL 	=	900,	
	LegR 	=	900,	
	LegL 	=	900,	
	RGun	=	1400,	
	Ldr 	=	900,	
	Tnk		=	900,	
	Shield 	=	SAHELAN_MAX_LIFE * 0,	
	PTLF 	=	96, 
	PTRF 	=	96,
	PTLB 	=	96,
	PTRB 	=	96,
}








this.SetUpSahelan = function()

	local TYPE_OKB = 1 
	
	local missionName = TppMission.GetMissionName()
	if missionName == "s13500" then	
		TYPE_OKB = 2
	end
	
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = {
		id = "SetStageType",
		index = TYPE_OKB, 
	}
	GameObject.SendCommand( gameObjectId, command )

	if mvars.isNormal then
		this.SetSahelanLife(SAHELAN_MAX_LIFE)
		this.SetSahelanPartsLife(this.sahelanLifeTable)
	else
		this.SetSahelanLife(SAHELAN_MAX_LIFE_EX)
		this.SetSahelanPartsLife(this.sahelanLifeTableEx)
		
		local gameObjectId = {type="TppSahelan2", group=0, index=0}
		local command = { id = "SetCombatGrade", defenseValue=60000, defenseValueForWeakPoint=20000, offenseGrade=6, defenseGrade=2 }
		GameObject.SendCommand(gameObjectId, command)
	end
	
	
	local command = {id="SetBaseRoute", route="rts_shln_b_1000"} -- Base Route for sahe
																 -- rts_shln_b_1000 is the default one
	GameObject.SendCommand(gameObjectId, command)
	
	
	if DEBUG then
		this.SetUpDebugSahelanParam()
	end
	
end



this.UpdateSahelanRoute = function( trapName )
	Fox.Log("*** s10151_enemy UpdateSahelanRoute ***"..trapName )

	local sahelanRouteTable = this.sahelanRouteTable

	
	for k, v in pairs(sahelanRouteTable) do
		if k == trapName then
			this.SetSahelanRoute( v[1], v[2] )
			return
		end
	end
end


this.SetSahelanLife = function(slife)
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local cmdSetLife = { id = "SetMaxLife", life = slife } 
	GameObject.SendCommand( gameObjectId, cmdSetLife )
end

this.SetSahelanPartsLife =function(sahelanLifeTable)
	for partsName,partsLife in pairs ( sahelanLifeTable ) do
	
		local gameObjectId = {type="TppSahelan2", group=0, index=0}
		local command = { id = "SetMaxPartsLife", parts = partsName, life = partsLife }
		GameObject.SendCommand( gameObjectId, command )
	end
end

this.SetUpDebugSahelanParam = function()






end




this.SetUpSupportHeli = function()
	Fox.Log("______s10151_sequence.SetUpSupportHeli()")
	local gameObjectId = GameObject.GetGameObjectId("SupportHeli")
	GameObject.SendCommand(gameObjectId, { id="SetAntiSahelanEnabled", enabled=true  })
end

this.StartHeliAntiSahelan = function()
	Fox.Log("______s10151_sequence.StartHeliAntiSahelan()")
	local gameObjectId = GameObject.GetGameObjectId("SupportHeli")
	GameObject.SendCommand(gameObjectId, { id="StartAntiSahelan", startPosition=Vector3(172,207,-208) , pullOutPosition=Vector3(172,207,-208)} )
end

this.DisableSupportHeli = function()
	Fox.Log("______s10151_sequence.DisableSupportHeli()")
	local gameObjectId = GameObject.GetGameObjectId("SupportHeli")
	GameObject.SendCommand(gameObjectId, { id="ChangeToIdleState"})
end





this.combatSetting = {
	nil
}





this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	--TppEffectUtility.SetDirtyModelMemoryStrategy("ExtraVehicle")
			
	
	
end


this.OnLoad = function ()
	Fox.Log("*** s10151_enemy onload ***")
end




return this


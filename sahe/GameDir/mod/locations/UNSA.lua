local this={
	description="UNSA MAP", --An IH-only thing I think?
	locationName="UNSA", --Four-letter name of the map
	locationId=139, --LocationId, also found in the TppLocationData in pack_common.fpkd's common_data DataSet, though there it can be set to 0, like here and in MGO maps, and it works fine. Here the id is near-after 113, the last MGO map.
	packs={

		"/Assets/tpp/pack/location/unsa/unsa.fpk"

			},
		
		-- TppMissionList.locationPackTable entry. 

	 locationMapParams={ -- These are the iDroid map parameters we'd find in /Assets/tpp/pack/mbdvc/mb_dvc_top_fpkd/Assets/tpp/ui/Script/mbdvc_map_location_parameter.lua
		 stageSize=4096,
		 scrollMaxLeftUpPosition=Vector3(-4000,0,-4000),
		 scrollMaxRightDownPosition=Vector3(4000,0,4000),
		 highZoomScale=2,
		 middleZoomScale=1,
		 lowZoomScale=0.75,
		 naviHighZoomScale = 2,
		 naviMiddleZoomScale	= 1,
		 locationNameLangId="tpp_loc_unsa",
		 stageRotate=0,
		 heightMapTexturePath="/Assets/tpp/ui/texture/map/unsa/afgh_height_clp.ftex",
		 photoRealMapTexturePath="/Assets/tpp/ui/texture/map/unsa/afgh_height_clp_alp.ftex",
		-- uniqueTownTexturePath="/Assets/tpp/ui/texture/map/building_icon/mb_map_bild_icon_afgh_alp_clp.ftex",
		-- commonTownTexturePath="/Assets/tpp/ui/texture/map/building_icon/mb_map_bild_icon_cmn_alp_clp.ftex",
		 townParameter = {
			 { 
				 cpName = "bas1_cp", 
				 langId = "", 
				 cursorLangId = "tpp_loc_unsa", 
				 position = Vector3(0,0.0,0), 
				 radius=400, 
				 uShift=0.25 , 
				 vShift=0.25 , 
				 mini=true 
			 },  
		 },
	 },
	 globalLocationMapParams={
		-- Intel level needed to mark objects on the map:
		sectionFuncRankForDustBox = 4, 
		sectionFuncRankForToilet  = 4, 
		-- The map will need a TppUICommand.RegisterCrackPoints table defined, or else it will use the last map's crack points table
		--sectionFuncRankForCrack   = 6, 
		-- Enable enemy FOM:
		isSpySearchEnable = Ivars.disableSpySearch~=nil and Ivars.disableSpySearch:Get() or true,--tex was true
		-- Enable herb marking:
		isHerbSearchEnable = Ivars.disableHerbSearch~=nil and Ivars.disableHerbSearch:Get() or true,--tex was true
		-- Size of the FOMs:
		spySearchRadiusMeter = { 40.0, 40.0, 35.0, 30.0, 25.0, 20.0, 15.0, 10.0, },
		-- Intervals between enemy FOM updates, corresponding to Intel level:
		spySearchIntervalSec = { 420.0,	420.0,	360.0,	300.0,	240.0,	180.0,	150.0,	120.0, },
		-- Radius at which Intel will mark herbs, according to Intel level:
		herbSearchRadiusMeter = { 0.0,  0.0,  10.0, 15.0, 20.0, 25.0, 30.0, 35.0, },
	},

	--requestTppBuddy2BlockController=true,
	weatherProbabilities={
		{TppDefine.WEATHER.SUNNY,75},
		{TppDefine.WEATHER.CLOUDY,25},
	},
	extraWeatherProbabilities={
		{TppDefine.WEATHER.RAINY,100},
	},
}
return this
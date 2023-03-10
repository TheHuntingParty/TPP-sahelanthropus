local this={	
	missionCode=13500, --Mission id, here taken from tex's range as it's also just a test thing
    location="UNSA", --Location name id, from the location script
       
	packs = function(missionCode)
    TppPackList.AddLocationCommonScriptPack(missionCode)
	TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SAHELAN)
        --Mission pack must ALWAYS BE LAST IN THE LIST
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s13500/s13500.fpk"
		
    end,

     
	missionGuaranteeGMP=20000000, -- GMP received after completing the mission

	lzInfo={
        -- LZ name from .fox2
        ["lz_oldfob_N0000|lz_oldfob_N_0000"]={
            -- apr, heli coming in when called in from the ground, stops at lz
            approachRoute="lz_oldfob_N0000|rt_apr_oldfob_N_0000",
            -- drp, entering mission area riding the heli and leaving after dropping off the player
            dropRoute="lz_drp_oldfob_N0000|rt_drp_oldfob_N_0000",
            -- rtn, leaving after holding at lz when the player calls it it from the ground, starts at lz
            returnRoute="lz_oldfob_N0000|rt_rtn_oldfob_N_0000",
        },
        ["lz_oldfob_N0001"]={
            -- apr, heli coming in when called in from the ground, stops at lz
            approachRoute="lz_oldfob_N0001_apr",
            -- drp, entering mission area riding the heli and leaving after dropping off the player
            dropRoute="lz_drp_oldfob_N0001_drp",
            -- rtn, leaving after holding at lz when the player calls it it from the ground, starts at lz
            returnRoute="lz_oldfob_N0001_rtn",
        },
    },--lzInfo},




    
	--startPos={-537.426, 504.307, -1178.677},

   startPos={72,0,313},

}
return this
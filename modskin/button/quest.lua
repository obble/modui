

    local _G = getfenv(0)

    for i = 1, 6 do                             -- QUEST PROGRESS
        local p = _G['QuestProgressItem'..i]
        if p then
            print'true'
            modSkin(p, 18)
            modSkinPadding(p, 2, 2, 2, 2, 2, 2, 2, 2)
            modSkinColor(p, .2, .2, .2)
        end
    end

    local sk = _G['QuestInfoSkillPointFrame']   -- SKILL POINT
    local skF = CreateFrame('Frame', nil, sk)
    skF:SetAllPoints(sk.Icon)
    modSkin(skF, 18)
    modSkinPadding(skF, 2, 2, 2, 2, 2, 2, 2, 2)
    modSkinColor(skF, .2, .2, .2)

    local sp = _G['QuestInfoRewardSpell']       -- SPELL POINT
	local spF = CreateFrame('Frame', nil, sp)
	spF:SetAllPoints(sp.Icon)
    modSkin(spF, 18)
    modSkinPadding(spF, 2, 2, 2, 2, 2, 2, 2, 2)
    modSkinColor(spF, .2, .2, .2)

    local t = _G['QuestInfoTalentFrame']       -- TALENT POINT
    local tF = CreateFrame('Frame', nil, t)
    tF:SetAllPoints(t.Icon)
    modSkin(tF, 18)
    modSkinPadding(tF, 2, 2, 2, 2, 2, 2, 2, 2)
    modSkinColor(tF, .2, .2, .2)

    for i = 1, GetNumQuestWatches() do
        -- QuestWatchFrame
    end


    --

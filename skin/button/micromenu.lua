
    local mb = {
        CharacterMicroButton,
        SpellbookMicroButton,
        TalentMicroButton,
        QuestLogMicroButton,
        SocialsMicroButton,
        WorldMapMicroButton,
        MainMenuMicroButton,
        HelpMicroButton,
    }

    for _, v in pairs(mb) do
        v.f = CreateFrame('Frame', nil, v)
        v.f:SetPoint('TOPLEFT', v, 4, -24)
        v.f:SetPoint('BOTTOMRIGHT', v, -4, 4)
        v.f:EnableMouse(false)
        modSkin(v.f)
        modSkinColor(v.f, .7, .7, .7)
    end

    --

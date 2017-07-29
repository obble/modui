

    local stat = CreateFrame('Frame', nil, CharacterAttributesFrame)
    stat:SetPoint('TOPLEFT', PlayerStatBackgroundTop)
    stat:SetPoint('BOTTOMRIGHT', PlayerStatBackgroundBottom)

    local melee = CreateFrame('Frame', nil, CharacterAttributesFrame)
    melee:SetPoint('TOPLEFT', MeleeAttackBackgroundTop)
    melee:SetPoint('BOTTOMRIGHT', MeleeAttackBackgroundBottom)

    local ranged = CreateFrame('Frame', nil, CharacterAttributesFrame)
    ranged:SetPoint('TOPLEFT', RangedAttackBackgroundTop)
    ranged:SetPoint('BOTTOMRIGHT', RangedAttackBackgroundBottom)

    for _, v in pairs ({stat, melee, ranged}) do
        modSkin(v, 2.5)
        modSkinColor(v, .7, .7, .7)
    end

    --

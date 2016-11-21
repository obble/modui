

    local _, class = UnitClass'player'

    if class ~= 'SHAMAN' then return end
    if tonumber(GetCVar'modUnitFrame') == 0 then return end

    -- TODO:
    --      register for totem death
    --      click behaviour to recast
    --      reset positions based on # of totems shown
    --      localisations

    local TOTEMS = {
        ['Stoneskin']         = {   icon = 'Spell_Nature_GroundingTotem',
                                    time = 45,
                                    type = 'Earth'
                                },
        ['Earthbind']         = {   icon = 'Spell_Nature_StrengthOfEarthTotem02',
                                    time = 45,
                                    type = 'Earth'
                                },
        ['Stoneclaw']         = {   icon = 'Spell_Nature_StoneClawTotem',
                                    time = 15,
                                    type = 'Earth'
                                },
        ['Stoneskin']         = {   icon = 'Spell_Nature_StoneSkinTotem',
                                    time = 120,
                                    type = 'Earth'
                                    },
        ['Tremor']            = {   icon = 'Spell_Nature_TremorTotem',
                                    time = 120,
                                    type = 'Earth'
                                },
            --
        ['Fire Nova']         = {   icon = 'Spell_Fire_SealOfFire',
                                    time = 5,
                                    type = 'Fire'
                                },
        ['Flametongue']       = {   icon = 'Spell_Nature_GuardianWard',
                                    time = 120,
                                    type = 'Fire'
                                },
        ['Frost Resistance']  = {   icon = 'Spell_FrostResistanceTotem_01',
                                    time = 120,
                                    type = 'Fire'
                                },
        ['Magma']             = {   icon = 'Spell_Fire_SelfDestruct',
                                    time = 20,
                                    type = 'Fire'
                                },
        ['Searing']           = {   icon = 'Spell_Fire_SearingTotem',
                                    time = 55,
                                    type = 'Fire'
                                },
            --
        ['Grace of Air']      = {   icon = 'Spell_Nature_InvisibilityTotem',
                                    time = 120,
                                    type = 'Air'
                                },
        ['Nature Resistance'] = {   icon = 'Spell_Nature_NatureResistanceTotem',
                                    time = 120,
                                    type = 'Air'
                                },
        ['Sentry']            = {   icon = 'Spell_Nature_RemoveCurse',
                                    time = 300,
                                    type = 'Air'
                                },
        ['Tranquil Air']      = {   icon = 'Spell_Nature_Brilliance',
                                    time = 120,
                                    type = 'Air'
                                },
        ['Windfury']          = {   icon = 'Spell_Nature_Windfury',
                                    time = 120,
                                    type = 'Air'
                                },
        ['Windwall']          = {   icon = 'Spell_Nature_EarthBind',
                                    time = 120,
                                    type = 'Air'
                                },
            --
        ['Disease Cleansing'] = {   icon = 'Spell_Nature_DiseaseCleansingTotem',
                                    time = 120,
                                    type = 'Water'
                                },
        ['Fire Resistance']   = {   icon = 'Spell_FireResistanceTotem_01',
                                    time = 120,
                                    type = 'Water'
                                },
        ['Healing Stream']    = {   icon = 'INV_Spear_04',
                                    time = 60,
                                    type = 'Water'
                                },
        ['Mana Spring']       = {   icon = 'Spell_Nature_ManaRegenTotem',
                                    time = 60,
                                    type = 'Water'
                                },
        ['Mana Tide']         = {   icon = 'Spell_Frost_SummonWaterElemental',
                                    time = 12,
                                    type = 'Water'
                                },
        ['Poison Cleansing']  = {   icon = 'Spell_Nature_PoisonCleansingTotem',
                                    time = 120,
                                    type = 'Water'
                                },
    }

    local earth = CreateFrame('Button', 'modTotemEarth', PlayerFrame)
    earth:SetWidth(24)
    earth:SetHeight(20)
    earth:SetPoint('TOPLEFT', PlayerFrame, 'BOTTOMLEFT', 110, 28)
    earth:Hide()

    local fire = CreateFrame('Button', 'modTotemFire', PlayerFrame)
    fire:SetWidth(24)
    fire:SetHeight(20)
    fire:SetPoint('LEFT', earth, 'RIGHT', 6, 0)
    fire:Hide()

    local air = CreateFrame('Button', 'modTotemAir', PlayerFrame)
    air:SetWidth(24)
    air:SetHeight(20)
    air:SetPoint('LEFT', fire, 'RIGHT', 6, 0)
    air:Hide()

    local water = CreateFrame('Button', 'modTotemWater', PlayerFrame)
    water:SetWidth(24)
    water:SetHeight(20)
    water:SetPoint('LEFT', air, 'RIGHT', 6, 0)
    water:Hide()

    for i, v in pairs({earth, fire, air, water}) do
        modSkin(v, 16)
        modSkinPadding(v, 2)
        modSkinColor(v, .2, .2, .2)

        v.icon = v:CreateTexture(nil, 'ARTWORK')
        v.icon:SetAllPoints()
        v.icon:SetTexCoord(.1, .9, .2, .8)

        v.timer = v:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
        v.timer:SetPoint('TOP', v, 'BOTTOM', 1, -2)
        v.timer:SetJustifyH'CENTER'
    end

    local UpdateTotem = function(totem)
        local time = GetTime()
        if time < this.finish then
            this.timer:SetText(SecondsToTimeAbbrev(this.finish - time))
        else
            this:SetScript('OnUpdate', nil)
            this:Hide()
            this.icon:SetTexture''
            this.timer:SetText''
        end
    end

    local AddTotem = function(totem, n)
        local bu = _G['modTotem'..totem.type]
        bu:Show()

        bu.icon:SetTexture('Interface\\Icons\\'..totem.icon)

        bu.start  = GetTime()
        bu.finish = bu.start + totem.time

        bu:SetScript('OnEnter',  function()
            local colour = RAID_CLASS_COLORS[class]
            GameTooltip:SetOwner(bu, 'ANCHOR_RIGHT')
            GameTooltip:AddLine(n..' Totem', colour.r, colour.g, colour.b)
            GameTooltip:Show()
        end)

        bu:SetScript('OnLeave',  function() GameTooltip:Hide() end)

        bu:SetScript('OnUpdate', function()
            UpdateTotem(totem)
        end)
    end

    local OnEvent = function(event)
        if  string.find(arg1, 'You cast (.+) Totem.') then
            local n = gsub(arg1, 'You cast (.+) Totem.', '%1')
            if TOTEMS[n] then AddTotem(TOTEMS[n], n) end
        end
    end

    local e = CreateFrame'Frame'
    e:RegisterEvent'CHAT_MSG_SPELL_SELF_BUFF'
    e:SetScript('OnEvent', OnEvent)

    --

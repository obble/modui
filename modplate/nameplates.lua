

    local TEXTURE  = [[Interface\AddOns\modui\modsb\texture\sb.tga]]
    local BACKDROP = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],}
    local class = UnitClass'player'
    local p = {} local t = {}
    local enabled = true                -- TOGGLE NAMEPLATES VISIBILITY DEFAULT

    local modPlate = function(plate)    -- STYLE
        local health = plate:GetChildren()
        local border, glow, name, level, _, raidicon = plate:GetRegions()

        border:SetVertexColor(.4, .4, .4)

        name:SetFont(STANDARD_TEXT_FONT, 12)
        name:ClearAllPoints()
        name:SetPoint('BOTTOMRIGHT', plate, 'TOPRIGHT', -4, -16)
        name:SetJustifyH'RIGHT'

        health:SetStatusBarTexture(TEXTURE)
        health:SetBackdrop(BACKDROP)
        health:SetBackdropColor(0, 0, 0, .6)

        if class == 'Rogue' or class == 'Druid' then
            plate.cp = plate:CreateFontString(nil, 'OVERLAY')
            plate.cp:SetFont(STANDARD_TEXT_FONT, 18, 'OUTLINE')
            plate.cp:SetPoint('LEFT', health)
            plate.cp:SetTextColor(0, .8, .4)
            plate.cp:Hide()
        end

        plate.skinned = true
    end

    local isPlate = function(frame) -- GO FISH
        local overlayRegion = frame:GetRegions()
        if not overlayRegion or overlayRegion:GetObjectType() ~= 'Texture'
        or overlayRegion:GetTexture() ~= [[Interface\Tooltips\Nameplate-Border]] then
            return false
        end
        return true
    end

    local isPlayer = function(n) -- CLASS COLOUR
        if not t[n] then
            TargetByName(n, true)
            table.insert(t, n)
            t[n] = 'ok'
            if UnitIsPlayer'target' then
                local class = UnitClass'target'
                table.insert(p, n)
                p[n] = {['class'] = string.upper(class)}
            end
        end
    end

    local addClass = function(plate)
        local health = plate:GetChildren()
        local _, _, name = plate:GetRegions()
        local n = name:GetText()
        local r = health:GetStatusBarColor()

        if not p[n] and not UnitName'target'
        and not string.find(n, '%s') and string.len(n) < 13
        and not t[n] then
            isPlayer(n) ClearTarget()
        end

        if p[n] and r > .9 then
            local colour = RAID_CLASS_COLORS[p[n]['class']]
            health:SetStatusBarColor(colour.r, colour.g, colour.b)
        end
    end

    local addCP = function(plate)   -- COMBOPOINT
        if plate.cp then
            local health = plate:GetChildren()
            local _, _, name = plate:GetRegions()
            local text   = name:GetText()
            local target = GetUnitName'target'
            local cp 	 = GetComboPoints()
            plate.cp:Hide()
            if target == text and health:GetAlpha() == 1 and cp > 0 then
                plate.cp:Show()
                plate.cp:SetText(cp)
            end
        end
    end

    local f = CreateFrame'Frame'
    f:SetScript('OnUpdate', function()
        local frames = {WorldFrame:GetChildren()}
	    for _, plate in ipairs(frames) do
            if isPlate(plate) and plate:IsVisible() then
                if not plate.skinned then modPlate(plate) end
                addCP(plate)
                addClass(plate)
            end
        end
    end)

    f:RegisterEvent'PLAYER_ENTERING_WORLD'
    f:SetScript('OnEvent', function() if enabled then ShowNameplates() end end)

    --

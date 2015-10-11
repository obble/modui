

    local TEXTURE = [[Interface\AddOns\modui\modsb\texture\sb.tga]]
    local BACKDROP = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],}
    local enabled = true -- TOGGLE NAMEPLATES VISIBILITY DEFAULT

        -- STYLE
    local modPlate = function(plate)
        local health = plate:GetChildren()
        local border, glow, name, level, _, raidicon = plate:GetRegions()

        border:SetVertexColor(.4, .4, .4)

        health:SetStatusBarTexture(TEXTURE)
        health:SetBackdrop(BACKDROP)
        health:SetBackdropColor(0, 0, 0, .6)

        name:SetFont(STANDARD_TEXT_FONT, 12)
        name:ClearAllPoints()
        name:SetPoint('BOTTOMRIGHT', plate, 'TOPRIGHT', -4, -16)
        name:SetJustifyH'RIGHT'

        plate.skinned = true
    end

        -- GO FISH
    local isPlate = function(frame)
        local overlayRegion = frame:GetRegions()
        if not overlayRegion or overlayRegion:GetObjectType() ~= 'Texture'
        or overlayRegion:GetTexture() ~= [[Interface\Tooltips\Nameplate-Border]] then
            return false
        end
        return true
    end

    local f = CreateFrame'Frame'
    f:SetScript('OnUpdate', function()
        local frames = {WorldFrame:GetChildren()}
	    for _, plate in ipairs(frames) do
            if isPlate(plate) and plate:IsVisible() and not plate.skinned then
                modPlate(plate)
            end
        end
    end)

        -- FORCE ON
    f:RegisterEvent'PLAYER_ENTERING_WORLD'
    f:SetScript('OnEvent', function() if enabled then ShowNameplates() end end)

    --

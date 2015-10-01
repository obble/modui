

    local r, g, b = 103/255, 103/255, 103/255
    local f = CreateFrame'Frame'
    local TEXTURE = [[Interface\AddOns\modui\modsb\texture\sb.tga]]
    local BACKDROP = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],}
    local enabled = true

        -- STYLE
    local function SkinNamePlates(self, namePlate)
        local health = namePlate:GetChildren()
        local border, glow, name, level, _, raidicon = namePlate:GetRegions()

        border:SetVertexColor(.4, .4, .4)

        health:SetStatusBarTexture(TEXTURE)
        health:SetBackdrop(BACKDROP)
        health:SetBackdropColor(0, 0, 0, .6)

        name:SetFont(STANDARD_TEXT_FONT, 12)
        name:ClearAllPoints()
        name:SetPoint('BOTTOMRIGHT', namePlate, 'TOPRIGHT', -4, -16)
        name:SetJustifyH'RIGHT'

        namePlate.skinned = true
    end


        -- GO FISH
    local function IsNamePlateFrame(frame)
        local overlayRegion = frame:GetRegions()
        if not overlayRegion or overlayRegion:GetObjectType() ~= 'Texture'
        or overlayRegion:GetTexture() ~= [[Interface\Tooltips\Nameplate-Border]] then
            return false
        end
        return true
    end

    f:SetScript('OnUpdate', function()
        local frames = {WorldFrame:GetChildren()}
	    for _, namePlate in ipairs(frames) do
            if IsNamePlateFrame(namePlate) and namePlate:IsVisible() and not namePlate.skinned then
                SkinNamePlates(f, namePlate)
            end
        end
    end)

    f:RegisterEvent'PLAYER_ENTERING_WORLD'
    f:SetScript('OnEvent', function() if enabled then ShowNameplates() end end)

    --

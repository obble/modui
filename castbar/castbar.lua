

    local TEXTURE = [[Interface\AddOns\modui\statusbar\texture\sb.tga]]
    local orig    = {}

    local overrideIcons = { -- these should be pulled into a casting table in globals tbh
        ['Hearthstone']    = [[Interface\Icons\inv_misc_rune_01]],
        ['Herb Gathering'] = [[Interface\Icons\spell_nature_naturetouchgrow]],
        ['Mining']         = [[Interface\Icons\trade_mining]]
    }

    orig.UseAction = UseAction

    CastingBarFrame:SetStatusBarTexture(TEXTURE)

    CastingBarFrame.Icon = CreateFrame('Frame', nil, CastingBarFrame)
    CastingBarFrame.Icon:SetWidth(25)
    CastingBarFrame.Icon:SetHeight(25)
    CastingBarFrame.Icon:SetPoint('RIGHT', CastingBarFrame, 'LEFT', -10, 2.5)

    CastingBarFrame.Icon.Texture = CastingBarFrame.Icon:CreateTexture(nil, 'ARTWORK')
    CastingBarFrame.Icon.Texture:SetAllPoints()

    local ToggleIcon = function()
        local t = CastingBarText:GetText()
        if  (not t) or t == '' then
            CastingBarFrame.Icon:Hide()
        else
            CastingBarFrame.Icon:Show()
            if  overrideIcons[t] then
                CastingBarFrame.Icon.Texture:SetTexture(overrideIcons[t])
            end
        end
    end

    UseAction = function(slot, target, button)
        orig.UseAction(slot, target, button)
        if  CastingBarFrame:GetAlpha() < 1 or not CastingBarFrame:IsShown() then
            local icon = GetActionTexture(slot)
            CastingBarFrame.Icon.Texture:SetTexture(icon)
        end
    end

    CastingBarFrame:SetScript('OnShow', ToggleIcon)



    --

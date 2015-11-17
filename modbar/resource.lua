
    local cost = {}
    local orig = {}
    local empty = function(t) return next(t) == nil end
    local merge = function(t1, t2) for i, v in pairs(t2) do t1[i] = v end return t1 end

    orig.ActionButton_OnEvent    = ActionButton_OnEvent
    orig.ActionButton_SetTooltip = ActionButton_SetTooltip
    
    local strip_esc = function(text)
        text = string.gsub(text, '\|c%x%x%x%x%x%x%x%x', '')
        text = string.gsub(text, '\|r', '');
        return text
    end

    local create = function()
        if not this.label then
            this.label = this:CreateFontString(nil, 'OVERLAY', 'NumberFontNormalSmall')
            this.label:SetPoint('CENTER', this, 'BOTTOM', 3, 0)
            this.label:SetText''
            ActionButton_SetTooltip()
            this.created = true
        end
    end

    local learn_ammo = function(text)
        if text ~= nil then
            if text == 'Auto Shot' or text == 'Shoot Bow' or
               text == 'Shoot Crossbow' or text == 'Shoot Gun' or
               text == 'Throw' then
                return {Ammo = {cost = 1}}
            end
        end
        return {}
    end

    local learn_reagent = function(text)
        if text ~= nil then
            text = strip_esc(text)
            local found, _, reagentname = string.find(text, 'Reagents: ([^,]+)')
            if found then return {Reagent = {cost = 1, name = reagentname}} end
        end
        return {}
    end

    local count_reagent = function(name)
        local total = 0
        for id = 0, 4 do
            for slot = 1, GetContainerNumSlots(id) do
                local ilink = GetContainerItemLink(id, slot)
                if ilink and string.find(ilink, name) then
                    local _, count = GetContainerItemInfo(id, slot)
                    total = total + count
                end
            end
        end
        return total
    end

    local fetch_resource = function(type)
        if type == 'Ammo' then
            local pageID = ActionButton_GetPagedID(this)
            if IsUsableAction(pageID) then
                local ammoID = GetInventorySlotInfo'AmmoSlot'
                if GetInventoryItemTexture('player', ammoID) then
                    return GetInventoryItemCount('player', ammoID)
                else
                    return 0
                end
            else
                return 0
            end
        elseif type == 'Reagent' then
            return count_reagent(cost[type].name)
        else
            return 0
        end
    end

    local show_resources = function()
        if HasAction(ActionButton_GetPagedID(this)) then
            if not empty(cost) then return true end
        end
        return false
    end

    local enable = function()
        for type, _ in cost do
            if type == 'Reagent' then this:RegisterEvent'BAG_UPDATE' end
        end
    end

    local save = function()
        local slotID = ActionButton_GetPagedID(this)
        if not saved_costs then saved_costs = {} end
        saved_costs[slotID] = cost
    end

    local load = function()
        local slotID = ActionButton_GetPagedID(this)
        if saved_costs and saved_costs[slotID] then
            cost = saved_costs[slotID]
        end
        enable()
    end

    local update = function()
        if show_resources() then
            local t = ''
            for type, v in cost do
                t = math.floor(fetch_resource(type)/v.cost)
                this.label:SetText(t) this.label:Show()
            end
        else
            this.label:Hide()
        end
    end

    local learn = function()
        local learned = {}
        for i = 1, GameTooltip:NumLines() do
            local label = _G['GameTooltipTextLeft'..i]
            local text  = strip_esc(label:GetText())
            if i == 1 then
                learned = merge(learned, learn_ammo(text))
            else
                learned = merge(learned, learn_reagent(text))
            end
        end
        cost = learned
        save() enable() update()
    end

    function ActionButton_OnEvent(event)
        orig.ActionButton_OnEvent(event)
        if not this.created then create() end
        if saved_costs and not this.modResourceLoaded then
            load()
            this.modResourceLoaded = true
        end
        if event == 'ACTIONBAR_PAGE_CHANGED' then
            load()
            if arg1 == 0 or arg1 == ActionButton_GetPagedID(this) then learn() end
        end
        update()
    end

    function ActionButton_SetTooltip()
        orig.ActionButton_SetTooltip()
        if this.created then learn() end
    end

    --



    local orig = {}

    local quicksearch = function(link)
        if link and not strfind(link, 'item:') then return end
        local name, li, q, ilevel, class, sub

        BrowseMinLevel:SetText''   BrowseMaxLevel:SetText''
        UIDropDownMenu_SetText('', BrowseDropDown) UIDropDownMenu_SetSelectedName(BrowseDropDown)

        if link then
            local i, j, name = strfind(link, '%[(.+)%]')
            BrowseName:SetText(name)
            BrowseName:HighlightText(0,-1)
            IsUsableCheckButton:SetChecked(false)
            local i, j, item = strfind(link, '(item:%d+:%d+:%d+:%d+)')
            name, li, q, ilevel, class, sub = GetItemInfo(item)
        else
            BrowseName:SetText''
            IsUsableCheckButton:SetChecked(true)
            class = 'Recipe'; sub = class
        end

        AuctionFrameBrowse.selectedClass = class
        for k, v in CLASS_FILTERS do
            if name == class then
                AuctionFrameBrowse.selectedClassIndex = k
                i = k
                break
            end
        end

        if class ~= sub then
            AuctionFrameBrowse.selectedSubclass = HIGHLIGHT_FONT_COLOR_CODE..sub..FONT_COLOR_CODE_CLOSE
            for k, v in {GetAuctionItemSubClasses(i)} do
                if name  == sub then
                    AuctionFrameBrowse.selectedSubclassIndex = k
                    break
                end
            end
        else
            AuctionFrameBrowse.selectedSubclass = nil
            AuctionFrameBrowse.selectedSubclassIndex = nil
        end

        AuctionFrameBrowse.selectedInvtype = nil
        AuctionFrameBrowse.selectedInvtypeIndex = nil
        AuctionFrameFilters_Update()
        BrowseSearchButton:Click()
        return 1
    end

    orig.UseContainerItem = UseContainerItem
    function UseContainerItem(parent, item)
        if IsAltKeyDown() then
            if not AuctionFrameBrowse:IsVisible() then AuctionFrameTab1:Click() return end
            if quicksearch(GetContainerItemLink(parent, item)) then return end
        end
        orig.UseContainerItem(parent, item)
    end

    --

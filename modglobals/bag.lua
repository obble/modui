

    local orig = {}
    orig.ContainerFrame_OnShow = ContainerFrame_OnShow
    function ContainerFrame_OnShow()
        orig.ContainerFrame_OnShow()
        CONTAINER_OFFSET_X = 50
    end

    --

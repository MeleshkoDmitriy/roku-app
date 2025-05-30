sub ShowDetailsScreen(content as Object, selectedItem as Integer)
    detailsScreen = CreateObject("roSGNode", "DetailsScreen")
    detailsScreen.content = content
    detailsScreen.jumpToItem = selectedItem

    detailsScreen.observeField("visible", "OnDetailsScreenVisibilityChanged")
    detailsScreen.observeField("buttonSelected", "OnButtonSelected")

    ShowScreen(detailsScreen)
end sub

sub OnDetailsScreenVisibilityChanged(event as Object)
    visible = event.getData()
    detailsScreen = event.getRoSGNode()
    currentScreen = GetCurrentScreen()
    screenType = currentScreen.subType()

    if visible = false
        if screenType = "GridScreen"
            currentScreen.jumpToItem = [m.selectedIndex[0], detailsScreen.itemFocused]
        else if screenType = "EpisodesScreen"
            content = detailsScreen.content.getChild(detailsScreen.itemFocused)
            currentScreen.jumpToItem = content.numEpisodes
        end if
    end if
end sub

sub OnButtonSelected(event)
    details = event.getRoSGNode()
    content = details.content
    buttonIndex = event.getData()
    selectedItem = details.itemFocused

    if buttonIndex = 0
        HandlePlayButton(content, selectedItem)
    else if buttonIndex = 1
        ShowEpisodesScreen(content, selectedItem)
    end if
end sub

sub HandlePlayButton(content as Object, selectedItem as Integer)
    itemContent = content.getChild(selectedItem)

    if itemContent.mediaType = "series"
        children = []

        for each season in itemContent.getChildren(-1, 0)
            children.append(CloneChildren(season))
        end for

        node = CreateObject("roSGNode", "ContentNode")
        node.update({
            children: children
        }, true)

        ShowVideoScreen(node, 0, true)
    else 
        ShowVideoScreen(content, selectedItem)
    end if

end sub
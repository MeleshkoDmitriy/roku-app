sub ShowDetailsScreen(content as Object, selectedItem as Integer)
    detailsScreen = CreateObject("roSGNode", "DetailsScreen")
    detailsScreen.content = content
    detailsScreen.jumpToItem = selectedItem

    detailsScreen.observeFields("visible", "OnDetailsScreenVisibilityChanged")
    detailsScreen.observeFields("buttonSelected", "OnButtonSelected")

    ShowScreen(detailsScreen)
end sub

sub OnDetailsScreenVisibilityChanged(event as Object)
    visible = event.getData()
    detailsScreen = event.getRoSGNode()

    if visible = false
        m.GridScreen.jumpToItem = [m.selectedIndex[0], detailsScreen.itemFocused]
    end if
end sub

sub OnButtonSelected(event)
    details = event.getRoSGNode()
    content = details.content
    buttonIndex = event.getData()
    selectedItem = details.itemFocused

    if buttonIndex = 0
        ShowVideoScreen(content, selectedItem)
    end if
end sub
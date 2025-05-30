sub ShowEpisodesScreen(content as Object, selectedItem as Integer)
    episodesScreen = CreateObject("roSGNode", "EpisodesScreen")
    episodesScreen.observeField("selectedItem", "OnEpisodesScreenItemSelected")
    episodesScreen.content = content.getChild(selectedItem)
    ShowScreen(episodesScreen)
end sub

sub OnEpisodesScreenItemSelected(event as Object)
    episodesScreen = event.getRoSGNode()
    selectedIndex = event.getData()
    rowContent = episodesScreen.content.getChild(selectedIndex[0])
    ShowDetailsScreen(rowContent, selectedIndex[1])
end sub
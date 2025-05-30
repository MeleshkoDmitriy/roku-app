sub ShowGridScreen()
    m.GridScreen = CreateObject("roSGNode", "GridScreen")
    m.GridScreen.observeField("rowItemSelected", "OnGridScreenItemSelected")
    ShowScreen(m.GridScreen) ' ScreenStackLogic
end sub

sub OnGridScreenItemSelected(event as Object)
    grid = event.getRoSGNode()
    m.selectedIndex = event.getData()
    rowContent = grid.content.getChild(m.selectedIndex[0])
    m.selectedRow = m.selectedIndex[0]
    ShowDetailsScreen(rowContent, m.selectedIndex[1])
end sub
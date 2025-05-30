sub ShowVideoScreen(rowContent as Object, selectedItem as Integer, isSeries = false as Boolean)
    videoScreen = CreateObject("roSGNode", "VideoScreen")
    videoScreen.observeField("close", "OnVideoScreenClose")

    videoScreen.isSeries = isSeries
    videoScreen.content = rowContent
    videoScreen.startIndex = selectedItem

    ShowScreen(videoScreen)
end sub

sub OnVideoScreenClose(event as Object)
    videoScreen = event.getRoSGNode()
    close = event.getData()

    if close = true
        CloseScreen(videoScreen)
        screen = GetCurrentScreen()
        screen.setFocus(true)

        if videoScreen.isSeries = false
            screen.jumpToItem = videoScreen.lastIndex
        end if
    end if
end sub

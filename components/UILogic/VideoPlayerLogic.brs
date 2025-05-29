sub ShowVideoScreen(content as Object, itemIndex as Integer)
    m.videoPlayer = CreateObject("roSGNode", "Video") ' video instance

    if itemIndex <> 0 
        numOfChildren = content.getChildCount()
        children = content.getChildren(numOfChildren - itemIndex, itemIndex)

        childrenClone = []
        for each child in children
            childrenClone.push(child.clone(false))
        end for

        node = CreateObject("roSGNode", "ContentNode")
        node.update({ children: childrenClone }, true)
        m.videoPlayer.content = node
    else
        m.videoPlayer.content = content.clone(true)
    end if

    m.videoPlayer.contentIsPlaylist = true
    ShowScreen(m.videoPlayer)
    m.videoPlayer.control = "play"
    m.videoPlayer.ObserveField("state", "OnVideoPlayerStateChange")
    m.videoPlayer.ObserveField("visible", "OnVideoVisibleChange")
end sub

sub OnVideoPlayerStateChange()
    state = m.videoPlayer.state

    if state = "error" or state = "finished"
        CloseScreen(m.videoPlayer)
    end if
end sub

sub OnVideoVisibleChange()
    if m.videoPlayer.visible = false and m.top.visible = true
        currentIndex = m.videoPlayer.contentIndex
        m.videoPlayer.control = "stop"
        m.videoPlayer.content = invalid
        m.GridScreen.setFocus(true)
        m.GridScreen.jumpToRowItem = [m.selectedIndex[0], currentIndex + m.selectedIndex[1]]
    end if
end sub

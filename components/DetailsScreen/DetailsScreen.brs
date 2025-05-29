function Init()
    m.top.observeField("visible", "OnVisibleChange")
    m.top.observeField("itemFocused", "OnItemFocusedChanged")

    m.buttons = m.top.findNode("buttons")
    m.poster = m.top.findNode("poster")
    m.description = m.top.findNode("descriptionLabel")
    m.title = m.top.findNode("titleLabel")
    m.time = m.top.findNode("timeLabel")
    m.release = m.top.findNode("releaseLabel")

    ' create buttons
    result = []
    for each button in ["Play"]
        result.push({
            title : button
        })
    end for

    m.buttons.content = ContentListToSimpleNode(result)
end function

sub OnVisibleChange()
    if m.top.visible = true
        m.buttons.setFocus(true)
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub SetDetailsContent(content as Object)
    m.description.text = content.description
    m.poster.uri = content.hdPosterUrl
    m.time.text = getTime(content.length)
    m.title.text = content.title
    m.release.text = content.releaseDate
end sub

sub OnJumpToItem()
    content = m.top.content

    if content <> Invalid AND m.top.jumpToItem >= 0 AND content.getChildCount() > m.top.getChildCount()
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub OnItemFocusedChanged(event as Object)
    focusedItem = event.getData()
    content = m.top.content.getChild(focusedItem)
    SetDetailsContent(content)
end sub

function OnKeyEvent(key as String, press as Boolean) as Boolean
    result = false

    if press
        if press = "left"
            currentItem = m.top.itemFocused
    
            m.top.jumpToItem = currentItem - 1
            result = true
        else if press = "right"
            m.top.jumpToItem = currentItem + 1
            result = true
        end if
    end if

    return result
end function
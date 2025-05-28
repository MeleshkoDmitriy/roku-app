sub Init()
    m.rowList = m.top.findNode("rowList")
    m.rowList.setFocus(true)

    m.titleLabel = m.top.findNode("titleLabel")
    m.descriptionLabel = m.top.findNode("descriptionLabel")

    m.rowList.observeFields("rowItemFocused", "OnItemFocused")
end sub

sub OnItemFocused()
    focusedIndex = m.rowList.rowItemFocused
    row = m.rowList.content.getChild(focusedIndex[0])
    item = row.getChild(focusedIndex[1])

    m.titleLabel.text = item.title
    m.descriptionLabel.text = item.description

    if item.length <> invalid
        m.titleLabel.text += " | time:" + getTime(item.length)
    end if
end sub

function getTime(length as Integer) as String
    minutes = (length / 60).toStr()
    seconds = length MOD 60

    if seconds < 10
        seconds = "0" + seconds.toStr()
    else 
        seconds = seconds.toStr()
    end if

    return minutes + ":" + seconds
end function
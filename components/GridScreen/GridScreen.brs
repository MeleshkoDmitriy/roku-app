sub Init()
    m.rowList = m.top.findNode("rowList")
    m.rowList.setFocus(true)

    m.titleLabel = m.top.findNode("titleLabel")
    m.descriptionLabel = m.top.findNode("descriptionLabel")

    m.top.observeField("visible", "OnVisibleChange")

    m.rowList.observeField("rowItemFocused", "OnItemFocused")
end sub

sub OnVisibleChange()
    if m.top.visible = true
        m.rowList.setFocus(true)
    end if
end sub

sub OnItemFocused()
    focusedIndex = m.rowList.rowItemFocused
    row = m.rowList.content.getChild(focusedIndex[0])
    item = row.getChild(focusedIndex[1])

    m.titleLabel.text = item.title
    m.descriptionLabel.text = item.description

    if item.length <> invalid and item.length <> 0
        m.titleLabel.text += " | time:" + getTime(item.length)
    end if
end sub

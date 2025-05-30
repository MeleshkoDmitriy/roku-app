function Init()
    m.top.observeField("visible", "OnVisibleChange")

    m.categoryList = m.top.findNode("categoryList")
    m.categoryList.observeField("itemFocused", "OnCategoryItemFocused")

    m.itemList = m.top.findNode("itemList")
    m.itemList.observeField("itemFocused", "OnListItemFocused")
    m.itemList.observeField("itemSelected", "OnListItemSelected")

    m.top.observeField("content", "OnContentChange")
end function

sub OnListItemFocused(event as Object)
    focusedItem = event.getData()
    categoryIndex = m.itemToSection[focusedItem]

    if (categoryIndex - 1) = m.categoryList.jumpToItem
        m.categoryList.animateToItem = categoryIndex
    else if NOT m.categoryList.isInFocusChain()
        m.categoryList.jumpToItem = categoryIndex
    end if
end sub

sub InitSections(content as Object)
    m.firstItemInSection = [0]
    m.itemToSection = []
    sections = []
    sectionsCount = 0

    for each section in content.getChildren(- 1, 0)
        itemsPerSection = section.getChildCount()

        for each child in section.getChildren(- 1, 0)
            m.itemToSection.push(sectionsCount)
        end for

        sections.push({ title : section.title })
        m.firstItemInSection.push(m.firstItemInSection.peek() + itemsPerSection) 
        sectionsCount++
    end for

    m.firstItemInSection.pop()
    m.categoryList.content = ContentListToSimpleNode(sections)
end sub

sub OnCategoryItemFocused(event as Object) 
    if m.categoryListGainFocus = true
        m.categoryListGainFocus = false
    else
        focusedItem = event.getData() 
        m.itemsList.jumpToItem = m.firstItemInSection[focusedItem]
    end if
end sub

sub OnJumpToItem(event as Object) 
    itemIndex = event.getData()
    m.itemsList.jumpToItem = itemIndex 
end sub

sub OnContentChange()
    content = m.top.content
    InitSections(content)
    m.itemsList.content = content
end sub

sub onVisibleChange()
    if m.top.visible = true
        m.itemsList.setFocus(true)
    end if
end sub

sub OnListItemSelected(event as Object) 
    itemSelected = event.getData() 
    sectionIndex = m.itemToSection[itemSelected] 
    m.top.selectedItem = [sectionIndex, itemSelected - m.firstItemInSection[sectionIndex]]
end sub

function OnKeyEvent(key as String, press as Boolean) as Boolean
    result = false

    if press
        if key = "left" and m.itemsList.HasFocus() 
            m.categoryListGainFocus = true
            m.categoryList.SetFocus(true)
            m.itemsList.drawFocusFeedback = false
            result = true
        else if key = "right" and m.categoryList.HasFocus() 
            m.itemsList.drawFocusFeedback = true
            m.itemsList.SetFocus(true)
            result = true
        end if
    end if
    
    return result
end function
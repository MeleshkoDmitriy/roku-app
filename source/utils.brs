function GetTime(length as Integer) as String
    minutes = (length / 60).toStr()
    seconds = length MOD 60

    if seconds < 10
        seconds = "0" + seconds.toStr()
    else 
        seconds = seconds.toStr()
    end if

    return minutes + ":" + seconds
end function

function ContentListToSimpleNode(contentList as Object, nodeType = "ContentNode" as String) as object
    result = CreateObject("roSGNode", nodeType)

    if result <> invalid

        for each itemAA in contentList
            item = CreateObject("roSGNode", nodeType)
            item.setFocus(itemAA)
            result.appendChild(item)
        end for
    end if

    return result
end function

function CloneChildren(node as Object, startItem = 0 as Integer)
    numOfChildren = node.getChildCount()
    children = node.getChildren(numOfChildren - startItem, startItem)
    childrenClone = []

    for each child in children
        childrenClone.push(child.clone(false))
    end for

    return childrenClone
end function

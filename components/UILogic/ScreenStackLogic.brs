sub InitScreenStack()
    m.screenStack = []
end sub

sub ShowScreen(node as Object)
    prev = m.screenStack.peek()

    if prev <> Invalid
        prev.visible = false
    end if

    m.top.appendChild(node)
    node.visible = true
    node.setFocus(true)
    m.screenStack.push(node)
end sub

sub CloseScreen(node as Object)
    if node = Invalid OR (m.screenStack.peek() <> Invalid AND m.screenStack.peek().isSameNode(node)) 
        last = m.screenStack.pop()
        last.visible = false
        m.top.removeChild(node)

        prev = m.screenStack.peek()
        if prev <> invalid
            prev.visible = true
            prev.setFocus(true)
        end if
    end if
end sub
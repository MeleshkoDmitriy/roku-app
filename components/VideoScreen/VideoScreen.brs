sub Init() 
    m.top.width = 1280
    m.top.height = 720
    m.top.color = "0x202020ff"

    m.playerTask = m.top.findNode("PlayerTask")
    m.playerTask.observeField("state", "OnPlayerTaskStateChange")
end sub

sub OnIndexChanged(event as Object)
    content = m.top.content
    index = event.getData()

    if content <> invalid
        m.playerTask.content = content
        m.playerTask.startIndex = index
        m.playerTask.control = "RUN"
    end if
end sub

sub OnPlayerTaskStateChange(event as Object)
    state = event.getData()

    if state = "done" OR state = "stop"
        m.top.close = true
    end if
end sub

function OnKeyEvent(key as String, press as Boolean) as Boolean
    result = false

    if press
        if key = "back" AND m.playerTask <> Invalid
            m.playerTask.control = "STOP"
            result = true
        end if
    end if

    return result
end function
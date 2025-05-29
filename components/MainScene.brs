sub Init() 
    m.top.backgroundColor = "0x662D91"
    m.top.backgroundUri = "pkg:/images/background.jpg"
    m.loadingIndicator = m.top.FindNode("loadingIndicator")

    InitScreenStack()
    ShowGridScreen()
    RunContentTask()
end sub

function OnKeyEvent(key as String, press as Boolean) as Boolean 
    result = false

    if press
        
        if key = "back" ' back button event listener
            numberOfScreens = m.screensStack.count()

            if numberOfScreens > 1
                CloseScreen(Invalid) ' screen stack logic
                result = true
            end if
        end if
    end if

    return result
end function
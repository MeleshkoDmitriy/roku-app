sub Init() 
    m.top.backgroundColor = "0x6F1BB1"
    m.top.backgroundUri = ""
    m.loadingIndicator = m.top.FindNode("loadingIndicator")

    InitScreenStack()
    ShowGridScreen()
    RunContentTask()
end sub
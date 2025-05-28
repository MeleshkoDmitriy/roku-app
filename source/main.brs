sub Main()
    ShowChannelRSGScreen()

end sub


sub ShowChannelRSGScreen()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.SetMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.Show()

    while(true)
        message = wait(0, m.port) ' 0 - wait message all the time
        messageType = type(message)
        if messageType = "roSGScreenEvent"
            if message.isScreenClosed() then return
        end if
    end while
end sub
Library "Roku_Ads.brs"

sub Init()
    m.top.functionName = "PlayContentWithAds"
    m.top.id = "PlayerTask"
end sub

sub PlayContentWithAds()
    parentNode = m.top.getParent()
    content = m.top.content
    m.top.lastIndex = m.top.startIndex
    items = content.getChildren(-1, 0)

    RAF = Roku_Ads()
    RAF.enableAdMeasurements(true)
    RAF.setAdUrl()

    keepPlay = true
    index = m.top.startIndex - 1
    itemsCount = items.count()

    while keepPlay
        if itemsCount - 1 > index
            parentNode.setFocus(true)
            index++
            item = items[index]
            RAF.setContentId(item.id)

            if item.categories <> invalid
                RAF.setContentGenre(item.categories)
            end if

            RAF.setContentLength(int(item.length))
            adPods = RAF.getAds()
            m.top.lastIndex = index
            csasStream = RAF.constructStitchedStream(item, adPods)
            keepPlay = RAF.renderStitchedStream(csasStream, parentNode)

        else
            keepPlay = false
        end if
    end while
end sub
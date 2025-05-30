sub Init()
    m.poster = m.top.findNode("poster")
    m.title = m.top.findNode("title")
    m.info = m.top.findNode("info")
    m.description = m.top.findNode("description")

    m.title.font.size = 20
    m.info.font.size = 16
    m.description.font.size = 16
end sub

sub ItemContentChanged()
    itemContent = m.top.itemContent

    if itemContent <> invalid
        m.poster.uri = itemContent.hdPosterUrl
        m.title.text = itemContent.title

        divider = " | "
        episode = "E" + itemContent.episodePosition
        time = getTime(itemContent.length)

        date = itemContent.releaseDate
        season = itemContent.titleSeason

        m.info.text = episode + divider + date + divider + time + divider + season
        m.description.text = itemContent.description
    end if
end sub
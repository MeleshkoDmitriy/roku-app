sub Init()
    m.top.functionName = "GetContent"
end sub

sub GetContent()
    rootChildren = []
    rows = {}

    xref = CreateObject("roURLTransfer")
    xref.setCertificatesFile("common:/certs/ca-bundle.crt")
    xref.setURL("https://jonathanbduval.com/roku/feeds/roku-developers-feed-v1.json")
    response = xref.getToStr()
    json = parseJson(response)

    if json <> invalid

        for each category in json
            value = json.lookup(category)

            if type(value) = "roArray" 

                if category <> "series"
                    row = {}
                    row.title = category
                    row.children = []

                    for each item in value
                        itemData = getItemData(item)
                        row.children.push(itemData)
                    end for

                    rootChildren.push(row)
                end if
            end if
        end for

        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.update({
            children: rootChildren
        }, true)

        m.top.content = contentNode
    end if
end sub 

function getItemData(video as Object) as Object
    item = {}
    
    if video.longDescription <> invalid
        item.description = video.longDescription
    else
        item.description = video.shortDescription
    end if

    item.hdPosterURL = video.thumbnail
    item.title = video.title
    item.releaseDate = video.releaseDate
    item.id = video.id

    if video.content <> invalid
        item.length = video.content.duration
    end if
    
    return item
end function
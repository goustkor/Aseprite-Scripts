local pc = app.pixelColor
local scale = app.preferences.general.screen_scale

tr = 0

local dlg = Dialog("Multi Replacer")
local bounds = dlg.bounds

dlg:button{ id=string,
            label=string,
            text="+",
            onclick = function ()
                addReplacer()
                refresh()
            end
}

dlg:button{ id=string,
            label=string,
            text="Replace",
            onclick = function ()
                replace()
            end
}

dlg:check{ id="selected",
           text="Only Selected",
           selected=false,
}



function addReplacer()
    if tr > 5 then return end
    dlg:separator{}

    dlg:color{ id="f"..tr,
    label="From: ",
    color=app.Color }

    dlg:newrow()

    dlg:color{ id="t" .. tr,
    label="To: ",
    color=app.Color }

    bounds = dlg.bounds
    dlg.bounds = Rectangle(
        bounds.x,
        bounds.y,
        bounds.width,
        bounds.height + 45*scale
    )
    
    tr = tr + 1
end

function refresh()
    dlg:close()
    dlg:show{wait = false}
end

addReplacer()

dlg.bounds = Rectangle(bounds.x, bounds.y, 150*scale, 110*scale)

dlg:show{wait = false}

function replace()

        local image = app.activeImage

        local data = dlg.data

        local f0, f1, f2, f3, f4, f5
        local color, pixel

        if data.f0 ~= nil then f0 = Color{ r= data.f0.red, g= data.f0.green, b= data.f0.blue, a= data.f0.alpha} end
        if data.f1 ~= nil then f1 = Color{ r= data.f1.red, g= data.f1.green, b= data.f1.blue, a= data.f1.alpha} end
        if data.f2 ~= nil then f2 = Color{ r= data.f2.red, g= data.f2.green, b= data.f2.blue, a= data.f2.alpha} end
        if data.f3 ~= nil then f3 = Color{ r= data.f3.red, g= data.f3.green, b= data.f3.blue, a= data.f3.alpha} end
        if data.f4 ~= nil then f4 = Color{ r= data.f4.red, g= data.f4.green, b= data.f4.blue, a= data.f4.alpha} end
        if data.f5 ~= nil then f5 = Color{ r= data.f5.red, g= data.f5.green, b= data.f5.blue, a= data.f5.alpha} end
        
        local selection = app.activeSprite.selection.bounds
        local bounds = app.activeImage.cel.bounds

        if data.selected == false then
            for i = 0, image.width do
                for j = 0, image.height do
                    pixel = nil
                    color = nil
                    pixel = image:getPixel(i, j)
                    color = Color{r= pc.rgbaR(pixel), g= pc.rgbaG(pixel), b= pc.rgbaB(pixel), a= pc.rgbaA(pixel)}
                    if f0 ~= nil then if color == f0 then image:drawPixel(i, j, data.t0) end end
                    if f1 ~= nil then if color == f1 then image:drawPixel(i, j, data.t1) end end
                    if f2 ~= nil then if color == f2 then image:drawPixel(i, j, data.t2) end end
                    if f3 ~= nil then if color == f3 then image:drawPixel(i, j, data.t3) end end
                    if f4 ~= nil then if color == f4 then image:drawPixel(i, j, data.t4) end end
                    if f5 ~= nil then if color == f5 then image:drawPixel(i, j, data.t5) end end
                end
            end
        end
        if data.selected == true then
            for i = 0, selection.width -1 do
                for j = 0, selection.height -1 do
                    pixel = nil
                    color = nil
                    pixel = image:getPixel((selection.x - bounds.x) + i, (selection.y - bounds.y ) + j)
                    color = Color{r= pc.rgbaR(pixel), g= pc.rgbaG(pixel), b= pc.rgbaB(pixel), a= pc.rgbaA(pixel)}
                    if f0 ~= nil then if color == f0 then image:drawPixel((selection.x - bounds.x) + i, (selection.y - bounds.y ) + j, data.t0) end end
                    if f1 ~= nil then if color == f1 then image:drawPixel((selection.x - bounds.x) + i, (selection.y - bounds.y ) + j, data.t1) end end
                    if f2 ~= nil then if color == f2 then image:drawPixel((selection.x - bounds.x) + i, (selection.y - bounds.y ) + j, data.t2) end end
                    if f3 ~= nil then if color == f3 then image:drawPixel((selection.x - bounds.x) + i, (selection.y - bounds.y ) + j, data.t3) end end
                    if f4 ~= nil then if color == f4 then image:drawPixel((selection.x - bounds.x) + i, (selection.y - bounds.y ) + j, data.t4) end end
                    if f5 ~= nil then if color == f5 then image:drawPixel((selection.x - bounds.x) + i, (selection.y - bounds.y ) + j + 1, data.t5) end end
                end
            end
        end

        app.refresh()

end
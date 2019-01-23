local totalTime = 0
local checkTime = 0


--Start Time
local sHora = tonumber(os.date("%H"))
local sMinutos = tonumber(os.date("%M"))
local sSegundos = tonumber(os.date("%S"))

--Paused Time
local pHora = tonumber(os.date("%H"))
local pMinutos = tonumber(os.date("%M"))
local pSegundos = tonumber(os.date("%S"))

--Conditions
local isPause = true
local isCheck = false

--Dialog
local toolBar = Dialog("Timer")
local toolBarHide = Dialog("Timer")
	
	--ToolBar hide button
	toolBarHide:button{
		text = "Show",
		onclick = function() 
			toolBar:show{wait=false} 
			toolBarHide:close{}
		end
	}

	--ToolBar default
	toolBar:button{
		text = "Reset",
		onclick = 	function()
						totalTime = 0
						checkTime = 0
						isPause = true
					end
	}
	toolBar:button{
		text = "||",
		onclick = function() pause() end
	}
	toolBar:button{
		text = ">",
		onclick = function() resume() end
	}
	toolBar:button{
		text = "Check",
		onclick = function() check() end
	}
	toolBar:button{
		text = "Hide",
		onclick = function() 
			toolBarHide:show{wait=false} 
			toolBar:close{}
		end
	}
	toolBar:show{wait=false}

--Pause timer and get totaltime 
function pause ()
	if isPause == true then
		app.alert("Is running")
		return
	end

	generateTotalTime()
	isPause = true

end

--Resume timer, and reset variables start time
function resume()
	if isPause == false then
		app.alert("Is stopped")
		return
	end

	sHora = tonumber(os.date("%H"))
	sMinutos = tonumber(os.date("%M"))
	sSegundos = tonumber(os.date("%S"))
	isPause = false
end


--Check timer past
function check()
	isCheck = true
	generateTotalTime()
	isCheck = false
	app.alert("Hours: " .. math.floor(checkTime / 60 / 60) .. " Minutes: " .. math.floor((checkTime / 60) % 60) .. " Seconds: " .. math.floor(checkTime % 60))
end


--Gerate timer to check time, and totaltime
function generateTotalTime ()
	--Check is pause false to set varibles pause time to current time
	if isPause == false then
		pHora = tonumber(os.date("%H"))
		pMinutos = tonumber(os.date("%M"))
		pSegundos = tonumber(os.date("%S"))
	end

	--Set startTime in seconds
	local startTime = sHora*60*60
	startTime = startTime +  sMinutos*60
	startTime = startTime + sSegundos

	--Set pauseTime in seconds
	local endTime = pHora * 60 * 60
	endTime = endTime + pMinutos * 60
	endTime = endTime + pSegundos


	if isCheck == true then
		if isPause == true then
			checkTime = totalTime
		else
			checkTime = totalTime + endTime - startTime
		end
	else
		totalTime = totalTime + endTime - startTime
	end
end

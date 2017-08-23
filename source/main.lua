local gol = script.Parent
local gui = gol.gui
local gametbl = {}

local function reset()
	for i = 1, 400 do gametbl[i] = 1 end
end

local function update()
	for i = 1, 400 do
		local c = gametbl[i]
		gui["btn"..i].BackgroundColor3 = Color3.new(c, c, c)
	end
end

local function getCount(i)
	local count = 0
	for j = -1, 1 do
		for x = -1, 1 do
			local n = i+x+(j*20)
			if gui["btn"..n].BackgroundColor3 == Color3.fromRGB(0, 0, 0) and n ~= i then
				count = count + 1
			end
		end
	end
	return count
end

local function generate()
	for i = 1, 400 do
		local btn = gol.btn0:Clone()
		btn.Parent = gui
		btn.Visible = true
		btn.Name = "btn" .. i
		btn.Position = UDim2.new(0, ((i-1)*20) % 400, 0, math.floor(i/20.05)*20)
		
		if (i % 20) < 2 or i <= 20 or i >= 380 then
			btn.Visible = false
		end
		
		btn.MouseButton1Click:Connect(function()
			if btn.BackgroundColor3 == Color3.fromRGB(255, 255, 255) then
				btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			elseif btn.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
				btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			end
		end)
	end
end

gol.runbtn.MouseButton1Click:Connect(function()
	reset()
	for i = 1, 400 do
		if (i % 20) >= 2 and (i % 20) <= 19 and i > 20 and i < 380 then
			local count = getCount(i)
			if gui["btn"..i].BackgroundColor3 == Color3.new(0, 0, 0) then
				if count >= 2 and count <= 3 then
					gametbl[i] = 0
				end
			elseif count == 3 then
				gametbl[i] = 0
			end
		end
	end
	update()
end)

generate()

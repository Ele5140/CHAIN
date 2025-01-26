--[[ 

Script by Ele5140 on GitHub.
I didn't consider devices with screens smaller/larger than my laptop's, I'm sorry lmao :sob:

]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

local Bypass = game:GetService("CoreGui")

local CoreGui = Instance.new("Folder")
CoreGui.Parent = Bypass

local Colors = {}
Colors.Players = Color3.new(1,1,1)
Colors.CHAIN = Color3.new(1,0.4,0.4)

-- UI

local MainUI = Instance.new("ScreenGui")
MainUI.Parent = CoreGui
MainUI.Enabled = true

local UI = Instance.new("Frame")
UI.Parent = MainUI
UI.Size = UDim2.new(0.983,0,0.966,0)
UI.Position = UDim2.new(0.008,0,0.016,0)
UI.BackgroundTransparency = 1

local Layout = Instance.new("UIGridLayout")
Layout.Parent = UI
Layout.CellPadding = UDim2.new(0,10,0,5)
Layout.CellSize = UDim2.new(0,50,0,50)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom

local PlayersButton = Instance.new("ImageButton")
PlayersButton.Parent = UI
PlayersButton.BackgroundTransparency = 0.5
PlayersButton.BackgroundColor3 = Color3.fromRGB(46, 49, 72)
PlayersButton.Image = "rbxassetid://18112836267"
local Round1 = Instance.new("UICorner")
Round1.CornerRadius = UDim.new(1,0)
Round1.Parent = PlayersButton

local CHAINButton = Instance.new("ImageButton")
CHAINButton.Parent = UI
CHAINButton.BackgroundTransparency = 0.5
CHAINButton.BackgroundColor3 = Color3.fromRGB(46, 49, 72)
CHAINButton.Image = "rbxassetid://13791057421"
local Round2 = Instance.new("UICorner")
Round2.CornerRadius = UDim.new(1,0)
Round2.Parent = CHAINButton

-- Highlight Creation

local create1 = function(thing, name, color)
	local highlight = Instance.new("Highlight")
	highlight.Adornee = thing
	highlight.Parent = CoreGui
	highlight.FillTransparency = 1
	highlight.OutlineColor = color
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Name = name
end

local Toggle = true
local ChainToggle = true

PlayersButton.MouseButton1Down:Connect(function()
	Toggle = not Toggle
end)

CHAINButton.MouseButton1Down:Connect(function()
	ChainToggle = not ChainToggle
end)

UIS.InputBegan:Connect(function(input, v)
	if v then return end

	if input.KeyCode == Enum.KeyCode.K then
		MainUI.Enabled = not MainUI.Enabled
	end
end)

local humsHealth = {}

-- Highlight Handler

for i, player in pairs(Players:GetChildren()) do
	repeat wait() until player.Character
	if not CoreGui:FindFirstChild(player.UserId) then
		create1(player.Character, (player.UserId), Color3.new(1,1,1))
		task.wait()
		humsHealth[player.UserId] = player.Character:FindFirstChild("Humanoid").Health
	end

end

game.Players.PlayerAdded:Connect(function(player)
	repeat wait() until player.Character
	if not CoreGui:FindFirstChild(player.UserId) then
		create1(player.Character, (player.UserId), Color3.new(1,1,1))
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	if CoreGui:FindFirstChild(player.UserId) then
		CoreGui:FindFirstChild(player.UserId):Destroy()
	end		
end)

RunService.Heartbeat:Connect(function()
	for i, player in pairs(Players:GetChildren()) do
		repeat wait() until player.Character
		
		local char = player.Character
		local hum = char:FindFirstChild("Humanoid")
		local ID = player.UserId
		
		if player.Character then
			if not CoreGui:FindFirstChild(player.UserId) then
				create1(char, player.UserId, Colors.Players)
			end
			CoreGui:FindFirstChild(ID).Enabled = Toggle
			CoreGui:FindFirstChild(ID).Adornee = player.Character

			if hum.Health ~= 0 then
				TS:Create(CoreGui:FindFirstChild(ID), TweenInfo.new(0.5), {OutlineColor = Colors.Players}):Play()
				TS:Create(CoreGui:FindFirstChild(ID), TweenInfo.new(0.2), {OutlineTransparency = 0}):Play()
			end
			if hum.Health == 0 then 
				CoreGui:FindFirstChild(ID).OutlineColor = Color3.new(1,0.2,0.2)
				TS:Create(CoreGui:FindFirstChild(ID), TweenInfo.new(1), {OutlineTransparency = 1}):Play()
			end
			
			if hum.Health ~= humsHealth[ID] and hum.Health < humsHealth[ID] then
				local colorsub = (100 - (humsHealth[ID] - hum.Health)) / 100
				print(colorsub)
				CoreGui:FindFirstChild(ID).OutlineColor = Color3.new(1,colorsub,colorsub)
			end
			
			humsHealth[ID] = hum.Health
		end
		task.wait()
	end
end)

RunService.Heartbeat:Connect(function()
	if workspace:FindFirstChild("Misc") then
		if workspace.Misc:FindFirstChild("AI") then
			if workspace.Misc.AI:FindFirstChild("CHAIN") then
				local chain = workspace.Misc.AI:FindFirstChild("CHAIN")
				if not CoreGui:FindFirstChild("CHAIN") then
					create1(chain, "CHAIN", Colors.CHAIN)
				end
				CoreGui:FindFirstChild("CHAIN").Enabled = ChainToggle
			else
				if CoreGui:FindFirstChild("CHAIN") then
					CoreGui:FindFirstChild("CHAIN"):Destroy()
				end
			end
		end
	end
	task.wait()
end)

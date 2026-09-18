local FOLDER, OFFSET, SMOOTH = "Workplace", Vector3.new(6, 1.5, 4), 0.1
local Players, RunService = game:GetService("Players"), game:GetService("RunService")
local player = Players.LocalPlayer
local function clear(n, p) local o = p:FindFirstChild(n) if o then o:Destroy() end end
clear("TV_FullController", player.PlayerGui) clear("Letyashiy_Televizor", workspace)
if makefolder and not isfolder(FOLDER) then makefolder(FOLDER) end
local playlist = {}
pcall(function()
if listfiles and isfolder(FOLDER) then
for _, p in ipairs(listfiles(FOLDER)) do
if p:sub(-4):lower() == ".mp3" or p:sub(-4):lower() == ".ogg" then table.insert(playlist, p) end
end
end
end)
if #playlist == 0 then playlist = {"rbxassetid://1837874690"} end
local index, isPlaying, isNeon = 1, true, false
local customColor = Color3.fromRGB(0, 255, 100)
local screen = Instance.new("Part")
screen.Name, screen.Size, screen.Anchored, screen.CanCollide, screen.Material, screen.Color, screen.Parent = "Letyashiy_Televizor", Vector3.new(5.3, 3, 0.2), true, false, Enum.Material.SmoothPlastic, Color3.fromRGB(15, 15, 15), workspace
local border = Instance.new("SelectionBox")
border.Adornee, border.Color3, border.LineThickness, border.SurfaceColor3, border.Visible, border.Parent = screen, customColor, 0.04, customColor, true, screen
local sgui = Instance.new("SurfaceGui")
sgui.Face, sgui.PixelsPerStud, sgui.Parent = Enum.NormalId.Front, 150, screen
local bg = Instance.new("Frame")
bg.Size, bg.BackgroundColor3, bg.Parent = UDim2.new(1,0,1,0), Color3.fromRGB(10,10,10), sgui
local container = Instance.new("Frame")
container.Size, container.Position, container.BackgroundTransparency, container.Parent = UDim2.new(0.8,0,0.6,0), UDim2.new(0.1,0,0.2,0), 1, bg
local bars = {}
for i = 1, 14 do
local b = Instance.new("Frame")
b.Size, b.Position, b.BorderSizePixel, b.Parent = UDim2.new(1/14-0.02,0,0.1,0), UDim2.new((i-1)/14+0.01,0,0.9,0), 0, container
Instance.new("UICorner").Parent = b
table.insert(bars, b)
end
local pe = Instance.new("ParticleEmitter")
pe.LightEmission, pe.Size, pe.Lifetime, pe.Speed, pe.EmissionDirection, pe.SpreadAngle, pe.Rate, pe.Parent = 1, NumberSequence.new({NumberSequenceKeypoint.new(0,0.6), NumberSequenceKeypoint.new(1,0)}), NumberRange.new(0.4,0.8), NumberRange.new(4,8), Enum.NormalId.Back, Vector2.new(20,20), 0, screen
local sound = Instance.new("Sound")
sound.Volume, sound.Looped, sound.Parent = 3, true, screen
local function play(i)
local p = playlist[i]
sound.SoundId = p:sub(1,12) == "rbxassetid://" and p or getcustomasset(p)
if isPlaying then sound:Play() end
end
play(index)
local gui = Instance.new("ScreenGui")
gui.Name, gui.ResetOnSpawn, gui.Parent = "TV_FullController", false, player:WaitForChild("PlayerGui")
local btn = Instance.new("TextButton")
btn.Size, btn.Position, btn.BackgroundColor3, btn.Text, btn.TextColor3, btn.Font, btn.TextSize, btn.Parent = UDim2.new(0,100,0,35), UDim2.new(1,-120,0,55), Color3.fromRGB(35,35,35), "🎵 Меню ТВ", Color3.fromRGB(255,255,255), Enum.Font.SourceSansBold, 14, gui
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
local panel = Instance.new("Frame")
panel.Size, panel.Position, panel.BackgroundColor3, panel.Visible, panel.Active, panel.Draggable, panel.Parent = UDim2.new(0,260,0,210), UDim2.new(0.5,-130,0.4,-105), Color3.fromRGB(25,25,25), false, true, true, gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)
local lbl = Instance.new("TextLabel")
lbl.Size, lbl.Position, lbl.BackgroundTransparency, lbl.TextColor3, lbl.Font, lbl.TextSize, lbl.TextWrapped, lbl.Parent = UDim2.new(1,-20,0,40), UDim2.new(0,10,0,10), 1, Color3.fromRGB(255,255,255), Enum.Font.SourceSansBold, 14, true, panel
local function up() lbl.Text = "Играет:\n" .. (playlist[index]:match("([^/]+)$") or "Стандартный трек") end
up()
local function createBtn(t, x, y, s, f)
local b = Instance.new("TextButton")
b.Size, b.Position, b.BackgroundColor3, b.Text, b.TextColor3, b.TextSize, b.Parent = s, UDim2.new(x,0,y,0), f, t, Color3.fromRGB(255,255,255), 16, panel
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
return b
end
local btnP = createBtn("⏸", 0.38, 0.22, UDim2.new(0,60,0,45), Color3.fromRGB(0,150,255))
btnP.TextSize = 22
local btnB = createBtn("◀◀", 0.08, 0.22, UDim2.new(0,55,0,45), Color3.fromRGB(50,50,50))
local btnN = createBtn("▶▶", 0.68, 0.22, UDim2.new(0,55,0,45), Color3.fromRGB(50,50,50))
local btnNeon = createBtn("Материал: Обычный", 0.08, 0.48, UDim2.new(0,216,0,30), Color3.fromRGB(60,60,60))
btnNeon.TextSize = 13
local colorSlider = Instance.new("ImageButton")
colorSlider.Size, colorSlider.Position, colorSlider.BorderSizePixel, colorSlider.Parent = UDim2.new(0, 216, 0, 20), UDim2.new(0.08, 0, 0.74, 0), 0, panel
Instance.new("UICorner", colorSlider).CornerRadius = UDim.new(0, 6)
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.15, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.45, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))})
gradient.Parent = colorSlider
local picker = Instance.new("Frame")
picker.Size, picker.BackgroundColor3, picker.Position, picker.Parent = UDim2.new(0, 6, 0, 24), Color3.fromRGB(255, 255, 255), UDim2.new(0.33, -3, 0, -2), colorSlider
Instance.new("UICorner", picker).CornerRadius = UDim.new(0, 3)
local function updateColorFromSlider(X)
local rX = X - colorSlider.AbsolutePosition.X
local percentage = math.clamp(rX / colorSlider.AbsoluteSize.X, 0, 1)
picker.Position = UDim2.new(percentage, -3, 0, -2)
if percentage >= 0.92 then customColor = Color3.fromRGB(255, 255, 255) else customColor = Color3.fromHSV(math.clamp(percentage / 0.90, 0, 1), 1, 1) end
border.Color3, border.SurfaceColor3 = customColor, customColor
if isNeon then screen.Color = customColor else screen.Color = Color3.fromRGB(15, 15, 15) end
end
local isDraggingColor = false
colorSlider.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDraggingColor = true updateColorFromSlider(input.Position.X) end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
if isDraggingColor and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateColorFromSlider(input.Position.X) end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDraggingColor = false end
end)
btn.MouseButton1Click:Connect(function() panel.Visible = not panel.Visible btn.BackgroundColor3 = panel.Visible and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(35, 35, 35) end)
btnP.MouseButton1Click:Connect(function() isPlaying = not isPlaying if isPlaying then sound:Resume() btnP.Text = "⏸" else sound:Pause() btnP.Text = "▶" end end)
btnB.MouseButton1Click:Connect(function() index = index - 1 if index < 1 then index = #playlist end play(index) up() end)
btnN.MouseButton1Click:Connect(function() index = index + 1 if index > #playlist then index = 1 end play(index) up() end)
btnNeon.MouseButton1Click:Connect(function()
isNeon = not isNeon
if isNeon then screen.Material = Enum.Material.Neon screen.Color = customColor btnNeon.Text = "Материал: Неоновый светится" btnNeon.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
else screen.Material = Enum.Material.SmoothPlastic screen.Color = Color3.fromRGB(15, 15, 15) btnNeon.Text = "Материал: Обычный пластик" btnNeon.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end
end)
RunService.RenderStepped:Connect(function()
local char = player.Character
if char and char:FindFirstChild("HumanoidRootPart") then
local hrp = char.HumanoidRootPart
screen.Position = screen.Position:Lerp(hrp.CFrame:PointToWorldSpace(OFFSET), SMOOTH)
screen.CFrame = CFrame.lookAt(screen.Position, screen.Position + hrp.CFrame.LookVector)
pe.Rate = (hrp.AssemblyLinearVelocity.Magnitude > 1 and isPlaying) and 75 or 0
end
end)
RunService.Heartbeat:Connect(function()
local loud = (isPlaying and sound.PlaybackLoudness or 0) / 1000
bg.BackgroundColor3, pe.Color = Color3.fromRGB(10,10,10), ColorSequence.new(customColor)
for i, b in ipairs(bars) do
local h = math.clamp(loud * 1.1 * (math.sin(tick() * (5 + i)) * 0.15 + 0.85), 0.05, 0.95)
b.Size = UDim2.new(b.Size.X.Scale, 0, h, 0)
b.Position = UDim2.new(b.Position.X.Scale, 0, 0.95 - h, 0)
b.BackgroundColor3 = customColor
end
end)

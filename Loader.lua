local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Configuration
local CORRECT_KEY = "YuanIsCool"
local KEY_LINK = "https://link-target.net/8487373/rbm2RHgBZtsD"

-- Theme Colors (Light Blue UI & Blue ESP)
local LIGHT_BLUE = Color3.fromRGB(135, 206, 250)
local DARK_BLUE = Color3.fromRGB(0, 102, 204)
local BLUE_ESP = Color3.fromRGB(30, 144, 255)

local FOV_SIZE = 250
local MAX_DISTANCE = 500

local drawingWorks = pcall(function() return Drawing.new("Line") end)

-- Key System GUI
local function createKeySystem(onSuccess)
    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "YuanKeySystem"
    keyGui.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 200)
    frame.Position = UDim2.new(0.5, -160, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = LIGHT_BLUE
    frame.Parent = keyGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "Yuan Own Hub - Key System"
    title.TextColor3 = LIGHT_BLUE
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 260, 0, 35)
    textBox.Position = UDim2.new(0.5, -130, 0, 50)
    textBox.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
    textBox.BorderSizePixel = 1
    textBox.BorderColor3 = LIGHT_BLUE
    textBox.PlaceholderText = "Enter Key Here..."
    textBox.PlaceholderColor3 = Color3.fromRGB(150, 180, 210)
    textBox.Text = ""
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 14
    textBox.Font = Enum.Font.Gotham
    textBox.Parent = frame

    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(0, 125, 0, 35)
    submitBtn.Position = UDim2.new(0, 30, 0, 100)
    submitBtn.BackgroundColor3 = DARK_BLUE
    submitBtn.BorderSizePixel = 0
    submitBtn.Text = "Submit Key"
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.TextSize = 14
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.Parent = frame

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0, 125, 0, 35)
    getKeyBtn.Position = UDim2.new(0, 165, 0, 100)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    getKeyBtn.BorderSizePixel = 0
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyBtn.TextSize = 14
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.Parent = frame

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 30)
    statusLabel.Position = UDim2.new(0, 0, 0, 150)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = LIGHT_BLUE
    statusLabel.TextSize = 13
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = frame

    getKeyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(KEY_LINK)
            statusLabel.TextColor3 = LIGHT_BLUE
            statusLabel.Text = "Key link copied to clipboard!"
        else
            statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            statusLabel.Text = "Clipboard not supported!"
        end
    end)

    submitBtn.MouseButton1Click:Connect(function()
        if textBox.Text == CORRECT_KEY then
            statusLabel.TextColor3 = LIGHT_BLUE
            statusLabel.Text = "Correct Key! Loading..."
            task.wait(1)
            keyGui:Destroy()
            onSuccess()
        else
            statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            statusLabel.Text = "Invalid Key! Try again."
        end
    end)
end

-- Main Hub Execution Logic
local function initHub()
    local function createESP(player)
        if player == LocalPlayer then return end

        local tracer = Drawing.new("Line")
        local distanceText = drawingWorks and Drawing.new("Text") or nil
        local highlight = Instance.new("Highlight")

        tracer.Color = BLUE_ESP
        tracer.Thickness = 1

        if distanceText then
            distanceText.Color = BLUE_ESP
            distanceText.Size = 13
            distanceText.Center = true
            distanceText.Outline = true
        end

        highlight.FillColor = BLUE_ESP
        highlight.OutlineColor = BLUE_ESP
        highlight.FillTransparency = 0.8
        highlight.OutlineTransparency = 0
        highlight.Parent = game:GetService("CoreGui")

        local function setAllVisibility(visible)
            tracer.Visible = visible
            if distanceText then distanceText.Visible = visible end
            highlight.Enabled = visible
        end

        local connection
        connection = RunService.RenderStepped:Connect(function()
            local character = player.Character
            if not character or not character:IsDescendantOf(workspace) or not LocalPlayer.Character then
                setAllVisibility(false)
                if not player:IsDescendantOf(Players) then
                    tracer:Remove()
                    if distanceText then distanceText:Remove() end
                    highlight:Destroy()
                    connection:Disconnect()
                end
                return
            end

            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local head = character:FindFirstChild("Head")

            if rootPart and humanoid and humanoid.Health > 0 and head then
                local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local distance = localRoot and (rootPart.Position - localRoot.Position).Magnitude or 0

                if onScreen and distance <= MAX_DISTANCE then
                    highlight.Adornee = character
                    highlight.Enabled = true

                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    tracer.To = Vector2.new(headPos.X, headPos.Y)
                    tracer.Visible = true

                    if distanceText then
                        distanceText.Text = "Distance: " .. math.floor(distance)
                        distanceText.Position = Vector2.new(headPos.X, headPos.Y - 20)
                        distanceText.Visible = true
                    end
                else
                    setAllVisibility(false)
                end
            else
                setAllVisibility(false)
            end
        end)
    end

    for _, player in ipairs(Players:GetPlayers()) do createESP(player) end
    Players.PlayerAdded:Connect(createESP)

    local fovCircle = drawingWorks and (function()
        local circle = Drawing.new("Circle")
        circle.Color = BLUE_ESP
        circle.Thickness = 1
        circle.Transparency = 1
        circle.Radius = FOV_SIZE
        circle.NumSides = 60
        circle.Filled = false
        circle.ZIndex = 999
        return circle
    end)() or nil

    RunService.RenderStepped:Connect(function()
        if fovCircle then
            fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            fovCircle.Visible = true
        end
    end)

    local lockedHead = nil

    local function getClosestHead()
        local character = LocalPlayer.Character
        if not character then return nil end

        local localRoot = character:FindFirstChild("HumanoidRootPart")
        if not localRoot then return nil end

        local centerPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local fovSq = FOV_SIZE * FOV_SIZE
        local closestHead = nil
        local closestScreenDist = fovSq

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local head = player.Character:FindFirstChild("Head")
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                local hum = player.Character:FindFirstChildOfClass("Humanoid")

                if head and rootPart and hum and hum.Health > 0 then
                    local distance = (rootPart.Position - localRoot.Position).Magnitude
                    if distance <= MAX_DISTANCE then
                        local screenPoint, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local screenPos = Vector2.new(screenPoint.X, screenPoint.Y)
                            local dist = (screenPos - centerPos).Magnitude
                            if dist < closestScreenDist then
                                closestScreenDist = dist
                                closestHead = head
                            end
                        end
                    end
                end
            end
        end

        lockedHead = closestHead
        return closestHead
    end

    local BulletHandler = require(game:GetService("ReplicatedStorage").ModuleScripts.GunModules.BulletHandler)
    local oldFire = BulletHandler.Fire

    BulletHandler.Fire = function(p6)
        local closestHead = getClosestHead()
        if closestHead then
            p6.Direction = (closestHead.Position - p6.Origin).Unit
        end
        return oldFire(p6)
    end
end

-- Initialize Key System
createKeySystem(initHub)


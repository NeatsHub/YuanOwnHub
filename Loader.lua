local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Configuration
local CORRECT_KEY = "YuanIsCool" -- Updated Key
local KEY_LINK = "https://discord.gg/XPBxDSpJHn" -- Link where users get the key

local PINK = Color3.fromRGB(255, 105, 180)
local FOV_SIZE = 250
local MAX_DISTANCE = 500
local DISCORD_LINK = "https://discord.gg/XPBxDSpJHn"

local drawingWorks = pcall(function() return Drawing.new("Line") end)

-- Key System GUI
local function createKeySystem(onSuccess)
    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "YuanKeySystem"
    keyGui.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 200)
    frame.Position = UDim2.new(0.5, -160, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.Parent = keyGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "Yuan Own Hub - Key System"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 260, 0, 35)
    textBox.Position = UDim2.new(0.5, -130, 0, 50)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    textBox.BorderSizePixel = 0
    textBox.PlaceholderText = "Enter Key Here..."
    textBox.Text = ""
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 14
    textBox.Font = Enum.Font.Gotham
    textBox.Parent = frame

    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(0, 125, 0, 35)
    submitBtn.Position = UDim2.new(0, 30, 0, 100)
    submitBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    submitBtn.BorderSizePixel = 0
    submitBtn.Text = "Submit Key"
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.TextSize = 14
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.Parent = frame

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0, 125, 0, 35)
    getKeyBtn.Position = UDim2.new(0, 165, 0, 100)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
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
    statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    statusLabel.TextSize = 13
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = frame

    getKeyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(KEY_LINK)
            statusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
            statusLabel.Text = "Key link copied to clipboard!"
        else
            statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            statusLabel.Text = "Clipboard not supported!"
        end
    end)

    submitBtn.MouseButton1Click:Connect(function()
        if textBox.Text == CORRECT_KEY then
            statusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
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
    local function showDiscordMenu()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = game:GetService("CoreGui")

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 150)
        frame.Position = UDim2.new(0.5, -150, 0.5, -75)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.BorderSizePixel = 0
        frame.Parent = screenGui

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 0, 50)
        textLabel.Position = UDim2.new(0, 0, 0, 10)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "Yuan Own Hub\nJoin the discord?"
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 18
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Parent = frame

        local declineButton = Instance.new("TextButton")
        declineButton.Size = UDim2.new(0, 120, 0, 35)
        declineButton.Position = UDim2.new(0, 20, 0, 85)
        declineButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        declineButton.BorderSizePixel = 0
        declineButton.Text = "Decline"
        declineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        declineButton.TextSize = 16
        declineButton.Font = Enum.Font.Gotham
        declineButton.Parent = frame

        local acceptButton = Instance.new("TextButton")
        acceptButton.Size = UDim2.new(0, 120, 0, 35)
        acceptButton.Position = UDim2.new(0, 160, 0, 85)
        acceptButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        acceptButton.BorderSizePixel = 0
        acceptButton.Text = "Accept"
        acceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        acceptButton.TextSize = 16
        acceptButton.Font = Enum.Font.Gotham
        acceptButton.Parent = frame

        local function closeMenu()
            screenGui:Destroy()
        end

        declineButton.MouseButton1Click:Connect(closeMenu)

        acceptButton.MouseButton1Click:Connect(function()
            if setclipboard then setclipboard(DISCORD_LINK) end
            pcall(function()
                request({
                    Url = 'http://127.0.0.1:6463/rpc?v=1',
                    Method = 'POST',
                    Headers = {
                        ['Content-Type'] = 'application/json',
                        Origin = 'https://discord.com'
                    },
                    Body = HttpService:JSONEncode({
                        cmd = 'INVITE_BROWSER',
                        nonce = HttpService:GenerateGUID(false),
                        args = {code = "XPBxDSpJHn"}
                    })
                })
            end)
            textLabel.Text = "Link copied to clipboard!"
            declineButton.Visible = false
            acceptButton.Visible = false
            task.delay(5, closeMenu)
        end)
    end

    showDiscordMenu()

    local function createESP(player)
        if player == LocalPlayer then return end

        local tracer = Drawing.new("Line")
        local distanceText = drawingWorks and Drawing.new("Text") or nil
        local highlight = Instance.new("Highlight")

        tracer.Color = PINK
        tracer.Thickness = 1

        if distanceText then
            distanceText.Color = PINK
            distanceText.Size = 13
            distanceText.Center = true
            distanceText.Outline = true
        end

        highlight.FillColor = PINK
        highlight.OutlineColor = PINK
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
        circle.Color = PINK
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


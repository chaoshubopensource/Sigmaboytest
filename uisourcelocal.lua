local Libary = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()
workspace.FallenPartsDestroyHeight = -math.huge

local Window = Libary:MakeWindow({
    Title = "Sigma Boy Hub | Brookhaven RP ",
    SubTitle = "by: maverickk7_",
    LoadText = "Carregando Sigma Boy Hub",
    Flags = "SigmaBoyHub_Broookhaven"
})

-- Botão minimizar quadrado e maior
Window:AddMinimizeButton({
    Button = { 
        Image = "rbxassetid://74542926893496", 
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 40, 0, 40)  -- Aumenta o tamanho do botão
    },
    Corner = { 
        CornerRadius = UDim.new(0, 8) -- Faz ficar mais quadrado (menos arredondado)
    },
})

local InfoTab = Window:MakeTab({ Title = "Info", Icon = "rbxassetid://15309138473" })

InfoTab:AddSection({ "Informações do Script" })
InfoTab:AddParagraph({ "Owner / Developer:", "maverickk 7." })
InfoTab:AddParagraph({ "Colaborações:", "Blue, sukuna, Magekko, Darkness, Star, Toddy" })
InfoTab:AddParagraph({ "Você está usando:", "Sigma Boy Hub Brookhaven " })
InfoTab:AddParagraph({"Your executor:", executor or "Unknown"})

InfoTab:AddSection({ "Rejoin" })
InfoTab:AddButton({
    Name = "Rejoin",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end
})

local TrollTab = Window:MakeTab({ Title = "Scripts Trolls", Icon = "rbxassetid://13364900349" })

TrollTab:AddSection({ "Black Hole" })
TrollTab:AddButton({
    Name = "Black Hole",
    Description = " Ativando isso você puxa Parts até o seu personagem",
    Callback = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        local Workspace = game:GetService("Workspace")

        local angle = 1
        local radius = 10
        local blackHoleActive = false

        local function setupPlayer()
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

            local Folder = Instance.new("Folder", Workspace)
            local Part = Instance.new("Part", Folder)
            local Attachment1 = Instance.new("Attachment", Part)
            Part.Anchored = true
            Part.CanCollide = false
            Part.Transparency = 1

            return humanoidRootPart, Attachment1
        end

        local humanoidRootPart, Attachment1 = setupPlayer()

        if not getgenv().Network then
            getgenv().Network = {
                BaseParts = {},
                Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
            }

            Network.RetainPart = function(part)
                if typeof(part) == "Instance" and part:IsA("BasePart") and part:IsDescendantOf(Workspace) then
                    table.insert(Network.BaseParts, part)
                    part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                    part.CanCollide = false
                end
            end

            local function EnablePartControl()
                LocalPlayer.ReplicationFocus = Workspace
                RunService.Heartbeat:Connect(function()
                    sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                    for _, part in pairs(Network.BaseParts) do
                        if part:IsDescendantOf(Workspace) then
                            part.Velocity = Network.Velocity
                        end
                    end
                end)
            end

            EnablePartControl()
        end

        local function ForcePart(v)
            if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
                for _, x in next, v:GetChildren() do
                    if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                        x:Destroy()
                    end
                end
                if v:FindFirstChild("Attachment") then
                    v:FindFirstChild("Attachment"):Destroy()
                end
                if v:FindFirstChild("AlignPosition") then
                    v:FindFirstChild("AlignPosition"):Destroy()
                end
                if v:FindFirstChild("Torque") then
                    v:FindFirstChild("Torque"):Destroy()
                end
                v.CanCollide = false
                
                local Torque = Instance.new("Torque", v)
                Torque.Torque = Vector3.new(1000000, 1000000, 1000000)
                local AlignPosition = Instance.new("AlignPosition", v)
                local Attachment2 = Instance.new("Attachment", v)
                Torque.Attachment0 = Attachment2
                AlignPosition.MaxForce = math.huge
                AlignPosition.MaxVelocity = math.huge
                AlignPosition.Responsiveness = 500
                AlignPosition.Attachment0 = Attachment2
                AlignPosition.Attachment1 = Attachment1
            end
        end

        local function toggleBlackHole()
            blackHoleActive = not blackHoleActive
            if blackHoleActive then
                for _, v in next, Workspace:GetDescendants() do
                    ForcePart(v)
                end

                Workspace.DescendantAdded:Connect(function(v)
                    if blackHoleActive then
                        ForcePart(v)
                    end
                end)

                spawn(function()
                    while blackHoleActive and RunService.RenderStepped:Wait() do
                        angle = angle + math.rad(2)

                        local offsetX = math.cos(angle) * radius
                        local offsetZ = math.sin(angle) * radius

                        Attachment1.WorldCFrame = humanoidRootPart.CFrame * CFrame.new(offsetX, 0, offsetZ)
                    end
                end)
            else
                Attachment1.WorldCFrame = CFrame.new(0, -1000, 0)
            end
        end

        LocalPlayer.CharacterAdded:Connect(function()
            humanoidRootPart, Attachment1 = setupPlayer()
            if blackHoleActive then
                toggleBlackHole()
            end
        end)

        toggleBlackHole()
    end
})

TrollTab:AddSection({ "Puxar Parts" })
TrollTab:AddButton({
    Name = "Puxar Parts",
    Description = "Para usar, chegue perto do Player Selecionado",
    Callback = function()
        -- Gui to Lua
        -- Version: 3.2

        -- Instances:

        local Gui = Instance.new("ScreenGui")
        local Main = Instance.new("Frame")
        local Box = Instance.new("TextBox")
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        local Label = Instance.new("TextLabel")
        local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
        local Button = Instance.new("TextButton")
        local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")

        --Properties:

        Gui.Name = "Gui"
        Gui.Parent = gethui()
        Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        Main.Name = "Main"
        Main.Parent = Gui
        Main.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
        Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Main.BorderSizePixel = 0
        Main.Position = UDim2.new(0.335954279, 0, 0.542361975, 0)
        Main.Size = UDim2.new(0.240350261, 0, 0.166880623, 0)
        Main.Active = true
        Main.Draggable = true

        Box.Name = "Box"
        Box.Parent = Main
        Box.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
        Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Box.BorderSizePixel = 0
        Box.Position = UDim2.new(0.0980926454, 0, 0.218712583, 0)
        Box.Size = UDim2.new(0.801089942, 0, 0.364963502, 0)
        Box.FontFace = Font.new("rbxasset://fonts/families/SourceSansSemibold.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        Box.PlaceholderText = "Player here"
        Box.Text = ""
        Box.TextColor3 = Color3.fromRGB(255, 255, 255)
        Box.TextScaled = true
        Box.TextSize = 31.000
        Box.TextWrapped = true

        UITextSizeConstraint.Parent = Box
        UITextSizeConstraint.MaxTextSize = 31

        Label.Name = "Label"
        Label.Parent = Main
        Label.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
        Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Label.BorderSizePixel = 0
        Label.Size = UDim2.new(1, 0, 0.160583943, 0)
        Label.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        Label.Text = "Bring Parts | Made by: Lusquinha_067"
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextScaled = true
        Label.TextSize = 14.000
        Label.TextWrapped = true

        UITextSizeConstraint_2.Parent = Label
        UITextSizeConstraint_2.MaxTextSize = 21

        Button.Name = "Button"
        Button.Parent = Main
        Button.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
        Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Button.BorderSizePixel = 0
        Button.Position = UDim2.new(0.183284417, 0, 0.656760991, 0)
        Button.Size = UDim2.new(0.629427791, 0, 0.277372271, 0)
        Button.Font = Enum.Font.Nunito
        Button.Text = "Bring | Off"
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextScaled = true
        Button.TextSize = 28.000
        Button.TextWrapped = true

        UITextSizeConstraint_3.Parent = Button
        UITextSizeConstraint_3.MaxTextSize = 28

        -- Scripts:

        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        local UserInputService = game:GetService("UserInputService")
        local Workspace = game:GetService("Workspace")

        local character
        local humanoidRootPart

        mainStatus = true
        UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
            if input.KeyCode == Enum.KeyCode.RightControl and not gameProcessedEvent then
                mainStatus = not mainStatus
                Main.Visible = mainStatus
            end
        end)

        local Folder = Instance.new("Folder", Workspace)
        local Part = Instance.new("Part", Folder)
        local Attachment1 = Instance.new("Attachment", Part)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1

        if not getgenv().Network then
            getgenv().Network = {
                BaseParts = {},
                Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
            }

            Network.RetainPart = function(Part)
                if Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
                    table.insert(Network.BaseParts, Part)
                    Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                    Part.CanCollide = false
                end
            end

            local function EnablePartControl()
                LocalPlayer.ReplicationFocus = Workspace
                RunService.Heartbeat:Connect(function()
                    sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                    for _, Part in pairs(Network.BaseParts) do
                        if Part:IsDescendantOf(Workspace) then
                            Part.Velocity = Network.Velocity
                        end
                    end
                end)
            end

            EnablePartControl()
        end

        local function ForcePart(v)
            if v:IsA("BasePart") and not v.Anchored and not v.Parent:FindFirstChildOfClass("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
                for _, x in ipairs(v:GetChildren()) do
                    if x:IsA("BodyMover") or x:IsA("RocketPropulsion") then
                        x:Destroy()
                    end
                end
                if v:FindFirstChild("Attachment") then
                    v:FindFirstChild("Attachment"):Destroy()
                end
                if v:FindFirstChild("AlignPosition") then
                    v:FindFirstChild("AlignPosition"):Destroy()
                end
                if v:FindFirstChild("Torque") then
                    v:FindFirstChild("Torque"):Destroy()
                end
                v.CanCollide = false
                local Torque = Instance.new("Torque", v)
                Torque.Torque = Vector3.new(100000, 100000, 100000)
                local AlignPosition = Instance.new("AlignPosition", v)
                local Attachment2 = Instance.new("Attachment", v)
                Torque.Attachment0 = Attachment2
                AlignPosition.MaxForce = math.huge
                AlignPosition.MaxVelocity = math.huge
                AlignPosition.Responsiveness = 200
                AlignPosition.Attachment0 = Attachment2
                AlignPosition.Attachment1 = Attachment1
            end
        end

        local blackHoleActive = false
        local DescendantAddedConnection

        local function toggleBlackHole()
            blackHoleActive = not blackHoleActive
            if blackHoleActive then
                Button.Text = "Bring Parts | On"
                for _, v in ipairs(Workspace:GetDescendants()) do
                    ForcePart(v)
                end

                DescendantAddedConnection = Workspace.DescendantAdded:Connect(function(v)
                    if blackHoleActive then
                        ForcePart(v)
                    end
                end)

                spawn(function()
                    while blackHoleActive and RunService.RenderStepped:Wait() do
                        Attachment1.WorldCFrame = humanoidRootPart.CFrame
                    end
                end)
            else
                Button.Text = "Bring Parts | Off"
                if DescendantAddedConnection then
                    DescendantAddedConnection:Disconnect()
                end
            end
        end

        local function getPlayer(name)
            local lowerName = string.lower(name)
            for _, p in pairs(Players:GetPlayers()) do
                local lowerPlayer = string.lower(p.Name)
                if string.find(lowerPlayer, lowerName) then
                    return p
                elseif string.find(string.lower(p.DisplayName), lowerName) then
                    return p
                end
            end
        end

        local player = nil

        local function VDOYZQL_fake_script() -- Box.Script 
            local script = Instance.new('Script', Box)

            script.Parent.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    player = getPlayer(Box.Text)
                    if player then
                        Box.Text = player.Name
                        print("Player found:", player.Name)
                    else
                        print("Player not found")
                    end
                end
            end)
        end
        coroutine.wrap(VDOYZQL_fake_script)()
        local function JUBNQKI_fake_script() -- Button.Script 
            local script = Instance.new('Script', Button)

            script.Parent.MouseButton1Click:Connect(function()
                if player then
                    character = player.Character or player.CharacterAdded:Wait()
                    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                    toggleBlackHole()
                else
                    print("Player is not selected")
                end
            end)
        end
        coroutine.wrap(JUBNQKI_fake_script)()
    end
})

TrollTab:AddSection({ "Invisível" })

TrollTab:AddButton({
    Name = "Ficar Invisível",
    Description = "Ficar invisível FE",
    Callback = function()
        local args = {
            [1] = {
                [1] = 102344834840946,
                [2] = 70400527171038,
                [3] = 0,
                [4] = 0,
                [5] = 0,
                [6] = 0
            }
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody"):InvokeServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Wear"):InvokeServer(111858803548721)
        local allaccessories = {}

        for zxcwefwfecas, xcaefwefas in ipairs({
            game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.BackAccessory,
            game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.FaceAccessory,
            game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.FrontAccessory,
            game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.NeckAccessory,
            game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.HatAccessory,
            game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.HairAccessory,
            game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.ShouldersAccessory,
            game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.WaistAccessory,
            game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.GraphicTShirt
        }) do
            for scacvdfbdb in string.gmatch(xcaefwefas, "%d+") do
                table.insert(allaccessories, tonumber(scacvdfbdb))
            end
        end

        wait()

        for asdwr,asderg in ipairs(allaccessories) do
            task.spawn(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Wear"):InvokeServer(asderg)
                print(asderg)
            end)
        end
    end
})

TrollTab:AddSection({ "Avatar RGB" })

local colors = { "Bright red", "Lime green", "Bright blue", "Bright yellow", "Bright cyan", "Hot pink", "Royal purple" }
local rgbEnabled = false

local function changeColor(color)
    local args = { color }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeBodyColor"):FireServer(unpack(args))
end

local function toggleRGBCharacter(enabled)
    rgbEnabled = enabled
    if rgbEnabled then
        while rgbEnabled do
            for _, color in ipairs(colors) do
                if not rgbEnabled then return end
                changeColor(color)
                wait(0.5)
            end
        end
    end
end

TrollTab:AddToggle({
    Name = "RGB Character",
    Description = "Deixa seu personagem RGB",
    Default = false,
    Callback = function(value)
        toggleRGBCharacter(value)
    end
})

TrollTab:AddSection({ "Cabelo RGB" })
local hairColors = {
    Color3.new(1, 1, 0), Color3.new(0, 0, 1), Color3.new(1, 0, 1), Color3.new(1, 1, 1),
    Color3.new(0, 1, 0), Color3.new(0.5, 0, 1), Color3.new(1, 0.647, 0), Color3.new(0, 1, 1)
}
local isActive = false

local function changeHairColor()
    local i = 1
    while isActive do
        if not isActive then break end
        local args = { [1] = "ChangeHairColor2", [2] = hairColors[i] }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Max1y"):FireServer(unpack(args))
        wait(0.1)
        i = i % #hairColors + 1
    end
end

TrollTab:AddToggle({
    Name = "Cabelo RGB",
    Description = "Deixa Seu Cabelo RGB",
    Default = false,
    Callback = function(value)
        isActive = value
        if isActive then
            changeHairColor()
        end
    end
})

TrollTab:AddSection({ "Anti Sit" })
TrollTab:AddToggle({
    Name = "Anti Sit",
    Description = "Não Deixa seu personagem Sentar",
    Default = false,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local connections = {}
        local runService = game:GetService("RunService")

        local function preventSitting(humanoid)
            if humanoid then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                local sitConnection = humanoid.StateChanged:Connect(function(_, newState)
                    if newState == Enum.HumanoidStateType.Seated then
                        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end)
                table.insert(connections, sitConnection)
            end
        end

        local function monitorCharacter()
            local function onCharacterAdded(character)
                local humanoid = character:WaitForChild("Humanoid")
                preventSitting(humanoid)
            end

            local characterAddedConnection = player.CharacterAdded:Connect(onCharacterAdded)
            table.insert(connections, characterAddedConnection)

            if player.Character then
                onCharacterAdded(player.Character)
            end
        end

        local function resetSitting()
            for _, connection in ipairs(connections) do
                connection:Disconnect()
            end
            connections = {}
            local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            end
        end

        if Value then
            monitorCharacter()
            local heartbeatConnection = runService.Heartbeat:Connect(function()
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                end
            end)
            table.insert(connections, heartbeatConnection)
        else
            resetSitting()
        end
    end
})

local Troll = Window:MakeTab({ Title = "Troll Players", Icon = "rbxassetid://131153193945220" })

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local cam = workspace.CurrentCamera

local selectedPlayerName = nil
local methodKill = nil
getgenv().Target = nil
local Character = LocalPlayer.Character
local Humanoid = Character and Character:WaitForChild("Humanoid")
local RootPart = Character and Character:WaitForChild("HumanoidRootPart")

-- Função para limpar o sofá (couch)
local function cleanupCouch()
    local char = LocalPlayer.Character
    if char then
        local couch = char:FindFirstChild("Chaos.Couch") or LocalPlayer.Backpack:FindFirstChild("Chaos.Couch")
        if couch then
            couch:Destroy()
        end
    end
    -- Limpar ferramentas via remoto
    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
end

-- Conectar evento CharacterAdded
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = newCharacter:WaitForChild("Humanoid")
    RootPart = newCharacter:WaitForChild("HumanoidRootPart")
    cleanupCouch()
    
    -- Conectar evento Died para o novo Humanoid
    Humanoid.Died:Connect(function()
        cleanupCouch()
    end)
end)

-- Conectar evento Died para o Humanoid inicial, se existir
if Humanoid then
    Humanoid.Died:Connect(function()
        cleanupCouch()
    end)
end

-- Função KillPlayerCouch
local function KillPlayerCouch()
    if not selectedPlayerName then
        warn("Erro: Nenhum jogador selecionado")
        return
    end
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then
        warn("Erro: Jogador alvo não encontrado ou sem personagem")
        return
    end

    local char = LocalPlayer.Character
    if not char then
        warn("Erro: Personagem do jogador local não encontrado")
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not root or not tRoot then
        warn("Erro: Componentes necessários não encontrados")
        return
    end

    local originalPos = root.Position 
    local sitPos = Vector3.new(145.51, -350.09, 21.58)

    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
    task.wait(0.2)

    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    task.wait(0.3)

    local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
    if tool then tool.Parent = char end
    task.wait(0.1)

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)

    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum.PlatformStand = false
    cam.CameraSubject = target.Character:FindFirstChild("Head") or tRoot or hum

    local align = Instance.new("BodyPosition")
    align.Name = "BringPosition"
    align.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    align.D = 10
    align.P = 30000
    align.Position = root.Position
    align.Parent = tRoot

    task.spawn(function()
        local angle = 0
        local startTime = tick()
        while tick() - startTime < 5 and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
            local tHum = target.Character:FindFirstChildOfClass("Humanoid")
            if not tHum or tHum.Sit then break end

            local hrp = target.Character.HumanoidRootPart
            local adjustedPos = hrp.Position + (hrp.Velocity / 1.5)

            angle += 50
            root.CFrame = CFrame.new(adjustedPos + Vector3.new(0, 2, 0)) * CFrame.Angles(math.rad(angle), 0, 0)
            align.Position = root.Position + Vector3.new(2, 0, 0)

            task.wait()
        end

        align:Destroy()
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        hum.PlatformStand = false
        cam.CameraSubject = hum

        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Velocity = Vector3.zero
                p.RotVelocity = Vector3.zero
            end
        end

        task.wait(0.1)
        root.CFrame = CFrame.new(sitPos)
        task.wait(0.3)

        local tool = char:FindFirstChild("Couch")
        if tool then tool.Parent = LocalPlayer.Backpack end

        task.wait(0.01)
        ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
        task.wait(0.2)
        root.CFrame = CFrame.new(originalPos)
    end)
end

-- Função BringPlayerLLL
local function BringPlayerLLL()
    if not selectedPlayerName then
        warn("Erro: Nenhum jogador selecionado")
        return
    end
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then
        warn("Erro: Jogador alvo não encontrado ou sem personagem")
        return
    end

    local char = LocalPlayer.Character
    if not char then
        warn("Erro: Personagem do jogador local não encontrado")
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not root or not tRoot then
        warn("Erro: Componentes necessários não encontrados")
        return
    end

    local originalPos = root.Position 
    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
    task.wait(0.2)

    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    task.wait(0.3)

    local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
    if tool then
        tool.Parent = char
    end
    task.wait(0.1)

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)

    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum.PlatformStand = false
    cam.CameraSubject = target.Character:FindFirstChild("Head") or tRoot or hum

    local align = Instance.new("BodyPosition")
    align.Name = "BringPosition"
    align.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    align.D = 10
    align.P = 30000
    align.Position = root.Position
    align.Parent = tRoot

    task.spawn(function()
        local angle = 0
        local startTime = tick()
        while tick() - startTime < 5 and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
            local tHum = target.Character:FindFirstChildOfClass("Humanoid")
            if not tHum or tHum.Sit then break end

            local hrp = target.Character.HumanoidRootPart
            local adjustedPos = hrp.Position + (hrp.Velocity / 1.5)

            angle += 50
            root.CFrame = CFrame.new(adjustedPos + Vector3.new(0, 2, 0)) * CFrame.Angles(math.rad(angle), 0, 0)
            align.Position = root.Position + Vector3.new(2, 0, 0)

            task.wait()
        end

        align:Destroy()
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        hum.PlatformStand = false
        cam.CameraSubject = hum

        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Velocity = Vector3.zero
                p.RotVelocity = Vector3.zero
            end
        end

        task.wait(0.1)
        root.Anchored = true
        root.CFrame = CFrame.new(originalPos)
        task.wait(0.001)
        root.Anchored = false

        task.wait(0.7)
        local tool = char:FindFirstChild("Couch")
        if tool then
            tool.Parent = LocalPlayer.Backpack
        end

        task.wait(0.001)
        ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    end)
end

-- Função BringWithCouch
local function BringWithCouch()
    local targetPlayer = Players:FindFirstChild(getgenv().Target)
    if not targetPlayer then
        warn("Erro: Nenhum jogador alvo selecionado")
        return
    end
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        warn("Erro: Jogador alvo sem personagem ou HumanoidRootPart")
        return
    end

    local args = { [1] = "ClearAllTools" }
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer(unpack(args))
    local args = { [1] = "PickingTools", [2] = "Couch" }
    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))

    local couch = LocalPlayer.Backpack:WaitForChild("Couch", 2)
    if not couch then
        warn("Erro: Sofá não encontrado no Backpack")
        return
    end

    couch.Name = "Chaos.Couch"
    local seat1 = couch:FindFirstChild("Seat1")
    local seat2 = couch:FindFirstChild("Seat2")
    local handle = couch:FindFirstChild("Handle")
    if seat1 and seat2 and handle then
        seat1.Disabled = true
        seat2.Disabled = true
        handle.Name = "Handle "
    else
        warn("Erro: Componentes do sofá não encontrados")
        return
    end
    couch.Parent = LocalPlayer.Character

    local tet = Instance.new("BodyVelocity", seat1)
    tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    tet.P = 1250
    tet.Velocity = Vector3.new(0, 0, 0)
    tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"

    repeat
        for m = 1, 35 do
            local pos = { x = 0, y = 0, z = 0 }
            local tRoot = targetPlayer.Character and targetPlayer.Character.HumanoidRootPart
            if not tRoot then break end
            pos.x = tRoot.Position.X + (tRoot.Velocity.X / 2)
            pos.y = tRoot.Position.Y + (tRoot.Velocity.Y / 2)
            pos.z = tRoot.Position.Z + (tRoot.Velocity.Z / 2)
            seat1.CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
            task.wait()
        end
        tet:Destroy()
        couch.Parent = LocalPlayer.Backpack
        task.wait()
        couch:FindFirstChild("Handle ").Name = "Handle"
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        task.wait()
        couch.Parent = LocalPlayer.Backpack
        couch.Handle.Name = "Handle "
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        tet = Instance.new("BodyVelocity", seat1)
        tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0, 0, 0)
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    until targetPlayer.Character and targetPlayer.Character.Humanoid and targetPlayer.Character.Humanoid.Sit == true
    task.wait()
    tet:Destroy()
    couch.Parent = LocalPlayer.Backpack
    task.wait()
    couch:FindFirstChild("Handle ").Name = "Handle"
    task.wait(0.3)
    couch.Parent = LocalPlayer.Character
    task.wait(0.3)
    couch.Grip = CFrame.new(Vector3.new(0, 0, 0))
    task.wait(0.3)
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer("ClearAllTools")
end

-- Função KillWithCouch
local function KillWithCouch()
    local targetPlayer = Players:FindFirstChild(getgenv().Target)
    if not targetPlayer then
        warn("Erro: Nenhum jogador alvo selecionado")
        return
    end
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        warn("Erro: Jogador alvo sem personagem ou HumanoidRootPart")
        return
    end

    local args = { [1] = "ClearAllTools" }
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer(unpack(args))
    local args = { [1] = "PickingTools", [2] = "Couch" }
    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))

    local couch = LocalPlayer.Backpack:WaitForChild("Couch", 2)
    if not couch then
        warn("Erro: Sofá não encontrado no Backpack")
        return
    end

    couch.Name = "Chaos.Couch"
    local seat1 = couch:FindFirstChild("Seat1")
    local seat2 = couch:FindFirstChild("Seat2")
    local handle = couch:FindFirstChild("Handle")
    if seat1 and seat2 and handle then
        seat1.Disabled = true
        seat2.Disabled = true
        handle.Name = "Handle "
    else
        warn("Erro: Componentes do sofá não encontrados")
        return
    end
    couch.Parent = LocalPlayer.Character

    local tet = Instance.new("BodyVelocity", seat1)
    tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    tet.P = 1250
    tet.Velocity = Vector3.new(0, 0, 0)
    tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"

    repeat
        for m = 1, 35 do
            local pos = { x = 0, y = 0, z = 0 }
            local tRoot = targetPlayer.Character and targetPlayer.Character.HumanoidRootPart
            if not tRoot then break end
            pos.x = tRoot.Position.X + (tRoot.Velocity.X / 2)
            pos.y = tRoot.Position.Y + (tRoot.Velocity.Y / 2)
            pos.z = tRoot.Position.Z + (tRoot.Velocity.Z / 2)
            seat1.CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
            task.wait()
        end
        tet:Destroy()
        couch.Parent = LocalPlayer.Backpack
        task.wait()
        couch:FindFirstChild("Handle ").Name = "Handle"
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        task.wait()
        couch.Parent = LocalPlayer.Backpack
        couch.Handle.Name = "Handle "
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        tet = Instance.new("BodyVelocity", seat1)
        tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0, 0, 0)
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    until targetPlayer.Character and targetPlayer.Character.Humanoid and targetPlayer.Character.Humanoid.Sit == true
    task.wait()
    couch.Parent = LocalPlayer.Backpack
    seat1.CFrame = CFrame.new(Vector3.new(9999, -450, 9999))
    seat2.CFrame = CFrame.new(Vector3.new(9999, -450, 9999))
    couch.Parent = LocalPlayer.Character
    task.wait(0.1)
    couch.Parent = LocalPlayer.Backpack
    task.wait(2)
    local bv = seat1:FindFirstChild("#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W")
    if bv then bv:Destroy() end
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer("ClearAllTools")
end

local PlayerSection = Troll:AddSection({ Name = "Troll Player" })

-- Função para obter lista de jogadores
local function getPlayerList()
    local players = Players:GetPlayers()
    local playerNames = {}
    for _, player in ipairs(players) do
        if player ~= LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    return playerNames
end

local killDropdown = Troll:AddDropdown({
    Name = "Selecionar Jogador",
    Options = getPlayerList(),
    Default = "",
    Callback = function(value)
        selectedPlayerName = value
        getgenv().Target = value
        print("Jogador selecionado: " .. tostring(value))
    end
})

Troll:AddButton({
    Name = "Atualizar Player List",
    Callback = function()
        local tablePlayers = Players:GetPlayers()
        local newPlayers = {}
        if killDropdown and #tablePlayers > 0 then
            for _, player in ipairs(tablePlayers) do
                if player.Name ~= LocalPlayer.Name then
                    table.insert(newPlayers, player.Name)
                end
            end
            killDropdown:Set(newPlayers)
            print("Lista de jogadores atualizada: ", table.concat(newPlayers, ", "))
            if selectedPlayerName and not Players:FindFirstChild(selectedPlayerName) then
                selectedPlayerName = nil
                getgenv().Target = nil
                killDropdown:SetValue("")
                print("Seleção resetada, jogador não está mais no servidor.")
            end
        else
            print("Erro: Dropdown não encontrado ou nenhum jogador disponível.")
        end
    end
})

Troll:AddButton({
    Name = "Teleportar até o Player",
    Callback = function()
        if not selectedPlayerName or not Players:FindFirstChild(selectedPlayerName) then
            print("Erro: Player não selecionado ou não existe")
            return
        end
        local character = LocalPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            warn("Erro: HumanoidRootPart do jogador local não encontrado")
            return
        end

        local targetPlayer = Players:FindFirstChild(selectedPlayerName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        else
            print("Erro: Player alvo não encontrado ou sem HumanoidRootPart")
        end
    end
})

Troll:AddToggle({
    Name = "Spectar Player",
    Default = false,
    Callback = function(value)
        local Camera = workspace.CurrentCamera

        local function UpdateCamera()
            if value then
                local targetPlayer = Players:FindFirstChild(selectedPlayerName)
                if targetPlayer and targetPlayer.Character then
                    local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        Camera.CameraSubject = humanoid
                    end
                end
            else
                if LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        Camera.CameraSubject = humanoid
                    end
                end
            end
        end

        if value then
            if not getgenv().CameraConnection then
                getgenv().CameraConnection = RunService.Heartbeat:Connect(UpdateCamera)
            end
        else
            if getgenv().CameraConnection then
                getgenv().CameraConnection:Disconnect()
                getgenv().CameraConnection = nil
            end
            UpdateCamera()
        end
    end
})

local MethodSection = Troll:AddSection({ Name = "Métodos" })

Troll:AddDropdown({
    Name = "Selecionar Método para Matar",
    Options = {"Bus", "Couch", "Couch Sem ir até o alvo [BETA]"},
    Default = "",
    Callback = function(value)
        methodKill = value
        print("Método selecionado: " .. tostring(value))
    end
})

Troll:AddButton({
    Name = "Matar Player",
    Callback = function()
        if not selectedPlayerName or not Players:FindFirstChild(selectedPlayerName) then
            print("Erro: Player não selecionado ou não existe")
            return
        end
        if methodKill == "Couch" then
            KillPlayerCouch()
        elseif methodKill == "Couch Sem ir até o alvo [BETA]" then
            KillWithCouch()
        else
            -- Método de ônibus
            local character = LocalPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then
                warn("Erro: HumanoidRootPart do jogador local não encontrado")
                return
            end

            local originalPosition = humanoidRootPart.CFrame

            local function GetBus()
                local vehicles = game.Workspace:FindFirstChild("Vehicles")
                if vehicles then
                    return vehicles:FindFirstChild(LocalPlayer.Name .. "Car")
                end
                return nil
            end

            local bus = GetBus()

            if not bus then
                humanoidRootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                -- Implementar lógica do ônibus aqui
                print("Método de ônibus selecionado - Implementação pendente")
            end
        end
    end
})

Troll:AddButton({
    Name = "Trazer Player",
    Callback = function()
        if not selectedPlayerName or not Players:FindFirstChild(selectedPlayerName) then
            print("Erro: Player não selecionado ou não existe")
            return
        end
        if methodKill == "Couch" then
            BringPlayerLLL()
        elseif methodKill == "Couch Sem ir até o alvo [BETA]" then
            BringWithCouch()
        else
            print("Selecione um método válido primeiro")
        end
    end
})

-- Sistema de Admin/Moderador
local AdminTab = Window:MakeTab({ Title = "Admin", Icon = "rbxassetid://13364900349" })

AdminTab:AddSection({ "Sistema Admin" })

local kickPlayers = {}
local banPlayers = {}

AdminTab:AddButton({
    Name = "Kick Todos os Players",
    Description = "Remove todos os outros jogadores do servidor",
    Callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                pcall(function()
                    player:Kick("Removido pelo Admin")
                end)
            end
        end
        print("Tentativa de kick em todos os players executada")
    end
})

AdminTab:AddButton({
    Name = "Crash Server",
    Description = "Tenta crashar o servidor",
    Callback = function()
        for i = 1, 1000 do
            spawn(function()
                while true do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(math.huge, math.huge, math.huge)
                    part.Parent = workspace
                    part.CFrame = CFrame.new(math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000))
                end
            end)
        end
        print("Crash server executado")
    end
})

-- Tab de Exploits Avançados
local ExploitTab = Window:MakeTab({ Title = "Exploits", Icon = "rbxassetid://13364900349" })

ExploitTab:AddSection({ "Exploits Avançados" })

ExploitTab:AddButton({
    Name = "Noclip",
    Description = "Ativa/Desativa noclip",
    Callback = function()
        local noclip = false
        local player = LocalPlayer
        local mouse = player:GetMouse()

        mouse.KeyDown:Connect(function(key)
            if key == "n" then
                noclip = not noclip
                game:GetService('RunService').Stepped:connect(function()
                    if noclip then
                        game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                    end
                end)
                print("Noclip:", noclip and "Ativado" or "Desativado")
            end
        end)
        print("Aperte N para ativar/desativar noclip")
    end
})

ExploitTab:AddButton({
    Name = "Speed Hack",
    Description = "Aumenta velocidade de movimento",
    Callback = function()
        local player = LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 100
            print("Velocidade aumentada para 100")
        end
    end
})

ExploitTab:AddButton({
    Name = "Jump Power",
    Description = "Aumenta poder de pulo",
    Callback = function()
        local player = LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = 200
            print("Poder de pulo aumentado para 200")
        end
    end
})

ExploitTab:AddButton({
    Name = "Infinite Health",
    Description = "Vida infinita (funciona em alguns jogos)",
    Callback = function()
        local player = LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            print("Vida infinita ativada")
        end
    end
})

-- Sistema de Fly Avançado
ExploitTab:AddSection({ "Sistema Fly Avançado" })

local flying = false
local flyConnection
local bodyVelocity
local bodyAngularVelocity

local function startFly()
    local player = LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character.HumanoidRootPart
    
    flying = true
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart
    
    bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
    bodyAngularVelocity.Parent = rootPart
    
    flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if flying and bodyVelocity then
            local camera = workspace.CurrentCamera
            local moveVector = humanoid.MoveDirection
            local lookVector = camera.CFrame.LookVector
            local rightVector = camera.CFrame.RightVector
            
            local velocity = Vector3.new(0, 0, 0)
            
            if moveVector.Magnitude > 0 then
                velocity = (lookVector * moveVector.Z + rightVector * moveVector.X) * 50
            end
            
            local UserInputService = game:GetService("UserInputService")
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                velocity = velocity + Vector3.new(0, 50, 0)
            elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                velocity = velocity - Vector3.new(0, 50, 0)
            end
            
            bodyVelocity.Velocity = velocity
        end
    end)
end

local function stopFly()
    flying = false
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    if bodyAngularVelocity then
        bodyAngularVelocity:Destroy()
        bodyAngularVelocity = nil
    end
    
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
end

ExploitTab:AddToggle({
    Name = "Fly Toggle",
    Description = "Ativa/Desativa voo - WASD para mover, Space/Shift para subir/descer",
    Default = false,
    Callback = function(state)
        if state then
            startFly()
        else
            stopFly()
        end
    end
})

-- Sistema de ESP
ExploitTab:AddSection({ "Sistema ESP" })

local espEnabled = false
local espConnections = {}

local function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Adornee = player.Character
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character
    highlight.Name = "PlayerESP"
end

local function removeESP(player)
    if player.Character then
        local esp = player.Character:FindFirstChild("PlayerESP")
        if esp then
            esp:Destroy()
        end
    end
end

local function toggleESP(enabled)
    espEnabled = enabled
    
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createESP(player)
            end
        end
        
        espConnections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
            if espEnabled then
                player.CharacterAdded:Connect(function()
                    wait(1)
                    if espEnabled then
                        createESP(player)
                    end
                end)
            end
        end)
    else
        for _, player in pairs(Players:GetPlayers()) do
            removeESP(player)
        end
        
        for _, connection in pairs(espConnections) do
            connection:Disconnect()
        end
        espConnections = {}
    end
end

ExploitTab:AddToggle({
    Name = "ESP Players",
    Description = "Mostra contorno vermelho nos jogadores",
    Default = false,
    Callback = function(state)
        toggleESP(state)
    end
})

-- Sistema de Teleport
ExploitTab:AddSection({ "Sistema Teleport" })

local teleportLocations = {
    ["Spawn"] = Vector3.new(0, 5, 0),
    ["Casa 1"] = Vector3.new(100, 5, 100),
    ["Casa 2"] = Vector3.new(-100, 5, -100),
    ["Escola"] = Vector3.new(200, 5, 0),
    ["Hospital"] = Vector3.new(-200, 5, 0),
    ["Shopping"] = Vector3.new(0, 5, 200),
}

for locationName, position in pairs(teleportLocations) do
    ExploitTab:AddButton({
        Name = "TP para " .. locationName,
        Description = "Teleporta para " .. locationName,
        Callback = function()
            local player = LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
                print("Teleportado para " .. locationName)
            end
        end
    })
end

-- Sistema de Aura/Auto Farm
local UtilityTab = Window:MakeTab({ Title = "Utilidades", Icon = "rbxassetid://13364900349" })

UtilityTab:AddSection({ "Auto Collect" })

local autoCollectEnabled = false
local collectConnection

UtilityTab:AddToggle({
    Name = "Auto Collect Money",
    Description = "Coleta dinheiro automaticamente",
    Default = false,
    Callback = function(state)
        autoCollectEnabled = state
        
        if state then
            collectConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if autoCollectEnabled then
                    for _, obj in pairs(workspace:GetChildren()) do
                        if obj.Name == "Money" or obj.Name == "Cash" or obj.Name == "Coin" then
                            local player = LocalPlayer
                            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                obj.CFrame = player.Character.HumanoidRootPart.CFrame
                            end
                        end
                    end
                end
            end)
        else
            if collectConnection then
                collectConnection:Disconnect()
                collectConnection = nil
            end
        end
    end
})

-- Sistema de Chat Spam
UtilityTab:AddSection({ "Chat System" })

local chatSpamEnabled = false
local chatSpamMessage = "Sigma Boy Hub!"

UtilityTab:AddTextBox({
    Name = "Mensagem para Spam",
    Default = "Sigma Boy Hub!",
    Callback = function(text)
        chatSpamMessage = text
    end
})

UtilityTab:AddToggle({
    Name = "Chat Spam",
    Description = "Envia mensagem repetidamente no chat",
    Default = false,
    Callback = function(state)
        chatSpamEnabled = state
        
        if state then
            spawn(function()
                while chatSpamEnabled do
                    game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(chatSpamMessage, "All")
                    wait(2)
                end
            end)
        end
    end
})

-- Tab de Audio
local AudioTab = Window:MakeTab({ Title = "Audio All", Icon = "rbxassetid://13364900349" })

-- Create a section
AudioTab:AddSection({ "Audio Todos os Players" })

-- Lista de áudios
local audios = {
    {Name = "Yamete Kudasai", ID = 108494476595033},
    {Name = "Gritinho", ID = 5710016194},
    {Name = "Jumpscare Horroroso", ID = 85435253347146},
    {Name = "Áudio Alto", ID = 6855150757},
    {Name = "Ruído", ID = 120034877160791},
    {Name = "Jumpscare 2", ID = 110637995610528},
    {Name = "Risada Da Bruxa Minecraft", ID = 116214940486087},
    {Name = "The Boiled One", ID = 137177653817621},
    {Name = "Deitei Um Ave Maria Doido", ID = 128669424001766},
    {Name = "Mandrake Detected", ID = 9068077052},
    {Name = "Aaaaaaaaa", ID = 80156405968805},
    {Name = "AAAHHHH", ID = 9084006093},
    {Name = "amongus", ID = 6651571134},
    {Name = "Sus", ID = 6701126635},
    {Name = "Gritao AAAAAAAAA", ID = 5853668794},
    {Name = "UHHHHH COFFCOFF", ID = 7056720271},
    {Name = "SUS", ID = 7153419575},
    {Name = "Sonic.exe", ID = 2496367477},
    {Name = "Tubers93 1", ID = 270145703},
    {Name = "Tubers93 2", ID = 18131809532},
    {Name = "John's Laugh", ID = 130759239},
    {Name = "Nao sei KKKK", ID = 6549021381},
    {Name = "Grito", ID = 80156405968805},
    {Name = "Sus Audio", ID = 7705506391},
    {Name = "AAAH", ID = 7772283448},
    {Name = "Gay, gay", ID = 18786647417},
    {Name = "Bat Hit", ID = 7129073354},
    {Name = "Nuclear Siren", ID = 675587093},
    {Name = "Sem ideia de nome KK", ID = 7520729342},
    {Name = "Grito 2", ID = 91412024101709},
    {Name = "Estora tímpano", ID = 268116333},
    {Name = "Gemidão", ID = 106835463235574},
    {Name = "Toma Jack", ID = 132603645477541},
    {Name = "Pede ifood pede", ID = 133843750864059},
    {Name = "I Ghost The down", ID = 84663543883498},
    {Name = "Compre OnLine Na shoope", ID = 8747441609},
    {Name = "Uh Que Nojo", ID = 103440368630269},
    {Name = "Sai dai Lava Prato", ID = 101232400175829},
    {Name = "Seloko num compensa", ID = 78442476709262},
}

local selectedAudioID

-- Adicionar uma textbox para inserir o ID do áudio
AudioTab:AddTextBox({
    Name = "Insira o ID do Áudio ou Musica",
    Description = "Digite o ID do áudio",
    PlaceholderText = "ID do áudio",
    Callback = function(value)
        selectedAudioID = tonumber(value)
    end
})

-- Adicionar uma dropdown para selecionar o áudio
local audioNames = {}
for _, audio in ipairs(audios) do
    table.insert(audioNames, audio.Name)
end

AudioTab:AddDropdown({
    Name = "Selecione o Áudio",
    Description = "Escolha um áudio da lista",
    Options = audioNames,
    Default = audioNames[1],
    Callback = function(value)
        for _, audio in ipairs(audios) do
            if audio.Name == value then
                selectedAudioID = audio.ID
                break
            end
        end
    end
})

-- Controle do loop
local audioLoop = false

-- Nova seção para loop de áudio
AudioTab:AddSection({ "Loop de Audio" })

-- Função para tocar o áudio repetidamente
local function playLoopedAudio()
    while audioLoop do
        if selectedAudioID then
            local args = {
                [1] = game:GetService("Workspace"),
                [2] = selectedAudioID,
                [3] = 1,
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))

            -- Criar e tocar o áudio
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://" .. selectedAudioID
            sound.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            sound:Play()
        else
            warn("Nenhum áudio selecionado!")
        end

        task.wait(0.5) -- Pequeno delay para evitar sobrecarga
    end
end

-- Toggle para loop de áudio
AudioTab:AddToggle({
    Name = "Loop Tocar Áudio",
    Description = "Ativa o loop do áudio",
    Default = false,
    Callback = function(value)
        audioLoop = value
        if audioLoop then
            task.spawn(playLoopedAudio) -- Inicia o loop em uma nova thread
        end
    end
})

-- Adicionar um parágrafo como label
AudioTab:AddParagraph({ "Info", "Loop de tocar Áudio (Todos players do Server ouvem)" })

-- Função para tocar o áudio normal
local function playAudio()
    if selectedAudioID then
        local args = {
            [1] = game:GetService("Workspace"),
            [2] = selectedAudioID,
            [3] = 1,
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))

        -- Criar e tocar o áudio
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. selectedAudioID
        sound.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        sound:Play()
    else
        warn("Nenhum áudio selecionado!")
    end
end

-- Nova seção para tocar áudio
AudioTab:AddSection({ "Tocar Áudio" })

-- Botão para tocar o áudio
AudioTab:AddButton({
    Name = "Tocar Áudio",
    Callback = function()
        playAudio()
    end
})

local audioIDFixed = 6314880174 -- ID fixo do áudio

local function Audio_All_ClientSide(ID)
    local function CheckFolderAudioAll()
        local FolderAudio = workspace:FindFirstChild("Audio all client")
        if not FolderAudio then
            FolderAudio = Instance.new("Folder")
            FolderAudio.Name = "Audio all client"
            FolderAudio.Parent = workspace
        end
        return FolderAudio
    end

    local function CreateSound(ID)
        if type(ID) ~= "number" then
            print("Insira um número válido!")
            return nil
        end

        local Folder_Audio = CheckFolderAudioAll()
        if Folder_Audio then
            local Sound = Instance.new("Sound")
            Sound.SoundId = "rbxassetid://" .. ID
            Sound.Volume = 1
            Sound.Looped = false
            Sound.Parent = Folder_Audio
            Sound:Play()
            task.wait(1) -- Tempo de espera antes de remover o som
            Sound:Destroy()
        end
    end

    CreateSound(ID)
end

local function Audio_All_ServerSide(ID)
    if type(ID) ~= "number" then
        print("Insira um número válido!")
        return nil
    end

    local GunSoundEvent = ReplicatedStorage:FindFirstChild("1Gu1nSound1s", true)
    if GunSoundEvent then
        GunSoundEvent:FireServer(workspace, ID, 1)
    end
end

-- Toggle para "Estorar ouvido de geral"
AudioTab:AddToggle({
    Name = "Estorar ouvido de geral KK",
    Description = "Toca áudio repetidamente para todos",
    Default = false,
    Callback = function(value)
        getgenv().Audio_All_loop_fast = value

        while getgenv().Audio_All_loop_fast do
            Audio_All_ServerSide(audioIDFixed)
            task.spawn(function()
                Audio_All_ClientSide(audioIDFixed)
            end)
            task.wait(0.03) -- Delay extremamente rápido (0.03 segundos)
        end
    end
})

AudioTab:AddParagraph({ "Info", "Todos do server ouvem o áudio" })

-- Tab de Audio
local AudioTab = Window:MakeTab({ Title = "Audio All", Icon = "rbxassetid://13364900349" })

-- Create a section
AudioTab:AddSection({ "Audio Todos os Players" })

-- Lista de áudios
local audios = {
    {Name = "Yamete Kudasai", ID = 108494476595033},
    {Name = "Gritinho", ID = 5710016194},
    {Name = "Jumpscare Horroroso", ID = 85435253347146},
    {Name = "Áudio Alto", ID = 6855150757},
    {Name = "Ruído", ID = 120034877160791},
    {Name = "Jumpscare 2", ID = 110637995610528},
    {Name = "Risada Da Bruxa Minecraft", ID = 116214940486087},
    {Name = "The Boiled One", ID = 137177653817621},
    {Name = "Deitei Um Ave Maria Doido", ID = 128669424001766},
    {Name = "Mandrake Detected", ID = 9068077052},
    {Name = "Aaaaaaaaa", ID = 80156405968805},
    {Name = "AAAHHHH", ID = 9084006093},
    {Name = "amongus", ID = 6651571134},
    {Name = "Sus", ID = 6701126635},
    {Name = "Gritao AAAAAAAAA", ID = 5853668794},
    {Name = "UHHHHH COFFCOFF", ID = 7056720271},
    {Name = "SUS", ID = 7153419575},
    {Name = "Sonic.exe", ID = 2496367477},
    {Name = "Tubers93 1", ID = 270145703},
    {Name = "Tubers93 2", ID = 18131809532},
    {Name = "John's Laugh", ID = 130759239},
    {Name = "Nao sei KKKK", ID = 6549021381},
    {Name = "Grito", ID = 80156405968805},
    {Name = "Sus Audio", ID = 7705506391},
    {Name = "AAAH", ID = 7772283448},
    {Name = "Gay, gay", ID = 18786647417},
    {Name = "Bat Hit", ID = 7129073354},
    {Name = "Nuclear Siren", ID = 675587093},
    {Name = "Sem ideia de nome KK", ID = 7520729342},
    {Name = "Grito 2", ID = 91412024101709},
    {Name = "Estora tímpano", ID = 268116333},
    {Name = "Gemidão", ID = 106835463235574},
    {Name = "Toma Jack", ID = 132603645477541},
    {Name = "Pede ifood pede", ID = 133843750864059},
    {Name = "I Ghost The down", ID = 84663543883498},
    {Name = "Compre OnLine Na shoope", ID = 8747441609},
    {Name = "Uh Que Nojo", ID = 103440368630269},
    {Name = "Sai dai Lava Prato", ID = 101232400175829},
    {Name = "Seloko num compensa", ID = 78247306746902},
}

local selectedAudioID

-- Adicionar uma textbox para inserir o ID do áudio
AudioTab:AddTextBox({
    Name = "Insira o ID do Áudio ou Musica",
    Description = "Digite o ID do áudio",
    PlaceholderText = "ID do áudio",
    Callback = function(value)
        selectedAudioID = tonumber(value)
        if selectedAudioID then
            print("Audio ID selecionado: " .. selectedAudioID)
        end
    end
})

-- Adicionar uma dropdown para selecionar o áudio
local audioNames = {}
for _, audio in ipairs(audios) do
    table.insert(audioNames, audio.Name)
end

AudioTab:AddDropdown({
    Name = "Selecione o Áudio",
    Description = "Escolha um áudio da lista",
    Options = audioNames,
    Default = audioNames[1],
    Callback = function(value)
        for _, audio in ipairs(audios) do
            if audio.Name == value then
                selectedAudioID = audio.ID
                print("Audio selecionado: " .. audio.Name .. " (ID: " .. audio.ID .. ")")
                break
            end
        end
    end
})

-- Controle do loop
local audioLoop = false

-- Nova seção para loop de áudio
AudioTab:AddSection({ "Loop de Audio" })

-- Função para tocar o áudio repetidamente
local function playLoopedAudio()
    spawn(function()
        while audioLoop do
            if selectedAudioID then
                -- Server side
                pcall(function()
                    local args = {
                        [1] = game:GetService("Workspace"),
                        [2] = selectedAudioID,
                        [3] = 1,
                    }
                    ReplicatedStorage.RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))
                end)

                -- Client side backup
                pcall(function()
                    local sound = Instance.new("Sound")
                    sound.SoundId = "rbxassetid://" .. selectedAudioID
                    sound.Volume = 0.5
                    sound.Parent = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if sound.Parent then
                        sound:Play()
                        game:GetService("Debris"):AddItem(sound, 10)
                    end
                end)
            else
                warn("Nenhum áudio selecionado!")
            end

            task.wait(0.5) -- Pequeno delay para evitar sobrecarga
        end
    end)
end

-- Toggle para loop de áudio
AudioTab:AddToggle({
    Name = "Loop Tocar Áudio",
    Description = "Ativa o loop do áudio selecionado",
    Default = false,
    Callback = function(value)
        audioLoop = value
        if audioLoop then
            print("Loop de audio iniciado")
            playLoopedAudio()
        else
            print("Loop de audio parado")
        end
    end
})

-- Adicionar um parágrafo como label
AudioTab:AddParagraph({ "Info", "Loop de tocar Áudio (Todos players do Server ouvem)" })

-- Função para tocar o áudio normal
local function playAudio()
    if selectedAudioID then
        -- Server side
        pcall(function()
            local args = {
                [1] = game:GetService("Workspace"),
                [2] = selectedAudioID,
                [3] = 1,
            }
            ReplicatedStorage.RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))
            print("Audio tocado via servidor: " .. selectedAudioID)
        end)

        -- Client side backup
        pcall(function()
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://" .. selectedAudioID
            sound.Volume = 1
            sound.Parent = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if sound.Parent then
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 30)
                print("Audio tocado localmente: " .. selectedAudioID)
            end
        end)
    else
        warn("Nenhum áudio selecionado! Use a caixa de texto ou dropdown.")
    end
end

-- Nova seção para tocar áudio
AudioTab:AddSection({ "Tocar Áudio" })

-- Botão para tocar o áudio
AudioTab:AddButton({
    Name = "Tocar Áudio Uma Vez",
    Description = "Toca o áudio selecionado uma vez",
    Callback = function()
        playAudio()
    end
})

-- Sistemas avançados de áudio
local audioIDFixed = 6314880174 -- ID fixo do áudio para spam

local function Audio_All_ClientSide(ID)
    local function CheckFolderAudioAll()
        local FolderAudio = workspace:FindFirstChild("Audio all client")
        if not FolderAudio then
            FolderAudio = Instance.new("Folder")
            FolderAudio.Name = "Audio all client"
            FolderAudio.Parent = workspace
        end
        return FolderAudio
    end

    local function CreateSound(ID)
        if type(ID) ~= "number" then
            warn("ID deve ser um número!")
            return nil
        end

        local Folder_Audio = CheckFolderAudioAll()
        if Folder_Audio then
            local Sound = Instance.new("Sound")
            Sound.SoundId = "rbxassetid://" .. ID
            Sound.Volume = 1
            Sound.Looped = false
            Sound.Parent = Folder_Audio
            Sound:Play()
            
            -- Remove o som após terminar
            spawn(function()
                task.wait(1)
                if Sound and Sound.Parent then
                    Sound:Destroy()
                end
            end)
        end
    end

    CreateSound(ID)
end

local function Audio_All_ServerSide(ID)
    if type(ID) ~= "number" then
        warn("ID deve ser um número!")
        return nil
    end

    pcall(function()
        local GunSoundEvent = ReplicatedStorage:FindFirstChild("1Gu1nSound1s", true)
        if GunSoundEvent then
            GunSoundEvent:FireServer(workspace, ID, 1)
        else
            warn("Evento de som não encontrado!")
        end
    end)
end

AudioTab:AddSection({ "Spam de Audio" })

-- Toggle para "Estorar ouvido de geral"
AudioTab:AddToggle({
    Name = "Estorar ouvido de geral",
    Description = "Spam de áudio extremo (0.03s delay)",
    Default = false,
    Callback = function(value)
        getgenv().Audio_All_loop_fast = value

        if value then
            print("SPAM DE AUDIO INICIADO - CUIDADO COM O VOLUME!")
            spawn(function()
                while getgenv().Audio_All_loop_fast do
                    -- Server side
                    Audio_All_ServerSide(audioIDFixed)
                    
                    -- Client side em thread separada
                    spawn(function()
                        Audio_All_ClientSide(audioIDFixed)
                    end)
                    
                    task.wait(0.03) -- Delay extremamente rápido
                end
                print("Spam de audio parado")
            end)
        end
    end
})

-- Botão para parar tudo
AudioTab:AddButton({
    Name = "PARAR TODOS OS ÁUDIOS",
    Description = "Para todos os loops e áudios",
    Callback = function()
        -- Para todos os loops
        audioLoop = false
        getgenv().Audio_All_loop_fast = false
        
        -- Remove pasta de áudios
        local audioFolder = workspace:FindFirstChild("Audio all client")
        if audioFolder then
            audioFolder:Destroy()
        end
        
        -- Para áudios locais
        if game.Players.LocalPlayer.Character then
            for _, obj in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if obj:IsA("Sound") then
                    obj:Stop()
                    obj:Destroy()
                end
            end
        end
        
        print("Todos os áudios foram parados!")
    end
})

AudioTab:AddParagraph({ "Aviso", "Use com responsabilidade! O spam pode causar lag no servidor." })

-- Tab de Shutdown e Lag
local ShutdownTab = Window:MakeTab({ Title = "Shutdown & Lag", Icon = "rbxassetid://13364900349" })

-- Shutdown Custom Section
ShutdownTab:AddSection({ "Shutdown Personalizado" })

-- Shutdown Server Button
ShutdownTab:AddButton({
    Name = "Shutdown Servidor",
    Description = "Usa 495 FireHoses para forçar shutdown",
    Callback = function()
        print("Iniciando shutdown do servidor...")
        for m = 1, 495 do
            local args = {
                [1] = "PickingTools",
                [2] = "FireHose"
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            local args = {
                [1] = "FireHose",
                [2] = "DestroyFireHose"
            }
            game:GetService("Players").LocalPlayer.Backpack.FireHose.ToolSound:FireServer(unpack(args))
        end
        local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -475, 999999999.414)
        local rootpart = game.Players.LocalPlayer.Character.HumanoidRootPart
        repeat wait() until rootpart.Parent == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script de Dupe",
            Text = "Shutdown Concluído, Agora Vai Desligar",
            Button1 = "Ok",
            Duration = 5
        })
        wait()
        for _, ergeg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ergeg.Name == "FireHose" then
                ergeg.Parent = game.Players.LocalPlayer.Character
            end
        end
        wait(0.2)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script de Dupe",
            Text = "Iniciando duplicação, seja paciente",
            Button1 = "Ok",
            Duration = 5
        })
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9999, -475, 9999)
    end
})

-- Shutdown Server (Internet Error) Button
ShutdownTab:AddButton({
    Name = "Shutdown Servidor (Erro de Internet)",
    Description = "Usa 535 FireHoses - simula erro de internet",
    Callback = function()
        print("Iniciando shutdown com erro de internet...")
        for m = 1, 535 do
            local args = {
                [1] = "PickingTools",
                [2] = "FireHose"
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            local args = {
                [1] = "FireHose",
                [2] = "DestroyFireHose"
            }
            game:GetService("Players").LocalPlayer.Backpack.FireHose.ToolSound:FireServer(unpack(args))
        end
        local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -475, 999999999.414)
        local rootpart = game.Players.LocalPlayer.Character.HumanoidRootPart
        repeat wait() until rootpart.Parent == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script de Dupe",
            Text = "Shutdown Concluído, Agora Vai Desligar",
            Button1 = "Ok",
            Duration = 5
        })
        wait()
        for _, ergeg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ergeg.Name == "FireHose" then
                ergeg.Parent = game.Players.LocalPlayer.Character
            end
        end
        wait(0.2)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script de Dupe",
            Text = "Iniciando duplicação, seja paciente",
            Button1 = "Ok",
            Duration = 5
        })
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9999, -475, 9999)
    end
})

-- Shutdown Server (Timeout Error) Button
ShutdownTab:AddButton({
    Name = "Shutdown Servidor (Erro de Conexão)",
    Description = "Usa 635 FireHoses - simula timeout",
    Callback = function()
        print("Iniciando shutdown com erro de conexão...")
        for m = 1, 635 do
            local args = {
                [1] = "PickingTools",
                [2] = "FireHose"
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            local args = {
                [1] = "FireHose",
                [2] = "DestroyFireHose"
            }
            game:GetService("Players").LocalPlayer.Backpack.FireHose.ToolSound:FireServer(unpack(args))
        end
        local oldcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -475, 999999999.414)
        local rootpart = game.Players.LocalPlayer.Character.HumanoidRootPart
        repeat wait() until rootpart.Parent == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script de Dupe",
            Text = "Shutdown Concluído, Agora Vai Desligar",
            Button1 = "Ok",
            Duration = 5
        })
        wait()
        for _, ergeg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ergeg.Name == "FireHose" then
                ergeg.Parent = game.Players.LocalPlayer.Character
            end
        end
        wait(0.2)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Script de Dupe",
            Text = "Iniciando duplicação, seja paciente",
            Button1 = "Ok",
            Duration = 5
        })
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9999, -475, 9999)
    end
})

-- Lag Laptop Section
ShutdownTab:AddSection({ "Lag com Laptop" })

-- Toggle States
local toggles = { 
    LagLaptop = false,
    LagPhone = false,
    LagBomb = false
}

-- Function to Simulate Normal Click
local function clickNormally(object)
    local clickDetector = object:FindFirstChildWhichIsA("ClickDetector")
    if clickDetector then
        fireclickdetector(clickDetector)
    end
end

-- Function to Lag Game with Laptop
local function lagarJogoLaptop(laptopPath, maxTeleports)
    if laptopPath then
        local teleportCount = 0
        while teleportCount < maxTeleports and toggles.LagLaptop do
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = laptopPath.CFrame
                clickNormally(laptopPath)
                teleportCount = teleportCount + 1
            end
            wait(0.0001)
        end
    else
        warn("Laptop não encontrado.")
    end
end

-- Lag Laptop Toggle
ShutdownTab:AddToggle({
    Name = "Lag com Laptop",
    Description = "Causa lag usando laptop do jogo",
    Default = false,
    Callback = function(state)
        toggles.LagLaptop = state
        if state then
            local laptopPath = workspace:FindFirstChild("WorkspaceCom")
            laptopPath = laptopPath and laptopPath:FindFirstChild("001_GiveTools")
            laptopPath = laptopPath and laptopPath:FindFirstChild("Laptop")
            
            if laptopPath then
                print("Iniciando lag com laptop...")
                spawn(function()
                    lagarJogoLaptop(laptopPath, 999999999)
                end)
            else
                warn("Laptop não encontrado no caminho especificado.")
                toggles.LagLaptop = false
            end
        else
            print("Lag com Laptop desativado.")
        end
    end
})

-- Lag Laptop Paragraph
ShutdownTab:AddParagraph({ "Informação", "O efeito de lag começa após 35 segundos" })

-- Lag Phone Section
ShutdownTab:AddSection({ "Lag com Telefone" })

-- Function to Lag Game with Phone
local function lagarJogoPhone(phonePath, maxTeleports)
    if phonePath then
        local teleportCount = 0
        while teleportCount < maxTeleports and toggles.LagPhone do
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = phonePath.CFrame
                clickNormally(phonePath)
                teleportCount = teleportCount + 1
            end
            wait(0.01)
        end
    else
        warn("Telefone não encontrado.")
    end
end

-- Lag Phone Toggle
ShutdownTab:AddToggle({
    Name = "Lag com Telefone",
    Description = "Causa lag usando telefone do jogo",
    Default = false,
    Callback = function(state)
        toggles.LagPhone = state
        if state then
            local phonePath = workspace:FindFirstChild("WorkspaceCom")
            phonePath = phonePath and phonePath:FindFirstChild("001_CommercialStores")
            phonePath = phonePath and phonePath:FindFirstChild("CommercialStorage1")
            phonePath = phonePath and phonePath:FindFirstChild("Store")
            phonePath = phonePath and phonePath:FindFirstChild("Tools")
            phonePath = phonePath and phonePath:FindFirstChild("Iphone")
            
            if phonePath then
                print("Iniciando lag com telefone...")
                spawn(function()
                    lagarJogoPhone(phonePath, 999999)
                end)
            else
                warn("Telefone não encontrado no caminho especificado.")
                toggles.LagPhone = false
            end
        else
            print("Lag com Telefone desativado.")
        end
    end
})

-- Lag Phone Paragraph
ShutdownTab:AddParagraph({ "Informação", "O script começa a causar lag após 35 segundos" })

-- Lag Bomb Section
ShutdownTab:AddSection({ "Lag com Bomba" })

ShutdownTab:AddToggle({
    Name = "Lag com Bomba",
    Description = "Causa lag extremo usando bombas",
    Default = false,
    Callback = function(Value)
        toggles.LagBomb = Value
        
        if Value then
            local Player = game.Players.LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local RootPart = Character:WaitForChild("HumanoidRootPart")
            local WorkspaceService = game:GetService("Workspace")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            
            local bombPath = WorkspaceService:FindFirstChild("WorkspaceCom")
            bombPath = bombPath and bombPath:FindFirstChild("001_CriminalWeapons")
            bombPath = bombPath and bombPath:FindFirstChild("GiveTools")
            local Bomb = bombPath and bombPath:FindFirstChild("Bomb")

            if Bomb then
                print("Iniciando lag com bomba...")
                
                task.spawn(function()
                    while toggles.LagBomb do
                        if Bomb and RootPart then
                            RootPart.CFrame = Bomb.CFrame
                            fireclickdetector(Bomb.ClickDetector)
                            task.wait(0.00001)
                        else
                            task.wait(0.0001) 
                        end
                    end
                end)

                task.spawn(function()
                    while toggles.LagBomb do
                        if Bomb and RootPart then
                            local VirtualInputManager = game:GetService("VirtualInputManager")
                            VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0) 
                            task.wait(1.5)
                            VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0) 

                            local args = {
                                [1] = "Bomb" .. Player.Name
                            }
                            ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Blo1wBomb1sServe1r"):FireServer(unpack(args))
                        end
                        task.wait(1.5)
                    end
                end)
            else
                warn("Bomba não encontrada no caminho especificado.")
                toggles.LagBomb = false
            end
        else
            print("Lag com Bomba desativado.")
        end
    end
})

ShutdownTab:AddParagraph({ "Informação", "O script começa a causar lag após 35 segundos" })

ShutdownTab:AddParagraph({ "Aviso", "Use essas funções com extrema cautela! Podem causar problemas sérios no servidor." })

print("Sigma Boy Hub carregado com sucesso!")
print("Discord: discord.gg/sigmahub")
print("Feito por: maverickk7_")
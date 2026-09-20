--==================================================
-- PLAY HUB 0.1
-- SEU PRÓPRIO JOGO / TEST PLACE
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIGURAÇÕES
--==================================================

local SHOW_TUTORIAL = true

local SPEED = 50
local MIN_SPEED = 16
local MAX_SPEED = 100

local CICLO_DELAY = 7
local DISTANCIA_CHEGADA = 4

--==================================================
-- ESTADOS
--==================================================

local Moving = false
local StopRequested = false
local Noclip = false

local AutoFarm = false
local AutoFarmThread = nil

local SavedCollision = {}

--==================================================
-- MUNDO 1
--==================================================

local Mundo1 = {
    Vector3.new(-44.87, 6.49, 32.31),
    Vector3.new(-50.68, 6.97, -36.22),
    Vector3.new(-65.07, 11.91, -5.57),
    Vector3.new(-66.82, 12.04, -41.11),
    Vector3.new(-4.45, -1.19, 3353.58)
}

--==================================================
-- MUNDO 2
--==================================================

local Mundo2 = {
    Vector3.new(-48.65, 6.49, 16.59),
    Vector3.new(-43.92, 6.97, -32.52),
    Vector3.new(-70.12, 11.91, -6.84),
    Vector3.new(-64.67, 12.04, -37.29),
    Vector3.new(-8.66, 46.64, 2082.59)
}

--==================================================
-- AUTO FARM
--==================================================

local AutoFarmPoints = {
    Vector3.new(1.57, 5.56, 26.65),
    Vector3.new(2.43, 46.64, 2082.56),
    Vector3.new(-16.82, 44.42, 2084.21)
}

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "PlayHub01"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

--==================================================
-- FUNÇÃO ROUND
--==================================================

local function Round(Object, Radius)

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Radius)
    Corner.Parent = Object

end

--==================================================
-- TUTORIAL
--==================================================

local Tutorial = Instance.new("Frame")
Tutorial.Size = UDim2.new(0, 320, 0, 270)
Tutorial.Position = UDim2.new(0.5, -160, 0.5, -135)
Tutorial.BackgroundColor3 = Color3.fromRGB(25,25,30)
Tutorial.BorderSizePixel = 0
Tutorial.Parent = Gui

Round(Tutorial, 14)

local TutorialTitle = Instance.new("TextLabel")
TutorialTitle.Size = UDim2.new(1, -20, 0, 45)
TutorialTitle.Position = UDim2.new(0, 10, 0, 10)
TutorialTitle.BackgroundTransparency = 1
TutorialTitle.Text = "PLAY HUB 0.1"
TutorialTitle.TextColor3 = Color3.fromRGB(255,255,255)
TutorialTitle.TextSize = 24
TutorialTitle.Font = Enum.Font.GothamBold
TutorialTitle.Parent = Tutorial

local TutorialText = Instance.new("TextLabel")
TutorialText.Size = UDim2.new(1, -30, 0, 130)
TutorialText.Position = UDim2.new(0, 15, 0, 60)
TutorialText.BackgroundTransparency = 1
TutorialText.Text =
    "COMO USAR\n\n" ..
    "• Escolha um mundo\n" ..
    "• Use os destinos\n" ..
    "• AUTO FARM faz o ciclo automaticamente\n" ..
    "• Ponto 1 → 2 → 3\n" ..
    "• Espera 7 segundos e repete"

TutorialText.TextColor3 = Color3.fromRGB(220,220,220)
TutorialText.TextSize = 14
TutorialText.Font = Enum.Font.Gotham
TutorialText.TextWrapped = true
TutorialText.Parent = Tutorial

local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.new(1, -40, 0, 45)
StartButton.Position = UDim2.new(0, 20, 1, -60)
StartButton.BackgroundColor3 = Color3.fromRGB(45,150,75)
StartButton.Text = "COMEÇAR"
StartButton.TextColor3 = Color3.fromRGB(255,255,255)
StartButton.TextSize = 18
StartButton.Font = Enum.Font.GothamBold
StartButton.Parent = Tutorial

Round(StartButton, 10)

--==================================================
-- PAINEL
--==================================================

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 250, 0, 500)
Main.Position = UDim2.new(0.5, -125, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(25,25,30)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui

Round(Main, 14)

--==================================================
-- TÍTULO
--==================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -125, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "PLAY HUB 0.1"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 19
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

--==================================================
-- FECHAR
--==================================================

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 35, 0, 30)
Close.Position = UDim2.new(1, -40, 0, 5)
Close.BackgroundColor3 = Color3.fromRGB(150,45,45)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.TextSize = 16
Close.Font = Enum.Font.GothamBold
Close.Parent = Main

Round(Close, 8)

--==================================================
-- MINIMIZAR
--==================================================

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0, 35, 0, 30)
Minimize.Position = UDim2.new(1, -80, 0, 5)
Minimize.BackgroundColor3 = Color3.fromRGB(65,65,75)
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255,255,255)
Minimize.TextSize = 20
Minimize.Font = Enum.Font.GothamBold
Minimize.Parent = Main

Round(Minimize, 8)

--==================================================
-- ABAS
--==================================================

local Mundo1Button = Instance.new("TextButton")
Mundo1Button.Size = UDim2.new(0, 115, 0, 35)
Mundo1Button.Position = UDim2.new(0, 8, 0, 50)
Mundo1Button.BackgroundColor3 = Color3.fromRGB(55,100,170)
Mundo1Button.Text = "MUNDO 1"
Mundo1Button.TextColor3 = Color3.fromRGB(255,255,255)
Mundo1Button.TextSize = 13
Mundo1Button.Font = Enum.Font.GothamBold
Mundo1Button.Parent = Main

Round(Mundo1Button, 8)

local Mundo2Button = Instance.new("TextButton")
Mundo2Button.Size = UDim2.new(0, 115, 0, 35)
Mundo2Button.Position = UDim2.new(0, 127, 0, 50)
Mundo2Button.BackgroundColor3 = Color3.fromRGB(55,55,65)
Mundo2Button.Text = "MUNDO 2"
Mundo2Button.TextColor3 = Color3.fromRGB(255,255,255)
Mundo2Button.TextSize = 13
Mundo2Button.Font = Enum.Font.GothamBold
Mundo2Button.Parent = Main

Round(Mundo2Button, 8)

--==================================================
-- SCROLL
--==================================================

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -16, 0, 390)
Scroll.Position = UDim2.new(0, 8, 0, 90)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.new(0,0,0,470)
Scroll.Parent = Main

--==================================================
-- STATUS
--==================================================

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -16, 0, 25)
Status.Position = UDim2.new(0, 8, 1, -28)
Status.BackgroundTransparency = 1
Status.Text = "PRONTO"
Status.TextColor3 = Color3.fromRGB(180,180,180)
Status.TextSize = 12
Status.Font = Enum.Font.Gotham
Status.Parent = Main

--==================================================
-- CRIAR BOTÃO
--==================================================

local function CreateButton(Text, Y)

    local Button = Instance.new("TextButton")

    Button.Size = UDim2.new(1, -5, 0, 38)
    Button.Position = UDim2.new(0, 2, 0, Y)

    Button.BackgroundColor3 =
        Color3.fromRGB(55,55,65)

    Button.Text = Text
    Button.TextColor3 =
        Color3.fromRGB(255,255,255)

    Button.TextSize = 13
    Button.Font = Enum.Font.GothamBold

    Button.Parent = Scroll

    Round(Button, 8)

    return Button
end

--==================================================
-- BOTÕES
--==================================================

local Button1 =
    CreateButton("ESTEIRA 1", 5)

local Button2 =
    CreateButton("ESTEIRA 2", 50)

local Button3 =
    CreateButton("ESTEIRA 3", 95)

local ButtonVIP =
    CreateButton("ESTEIRA VIP | 199 ROBUX", 140)

local ButtonTrofeu =
    CreateButton("TROFÉU", 185)

local AutoFarmButton =
    CreateButton("AUTO FARM: DESLIGADO", 230)

local DestinationButton =
    CreateButton("DESTINO", 275)

local StopButton =
    CreateButton("STOP", 320)

local NoclipButton =
    CreateButton("NOCLIP: DESLIGADO", 365)

--==================================================
-- VELOCIDADE
--==================================================

local SpeedMinus =
    CreateButton("−", 410)

SpeedMinus.Size =
    UDim2.new(0, 45, 0, 38)

local SpeedLabel =
    CreateButton(
        "VELOCIDADE: " .. SPEED,
        410
    )

SpeedLabel.Position =
    UDim2.new(0, 52, 0, 410)

SpeedLabel.Size =
    UDim2.new(0, 135, 0, 38)

SpeedLabel.AutoButtonColor = false

local SpeedPlus =
    CreateButton("+", 410)

SpeedPlus.Position =
    UDim2.new(0, 192, 0, 410)

SpeedPlus.Size =
    UDim2.new(0, 45, 0, 38)

--==================================================
-- ATUALIZAR VELOCIDADE
--==================================================

local function UpdateSpeed()

    SpeedLabel.Text =
        "VELOCIDADE: " .. SPEED

    local Character =
        Player.Character

    if Character then

        local Humanoid =
            Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            Humanoid.WalkSpeed = SPEED
        end
    end
end

--==================================================
-- DIMINUIR VELOCIDADE
--==================================================

SpeedMinus.MouseButton1Click:Connect(function()

    SPEED = math.max(
        MIN_SPEED,
        SPEED - 5
    )

    UpdateSpeed()

end)

--==================================================
-- AUMENTAR VELOCIDADE
--==================================================

SpeedPlus.MouseButton1Click:Connect(function()

    SPEED = math.min(
        MAX_SPEED,
        SPEED + 5
    )

    UpdateSpeed()

end)

--==================================================
-- DRAG MOBILE / PC
--==================================================

local Dragging = false
local DragStart
local StartPosition

local function UpdateDrag(Input)

    local Delta =
        Input.Position - DragStart

    Main.Position =
        UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
end

Title.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position

        Input.Changed:Connect(function()

            if Input.UserInputState ==
                Enum.UserInputState.End then

                Dragging = false

            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(Input)

    if Dragging and
        (
            Input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch
        ) then

        UpdateDrag(Input)

    end
end)

--==================================================
-- MOVIMENTO NORMAL
--==================================================

local function Go(Target, Name)

    if Moving then
        return
    end

    Moving = true
    StopRequested = false

    Status.Text =
        "INDO: " .. Name

    while not StopRequested do

        local Character =
            Player.Character

        if not Character then
            task.wait(0.2)
            continue
        end

        local Humanoid =
            Character:FindFirstChildOfClass("Humanoid")

        local Root =
            Character:FindFirstChild("HumanoidRootPart")

        if not Humanoid or not Root then
            task.wait(0.2)
            continue
        end

        Humanoid.WalkSpeed = SPEED

        local Distance =
            (Root.Position - Target).Magnitude

        if Distance <= DISTANCIA_CHEGADA then

            Status.Text =
                "CHEGOU: " .. Name

            break
        end

        Humanoid:MoveTo(Target)

        task.wait(0.1)
    end

    Moving = false
end

--==================================================
-- PEGAR PERSONAGEM
--==================================================

local function GetCharacter()

    local Character =
        Player.Character

    if not Character then
        return nil,nil,nil
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    local Root =
        Character:FindFirstChild("HumanoidRootPart")

    if not Humanoid or not Root then
        return nil,nil,nil
    end

    return Character,Humanoid,Root
end

--==================================================
-- AUTO FARM MOVIMENTO
--==================================================

local function MoveAutoFarmTo(Target, Number)

    while AutoFarm do

        local Character,Humanoid,Root =
            GetCharacter()

        if not Character then
            task.wait(0.2)
            continue
        end

        Humanoid.WalkSpeed = SPEED

        local Distance =
            (Root.Position - Target).Magnitude

        if Distance > DISTANCIA_CHEGADA then

            Status.Text =
                "INDO PARA PONTO " ..
                Number

            Humanoid:MoveTo(Target)

            task.wait(0.1)

        else

            -- COORDENADA EXATA
            Root.CFrame =
                CFrame.new(Target)

            Humanoid:Move(
                Vector3.zero,
                false
            )

            Status.Text =
                "PONTO " ..
                Number ..
                " OK"

            return true
        end
    end

    return false
end

--==================================================
-- PARAR AUTO FARM
--==================================================

local function StopAutoFarm()

    AutoFarm = false

    local Character =
        Player.Character

    if Character then

        local Humanoid =
            Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then

            Humanoid:Move(
                Vector3.zero,
                false
            )

        end
    end

    AutoFarmButton.Text =
        "AUTO FARM: DESLIGADO"

    AutoFarmButton.BackgroundColor3 =
        Color3.fromRGB(70,70,80)

    Status.Text =
        "AUTO FARM PARADO"

    AutoFarmThread = nil
end

--==================================================
-- INICIAR AUTO FARM
--==================================================

local function StartAutoFarm()

    if AutoFarm then
        return
    end

    AutoFarm = true

    AutoFarmButton.Text =
        "AUTO FARM: LIGADO"

    AutoFarmButton.BackgroundColor3 =
        Color3.fromRGB(45,150,75)

    AutoFarmThread =
        task.spawn(function()

            while AutoFarm do

                --==================================
                -- PONTO 1
                --==================================

                if not MoveAutoFarmTo(
                    AutoFarmPoints[1],
                    1
                ) then
                    break
                end

                if not AutoFarm then
                    break
                end

                task.wait(0.3)

                --==================================
                -- PONTO 2
                --==================================

                if not MoveAutoFarmTo(
                    AutoFarmPoints[2],
                    2
                ) then
                    break
                end

                if not AutoFarm then
                    break
                end

                task.wait(0.3)

                --==================================
                -- PONTO 3
                --==================================

                if not MoveAutoFarmTo(
                    AutoFarmPoints[3],
                    3
                ) then
                    break
                end

                if not AutoFarm then
                    break
                end

                --==================================
                -- ESPERA 7 SEGUNDOS
                --==================================

                for Tempo = 7,1,-1 do

                    if not AutoFarm then
                        break
                    end

                    Status.Text =
                        "ESPERANDO " ..
                        Tempo ..
                        "s"

                    task.wait(1)
                end

                if not AutoFarm then
                    break
                end

                --==================================
                -- NOVO CICLO
                --==================================

                Status.Text =
                    "VOLTANDO AO PONTO 1"

                task.wait(0.1)
            end

            AutoFarmThread = nil

            AutoFarmButton.Text =
                "AUTO FARM: DESLIGADO"

            AutoFarmButton.BackgroundColor3 =
                Color3.fromRGB(70,70,80)

            if Gui.Parent then

                Status.Text =
                    "AUTO FARM PARADO"

            end
        end)
end

--==================================================
-- BOTÃO AUTO FARM
--==================================================

AutoFarmButton.MouseButton1Click:Connect(function()

    if AutoFarm then

        StopAutoFarm()

    else

        StartAutoFarm()

    end

end)

--==================================================
-- DESTINO
--==================================================

DestinationButton.MouseButton1Click:Connect(function()

    if AutoFarm then
        StopAutoFarm()
    end

    task.spawn(function()

        Go(
            AutoFarmPoints[1],
            "PONTO 1"
        )

        if StopRequested then
            return
        end

        Go(
            AutoFarmPoints[2],
            "PONTO 2"
        )

        if StopRequested then
            return
        end

        Go(
            AutoFarmPoints[3],
            "PONTO 3"
        )

    end)
end)

--==================================================
-- STOP
--==================================================

StopButton.MouseButton1Click:Connect(function()

    StopRequested = true
    Moving = false

    StopAutoFarm()

    Status.Text =
        "PARADO"

end)

--==================================================
-- NOCLIP
--==================================================

local function SetNoclip(Value)

    Noclip = Value

    if Noclip then

        NoclipButton.Text =
            "NOCLIP: LIGADO"

        NoclipButton.BackgroundColor3 =
            Color3.fromRGB(45,150,75)

    else

        NoclipButton.Text =
            "NOCLIP: DESLIGADO"

        NoclipButton.BackgroundColor3 =
            Color3.fromRGB(70,70,80)

        for Part,Collision in pairs(
            SavedCollision
        ) do

            if Part and Part.Parent then
                Part.CanCollide = Collision
            end

        end

        SavedCollision = {}

    end
end

NoclipButton.MouseButton1Click:Connect(function()

    SetNoclip(not Noclip)

end)

RunService.Heartbeat:Connect(function()

    if not Noclip then
        return
    end

    local Character =
        Player.Character

    if not Character then
        return
    end

    for _,Part in ipairs(
        Character:GetDescendants()
    ) do

        if Part:IsA("BasePart") then

            if SavedCollision[Part] == nil then

                SavedCollision[Part] =
                    Part.CanCollide

            end

            Part.CanCollide = false

        end
    end
end)

--==================================================
-- VELOCIDADE AO RENASCER
--==================================================

Player.CharacterAdded:Connect(function()

    task.wait(1)

    UpdateSpeed()

end)

--==================================================
-- MUNDO
--==================================================

local CurrentWorld = 1

local function ShowWorld(World)

    CurrentWorld = World

    if World == 1 then

        Mundo1Button.BackgroundColor3 =
            Color3.fromRGB(55,100,170)

        Mundo2Button.BackgroundColor3 =
            Color3.fromRGB(55,55,65)

        ButtonVIP.Text =
            "ESTEIRA VIP | 199 ROBUX"

    else

        Mundo1Button.BackgroundColor3 =
            Color3.fromRGB(55,55,65)

        Mundo2Button.BackgroundColor3 =
            Color3.fromRGB(55,100,170)

        ButtonVIP.Text =
            "ESTEIRA VIP | 279 ROBUX"

    end
end

Mundo1Button.MouseButton1Click:Connect(function()

    ShowWorld(1)

    Status.Text =
        "MUNDO 1"

end)

Mundo2Button.MouseButton1Click:Connect(function()

    ShowWorld(2)

    Status.Text =
        "MUNDO 2"

end)

--==================================================
-- BOTÕES MUNDO 1 / MUNDO 2
--==================================================

Button1.MouseButton1Click:Connect(function()

    if CurrentWorld == 1 then

        Go(
            Mundo1[1],
            "ESTEIRA 1"
        )

    else

        Go(
            Mundo2[1],
            "ESTEIRA 1"
        )

    end
end)

Button2.MouseButton1Click:Connect(function()

    if CurrentWorld == 1 then

        Go(
            Mundo1[2],
            "ESTEIRA 2"
        )

    else

        Go(
            Mundo2[2],
            "ESTEIRA 2"
        )

    end
end)

Button3.MouseButton1Click:Connect(function()

    if CurrentWorld == 1 then

        Go(
            Mundo1[3],
            "ESTEIRA 3"
        )

    else

        Go(
            Mundo2[3],
            "ESTEIRA 3"
        )

    end
end)

ButtonVIP.MouseButton1Click:Connect(function()

    if CurrentWorld == 1 then

        Go(
            Mundo1[4],
            "ESTEIRA VIP"
        )

    else

        Go(
            Mundo2[4],
            "ESTEIRA VIP"
        )

    end
end)

ButtonTrofeu.MouseButton1Click:Connect(function()

    if CurrentWorld == 1 then

        Go(
            Mundo1[5],
            "TROFÉU"
        )

    else

        Go(
            Mundo2[5],
            "TROFÉU"
        )

    end
end)

--==================================================
-- MINIMIZAR
--==================================================

local Minimized = false

Minimize.MouseButton1Click:Connect(function()

    Minimized = not Minimized

    Scroll.Visible =
        not Minimized

    Mundo1Button.Visible =
        not Minimized

    Mundo2Button.Visible =
        not Minimized

    Status.Visible =
        not Minimized

    if Minimized then

        Main.Size =
            UDim2.new(
                0,250,
                0,45
            )

    else

        Main.Size =
            UDim2.new(
                0,250,
                0,500
            )

    end
end)

--==================================================
-- FECHAR
--==================================================

Close.MouseButton1Click:Connect(function()

    StopRequested = true

    StopAutoFarm()

    SetNoclip(false)

    Gui:Destroy()

end)

--==================================================
-- COMEÇAR
--==================================================

StartButton.MouseButton1Click:Connect(function()

    Tutorial.Visible = false
    Main.Visible = true

    Status.Text =
        "PRONTO"

end)

--==================================================
-- INICIALIZAÇÃO
--==================================================

ShowWorld(1)

UpdateSpeed()

if SHOW_TUTORIAL then

    Tutorial.Visible = true
    Main.Visible = false

else

    Tutorial.Visible = false
    Main.Visible = true

end

--==================================================
-- PLAY HUB V4.5 • BETA
-- Roblox Studio - jogo próprio
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--==================================================
-- CONFIGURAÇÕES
--==================================================

local SHOW_TUTORIAL = true

local SPEED = 50
local MIN_SPEED = 16
local MAX_SPEED = 60

local DISTANCIA_CHEGADA = 4
local CICLO_DELAY = 7

local DISCORD_LINK =
    "https://discord.gg/3Q5HMDaAb"

--==================================================
-- ESTADOS
--==================================================

local Moving = false
local StopRequested = false
local Noclip = false
local AutoFarm = false

local Character
local Humanoid
local Root

--==================================================
-- PERSONAGEM
--==================================================

local function LoadCharacter()

    Character =
        Player.Character
        or Player.CharacterAdded:Wait()

    Humanoid =
        Character:WaitForChild("Humanoid")

    Root =
        Character:WaitForChild("HumanoidRootPart")

    Humanoid.WalkSpeed = SPEED

end

LoadCharacter()

Player.CharacterAdded:Connect(function()

    task.wait(1)

    LoadCharacter()

end)

--==================================================
-- COORDENADAS
--==================================================

local Mundo1 = {

    Esteira1 = Vector3.new(
        -44.87,
        6.49,
        32.31
    ),

    Esteira2 = Vector3.new(
        -50.68,
        6.97,
        -36.22
    ),

    Esteira3 = Vector3.new(
        -65.07,
        11.91,
        -5.57
    ),

    VIP = Vector3.new(
        -66.82,
        12.04,
        -41.11
    ),

    Trofeu = Vector3.new(
        -4.45,
        -1.19,
        3353.58
    )
}

local Mundo2 = {

    Esteira1 = Vector3.new(
        -48.65,
        6.49,
        16.59
    ),

    Esteira2 = Vector3.new(
        -43.92,
        6.97,
        -32.52
    ),

    Esteira3 = Vector3.new(
        -70.12,
        11.91,
        -6.84
    ),

    VIP = Vector3.new(
        -64.67,
        12.04,
        -37.29
    ),

    Trofeu = Vector3.new(
        -8.66,
        46.64,
        2082.59
    )
}

--==================================================
-- AUTO FARM
--==================================================

local AutoFarmPoints = {

    Vector3.new(
        1.57,
        5.56,
        26.65
    ),

    Vector3.new(
        2.43,
        46.64,
        2082.56
    ),

    Vector3.new(
        -16.82,
        44.42,
        2084.21
    )

}

--==================================================
-- GUI
--==================================================

local Gui =
    Instance.new("ScreenGui")

Gui.Name =
    "PlayHubV45Beta"

Gui.ResetOnSpawn =
    false

Gui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

Gui.Parent =
    Player:WaitForChild("PlayerGui")

--==================================================
-- TUTORIAL
--==================================================

local Tutorial =
    Instance.new("Frame")

Tutorial.Size =
    UDim2.new(
        0,
        430,
        0,
        300
    )

Tutorial.Position =
    UDim2.new(
        0.5,
        -215,
        0.5,
        -150
    )

Tutorial.BackgroundColor3 =
    Color3.fromRGB(
        15,
        15,
        18
    )

Tutorial.BorderSizePixel =
    0

Tutorial.Parent =
    Gui

local TutorialCorner =
    Instance.new("UICorner")

TutorialCorner.CornerRadius =
    UDim.new(
        0,
        18
    )

TutorialCorner.Parent =
    Tutorial

local TutorialStroke =
    Instance.new("UIStroke")

TutorialStroke.Thickness =
    3

TutorialStroke.Color =
    Color3.fromRGB(
        255,
        0,
        0
    )

TutorialStroke.Parent =
    Tutorial

local TutorialTitle =
    Instance.new("TextLabel")

TutorialTitle.Size =
    UDim2.new(
        1,
        -30,
        0,
        50
    )

TutorialTitle.Position =
    UDim2.new(
        0,
        15,
        0,
        10
    )

TutorialTitle.BackgroundTransparency =
    1

TutorialTitle.Text =
    "PLAY HUB V4.5 • BETA"

TutorialTitle.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

TutorialTitle.TextScaled =
    true

TutorialTitle.Font =
    Enum.Font.GothamBold

TutorialTitle.Parent =
    Tutorial

local TutorialText =
    Instance.new("TextLabel")

TutorialText.Size =
    UDim2.new(
        1,
        -40,
        0,
        130
    )

TutorialText.Position =
    UDim2.new(
        0,
        20,
        0,
        65
    )

TutorialText.BackgroundTransparency =
    1

TutorialText.Text =
    "COMO USAR\n\n" ..
    "• Escolha MUNDO 1 ou MUNDO 2.\n" ..
    "• Use os botões de destino.\n" ..
    "• No MUNDO 2 existe o AUTO FARM.\n" ..
    "• O Auto Farm passa pelos 3 pontos.\n" ..
    "• Depois espera 7 segundos e repete."

TutorialText.TextColor3 =
    Color3.fromRGB(
        220,
        220,
        220
    )

TutorialText.TextSize =
    15

TutorialText.Font =
    Enum.Font.Gotham

TutorialText.TextWrapped =
    true

TutorialText.Parent =
    Tutorial

local StartButton =
    Instance.new("TextButton")

StartButton.Size =
    UDim2.new(
        1,
        -50,
        0,
        50
    )

StartButton.Position =
    UDim2.new(
        0,
        25,
        1,
        -65
    )

StartButton.BackgroundColor3 =
    Color3.fromRGB(
        55,
        140,
        75
    )

StartButton.Text =
    "COMEÇAR"

StartButton.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

StartButton.TextScaled =
    true

StartButton.Font =
    Enum.Font.GothamBold

StartButton.Parent =
    Tutorial

local StartCorner =
    Instance.new("UICorner")

StartCorner.CornerRadius =
    UDim.new(
        0,
        12
    )

StartCorner.Parent =
    StartButton

--==================================================
-- PAINEL PRINCIPAL HORIZONTAL
--==================================================

local Main =
    Instance.new("Frame")

Main.Size =
    UDim2.new(
        0,
        650,
        0,
        350
    )

Main.Position =
    UDim2.new(
        0.5,
        -325,
        0.5,
        -175
    )

Main.BackgroundColor3 =
    Color3.fromRGB(
        12,
        12,
        15
    )

Main.BorderSizePixel =
    0

Main.Visible =
    false

Main.Parent =
    Gui

local MainCorner =
    Instance.new("UICorner")

MainCorner.CornerRadius =
    UDim.new(
        0,
        18
    )

MainCorner.Parent =
    Main

--==================================================
-- BORDA #FF0000 / #000000
--==================================================

local MainStroke =
    Instance.new("UIStroke")

MainStroke.Thickness =
    3

MainStroke.Color =
    Color3.fromRGB(
        255,
        0,
        0
    )

MainStroke.Parent =
    Main

task.spawn(function()

    while Gui.Parent do

        -- vermelho para preto

        for i = 0, 30 do

            if not Gui.Parent then
                break
            end

            local Alpha =
                i / 30

            MainStroke.Color =
                Color3.new(
                    1 - Alpha,
                    0,
                    0
                )

            task.wait(0.04)

        end

        -- preto para vermelho

        for i = 0, 30 do

            if not Gui.Parent then
                break
            end

            local Alpha =
                i / 30

            MainStroke.Color =
                Color3.new(
                    Alpha,
                    0,
                    0
                )

            task.wait(0.04)

        end

    end

end)

--==================================================
-- TÍTULO + BETA
--==================================================

local Title =
    Instance.new("TextLabel")

Title.Size =
    UDim2.new(
        0,
        300,
        0,
        40
    )

Title.Position =
    UDim2.new(
        0,
        15,
        0,
        5
    )

Title.BackgroundTransparency =
    1

Title.Text =
    "PLAY HUB V4.5 • BETA"

Title.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

Title.TextScaled =
    true

Title.Font =
    Enum.Font.GothamBold

Title.TextXAlignment =
    Enum.TextXAlignment.Left

Title.Parent =
    Main

--==================================================
-- DISCORD
-- FICA BEM LONGE DOS CONTROLES
--==================================================

local DiscordTop =
    Instance.new("TextButton")

DiscordTop.Size =
    UDim2.new(
        0,
        90,
        0,
        32
    )

DiscordTop.Position =
    UDim2.new(
        0,
        350,
        0,
        8
    )

DiscordTop.BackgroundColor3 =
    Color3.fromRGB(
        65,
        65,
        140
    )

DiscordTop.Text =
    "DISCORD"

DiscordTop.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

DiscordTop.TextScaled =
    true

DiscordTop.Font =
    Enum.Font.GothamBold

DiscordTop.Parent =
    Main

local DiscordTopCorner =
    Instance.new("UICorner")

DiscordTopCorner.CornerRadius =
    UDim.new(
        0,
        9
    )

DiscordTopCorner.Parent =
    DiscordTop

--==================================================
-- MINIMIZAR
--==================================================

local MinButton =
    Instance.new("TextButton")

MinButton.Size =
    UDim2.new(
        0,
        32,
        0,
        32
    )

MinButton.Position =
    UDim2.new(
        1,
        -80,
        0,
        8
    )

MinButton.BackgroundColor3 =
    Color3.fromRGB(
        55,
        55,
        65
    )

MinButton.Text =
    "-"

MinButton.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

MinButton.TextScaled =
    true

MinButton.Font =
    Enum.Font.GothamBold

MinButton.Parent =
    Main

local MinCorner =
    Instance.new("UICorner")

MinCorner.CornerRadius =
    UDim.new(
        0,
        9
    )

MinCorner.Parent =
    MinButton

--==================================================
-- FECHAR
--==================================================

local CloseButton =
    Instance.new("TextButton")

CloseButton.Size =
    UDim2.new(
        0,
        32,
        0,
        32
    )

CloseButton.Position =
    UDim2.new(
        1,
        -42,
        0,
        8
    )

CloseButton.BackgroundColor3 =
    Color3.fromRGB(
        170,
        50,
        50
    )

CloseButton.Text =
    "X"

CloseButton.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

CloseButton.TextScaled =
    true

CloseButton.Font =
    Enum.Font.GothamBold

CloseButton.Parent =
    Main

local CloseCorner =
    Instance.new("UICorner")

CloseCorner.CornerRadius =
    UDim.new(
        0,
        9
    )

CloseCorner.Parent =
    CloseButton

--==================================================
-- ABAS
--==================================================

local Tab1 =
    Instance.new("TextButton")

Tab1.Size =
    UDim2.new(
        0,
        120,
        0,
        38
    )

Tab1.Position =
    UDim2.new(
        0,
        15,
        0,
        52
    )

Tab1.BackgroundColor3 =
    Color3.fromRGB(
        55,
        110,
        170
    )

Tab1.Text =
    "MUNDO 1"

Tab1.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

Tab1.TextScaled =
    true

Tab1.Font =
    Enum.Font.GothamBold

Tab1.Parent =
    Main

local Tab1Corner =
    Instance.new("UICorner")

Tab1Corner.CornerRadius =
    UDim.new(
        0,
        10
    )

Tab1Corner.Parent =
    Tab1

local Tab2 =
    Instance.new("TextButton")

Tab2.Size =
    UDim2.new(
        0,
        120,
        0,
        38
    )

Tab2.Position =
    UDim2.new(
        0,
        145,
        0,
        52
    )

Tab2.BackgroundColor3 =
    Color3.fromRGB(
        45,
        45,
        55
    )

Tab2.Text =
    "MUNDO 2"

Tab2.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

Tab2.TextScaled =
    true

Tab2.Font =
    Enum.Font.GothamBold

Tab2.Parent =
    Main

local Tab2Corner =
    Instance.new("UICorner")

Tab2Corner.CornerRadius =
    UDim.new(
        0,
        10
    )

Tab2Corner.Parent =
    Tab2

--==================================================
-- SCROLL
--==================================================

local Scroll =
    Instance.new("ScrollingFrame")

Scroll.Size =
    UDim2.new(
        1,
        -30,
        0,
        215
    )

Scroll.Position =
    UDim2.new(
        0,
        15,
        0,
        98
    )

Scroll.BackgroundTransparency =
    1

Scroll.BorderSizePixel =
    0

Scroll.ScrollBarThickness =
    5

Scroll.CanvasSize =
    UDim2.new(
        0,
        0,
        0,
        510
    )

Scroll.Parent =
    Main

--==================================================
-- STATUS
--==================================================

local Status =
    Instance.new("TextLabel")

Status.Size =
    UDim2.new(
        1,
        -30,
        0,
        28
    )

Status.Position =
    UDim2.new(
        0,
        15,
        1,
        -35
    )

Status.BackgroundTransparency =
    1

Status.Text =
    "Pronto"

Status.TextColor3 =
    Color3.fromRGB(
        190,
        190,
        190
    )

Status.TextScaled =
    true

Status.Font =
    Enum.Font.Gotham

Status.Parent =
    Main

--==================================================
-- FUNÇÃO CRIAR BOTÃO
--==================================================

local function CreateButton(Text, Y)

    local Button =
        Instance.new("TextButton")

    Button.Size =
        UDim2.new(
            0,
            195,
            0,
            40
        )

    Button.Position =
        UDim2.new(
            0,
            5,
            0,
            Y
        )

    Button.BackgroundColor3 =
        Color3.fromRGB(
            50,
            50,
            60
        )

    Button.Text =
        Text

    Button.TextColor3 =
        Color3.fromRGB(
            255,
            255,
            255
        )

    Button.TextScaled =
        true

    Button.Font =
        Enum.Font.GothamBold

    Button.Parent =
        Scroll

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            10
        )

    Corner.Parent =
        Button

    return Button

end

--==================================================
-- MUNDO 1
--==================================================

local M1B1 =
    CreateButton("ESTEIRA 1",5)

local M1B2 =
    CreateButton("ESTEIRA 2",50)

local M1B3 =
    CreateButton("ESTEIRA 3",95)

local M1B4 =
    CreateButton(
        "ESTEIRA VIP | 199 ROBUX",
        140
    )

local M1B5 =
    CreateButton("TROFÉU",185)

--==================================================
-- MUNDO 2
--==================================================

local M2B1 =
    CreateButton("ESTEIRA 1",5)

local M2B2 =
    CreateButton("ESTEIRA 2",50)

local M2B3 =
    CreateButton("ESTEIRA 3",95)

local M2B4 =
    CreateButton(
        "ESTEIRA VIP | 279 ROBUX",
        140
    )

local M2B5 =
    CreateButton("TROFÉU",185)

local AutoFarmButton =
    CreateButton(
        "AUTO FARM: DESLIGADO",
        230
    )

local DestinationButton =
    CreateButton(
        "IR PARA DESTINO",
        275
    )

local StopButton =
    CreateButton(
        "PARAR",
        320
    )

local NoclipButton =
    CreateButton(
        "NOCLIP: DESLIGADO",
        365
    )

--==================================================
-- VELOCIDADE
--==================================================

local SpeedMinus =
    CreateButton("-",410)

SpeedMinus.Size =
    UDim2.new(
        0,
        55,
        0,
        40
    )

local SpeedLabel =
    CreateButton(
        "VELOCIDADE: "..SPEED,
        410
    )

SpeedLabel.Size =
    UDim2.new(
        0,
        120,
        0,
        40
    )

SpeedLabel.Position =
    UDim2.new(
        0,
        65,
        0,
        410
    )

local SpeedPlus =
    CreateButton("+",410)

SpeedPlus.Size =
    UDim2.new(
        0,
        55,
        0,
        40
    )

SpeedPlus.Position =
    UDim2.new(
        0,
        195,
        0,
        410
    )

local DiscordButton =
    CreateButton(
        "💬 DISCORD",
        455
    )

DiscordButton.BackgroundColor3 =
    Color3.fromRGB(
        65,
        65,
        140
    )

--==================================================
-- JANELA DISCORD
--==================================================

local DiscordFrame =
    Instance.new("Frame")

DiscordFrame.Size =
    UDim2.new(
        0,
        330,
        0,
        175
    )

DiscordFrame.Position =
    UDim2.new(
        0.5,
        -165,
        0.5,
        -87
    )

DiscordFrame.BackgroundColor3 =
    Color3.fromRGB(
        20,
        20,
        25
    )

DiscordFrame.BorderSizePixel =
    0

DiscordFrame.Visible =
    false

DiscordFrame.ZIndex =
    20

DiscordFrame.Parent =
    Gui

local DiscordCorner =
    Instance.new("UICorner")

DiscordCorner.CornerRadius =
    UDim.new(
        0,
        15
    )

DiscordCorner.Parent =
    DiscordFrame

local DiscordStroke =
    Instance.new("UIStroke")

DiscordStroke.Thickness =
    3

DiscordStroke.Color =
    Color3.fromRGB(
        255,
        0,
        0
    )

DiscordStroke.Parent =
    DiscordFrame

local DiscordTitle =
    Instance.new("TextLabel")

DiscordTitle.Size =
    UDim2.new(
        1,
        -50,
        0,
        35
    )

DiscordTitle.Position =
    UDim2.new(
        0,
        10,
        0,
        5
    )

DiscordTitle.BackgroundTransparency =
    1

DiscordTitle.Text =
    "DISCORD"

DiscordTitle.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

DiscordTitle.TextScaled =
    true

DiscordTitle.Font =
    Enum.Font.GothamBold

DiscordTitle.ZIndex =
    21

DiscordTitle.Parent =
    DiscordFrame

local DiscordClose =
    Instance.new("TextButton")

DiscordClose.Size =
    UDim2.new(
        0,
        30,
        0,
        30
    )

DiscordClose.Position =
    UDim2.new(
        1,
        -38,
        0,
        5
    )

DiscordClose.BackgroundColor3 =
    Color3.fromRGB(
        170,
        50,
        50
    )

DiscordClose.Text =
    "X"

DiscordClose.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

DiscordClose.TextScaled =
    true

DiscordClose.ZIndex =
    21

DiscordClose.Parent =
    DiscordFrame

local DiscordBox =
    Instance.new("TextBox")

DiscordBox.Size =
    UDim2.new(
        1,
        -20,
        0,
        45
    )

DiscordBox.Position =
    UDim2.new(
        0,
        10,
        0,
        50
    )

DiscordBox.BackgroundColor3 =
    Color3.fromRGB(
        45,
        45,
        55
    )

DiscordBox.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

DiscordBox.Text =
    DISCORD_LINK

DiscordBox.TextSize =
    14

DiscordBox.Font =
    Enum.Font.Gotham

DiscordBox.ClearTextOnFocus =
    false

DiscordBox.TextEditable =
    true

DiscordBox.ZIndex =
    21

DiscordBox.Parent =
    DiscordFrame

local DiscordBoxCorner =
    Instance.new("UICorner")

DiscordBoxCorner.CornerRadius =
    UDim.new(
        0,
        8
    )

DiscordBoxCorner.Parent =
    DiscordBox

local DiscordInfo =
    Instance.new("TextLabel")

DiscordInfo.Size =
    UDim2.new(
        1,
        -20,
        0,
        40
    )

DiscordInfo.Position =
    UDim2.new(
        0,
        10,
        0,
        105
    )

DiscordInfo.BackgroundTransparency =
    1

DiscordInfo.Text =
    "Selecione o link e use Copiar."

DiscordInfo.TextColor3 =
    Color3.fromRGB(
        190,
        190,
        190
    )

DiscordInfo.TextScaled =
    true

DiscordInfo.Font =
    Enum.Font.Gotham

DiscordInfo.ZIndex =
    21

DiscordInfo.Parent =
    DiscordFrame

local function OpenDiscord()

    DiscordFrame.Visible =
        true

    task.defer(function()

        DiscordBox:CaptureFocus()

        DiscordBox.CursorPosition =
            #DISCORD_LINK + 1

    end)

end

DiscordTop.MouseButton1Click:Connect(
    OpenDiscord
)

DiscordButton.MouseButton1Click:Connect(
    OpenDiscord
)

DiscordClose.MouseButton1Click:Connect(
    function()

        DiscordFrame.Visible =
            false

    end
)

--==================================================
-- VELOCIDADE
--==================================================

local function UpdateSpeed()

    SpeedLabel.Text =
        "VELOCIDADE: "..SPEED

    if Humanoid then
        Humanoid.WalkSpeed =
            SPEED
    end

end

SpeedMinus.MouseButton1Click:Connect(
    function()

        SPEED =
            math.max(
                MIN_SPEED,
                SPEED - 5
            )

        UpdateSpeed()

    end
)

SpeedPlus.MouseButton1Click:Connect(
    function()

        SPEED =
            math.min(
                MAX_SPEED,
                SPEED + 5
            )

        UpdateSpeed()

    end
)

--==================================================
-- NOCLIP
--==================================================

local NoclipConnection

local function SetNoclip(Value)

    Noclip =
        Value

    if Noclip then

        NoclipButton.Text =
            "NOCLIP: LIGADO"

        NoclipButton.BackgroundColor3 =
            Color3.fromRGB(
                45,
                150,
                75
            )

        if NoclipConnection then
            NoclipConnection:Disconnect()
        end

        NoclipConnection =
            RunService.Heartbeat:Connect(
                function()

                    if not Character then
                        return
                    end

                    for _, Part in
                        ipairs(
                            Character:GetDescendants()
                        ) do

                        if Part:IsA("BasePart") then
                            Part.CanCollide = false
                        end

                    end

                end
            )

    else

        NoclipButton.Text =
            "NOCLIP: DESLIGADO"

        NoclipButton.BackgroundColor3 =
            Color3.fromRGB(
                50,
                50,
                60
            )

        if NoclipConnection then

            NoclipConnection:Disconnect()

            NoclipConnection =
                nil

        end

    end

end

NoclipButton.MouseButton1Click:Connect(
    function()

        SetNoclip(
            not Noclip
        )

    end
)

--==================================================
-- MOVIMENTO
--==================================================

local function Go(Target, Name)

    if not Humanoid or not Root then
        return false
    end

    StopRequested =
        false

    Moving =
        true

    Status.Text =
        "INDO: "..Name

    Humanoid.WalkSpeed =
        SPEED

    while Moving
        and not StopRequested do

        if not Root
            or not Root.Parent then

            Moving =
                false

            return false

        end

        local Distance =
            (
                Root.Position
                - Target
            ).Magnitude

        if Distance <=
            DISTANCIA_CHEGADA then

            Root.CFrame =
                CFrame.new(Target)

            Moving =
                false

            Status.Text =
                "CHEGOU: "..Name

            return true

        end

        Humanoid:MoveTo(Target)

        task.wait(0.1)

    end

    Moving =
        false

    return false

end

--==================================================
-- MOVIMENTO AUTO FARM
--==================================================

local function MoveAutoFarmTo(
    Target,
    Number
)

    if not Humanoid or not Root then
        return false
    end

    Moving =
        true

    Status.Text =
        "AUTO FARM → PONTO "..Number

    Humanoid.WalkSpeed =
        SPEED

    while AutoFarm
        and not StopRequested do

        if not Root
            or not Root.Parent then

            return false

        end

        local Distance =
            (
                Root.Position
                - Target
            ).Magnitude

        if Distance <=
            DISTANCIA_CHEGADA then

            Root.CFrame =
                CFrame.new(Target)

            task.wait(0.15)

            if Root then
                Root.CFrame =
                    CFrame.new(Target)
            end

            Moving =
                false

            return true

        end

        Humanoid:MoveTo(Target)

        task.wait(0.1)

    end

    Moving =
        false

    return false

end

--==================================================
-- PARAR AUTO FARM
--==================================================

local function StopAutoFarm()

    AutoFarm =
        false

    StopRequested =
        true

    Moving =
        false

    if Humanoid then
        Humanoid:Move(Vector3.zero)
    end

    AutoFarmButton.Text =
        "AUTO FARM: DESLIGADO"

    AutoFarmButton.BackgroundColor3 =
        Color3.fromRGB(
            50,
            50,
            60
        )

    Status.Text =
        "AUTO FARM PARADO"

end

--==================================================
-- INICIAR AUTO FARM
--==================================================

local function StartAutoFarm()

    if AutoFarm then
        return
    end

    StopRequested =
        false

    AutoFarm =
        true

    AutoFarmButton.Text =
        "AUTO FARM: LIGADO"

    AutoFarmButton.BackgroundColor3 =
        Color3.fromRGB(
            45,
            150,
            75
        )

    task.spawn(function()

        while AutoFarm do

            -- PONTO 1

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

            -- PONTO 2

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

            -- PONTO 3

            if not MoveAutoFarmTo(
                AutoFarmPoints[3],
                3
            ) then
                break
            end

            if not AutoFarm then
                break
            end

            -- 7 SEGUNDOS

            for Tempo = 7, 1, -1 do

                if not AutoFarm then
                    break
                end

                Status.Text =
                    "ESPERANDO "..Tempo.."s"

                task.wait(1)

            end

            if not AutoFarm then
                break
            end

            Status.Text =
                "VOLTANDO AO PONTO 1"

            task.wait(0.1)

        end

        AutoFarmButton.Text =
            "AUTO FARM: DESLIGADO"

        AutoFarmButton.BackgroundColor3 =
            Color3.fromRGB(
                50,
                50,
                60
            )

        Status.Text =
            "AUTO FARM PARADO"

    end)

end

AutoFarmButton.MouseButton1Click:Connect(
    function()

        if AutoFarm then
            StopAutoFarm()
        else
            StartAutoFarm()
        end

    end
)

--==================================================
-- DESTINO
--==================================================

DestinationButton.MouseButton1Click:Connect(
    function()

        StopRequested =
            false

        task.spawn(function()

            if not Go(
                AutoFarmPoints[1],
                "PONTO 1"
            ) then
                return
            end

            if StopRequested then
                return
            end

            task.wait(0.3)

            if not Go(
                AutoFarmPoints[2],
                "PONTO 2"
            ) then
                return
            end

            if StopRequested then
                return
            end

            task.wait(0.3)

            Go(
                AutoFarmPoints[3],
                "PONTO 3"
            )

        end)

    end
)

--==================================================
-- PARAR
--==================================================

StopButton.MouseButton1Click:Connect(
    function()

        StopRequested =
            true

        Moving =
            false

        if AutoFarm then
            StopAutoFarm()
        end

        if Humanoid then
            Humanoid:Move(Vector3.zero)
        end

        Status.Text =
            "PARADO"

    end
)

--==================================================
-- MUNDO 1
--==================================================

M1B1.MouseButton1Click:Connect(
    function()
        Go(
            Mundo1.Esteira1,
            "ESTEIRA 1"
        )
    end
)

M1B2.MouseButton1Click:Connect(
    function()
        Go(
            Mundo1.Esteira2,
            "ESTEIRA 2"
        )
    end
)

M1B3.MouseButton1Click:Connect(
    function()
        Go(
            Mundo1.Esteira3,
            "ESTEIRA 3"
        )
    end
)

M1B4.MouseButton1Click:Connect(
    function()
        Go(
            Mundo1.VIP,
            "ESTEIRA VIP"
        )
    end
)

M1B5.MouseButton1Click:Connect(
    function()
        Go(
            Mundo1.Trofeu,
            "TROFÉU"
        )
    end
)

--==================================================
-- MUNDO 2
--==================================================

M2B1.MouseButton1Click:Connect(
    function()
        Go(
            Mundo2.Esteira1,
            "ESTEIRA 1"
        )
    end
)

M2B2.MouseButton1Click:Connect(
    function()
        Go(
            Mundo2.Esteira2,
            "ESTEIRA 2"
        )
    end
)

M2B3.MouseButton1Click:Connect(
    function()
        Go(
            Mundo2.Esteira3,
            "ESTEIRA 3"
        )
    end
)

M2B4.MouseButton1Click:Connect(
    function()
        Go(
            Mundo2.VIP,
            "ESTEIRA VIP"
        )
    end
)

M2B5.MouseButton1Click:Connect(
    function()
        Go(
            Mundo2.Trofeu,
            "TROFÉU"
        )
    end
)

--==================================================
-- TROCAR MUNDO
--==================================================

local function ShowWorld(World)

    local World1 =
        World == 1

    local World2 =
        World == 2

    M1B1.Visible = World1
    M1B2.Visible = World1
    M1B3.Visible = World1
    M1B4.Visible = World1
    M1B5.Visible = World1

    M2B1.Visible = World2
    M2B2.Visible = World2
    M2B3.Visible = World2
    M2B4.Visible = World2
    M2B5.Visible = World2

    AutoFarmButton.Visible = World2
    DestinationButton.Visible = World2
    StopButton.Visible = World2
    NoclipButton.Visible = World2
    SpeedMinus.Visible = World2
    SpeedLabel.Visible = World2
    SpeedPlus.Visible = World2
    DiscordButton.Visible = World2

    if World1 then

        Tab1.BackgroundColor3 =
            Color3.fromRGB(
                55,
                110,
                170
            )

        Tab2.BackgroundColor3 =
            Color3.fromRGB(
                45,
                45,
                55
            )

    else

        Tab1.BackgroundColor3 =
            Color3.fromRGB(
                45,
                45,
                55
            )

        Tab2.BackgroundColor3 =
            Color3.fromRGB(
                55,
                110,
                170
            )

    end

end

Tab1.MouseButton1Click:Connect(
    function()
        ShowWorld(1)
    end
)

Tab2.MouseButton1Click:Connect(
    function()
        ShowWorld(2)
    end
)

--==================================================
-- ARRASTAR NO CELULAR/PC
--==================================================

local Dragging = false
local DragStart
local StartPosition

Title.InputBegan:Connect(
    function(Input)

        if
            Input.UserInputType ==
                Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
                Enum.UserInputType.Touch
        then

            Dragging = true

            DragStart =
                Input.Position

            StartPosition =
                Main.Position

        end

    end
)

UserInputService.InputChanged:Connect(
    function(Input)

        if not Dragging then
            return
        end

        if
            Input.UserInputType ==
                Enum.UserInputType.MouseMovement
            or
            Input.UserInputType ==
                Enum.UserInputType.Touch
        then

            local Delta =
                Input.Position
                - DragStart

            Main.Position =
                UDim2.new(
                    StartPosition.X.Scale,
                    StartPosition.X.Offset
                        + Delta.X,

                    StartPosition.Y.Scale,
                    StartPosition.Y.Offset
                        + Delta.Y
                )

        end

    end
)

UserInputService.InputEnded:Connect(
    function(Input)

        if
            Input.UserInputType ==
                Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
                Enum.UserInputType.Touch
        then

            Dragging = false

        end

    end
)

--==================================================
-- MINIMIZAR
--==================================================

local MiniButton =
    Instance.new("TextButton")

MiniButton.Size =
    UDim2.new(
        0,
        70,
        0,
        42
    )

MiniButton.Position =
    UDim2.new(
        0,
        10,
        0.5,
        -21
    )

MiniButton.BackgroundColor3 =
    Color3.fromRGB(
        20,
        20,
        25
    )

MiniButton.Text =
    "PLAY"

MiniButton.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

MiniButton.TextScaled =
    true

MiniButton.Font =
    Enum.Font.GothamBold

MiniButton.Visible =
    false

MiniButton.Parent =
    Gui

local MiniCorner =
    Instance.new("UICorner")

MiniCorner.CornerRadius =
    UDim.new(
        0,
        12
    )

MiniCorner.Parent =
    MiniButton

local MiniStroke =
    Instance.new("UIStroke")

MiniStroke.Thickness =
    2

MiniStroke.Color =
    Color3.fromRGB(
        255,
        0,
        0
    )

MiniStroke.Parent =
    MiniButton

MinButton.MouseButton1Click:Connect(
    function()

        Main.Visible = false
        MiniButton.Visible = true

    end
)

MiniButton.MouseButton1Click:Connect(
    function()

        Main.Visible = true
        MiniButton.Visible = false

    end
)

--==================================================
-- FECHAR
--==================================================

CloseButton.MouseButton1Click:Connect(
    function()

        AutoFarm = false
        StopRequested = true
        Moving = false

        if NoclipConnection then

            NoclipConnection:Disconnect()

            NoclipConnection = nil

        end

        Gui:Destroy()

    end
)

--==================================================
-- COMEÇAR
--==================================================

StartButton.MouseButton1Click:Connect(
    function()

        Tutorial.Visible = false
        Main.Visible = true

    end
)

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

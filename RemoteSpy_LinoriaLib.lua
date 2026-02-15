--[[

RanZx999 Remote Spy & Game Explorer
UI Library: LinoriaLib (Compact & Professional)

Features:
- Remote Spy (FireServer, InvokeServer tracking)
- Script Viewer & Decompiler
- Instance Explorer (like Dex)
- RemoteEvent Logger with args
- Copy to Clipboard functions
- Search & Filter
- Export logs

Created by RanZx999
Perfect for reverse engineering games!

]]

-- Load LinoriaLib
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Data Storage
local RemoteLogs = {}
local ScriptList = {}
local RemoteEventList = {}
local RemoteFunctionList = {}

-- Utility Functions
local function notify(title, text, duration)
    Library:Notify(text, duration or 3)
end

local function copyToClipboard(text)
    if setclipboard then
        setclipboard(text)
        notify("Copied!", "Text copied to clipboard!")
    else
        notify("Error", "Executor doesn't support clipboard!")
    end
end

local function formatArgs(...)
    local args = {...}
    local formatted = {}
    
    for i, arg in ipairs(args) do
        local argType = type(arg)
        
        if argType == "string" then
            table.insert(formatted, string.format('"%s"', arg))
        elseif argType == "number" then
            table.insert(formatted, tostring(arg))
        elseif argType == "boolean" then
            table.insert(formatted, tostring(arg))
        elseif argType == "table" then
            table.insert(formatted, "Table")
        elseif typeof(arg) == "Instance" then
            table.insert(formatted, arg:GetFullName())
        elseif typeof(arg) == "Vector3" then
            table.insert(formatted, string.format("Vector3(%s, %s, %s)", arg.X, arg.Y, arg.Z))
        elseif typeof(arg) == "CFrame" then
            table.insert(formatted, "CFrame")
        else
            table.insert(formatted, tostring(arg))
        end
    end
    
    return table.concat(formatted, ", ")
end

-- Create Window
local Window = Library:CreateWindow({
    Title = 'RanZx999 Remote Spy',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- Tabs
local Tabs = {
    Main = Window:AddTab('Remote Spy'),
    Explorer = Window:AddTab('Explorer'),
    Scripts = Window:AddTab('Scripts'),
    Settings = Window:AddTab('Settings')
}

-- Remote Spy Tab
do
    local MainGroup = Tabs.Main:AddLeftGroupbox('Remote Logging')
    
    -- Stats
    local StatsLabel = MainGroup:AddLabel('Logs: 0 | Remotes: 0')
    
    -- Controls
    MainGroup:AddToggle('EnableSpy', {
        Text = 'Enable Remote Spy',
        Default = true,
        Tooltip = 'Log all RemoteEvent/Function calls'
    })
    
    MainGroup:AddToggle('LogFireServer', {
        Text = 'Log FireServer',
        Default = true,
        Tooltip = 'Log RemoteEvent:FireServer() calls'
    })
    
    MainGroup:AddToggle('LogInvokeServer', {
        Text = 'Log InvokeServer',
        Default = true,
        Tooltip = 'Log RemoteFunction:InvokeServer() calls'
    })
    
    MainGroup:AddButton({
        Text = 'Clear Logs',
        Func = function()
            RemoteLogs = {}
            notify("Cleared", "All logs cleared!")
        end,
        DoubleClick = false,
        Tooltip = 'Clear all remote logs'
    })
    
    MainGroup:AddButton({
        Text = 'Export Logs to Clipboard',
        Func = function()
            if #RemoteLogs == 0 then
                notify("Error", "No logs to export!")
                return
            end
            
            local export = "=== REMOTE LOGS ===\n\n"
            for i, log in ipairs(RemoteLogs) do
                export = export .. string.format("[%d] %s\n", i, log) .. "\n"
            end
            
            copyToClipboard(export)
        end,
        DoubleClick = false,
        Tooltip = 'Copy all logs to clipboard'
    })
    
    -- Filters
    local FilterGroup = Tabs.Main:AddRightGroupbox('Filters')
    
    FilterGroup:AddInput('FilterRemoteName', {
        Default = '',
        Numeric = false,
        Finished = false,
        Text = 'Filter by Name',
        Tooltip = 'Only show remotes matching this name',
        Placeholder = 'Enter remote name...'
    })
    
    FilterGroup:AddToggle('FilterDamage', {
        Text = 'Show only Damage-related',
        Default = false,
        Tooltip = 'Filter for Damage, Hit, Kill, etc.'
    })
    
    FilterGroup:AddToggle('FilterWeapon', {
        Text = 'Show only Weapon-related',
        Default = false,
        Tooltip = 'Filter for Gun, Shoot, Fire, etc.'
    })
    
    -- Live Log Display
    local LogGroup = Tabs.Main:AddRightGroupbox('Live Logs (Last 10)')
    local LogBox = LogGroup:AddLabel('Waiting for remote calls...')
    
    -- Update logs display
    task.spawn(function()
        while task.wait(0.5) do
            local displayLogs = {}
            local start = math.max(1, #RemoteLogs - 9)
            
            for i = start, #RemoteLogs do
                table.insert(displayLogs, RemoteLogs[i])
            end
            
            if #displayLogs > 0 then
                LogBox:SetText(table.concat(displayLogs, "\n"))
            end
            
            StatsLabel:SetText(string.format('Logs: %d | Remotes: %d', #RemoteLogs, #RemoteEventList + #RemoteFunctionList))
        end
    end)
end

-- Explorer Tab
do
    local ExplorerGroup = Tabs.Explorer:AddLeftGroupbox('Game Explorer')
    
    ExplorerGroup:AddButton({
        Text = 'Scan Game for Remotes',
        Func = function()
            RemoteEventList = {}
            RemoteFunctionList = {}
            
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    table.insert(RemoteEventList, {
                        Name = obj.Name,
                        Path = obj:GetFullName(),
                        Object = obj
                    })
                elseif obj:IsA("RemoteFunction") then
                    table.insert(RemoteFunctionList, {
                        Name = obj.Name,
                        Path = obj:GetFullName(),
                        Object = obj
                    })
                end
            end
            
            notify("Scan Complete", string.format("Found %d RemoteEvents, %d RemoteFunctions", 
                #RemoteEventList, #RemoteFunctionList))
        end,
        DoubleClick = false
    })
    
    ExplorerGroup:AddButton({
        Text = 'List All RemoteEvents',
        Func = function()
            if #RemoteEventList == 0 then
                notify("Error", "Scan for remotes first!")
                return
            end
            
            local list = "=== REMOTE EVENTS ===\n\n"
            for i, remote in ipairs(RemoteEventList) do
                list = list .. string.format("[%d] %s\nPath: %s\n\n", i, remote.Name, remote.Path)
            end
            
            copyToClipboard(list)
            notify("Copied", string.format("%d RemoteEvents copied!", #RemoteEventList))
        end,
        DoubleClick = false
    })
    
    ExplorerGroup:AddButton({
        Text = 'List All RemoteFunctions',
        Func = function()
            if #RemoteFunctionList == 0 then
                notify("Error", "Scan for remotes first!")
                return
            end
            
            local list = "=== REMOTE FUNCTIONS ===\n\n"
            for i, remote in ipairs(RemoteFunctionList) do
                list = list .. string.format("[%d] %s\nPath: %s\n\n", i, remote.Name, remote.Path)
            end
            
            copyToClipboard(list)
            notify("Copied", string.format("%d RemoteFunctions copied!", #RemoteFunctionList))
        end,
        DoubleClick = false
    })
    
    local PathGroup = Tabs.Explorer:AddRightGroupbox('Quick Access Paths')
    
    PathGroup:AddButton({
        Text = 'Copy ReplicatedStorage Path',
        Func = function()
            copyToClipboard("game:GetService('ReplicatedStorage')")
        end,
        DoubleClick = false
    })
    
    PathGroup:AddButton({
        Text = 'Copy Workspace Path',
        Func = function()
            copyToClipboard("game:GetService('Workspace')")
        end,
        DoubleClick = false
    })
    
    PathGroup:AddButton({
        Text = 'Copy Player Character Path',
        Func = function()
            copyToClipboard(string.format("game.Players.%s.Character", LocalPlayer.Name))
        end,
        DoubleClick = false
    })
end

-- Scripts Tab
do
    local ScriptsGroup = Tabs.Scripts:AddLeftGroupbox('Script Scanner')
    
    ScriptsGroup:AddButton({
        Text = 'Scan for LocalScripts',
        Func = function()
            ScriptList = {}
            
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
                    table.insert(ScriptList, {
                        Name = obj.Name,
                        Type = obj.ClassName,
                        Path = obj:GetFullName(),
                        Object = obj
                    })
                end
            end
            
            notify("Scan Complete", string.format("Found %d scripts!", #ScriptList))
        end,
        DoubleClick = false
    })
    
    ScriptsGroup:AddButton({
        Text = 'List All Scripts',
        Func = function()
            if #ScriptList == 0 then
                notify("Error", "Scan for scripts first!")
                return
            end
            
            local list = "=== SCRIPTS ===\n\n"
            for i, script in ipairs(ScriptList) do
                list = list .. string.format("[%d] %s (%s)\nPath: %s\n\n", 
                    i, script.Name, script.Type, script.Path)
            end
            
            copyToClipboard(list)
            notify("Copied", string.format("%d Scripts copied!", #ScriptList))
        end,
        DoubleClick = false
    })
    
    ScriptsGroup:AddButton({
        Text = 'Find Weapon Scripts',
        Func = function()
            local weaponScripts = {}
            
            for _, script in ipairs(ScriptList) do
                local name = string.lower(script.Name)
                if string.match(name, "gun") or 
                   string.match(name, "weapon") or 
                   string.match(name, "shoot") or
                   string.match(name, "fire") then
                    table.insert(weaponScripts, script)
                end
            end
            
            if #weaponScripts == 0 then
                notify("Not Found", "No weapon scripts found!")
                return
            end
            
            local list = "=== WEAPON SCRIPTS ===\n\n"
            for i, script in ipairs(weaponScripts) do
                list = list .. string.format("[%d] %s (%s)\nPath: %s\n\n", 
                    i, script.Name, script.Type, script.Path)
            end
            
            copyToClipboard(list)
            notify("Found", string.format("%d Weapon scripts found!", #weaponScripts))
        end,
        DoubleClick = false
    })
    
    local DecompilerGroup = Tabs.Scripts:AddRightGroupbox('Decompiler')
    
    DecompilerGroup:AddLabel('Note: Requires executor with decompiler support')
    
    DecompilerGroup:AddInput('DecompileScriptName', {
        Default = '',
        Numeric = false,
        Finished = true,
        Text = 'Script Name',
        Tooltip = 'Enter exact script name to decompile',
        Placeholder = 'e.g., GunScript'
    })
    
    DecompilerGroup:AddButton({
        Text = 'Decompile Script',
        Func = function()
            local scriptName = Options.DecompileScriptName.Value
            
            if scriptName == '' then
                notify("Error", "Enter a script name!")
                return
            end
            
            if not decompile then
                notify("Error", "Executor doesn't support decompile!")
                return
            end
            
            -- Find script
            local targetScript = nil
            for _, script in ipairs(ScriptList) do
                if script.Name == scriptName then
                    targetScript = script.Object
                    break
                end
            end
            
            if not targetScript then
                notify("Error", "Script not found! Scan first!")
                return
            end
            
            -- Decompile
            local success, result = pcall(function()
                return decompile(targetScript)
            end)
            
            if success then
                copyToClipboard(result)
                notify("Success", "Script decompiled & copied!")
            else
                notify("Error", "Decompile failed!")
            end
        end,
        DoubleClick = false
    })
end

-- Settings Tab
do
    local InfoGroup = Tabs.Settings:AddLeftGroupbox('Information')
    
    InfoGroup:AddLabel('RanZx999 Remote Spy')
    InfoGroup:AddLabel('Version: 1.0')
    InfoGroup:AddLabel('UI: LinoriaLib')
    InfoGroup:AddLabel('')
    InfoGroup:AddLabel('Created by: RanZx999')
    
    local ControlsGroup = Tabs.Settings:AddLeftGroupbox('Controls')
    
    ControlsGroup:AddLabel('Toggle UI: Right CTRL')
    ControlsGroup:AddLabel('Unload: Use button below')
    
    ControlsGroup:AddButton({
        Text = 'Unload Script',
        Func = function()
            Library:Unload()
        end,
        DoubleClick = true,
        Tooltip = 'Double-click to unload'
    })
    
    local UtilityGroup = Tabs.Settings:AddRightGroupbox('Utilities')
    
    UtilityGroup:AddButton({
        Text = 'Open Dex Explorer',
        Func = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
            notify("Loaded", "Dex Explorer loaded!")
        end,
        DoubleClick = false
    })
    
    UtilityGroup:AddButton({
        Text = 'Open Simple Spy',
        Func = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
            notify("Loaded", "Simple Spy loaded!")
        end,
        DoubleClick = false
    })
    
    UtilityGroup:AddButton({
        Text = 'Rejoin Server',
        Func = function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end,
        DoubleClick = true
    })
end

-- REMOTE SPY HOOK
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if Toggles.EnableSpy and Toggles.EnableSpy.Value then
        -- FireServer
        if method == "FireServer" and self:IsA("RemoteEvent") and Toggles.LogFireServer.Value then
            local remoteName = self.Name
            local remotePath = self:GetFullName()
            
            -- Apply filters
            local shouldLog = true
            
            if Options.FilterRemoteName.Value ~= '' then
                if not string.match(string.lower(remoteName), string.lower(Options.FilterRemoteName.Value)) then
                    shouldLog = false
                end
            end
            
            if Toggles.FilterDamage.Value then
                local lowerName = string.lower(remoteName)
                if not (string.match(lowerName, "damage") or 
                        string.match(lowerName, "hit") or 
                        string.match(lowerName, "kill") or
                        string.match(lowerName, "hurt")) then
                    shouldLog = false
                end
            end
            
            if Toggles.FilterWeapon.Value then
                local lowerName = string.lower(remoteName)
                if not (string.match(lowerName, "gun") or 
                        string.match(lowerName, "weapon") or 
                        string.match(lowerName, "shoot") or
                        string.match(lowerName, "fire")) then
                    shouldLog = false
                end
            end
            
            if shouldLog then
                local formattedArgs = formatArgs(...)
                local log = string.format("[FireServer] %s | Args: %s", remoteName, formattedArgs)
                table.insert(RemoteLogs, log)
                
                -- Also log path for copying
                print(string.format("Path: %s", remotePath))
            end
        end
        
        -- InvokeServer
        if method == "InvokeServer" and self:IsA("RemoteFunction") and Toggles.LogInvokeServer.Value then
            local remoteName = self.Name
            local remotePath = self:GetFullName()
            local formattedArgs = formatArgs(...)
            local log = string.format("[InvokeServer] %s | Args: %s", remoteName, formattedArgs)
            table.insert(RemoteLogs, log)
            print(string.format("Path: %s", remotePath))
        end
    end
    
    return oldNamecall(self, ...)
end))

-- Theme Manager & Save Manager
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

ThemeManager:SetFolder('RanZx999Spy')
SaveManager:SetFolder('RanZx999Spy')

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

-- Success notification
Library:Notify('Remote Spy Loaded!', 5)

print("="..string.rep("=", 50))
print("🔍 RanZx999 Remote Spy Loaded!")
print("="..string.rep("=", 50))
print("Features:")
print("  • Remote Event/Function Logger")
print("  • Game Explorer & Scanner")
print("  • Script Decompiler")
print("  • Copy to Clipboard")
print("="..string.rep("=", 50))
print("Press Right CTRL to toggle UI")
print("="..string.rep("=", 50))
# 🔍 RanZx999 Remote Spy

<div align="center">

![Version](https://img.shields.io/badge/version-1.0-blue.svg)
![Status](https://img.shields.io/badge/status-DEPRECATED-red.svg)
![UI](https://img.shields.io/badge/UI-LinoriaLib-purple.svg)

**Advanced Remote Event/Function Spy with Real-time Logging**

*Created by Mahatma Arangga (RanZx999)*

⚠️ **WARNING: This version uses metamethod hooks and may trigger anti-cheat in some games!**

</div>

---

## ⚠️ **SCRIPT STATUS**

### 🔴 **DEPRECATED - Use GameExplorer_Safe.lua Instead!**

**Kondisi Script:**
- ❌ **Not Recommended** for games with anti-cheat
- ❌ **May cause errors** in heavily protected games
- ⚠️ **Uses metamethod hooks** (`hookmetamethod`)
- ⚠️ **Real-time logging** can trigger detection
- ✅ **Works** on unprotected/casual games

**Known Issues:**
- Errors in games like "[UPDATE 1] SATU TEMBAKAN"
- Conflicts with game scripts (COREGUN errors)
- May crash in server-sided games
- LinoriaLib loading issues on some executors

**Why Deprecated:**
Many modern Roblox games have anti-cheat that detects metamethod hooks. This script will cause errors or get you kicked in protected games.

**Recommended Alternative:** Use `GameExplorer_Safe.lua` instead!

---

## 📋 Features

### 📡 **Remote Spy**
- Real-time FireServer logging
- Real-time InvokeServer logging
- Argument formatting & display
- Filter by name
- Filter by damage-related
- Filter by weapon-related
- Export logs to clipboard
- Live log display (last 10)

### 🔍 **Explorer**
- Scan all RemoteEvents
- Scan all RemoteFunctions
- List with full paths
- Copy paths to clipboard
- Quick access paths

### 💻 **Scripts**
- Scan LocalScripts
- Scan ModuleScripts
- Find weapon scripts
- Decompiler support
- Copy decompiled code

### ⚙️ **Settings**
- Load Dex Explorer
- Load Simple Spy
- Theme manager
- Config save/load

---

## 🎮 **Compatibility**

### ✅ **Works On:**
- Casual games without anti-cheat
- Older Roblox games
- Your own games (testing)
- Private servers

### ❌ **Doesn't Work On:**
- Games with metamethod protection
- Server-sided games
- Games with strong anti-cheat
- FPS games with hit detection protection

### 📊 **Tested Games:**
| Game | Status | Notes |
|------|--------|-------|
| [UPDATE 1] SATU TEMBAKAN | ❌ Failed | COREGUN script errors |
| Arsenal | ⚠️ Risky | May get kicked |
| Phantom Forces | ❌ Failed | Anti-cheat detected |
| Casual Simulator Games | ✅ Works | No issues |

---

## 📥 **Installation**

### Method 1: Loadstring (GitHub)
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/RanZx999/RanZx999-ESP-Hub/main/RemoteSpy_LinoriaLib.lua'))()
```

### Method 2: Direct Execute
1. Download `RemoteSpy_LinoriaLib.lua`
2. Copy all content
3. Paste in executor
4. Execute

---

## 🎯 **Usage**

### First Time Setup
1. Execute the script
2. Wait for UI to load (5-10 seconds)
3. Press **Right CTRL** to toggle UI
4. Enable "Enable Remote Spy"

### Finding Exploits
1. **Tab: Remote Spy** → Enable spy
2. Play the game normally
3. Shoot, damage, interact with game
4. Watch logs appear in real-time
5. Click "Export Logs" to copy all data
6. Analyze logs for patterns

### Scanning Game
1. **Tab: Explorer** → Click "Scan Game for Remotes"
2. Click "List All RemoteEvents"
3. Data auto-copies to clipboard
4. Paste in notepad and analyze

### Decompiling Scripts
1. **Tab: Scripts** → Click "Scan for LocalScripts"
2. Enter script name (e.g., "GunScript")
3. Click "Decompile Script"
4. Code auto-copies to clipboard

---

## ⚙️ **Configuration**

### Remote Spy Settings
```lua
Enable Remote Spy: ON/OFF
Log FireServer: ON/OFF
Log InvokeServer: ON/OFF
Filter by Name: [text input]
Filter Damage-related: ON/OFF
Filter Weapon-related: ON/OFF
```

### Filters
- **Name Filter**: Only show remotes matching name
- **Damage Filter**: Only show Damage/Hit/Kill/Hurt
- **Weapon Filter**: Only show Gun/Weapon/Shoot/Fire

---

## 🎹 **Controls**

| Key | Action |
|-----|--------|
| **Right CTRL** | Toggle UI |
| **Click & Drag** | Move UI |
| **Double-click Unload** | Close script |

---

## ⚠️ **Warnings & Limitations**

### ⚠️ **Use at Your Own Risk!**
- This script uses **metamethod hooks**
- May trigger **anti-cheat detection**
- Can cause **script errors** in protected games
- May result in **kicks or bans**

### 🚫 **Known Limitations:**
- Doesn't work in heavily protected games
- LinoriaLib may fail to load on some executors
- Real-time logging can cause lag
- Metamethod hooks conflict with game scripts

### 💡 **Tips:**
- Test in private servers first
- Use on alt accounts
- Don't use in competitive games
- Switch to `GameExplorer_Safe.lua` for protected games

---

## 🐛 **Troubleshooting**

### Error: "ATTEMPT TO CALL A NIL VALUE"
**Cause:** Game script conflict or anti-cheat  
**Solution:** Use `GameExplorer_Safe.lua` instead

### Error: "Failed to load LinoriaLib"
**Cause:** Executor doesn't support library or internet issue  
**Solution:** Check executor compatibility or internet

### UI Not Showing
**Cause:** UI loaded off-screen or library failed  
**Solution:** Press Right CTRL or rejoin game

### No Logs Appearing
**Cause:** Anti-cheat blocking hooks or no remotes fired  
**Solution:** Verify "Enable Remote Spy" is ON, or game uses different system

---

## 📝 **Changelog**

### Version 1.0 (DEPRECATED)
- Initial release
- Real-time remote logging
- LinoriaLib UI
- Script scanner
- Decompiler support
- **DEPRECATED** due to anti-cheat issues

---

## 🤝 **Recommended Alternative**

**Use GameExplorer_Safe.lua instead!**

### Why Switch?
- ✅ No metamethod hooks
- ✅ No anti-cheat detection
- ✅ Works on all games
- ✅ Fluent UI (better compatibility)
- ✅ No errors or crashes

**Link:** [GameExplorer_Safe.lua](GameExplorer_Safe.lua)

---

## 👥 **Credits**

**Created by:** [Mahatma Arangga](https://github.com/ranzxx999) (RanZx999)

**UI Library:** [LinoriaLib by violin-suzutsuki](https://github.com/violin-suzutsuki/LinoriaLib)

**Special Thanks:**
- Roblox scripting community
- LinoriaLib developers
- Beta testers

---

## 📜 **License**

This project is licensed under the MIT License.

---

## ⚠️ **Disclaimer**

**IMPORTANT NOTICE:**

This script is for **educational purposes only**. 

- ⚠️ **DEPRECATED** - Not recommended for use
- ⚠️ Use at your own risk
- ⚠️ May violate Roblox ToS
- ⚠️ Can result in account termination
- ⚠️ We are not responsible for any bans

**Use the safe alternative: GameExplorer_Safe.lua**

---

<div align="center">

**Made with ❤️ by Mahatma Arangga (RanZx999)**

⚠️ **This version is DEPRECATED - Use GameExplorer_Safe.lua!** ⚠️

[⬆ Back to Top](#-ranzx999-remote-spy)

</div>

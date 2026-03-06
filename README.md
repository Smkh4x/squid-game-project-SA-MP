# SMK Squid Game SA-MP Filter Script

This is a **Squid Game inspired filter script** for **SA-MP**, developed in PAWN.  
It allows you to create and manage **custom game rooms**, control player positions, and manage game events.

## Features

- **Custom Squid Game Rooms** – Easily teleport to different rooms using `/gotoco` or `/gotocordones`.  
- **Coordinate-Based Teleportation** – `/gotocordones` lets you teleport to exact coordinates from the script.  
- **Timer System** – Automated game timers for each round or challenge.  
- **Object Management** – Uses the Streamer plugin to handle map objects efficiently.  
- **Dev SMK Style Header** – ASCII art headers for script readability and style.  

## Commands

- `/gotoco [room_id]` – Teleport to a predefined Squid Game room.  
- `/gotocordones [x] [y] [z]` – Teleport to exact coordinates stored in the filter script.

## add this in your game mode example : (roleplay.pwn)

// Squid Game Timer Variables
new squidGameTimer = -1;
new squidGameTime = 0;
new squidGameActive = 0;
new Text:squidGameDisplay = Text:INVALID_TEXT_DRAW;
//new Text: squidGameDisplay[2];

// Squid Game Music URL
#define SQUID_GAME_MUSIC_URL "http://l.top4top.io/m_3670294cq0.mp3"

// in public OnGameModeInit()

	// Create TextDraw for Squid Game Timer
	squidGameDisplay = TextDrawCreate(266.000, 44.000, "00:00");
	TextDrawFont(squidGameDisplay, 2);
	TextDrawLetterSize(squidGameDisplay, 0.530, 2.300);
	TextDrawColor(squidGameDisplay, 0xFF0000FF);
	TextDrawAlignment(squidGameDisplay, 1);
	TextDrawSetShadow(squidGameDisplay, 2);
	TextDrawSetOutline(squidGameDisplay, 1);
	TextDrawBackgroundColor(squidGameDisplay, 0);

// ============= SQUID GAME TIMER SYSTEM =============

// Squid Game Timer Callback
public UpdateSquidGameTimer()
{
	if(!squidGameActive) return;
	
	if(squidGameTime > 0)
	{
		squidGameTime--;
		
		new minutes = squidGameTime / 60;
		new seconds = squidGameTime % 60;
		new timeStr[10];
		format(timeStr, sizeof(timeStr), "%02d:%02d", minutes, seconds);
		
		TextDrawSetString(squidGameDisplay, timeStr);
		
		// Change color based on time remaining
		if(squidGameTime <= 10)
		{
			TextDrawColor(squidGameDisplay, 0xFF0000FF); // Red for last 10 seconds
		}
		else if(squidGameTime <= 30)
		{
			TextDrawColor(squidGameDisplay, 0xFFFF00FF); // Yellow for last 30 seconds
		}
	}
	else
	{
		// Timer finished
		squidGameActive = 0;
		if(squidGameTimer != -1)
		{
			KillTimer(squidGameTimer);
			squidGameTimer = -1;
		}
		TextDrawHideForAll(squidGameDisplay);
		
		// Play end sound for all players
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0); // Timer end sound
			}
		}
		
		SendClientMessageToAll(0xFFFF00FF, "Squid Game timer finished!");
	}
}

// Squid Game Start Command
CMD:startsquidgame(playerid, params[])
{
	// Check if admin or condition
	if(squidGameActive)
	{
		SendClientMessage(playerid, 0xFF0000FF, "Squid Game is already running!");
		return 1;
	}
	
	// Set game parameters (you can modify these values)
	squidGameTime = 150; // 5 minutes (300 seconds)
	squidGameActive = 1;
	
	// Show timer for all players
	TextDrawShowForAll(squidGameDisplay);
	
	// Start the timer (update every 1000ms = 1 second)
	if(squidGameTimer != -1)
	{
		KillTimer(squidGameTimer);
	}
	squidGameTimer = SetTimer("UpdateSquidGameTimer", 1000, 1);
	
	// Play sound effect for all players (game start sound)
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0); // Squid game start sound
			PlayAudioStreamForPlayer(i, SQUID_GAME_MUSIC_URL); // Play MP3 music
		}
	}
	
	// Send message to all players
	new msg[128];
	format(msg, sizeof(msg), "Squid Game Started! Timer: %d seconds", squidGameTime);
	SendClientMessageToAll(0x00FF00FF, msg);
	
	return 1;
}

CMD:stopsquidgame(playerid, params[])
{
	if(!squidGameActive)
	{
		SendClientMessage(playerid, 0xFF0000FF, "Squid Game is not running!");
		return 1;
	}
	
	// Stop the game
	squidGameActive = 0;
	if(squidGameTimer != -1)
	{
		KillTimer(squidGameTimer);
		squidGameTimer = -1;
	}
	TextDrawHideForAll(squidGameDisplay);
	
	// Stop music for all players
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			StopAudioStreamForPlayer(i);
		}
	}
	
	SendClientMessageToAll(0xFFFF00FF, "Squid Game has been stopped!");
	
	return 1;
}

## Installation

1. Clone the repository:  
```bash
git clone https://github.com/Smkh4x/squid-game-project-SA-MP.git

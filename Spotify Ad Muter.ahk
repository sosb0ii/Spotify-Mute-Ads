#Persistent
Loop
{
	if (WinExist("ahk_exe Spotify.exe")) ;only runs when spotify is open
	{
		WinGetTitle, Playing, ahk_exe Spotify.exe ;obtains current song
		while (!InStr(Playing," - ") and Playing !== "Spotify Free") ;not song, not paused
		{
			SoundSet, 1,, Mute ;mute the sound
			WinGetTitle, Playing, ahk_exe Spotify.exe ;checks again
		}
		Soundset, 0,, Mute ;unmute the sound
		;Sleep, 2000 ;waits 2 sec to check song
	}
	Else Sleep, 60000 ;waits 60 sec to check spotify	
}
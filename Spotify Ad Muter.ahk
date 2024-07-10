PlayingEarlier:=""
Loop
{
	if (WinExist("ahk_exe Spotify.exe")) ;only runs when spotify is open
	{
		WinGetTitle, Playing, ahk_exe Spotify.exe ;obtains current song
		if (Playing !== PlayingEarlier and Playing !== "Spotify Free") ;new song
		{
			if (!InStr(Playing," - ") and !InStr(Playing, "|")) ;not song or pod
			{
				SoundSet, 1,, Mute ;mute the sound
				;FileAppend, %Playing%`n, Ads.txt ;records as ad
			}
			else
			{
				SoundSet, 0,, Mute ;unmute if song or pod
				;FileAppend, %Playing%`n, SongsPods.txt
			}
			PlayingEarlier:=Playing ;redefines previous song
		}
	}
	else Sleep 30000 ;waits 30 sec to check Spotify
}
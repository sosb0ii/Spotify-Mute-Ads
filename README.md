
# Spotify Ad Muter (Desktop)

This program will mute unskippable ads (or commercials) on Spotify. It is intended for the peace of mind of Spotify Free users who can use the Desktop app.

## Installation Guide

This script uses AutoHotkey v1.1, and as such requires the AutoHotkey software, which can be installed from their website. The most updated release can be downloaded directly by clicking [here](https://www.autohotkey.com/download/ahk-install.exe). A version for AutoHotkey v2 may or may not be added as a separate branch in the future. It works only on the Spotify desktop app (which can be installed [here](https://www.spotify.com/de-en/download/other/)), *not* on the website. When these are installed, the `Spotify Ad Muter.ahk` file above can be run from any directory while Spotify is open to mute the Ads.

## Functionality

This script will first check to see if Spotify is running or not. If not, it will wait one minute before checking again. If Spotify is running, it will retrieve the title of the Spotify window. If the current title is different from the last title (initially set to a blank string, and subsequently reset for new songs) and also not the `Spotify Free` title which occurs when it is paused, then a new audio is playing.  
When a new audio begins playing, the script checks if the ` - ` string (present in the `Artist - Song` format when a song is playing) or the `|` character (present in many podcast titles) is in the name of the window. If neither is present, an advertisement is playing, and the system sound is muted. If one or both strings are present, then a song or podcase is playing, and the sound is unmuted.  
In this way, the script will always and only perform an action when a new audio starts. 


## Optimization

In order to minimize processing power, when Spotify is not open, the script waits 30 seconds before checking again if it's open. This way, the script can be running when Spotify is not, without continuously looping and checking things. As long as you don't get an ad within 30 seconds of opening the app, it will work fine.  
If you wish to further minimize processing power (for whatever reason) you can extend this delay (in line 22) by altering the time (in milliseconds) of the delay. Of course you can also add a delay anywhere you want, but you might compromise the effectiveness of the script.  
If you have no concern for minimizing processing power and want to ensure absolute effectiveness of the script, you can comment out (put a semicolon in front of) line 22 or remove it entirely.

## Customization

In the near future, a feature will be added for podcast users to help the script identify podcast episodes. To keep a list of episode titles, uncomment lines 12 and 17. Those mistakenly detected as ads will be in a file called `Ads.txt` and the others will be in a file called `SongsPods.txt`, all in the same directory.

## Issues and Potential Fixes

> [!NOTE]
> The below information is out of date. It will be updated soon.

- Podcasts do not have the " - " syntax present in the window title, and will be muted.
	- While the " - " isn't going to work most of the time, you might find another string, such as "|" that your podcasts use, and add it to line 6 like so:  
`while (!InStr(Playing," - ") and !InStr(Playing,"|") and Playing !== "Spotify Free")`  
	- However, this will get cluttered fast. Maybe a RegExMatch would work better.
- If an advertisement contains the " - " string in its sponsorship message, it will not be muted (and cannot be muted). This has not been observed yet, however.
	- I really don't think this will be a problem, but if it happens once, it can easily be countered with a statement like `or Playing = "Try now, it's free!"` put in the `while ()` condition.
	- I'll add a script that will put the name of every new Spotify window title in a .txt file, to easily view the names of any problematic advertisements or podcasts.
 - If the computer is muted by choice by the user, it will be immediately unmuted when a song is playing, or even paused.
	- This could be annoying if Spotify is paused and you need to turn off sound from another app in a pinch. I'll have to fix it by only unmuting once when the ad is detected.
 - If the computer is unmuted by the user during an advertisement (or podcast), it will be immediately muted by the program.
	- I think it doesn't matter for ads, but it's obviously a big deal for podcasts at the moment. However, it's an easy fix by expanding the single `while ()` loop into a few more expressions to mute once.
 - When the program mutes an advertisement as desired, it also mutes other sounds on the computer, which is unideal for background music.
	- This ones a bit more tricky. Perhaps the `SoundSet` command could somehow only target Spotify's sound.
 - When the program unmutes after an advertisement, the last bit of the ad is still heard.
	- This can be fixed with a `Sleep` command, although the timing may differ among users.
 - Sometimes, the contents of an ad are skipped halfway or entirely when muted by the program. It displays "Can't play the current song" in a floating white tag over the play bar at the bottom.
	- Not really an issue; this is great. If someone figures out why, perhaps a rudimentary ad skipper can be made.

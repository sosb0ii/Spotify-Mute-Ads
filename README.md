
# Spotify Ad Muter (Desktop)

For those who use Spotify Free on Desktop, it may be desired to mute the unskippable ads whenever they come up until they have passed. This repository contains a file that will do exactly that with AutoHotkey.

### Requirements and Application

This script uses AutoHotkey v1.1, and as such requires the AutoHotkey software. A version for AutoHotkey v2 may or may not be added as a separate branch in the future. It works only on the Spotify desktop app, *not* on the website.

## Installation Guide

For those who do not already have AHK v1.1 and the Spotify desktop app, they should be installed first. Then, the .ahk file above can be downloaded and run from any directory on the computer.

### Functionality

This script will first check to see if Spotify is running or not. If not, it will wait one minute before checking again. If Spotify is running, it will retrieve the title of the Spotify window. This title will follow the "Artist - Song" format when a song is playing, or "Spotify Free" when nothing is playing. When an advertisement is playing, the title will often be "Advertisement" or "Spotify", but occasionally contains a different message from the advertiser.  
For this reason, the method of checking whether or not an advertisement is playing is by looking for the string " - " in the title and checking if the title is "Spotify Free" (content is paused). If both conditions are false, it assumes that an advertisement is playing, and mutes the system sound. It will continue to check the title of the window and mute the system sound until a song begins playing (" - " occurs in the window title) or the content is paused (title is "Spotify Free"). When either of those conditions become true, the script unmutes the sound and waits 2 seconds to check the title again.

### Optimization

In order to minimize processing power, a 60 second delay will continually check if the Spotify app has been opened when it is not already open. This way, the script can be running when Spotify is not, without continuously looping and checking things. As long as you don't get an ad within 60 seconds of opening the app, it will work fine.  
If you wish to further minimize processing power (for whatever reason) you can uncomment the delay in line 12 (remove the semicolon). This will add a delay to checking for ads, so you might hear the first second or two of the advertisement.

### Issues and Potential Fixes

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
# SchoolTools
### By Nerdiest
#### _Because personalization shouldn't be blocked_
> Note: You are currently viewing the testing branch. Expect bugs if ran!
## About

SchoolTools is an app built in PowerShell aiming to allow the user to change between light and dark mode, as well as change the wallpaper.

The app gets past school-set restrictions on Windows-based school assigned devices. Ever notice how some options on the settings menu are blocked? This app aims to be a replacement to these blocked settings.
## How it's done
### Dark/Light mode
The switch is done relatively simply. The app edits 2 registry keys, `SystemUsesLightTheme` and `AppsUseLightTheme`. These will be set to `1` for light mode and `0` for dark mode. After, it restarts explorer.exe.
> Note: These keys are edited locally, and won't affect other users.
### Transparency Effects
Pretty much the same as the dark/light mode system, however we now edit the `EnableTransparency` registry key.
> Note: Same as the dark/light mode keys, these are edited on the user-side, and new users of the system will not see these changes.
### Wallpaper Switch
This one is a lot more complicated. If you choose one of the default wallpapers, then they will be set from the apps files. Otherwise, you can choose your own. The app copies the file to `APPDATA\Microsoft\Windows\Themes\` and renames it to `TranscodedWallpaper`, which overrides your image data for the current wallpaper. After, it restarts explorer.exe to show your changes.
> Note: If your device changes screen orientation from landscape to portrait, your wallpaper will be reset and you will have to use the app again to fix it. We are working on a fix to this now.
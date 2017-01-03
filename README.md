# MenuBarDnD

MenuBarDnD is a menubar application that toggles Do Not Disturb(DnD) on your Mac. DnD is a useful, but horribly underused feature in MacOS because the shortcut and toggle are somewhat hidden.

## Installation
MenuBarDnD can be installed with Homebrew using the following commands.  
`
brew tap alexzye/mbdnd  
brew cask install menubardnd  
`  

## Usage
The application is activated by simply clicking on the menubar icon.  
![deactivated](/img/deactivated.png)

*Notice that the color of the notification center gives you the status of your Do Not Disturb.*

Clicking the menubar icon again will toggle it back to the inital state.
![activated](/img/activated.png)

Right-clicking the menubar icon will open a menu where you can toggle or quit the application.  

## Known Issues
- Do Not Disturb gets automatically turned off at midnight. MenuBarDnD does not currently deal with it at all.
- Do Not Disturb settings like setting up custom DnD schedules are not supported either.

These issues are here partly because Apple hasn't realsed any public API to the Do Not Disturb feature. I will be looking for workarounds to hopefully fix these issues.

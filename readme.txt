This is an addon designed to almost completely replace your mouse and keyboard with your Xbox 360 controller and many other gamepads/joysticks. With some patience and practice you can raid and PvP with it. It is built for total character control using the maximum amount of buttons available for the quickest reflexes possible, so its prepared to play any casual or end-game role right away. Its free and still manages to have more functionality than Pinnacle Game Profiler or Switchblade.

To Install -

1 Install the Addon in your /interface/addons folder.

2 'http://glovepie.org/poiuytrewq.php'GlovePIE by Carl Kenner is required for the PIE files to set the controls. Run GlovePIE (on vista you need admin access so it can send keys to fullscreen programs) and open a .PIE file located in the interface/addons/Soulbound360 directory: 

S360DirectX.pie will work with the normal DirectX plug and play driver. Pet controls are not set in this configuration.
S360DirectXPet.pie is for Hunters/Warlocks with the normal driver. Party member and some targeting functions are not set in this configuration.
S360Morii.pie is for 'http://translate.google.com/translate?js=y&prev=_t&hl=en&ie=UTF-8&layout=1&eotf=1&u=http://www.katch.ne.jp/~morii/&sl=auto&tl=en The Unofficial Xbox 360 Controller Driver by Morii. All controls are available and you can use the Middle X button. This file will do nothing unless you have installed Morii's driver.


All of the files work with Morii's driver. Open the file you want and click RUN. You can also click the [.] on the menu so that the window minimizes to your system tray.

3 Run the game and type /s360 to enable or disable the hover icon.

Then just grab your controller. Other controllers similar to the Xbox 360 controller or even generic gamepads and joysticks might also work as well. NOTE! You no longer need to reset your bindings to default.

If your using the plug and play DirectX driver and the mouse cursor doesn't move after you run the GlovePie script and press the Right thumb stick, make sure you've installed the 'http://www.microsoft.com/hardware/download/download.aspx?category=gaming' Xbox 360 Accessories software.

Morii's driver installation instructions

This is an optional step but you get a lot more buttons from it and a very detailed configuration page in the Game Controllers control panel. First 'http://translate.google.com/translate?js=y&prev=_t&hl=en&ie=UTF-8&layout=1&eotf=1&u=http://www.katch.ne.jp/~morii/&sl=auto&tl=en' download the proper driver for your pad and os from this link. Then-

1. Go to Control Panel -> Hardware and Sound -> Device Manager 
2. When User Account Control shows up click "Continue"
3. Under the "Human Interface Devices" tree, find "Microsoft Xbox 360 Controller". Right click and select Update Driver Software
4. Update Driver Software window appears, select Browse my computer for driver software
5. On the next screen select "Let me pick from a list of drivers"
6. At select driver click "Have Disk"
7. "Install From Disk" appears, click Browse.
8. Choose the INF file in the folder that you unzipped to and hit open
09. Then hit OK
10. Drops back to "Update Driver Software", from there go to "Next" 
11. "Windows Security" will pop up, hit Next.
12. Finally it should say updated driver software successfully, just hit close

When you first install the driver sometimes the calibration is wonky on the analog sticks. If this happens, rename \Windows\System32\x360cps.dll to \Windows\System32\x360cps.bak and calibrate it in the 'Game Controllers' control panel. Don't forget to rename the dll file back when its done! 

When its installed, you'll have to change the 'Xbox Guilde Button' to Button13 in Game Controllers -> Properties -> Buttons tab. In the Triggers tab, change the Z axis to Button 11 and 12 as well. When you start GlovePIE, you can run any PIE file you want, but the S360Morii file will give you the most buttons. Its a bit of a hassle but you have an extra 15 controls from it, and the calibration is much smoother. You also won't have to reload the pie files for pet classes. 


To Use

Hover over the icon and press buttons or combination of buttons on the controller. While the mouse hovers over the icon, the screen will display the actions assigned to the buttons you press. This will help you get a 'feel' for your controls, and help you learn the bindings. If you practice and memorize the abilities as displayed while on the icon you will find it a much easier transition from keyboard and mouse to your controller. Your keyboard and mouse are also not disabled so you can switch back to type or navigate at any time, though you'll have to move the mouse off the icon first.

Every configuration uses all of the top buttons and thumb stick buttons to trigger actions. The 4 primary D-Pad directions are also assigned buttons. The thumb sticks control movement by default. The left shoulder and trigger are assigned to left/right mouse clicks. The right trigger is a button modifier, allowing a second set of keys when pressed together with another. Pressing both right shoulders is jump.

In the DirectX configs the right shoulder is a second modifier. In Morii's configuration, this button is target instead and the Middle X is the second modifier that can combine with the right trigger as well to add a third modifier and even more possible combinations. Unassigned combinations will display as not assigned when pressing them while over the icon. You can keybind these to auras or totems or whatever you like. You can also create /cast macros for functions not assigned if you have a lot or you'd rather stick them on your action bar.

On installation, the buttons are mapped to WoW's default keys. If you want to change what the buttons do in Key Bindings, make sure you go to the addon configuration options and check enable user defined keys, or they won't set. 

To access more than the first twelve actions on the main action bar, hold the right trigger down and press one of the first 6 action buttons. Swapping between action bars is very fast this way and with some practice it can become second nature.

If you're a healer, you should also try the party targeting buttons. They will make your life a lot easier than mousing everything with the joystick. However in raid situations you'll want to continue using healbot or grid, since the party targeting buttons only target your current party.

You can now edit the raw PIE files easily as well. Press STOP to cease running the file, then edit one of the table entries for calibration, joystick axis, or joystick assignment for mouse & movement.

Why Its Nice

 more buttons
 its simple to install
 its set up to play immediately, without having to install and then set every button
 the addon simplifies learning and changing bindings
 its made from an end-game perspective, not casual and 'maybe' it works for other things
 its free




v0.4
* Enable User Bindings allows default binds to be individually overwritten in Key Bindings

v0.39
* Added RT as SHIFT for quick item comparisons
* Mouse is now far more responsive and accurate at lower thresholds
* Mouse deadzone is fixed for DirectX config
* Autorun/Follow working as intended
v0.38 
* Spacebar sticking gets fixed and PIE file easier to edit
v0.37
* PIE files corrected for mouse clicking&dragging;, shift-clicking, autorun, jump, and attack toggle functions
v0.36
* PIE file debugging for follow/autorun
* General cleaning up of code
* Easier to edit for joystick assignment and calibration
* Added reset position and attributes for icon
* SHIFT-L and CTRL-SHIFT-L are now SHIFT-Comma and CTRL-SHIFT-Comma due to B bound as default for quest log
v0.35
* Bindings can be changed
* Configuration options panel
v0.33
* No longer requires keybindings to be reset to default
* Fixed issue with right shoulder and right click disengaging.
v0.32
* Fixed sticky right mouse button when right shoulder active
* Remembered to change toc version this time
v0.31
* Now works with default DirectX driver
* Multiple configurations supporting both available drivers
* Fixed conflicting mouse combinations
* Shrunk the icon image; zip is down to 33KB
* Detects Scroll Wheel directions.
* Changed TOGGLE FOLLOW key to ` to avoid CTRL modifier conflicts. Not mapped by default in WoW * keybindings.
* Tested sucessfully on two Vista PCs, one with Morii driver and one with DirectX
Focus Target now shows up properly as Focus Target, not Pet Attack
v0.2a
* Addon created (WoWUIDesigner FTW)
* Created icon
* Mousing over icon shows button presses
* Fixed some mouse issues problems in the script
* Screenshot
* Yup I think thats all I did
v0.11
* Just the script
* Middle X functioning as modifier for slightly less important functions than easier-to-press Right Trigger
* Tested successfully in WotLK
* Stopped Left Thumb Y motion from eating W/S keyboard keys, so if you panic and revert to keyboard you still have control


Known Issues

Stuff I can probably fix

DirectX won't Force Feedback on action bar switch.


Stuff I probably can't fix
Can't type (no chatpad support)
Hard learning curve; get wtfpwnt bad for a month

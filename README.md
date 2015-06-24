# WarriorHUD
This World of Warcraft AddOn is a HUD(Head-up-Display) created exclusively for Warriors. It will display all important Cooldowns, your Rage and Alert you in certain Situations.


# Changelog

2.2 (11. January 2015)
- fixed the glowing of overpower if not in correct stance
- increased the glowing animation from 0.04 to 0.01 (updatetime)

2.1 (10. January 2015)
- reverted a small change so that the AddOn only loads on warriors
- major changes in the glow code eg.
- switched from "UPDATE_SHAPESHIFT_FORMS" to "UPDATE_BONUS_ACTIONBAR" for show/hiding glows on stancedance
- WHUD_GLOWING variable will now save the glow frames as well
- implemented Numielle's ActionBarGlow port
- fixed moving frames by typing coords in the options UI
- fixed an error inside the old whud command section
- added the Cooldowns-Racials variable and options for it(and trinkets) to hide/show racial/trinket cds via option UI
- Enhanced Alerts frame, there are now up to 3 alert lines which work like SCT if multiple alerts are firing at the same time

2.0 (6. January 2015)
- added a timer to the Cooldown Alert
- fixed &amp;amp; cleaned up some code parts
- reworked the "editmode"
- added the options UI
- the old chat commands are now usable with /whudold
- added the button glow
- (maybe I forgot to document some changes due to my break)

1.8 (30. July 2014)
- added the event "PLAYER_DEAD" to hide the Ragebar if the player died
- fixed the chatcommand to disable/enable fading
- Overpower/Revenge/Shield Bash/Pummel will now only get triggered by the combatlog - therefor their names are removed from WHUD_IMPORTANTSPELLS
- excluded the Shine until it's working 100% bug-free
- included the Cooldown Clock animation instead of the shine
- if Overpower is usable but it's still on CD the Overpower alert will now have: 60% Alpha and if you're using the text mode the color is darker as well

1.7 (28. July 2014)
- fixed chat command for CD trinkets&amp;amp;fadein
- changed fadeout option to fadein
- the overpower alert will disappear after you've used Overpower
- added few other alerts like Battle Shout/Salvation/Weightstones
- shorten &amp;amp; cleaned a lot of code esp. in frame creation, resetting and setting
- added Racial 'Perception' (Human)

1.6 (20. July 2014)
- implemented Trinket CD compatibility (yay!)
- quick hotfix for CDslot 4-6 to not display CDs twice
- quick hotfix for Cooldowns seperation of Pummel/Shield Bash
- (overpower alert) lowered the icon mode - icon from 75x75 to 65x65
- (overpower alert) default timer color is now yellow, it turns red when it's 1 or less seconds
- (overpower alert) fixed an issue at switching between both modes when the other timer didn't hide

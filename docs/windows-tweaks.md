# Tweak Windows for a better user experience

### Run the Windows 10 Debloater

To easily remove much of the pre-packaged bloatware in Windows 10, you can use
[this debloating script](https://github.com/Sycnex/Windows10Debloater). A full
guide to using the script can be found in the repo, but if you're unsure, you
can't go wrong with the GUI. Except maybe bricking your system. Probably not
though.


### Disable UAC

Although often controversial, no one really likes UAC. Don't lie, you always
just click allow anyway, so you might as well save yourself the trouble and
disable it altogether. This can be done through the Control Panel, under
*User Account and Family Safety -> User Accounts -> Change User Account Control
settings*, by dragging the slider to the bottom ('Never notify').


### Clean up the Taskbar

The taskbar serves very little purpose on a virtual machine, so it's
recommended to clean it up a bit (read: almost completely). To do this, open
Settings and navigate to *Taskbar -> Turn System Icons On and Off*.


### Hide the Recycle Bin Icon from the Desktop

If you're using the remote mounted host filesytem (and you should be), the
Windows recycle bin serves little purpose and blocks out some of the wallpaper,
which should be appreciated in its full glory. To disable it, open Settings and
navigate to *Personalization -> Themes, Desktop Icon Settings* and disable it
from there.


### Disable Notifications

A desktop operating system should not need notifications. If you feel you need
to be notified the instant someone wants to contact you, buy a phone.
Notifications should be disabled through *Settings -> System -> Notifications
& actions*, and toggling the switch under 'Get notifications from apps and
other senders' to the off position.


### Disable Action Center

Following on from the previous point, the quick settings do not belong in a
notification center. That is what the taskbar is for. The cloest way to disable
this particular piece of bloat by ensuring the 'Action Center' taskbar icon is
disabled, and then make sure to ignore its existence. Unfortunately Windows
does not currently allow users to completely disable the Action Center, but
consider it out of sight and out of mind.


### Disable Unneeded Startup Programs

Download autoruns from sysinternals [here][autoruns-dl], and use the included
GUI to disable startup programs at your own discretion.


### Set the Holy Wallpaper

Download [this wallpaper][wallpaper-dl] and set it as the desktop picture.
This is a *vital* configuration step.


### Enable 'Ultimate Performance'

To maximise Windows performance, first launch the built-in utility `powercfg`
to enable the 'Ultimate Performance' setting, by running
`powercfg.exe -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61` from an
administrator command prompt. After making the option visible, open Control
Panel and select the option under *Hardware and Sound -> Power Options ->
Choose a power plan*.

Additionally, you can also go to *Settings -> System -> About -> Advanced
system settings -> Performance Options* and select 'Adjust for best
performance'.


### Disable All Telemetry

No explanation needed. Just make your way on over to *Settings -> Privacy* and
go HAM from there. In addition, there are numerous tutorials available online
describing several additional steps to disable Microsoft Telemetry.

In all honesty, the subject of disabling Microsoft telemetry could constitute
and entire document of its own, and this section should, at some point in the
future, be updated with a more detailed guide.


### Disable Search Indexing

To disable Windows search indexing, and stop the service regularly consuming
valuable resources, run `services.msc` and locate the 'Windows Search' service.
Double click the service, and under the drop-down menu entitled 'startup type',
select 'Disable'.


### Disable Hibernation

Hibernation isn't really needed for a virtual machine, and can be disabled
by running the command `powercfg.exe /hibernate off` as an administrator.


### Disable Visual Effects

We don't need animations or glossy finishes; while these options make for
cool screenshots, they really only make the VM run slower. Disable them under
*Settings -> Ease of Access -> Display -> Simplify and personalise Windows*.


### Disable Lock Screen

A computer does not need a lock screen. It is not a cell phone. Disable the
lock screen (and jump straight to the login prompt) by first opening regedit
and navigating to `HKLM\SOFTWARE\Policies\Microsoft\Windows`. From here, create
a new key called `Personalization`, and give this key a single DWORD called
`NoLockScreen` with the value `0x00000000` (0).


### Disable Swap

Disabling the swapfile (pagefile) is a hotly-debated topic. If you would like
to do it, it can be done by opening *Settings -> System -> About -> Advanced
system settings -> Performance Options -> Advanced -> Virtual memory*,
clicking 'Change' and clicking the checkbox for 'Automatically
manage paging file size for all drives' followed by the radio button for 'No
paging file'. Then click Ok back through all the menus.


This file is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].
See [DOC_LICENSE](../DOC_LICENSE).

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png

[autoruns-dl]: https://docs.microsoft.com/en-us/sysinternals/downloads/autoruns
[wallpaper-dl]: https://i.imgur.com/LwYlpqn.png

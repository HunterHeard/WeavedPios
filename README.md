# WeavedPios
An iPhone app allowing you to control your Raspberry Pi's GPIOs through Weaved and WebioPi on iOS
programmed with Xcode in swift

Basic goals of this project:

1. Allow the user to Log in to Weaved (done)
2. Allow the user to select a Raspberry Pi that has WebIOPi installed on it
3. Allow the user to monitor and control the GPIO pins on the Pi, as long as they are logged in
4. Allow the user to label GPIOs, label their 'high' and 'low' states (so for Water, you could have "flow" and "stop")
5. Allow the user to choose which GPIOs to ignore, so that they aren't cluttered with 16 pins on their app

6. Allow the user to configure notifications, so that they can be notified of a monitor pin moving, even if they are not logged in
7. Allow the user to set pins to be "persistent," which is to say that if the Pi reboots, the pin will set itself to where it was before it rebooted. Or set them to NOT be persistent, and to start off as "off" or "on"
8. Think of a better name than "WeavedPios"



April 21 2016
This version is made in Xcode v 6.2 (6C131e)

faq
"How do I compile this?"
I am not sure how Xcode does project imports. Attempt2.xcodeproj is the project file. You need the 'Attempt2' folder definitely, and 'Attempt2Tests' maybe. So take those three and try opening the project file, or importing it into Xcode.


"What does this do that the official Weaved and WebIOPi apps don't do?"
The notifications, labeling, and persistency should make this a bit more convenient than the official Weaved and WebIOPi apps

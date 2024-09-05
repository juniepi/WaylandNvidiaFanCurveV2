
# Wayland x Nvidia FanCurveV2
**``🌡️🔥 /Basic Information/ ❄️🌡️``**

![example](https://github.com/user-attachments/assets/94031e85-792a-40a1-82f0-0b4a73814763)


Hi Hi ^^ After making the original Wayland Nvidia FanCurve Project it worked fine but i wanted it to be more aesthetically pleasing! So me and some friends including  [Kyle Ouellette](https://github.com/kyouellette) who does amazing work might i add, Came together and spent a couple hours brainstorming ways to make the code easier to manage and pleasing to look at! 

**⚠️ Warning!**

The same warnings still apply as in the original project! 

- Dual GPU can **Possibly** work but i could never recommend it especially with this version!
- No water cooled GPU's this will break your graphics card! No water blocks or AIO coolers!
- NO LAPTOPS
- Make sure your labels(which will be explained later) match up to **YOUR** system!

Make sure you follow these warnings or it could result in GPU Failure!

**🔻 KNOWN ISSUE**

There has been issues in the past regarding this script calling sudo too many times and locking the user from using sudo privileges! This is because of a misconfiguration in the script it's self! Seems as if the fixes I have made to the script has fixed this issue! But if you continue to have the previous mentioned issues please add permission in your sudoers file for your user to be able to access and use nvidia-settings commands without the need for sudo!

To access your sudoers file the command should be!:
```
$ sudo vi
```

Then add this line into the appropriate spot in your file! Remember to change the * to your username:
```
*your username* ALL=(ALL) NOPASSWD: /usr/bin/nvidia-settings
```
This will be what you would add to your sudoers file! Thanks for your understanding



## Getting Started
**``🌱 /Starting Off/Basic info/ 🚀``**

This Project does require some packages most of which you should already have! You will also need a Nvidia Driver that works with nvidia-settings installed! If you do not have a nvidia driver installed, Please check out A1RM4X's [Video](https://www.youtube.com/watch?v=QW2XGMAu6VE) on a Script made by [TKG](https://github.com/Frogging-Family/nvidia-all) This should get you fully setup for nvidia! Some other packages you will need include:

- bash
- nvidia-settings
- dialog

To install these packages use the commands:
```
sudo pacman -S nvida-settings
```
```
sudo pacman -S bash
```
```
sudo pacman -S dialog
```
Now you should be all set for the setup process and install process! 

## Setup & Configuration
**``🛠️ /Configuration/Setup/ 📚``**

To get setup we have to actually get the file! you can either download/copy the file directly into your own computer or you can get it from this github repo by doing:
```
$ git clone https://github.com/juniepi/WaylandNvidiaFanCurveV2
```
Once you have your nfcv2.sh we have to go into the config and edit it to your liking! 

**📑 Configuration**

To configure your file you most open nfcv2.sh into some type of text editor whether that me neovim, vim, nano, or even VsCode!

Once you have opened your nfcv2.sh file into your text editor, You may have noticed that the file has changed a lot from the original version ^^ please remember some nvidia cards don't properly configure fan speeds below 46% speed! For the most stable experience start your fan curve at 46% speed if you dont want a 0% fan speed block!

-

Starting out with your fans
```
set_fan_speed() {
    local temperature=$1

    if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"
        fan_speed=47
    elif ((temperature >= 36 && temperature <= 50)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=50" -a "[fan-1]/GPUTargetFanSpeed=50"
        fan_speed=50
    elif ((temperature >= 51 && temperature <= 63)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=65" -a "[fan-1]/GPUTargetFanSpeed=65"
        fan_speed=65
    elif ((temperature >= 64 && temperature <= 70)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=85" -a "[fan-1]/GPUTargetFanSpeed=85"
        fan_speed=85
    elif ((temperature >= 71 && temperature <= 100)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=100" -a "[fan-1]/GPUTargetFanSpeed=100"
        fan_speed=100
    fi
}
```
This is your fan curve! Right now its set to my settings! All you have to do to set it up to your liking is change all the ranges! the ranges being 
```
if ((temperature >= here && temperature <= here)); then
```
Make sure when doing this whatever number you end with, Make sure the next minimum range is one above the previous max range, That might have been confusing so I'll give an example!

**🗒️ Examples**

So lets use the example 0 and 36, say this is the first curve i have!
```
if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"
        fan_speed=47
```
Now you want to make sure that the max temp which is labeled as "<=", Make sure that your next nodes minimum is one above the previous maximums 
```
elif ((temperature >= 36 && temperature <= 50)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=50" -a "[fan-1]/GPUTargetFanSpeed=50"
        fan_speed=50
```
This is what your next node should look like! Pretty simple right! So altogether it should look like this : 
```
if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"
        fan_speed=47
    elif ((temperature >= 36 && temperature <= 50)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=50" -a "[fan-1]/GPUTargetFanSpeed=50"
        fan_speed=50
```
Boom now you have a properly configured temperature range! But wait what about the fans? All you have to do to change fan speeds for these temperature ranges in a node is changing [fan-0] and [fan-1] GPUTargetFanSpeed= , To whatever speed you want in the prevous set range of temperatures, Then finally you want to set fan_speed= to the same speeds you sat [fan-0] and [fan-1]!
```
if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"
        fan_speed=47
```
So if you wanted to change your fan speeds for this first temperature range you would change:
```
"[fan-0]/GPUTargetFanSpeed=47" "[fan-1]/GPUTargetFanSpeed=47" and fan_speed=47
```
to whatever number you want! And then just go down the line of the different ranges! 

**🚧 Important Notes**

Make Sure that you're only changing the variable for temperature ranges and speeds in this section of code!!!
```
set_fan_speed() {
    local temperature=$1

    if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"
        fan_speed=47
    elif ((temperature >= 36 && temperature <= 50)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=50" -a "[fan-1]/GPUTargetFanSpeed=50"
        fan_speed=50
    elif ((temperature >= 51 && temperature <= 63)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=65" -a "[fan-1]/GPUTargetFanSpeed=65"
        fan_speed=65
    elif ((temperature >= 64 && temperature <= 70)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=85" -a "[fan-1]/GPUTargetFanSpeed=85"
        fan_speed=85
    elif ((temperature >= 71 && temperature <= 100)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=100" -a "[fan-1]/GPUTargetFanSpeed=100"
        fan_speed=100
    fi
}
```
changing anything else outside of this section regarding fan_speed and temperature will break the program!!

Another important note to have is there are issues where some GPU's fans dont consistently spin unless their fan_speed is set to 47 and above so take this into consideration! 

**⏱️ Setting Up Update timer**

This is probably the easiest thing you'll do throughout this entire guide! The update timer basically is just how long until you want your script to scan your GPU's temp and adjust the fans! it should be located as sleep in the script and its found here in the code near the very bottom:
```
    tput clear
    
    
    echo "╔═══════════════════════════╗"
    echo "  GPU Temperature: $temperature°C   "
    echo "  Fan Speed: $fan_speed%            "
    echo "╚═══════════════════════════╝"

    
    sleep 15 <-- here
done
```
For gaming i would recommend setting this to around 5-8, for productivity i would set it anywhere from 10-30! After you change sleep to whatever number you want! you're done with this step!

**🚧 Final Notes**

Now you should be done configuring your curves that you want and the update timer! Now lets get into the last important part of setting up this program!

## Preparing Labels 
**``📄 /Labels/Important info/ 🛑``**

Now we have to make sure your labels match up! First we have to run some commands to see what your system is labeling your GPU and the fans on your GPU!

**📜 GPU Label**

First lets see what your system labels your GPU usually they should label it 0! but just incase lets make sure!
```
$ nvidia-smi --query-gpu=index --format=csv
```
This should give you back an index and a number! That number is your GPU's Label in your system! By any chance its not labeled 0, go into the nfcv2.sh and change the 0 in [gpu:0] to whatever number that previous command gave you! gpu:0 should be found here in your code:
```
 if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"

```

**📜 Fan Labels**
Now lets move onto fan labels! To check our fan labels we need to run this command:
```
$ nvidia-settings -q fans
```
This command should tell you how many fans that your system environment has labeled! For most people you should see 2 Fans, [fan-0] and [fan-1] This means your good to go! By any chance you have only [fan-0] you need to change these lines of code:
```
  if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"
```
And remove [fan-1]! it should look like this after you're done
```
 if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47"
```
Pretty Simple right! Now if you ran
```
$ nvidia-settings -q fans
```
And you have more than 2 fans, this would be [fan-0] [fan-1] [fan-2] you will have to add [fan-2] to the code it would look something like this:
```
    if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47" -a "[fan-2]/GPUTargetFanSpeed=47"
        fan_speed=47
```
Again pretty simple right! After doing this we should be on our final step!

**Please make sure you make these changes to all lines of code that has to do with setting fan curves! This only includes these line of code:**

```
    if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"
        fan_speed=47
    elif ((temperature >= 36 && temperature <= 50)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=50" -a "[fan-1]/GPUTargetFanSpeed=50"
        fan_speed=50
    elif ((temperature >= 51 && temperature <= 63)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=65" -a "[fan-1]/GPUTargetFanSpeed=65"
        fan_speed=65
    elif ((temperature >= 64 && temperature <= 70)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=85" -a "[fan-1]/GPUTargetFanSpeed=85"
        fan_speed=85
    elif ((temperature >= 71 && temperature <= 100)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=100" -a "[fan-1]/GPUTargetFanSpeed=100"
        fan_speed=100
    fi
```
**This is very important!**


# 🏁 Final Step
**``🚩 /Permissions/ ✔️``**

now for the fated and final step! we have to give nfcv2.sh execution permissions! first what we need to do is cd into where our nfcv2.sh is located! for example:
```
cd /Path/To/Location
```
Once you ls and see your file nfcv2.sh all you have to do is run this command
```
chmod +x nfcv2.sh
```
BOOM now you're done and you script is all setup! Now let me show you how to run it!

# 🎉 Commands & End of Guide
**``🟢 /Start/Stop/ 🔴``**

**Starting Script**

To start this script! you need to be in the same directory as your nfcv2.sh and run this command
```
./nfcv2.sh
```
Now the script should start! You can keep this in the background and it automatically change your fan speeds to the temperatures you set! 

**Stopping Script**

Note that when you stop this script the fans on your GPU will stay set to whatever the script last set them too! To continue adapting your fans speeds, restart the script! The only way i know of completely removing the gpu set speed is restarting your pc! 

-
But to stop the script all you have to do is click in the terminal that the script is running in and press CTRL + C this will stop the script but take mention of the note above! 

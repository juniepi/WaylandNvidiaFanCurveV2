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

Sometimes if your temp doesnt go above the threshold of changing temps by one or two degrees it might not change! So the script could be 1 to 2 degrees off! Keep that in mind! NOTE When your temp goes above a certain point in your fan curve for example if your 36C is 47% fan speed and 37 is 50% fan speed if your temp goes from 36 to 37 your script WILL updates, This only happens when the program doesnt have to actively update your temps! 

![knownissue](https://github.com/user-attachments/assets/b268abd2-bb30-4847-94d3-8b20a8b316f6)


## Getting Started
**``🌱 /Starting Off/Basic info/ 🚀``**

This Project does require some packages most of which you should are have! You will also need some sort of Nvidia Driver installed! If you do not have a nvidia driver install, Please check out A1RM4X's [Video](https://www.youtube.com/watch?v=QW2XGMAu6VE) on a Script made by [TKG](https://github.com/Frogging-Family/nvidia-all) This should get you fully setup for nvidia! Some other packages you will need are

- bash
- nvidia-settings
- dialog

To install these packages its
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

To get setup we have to actually get the file! you can either download/copy the file directly into your own computer/.sh file or you can get it from this github repo by doing
```
$ git clone https://github.com/juniepi/WaylandNvidiaFanCurveV2
```
Once you have your nfcv2.sh we have to go into the config and edit it to your liking! 

**📑 Configuration**

To configure your file you most open nfcv2.sh into some type of text editor whether that me neovim, vim, nano, or even VsCode!

Once you have opened your nfcv2.sh file into your text editor you may have noticed that the file has changed a lot from the original version ^^ Don't worry its actually way easier to setup than last time!

-

Starting out with your fans
```
if ((temperature >= 0 && temperature <= 35)); then
        fan_speed=47
    elif ((temperature >= 36 && temperature <= 50)); then
        fan_speed=50
    elif ((temperature >= 51 && temperature <= 63)); then
        fan_speed=65
    elif ((temperature >= 64 && temperature <= 70)); then
        fan_speed=85
    elif ((temperature >= 71 && temperature <= 100)); then
        fan_speed=100
    fi
```
This is your fan curve! Right now its set to my settings! All you have to do to set it up to your liking is change all the ranges! the ranges being 
```
if ((temperature >= here && temperature <= here)); then
```
Make sure when doing this whatever number you end with,Make sure the next minimum range is one above the previous max range, That might have been confusing so I'll give an example!

**🗒️ Examples**

So lets use the example 0 and 36, say this is the first curve i have because it has 0!
```
if ((temperature >= 0 && temperature <= 35)); then
        fan_speed=47
```
and i want to make my  next fancurve so i would have to make the starting temperature +1 of the previous so the next line would look like:
```
 elif ((temperature >= 36 && temperature <= 50)); then
        fan_speed=50
```
Pretty simple once you have a visual explanation right! so if this was togther in the config it would look like this:
```
if ((temperature >= 0 && temperature <= 35)); then
        fan_speed=47
    elif ((temperature >= 36 && temperature <= 50)); then
        fan_speed=50
```
Boom now you have a properly configured temperature range! But wait what about the fans? Well this is a lot easier than last time! All you have to do to change fan speeds for these temperature ranges is change the fan_speed variable!
```
if ((temperature >= 0 && temperature <= 35)); then
        fan_speed=47
```
So if you wanted to change your fan speeds for this first temperature range you would change:
```
fan_speed=
```
to whatever number you want! And then just go down the line of the different ranges! 

**🚧 Important Notes**

Make Sure that you're only changing the variable for temperature ranges and speeds in this section of code!!!
```
 if ((temperature >= 0 && temperature <= 35)); then
        fan_speed=47
    elif ((temperature >= 36 && temperature <= 50)); then
        fan_speed=50
    elif ((temperature >= 51 && temperature <= 63)); then
        fan_speed=65
    elif ((temperature >= 64 && temperature <= 70)); then
        fan_speed=85
    elif ((temperature >= 71 && temperature <= 100)); then
        fan_speed=100
    fi
```
changing anything else outside of this section regarding fan_speed and temperature will break the program!!

Another important note to have is there are issues where some GPU's fans dont consistently spin unless their fan_speed is set to 47 and above so take this into consideration! 

**⏱️ Setting Up Update timer**

This is probably the easiest thing you'll do throughout this entire guide! The update timer basically is just how long until you want your script to scan you GPU's temp and adjust the fans! it should be located as sleep in the script and its found here in the code near the very bottom:
```
while true; do
    temperature=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)

    # Check if temperature has changed
    if [[ "$temperature" != "$previous_temperature" ]]; then
        set_fan_speed $temperature
        previous_temperature=$temperature
    fi

    sleep 10    #   <-------
done
```
For gaming i would recommend setting this to around 5-8, for productivity i would set it anywhere from 10-30! After you change sleep to whatever number you want! you're done with this step!

**🚧 Final Notes**

Now you should be done configuring your curves that you want and the update timer! Now lets get into the last important part of setting up this program!

## Preparing Labels 
**``📄 /Labels/Important info/ 🛑``**

Now we have to make sure your labels match up! this should be a lot simpler than last time as well! first we have to run some commands to see what your system is labeling your GPU and fans on your GPU!

**📜 GPU Label**

First lets see what your system labels your GPU usually they should label it 0! but just incase lets make sure!
```
$ nvidia-smi --query-gpu=index --format=csv
```
This should give you back an index and a number! That number is your GPU's Label in your system! By any chance its not labeled 0, go into the nfcv2.sh and change the 0 in [gpu:0] to whatever number that previous command gave you! gpu:0 should be found here in your code:
```
 if [[ "$fan_speed" != "$previous_fan_speed" ]]; then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=$fan_speed" -a "[fan-1]/GPUTargetFanSpeed=$fan_speed"
```

**📜 Fan Labels**
Now lets move onto fan labels! To check our fan labels we need to run this command:
```
$ nvidia-settings -q fans
```
This command should tell you how many fans that your system environment has labeled! For most people you should see 2 Fans, [fan:0] and [fan:1] This means your good to go! By any chance you have only [fan:0] you need to change this line of code:
```
 if [[ "$fan_speed" != "$previous_fan_speed" ]]; then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=$fan_speed" -a "[fan-1]/GPUTargetFanSpeed=$fan_speed"
```
And remove [fan-1]! it should look like this after you're done
```
 if [[ "$fan_speed" != "$previous_fan_speed" ]]; then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=$fan_speed"
```
Pretty Simple right! Now if you ran
```
$ nvidia-settings -q fans
```
And you have more than 2 fans, this would be [fan:0] [fan:1] [fan:2] you will have to add [fan:2] to the code it would look something like this:
```
 if [[ "$fan_speed" != "$previous_fan_speed" ]]; then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=$fan_speed" -a "[fan-1]/GPUTargetFanSpeed=$fan_speed" -a "[fan-2]/GPUTargetFanSpeed=$fan_speed"
```
Again pretty simple right! After doing this we should be on our final step!

**🏁 Final Step** 

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

Note that when you stop this script the fans on your GPU will stay set to whatever the script last set them too unless you restart the scrip then they will start adapting again! The only way i know of completely removing the gpu set speed is restarting your pc! 

-
But you stop the script all you have to do is click in the terminal that its running in and press CTRL + C this will stop the script but take mention of the note above! 

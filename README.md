# KinectRobotArm
Control a robotic arm with Kinect for XBOX 360 camera using processing and arduino

(video from youtube)

For the first [GeekPicnic festival in Jerusalem](http://geekpicnic.co.il/), Israel I've took a robotic arm and wanted it to dance according to the person's movements in front of it.

The robotic arm is based on a kit by lynxmotion: [http://www.lynxmotion.com/p-1033-al5a-robotic-arm-combo-kit-no-software-wssc-32u.aspx](http://www.lynxmotion.com/p-1033-al5a-robotic-arm-combo-kit-no-software-wssc-32u.aspx)
(without the rotation arm part).
Since the controller provided didn't work at all it was replaced with Arduino nano
The servos were powered with a DC-DC converter (12V to 6V)


## Schematic
![](/schematic.JPG)

## Drawing
![](/Drawing.JPG)

## Arduino Sketch - [robotic_arm](/Arduino/robotic_arm/robotic_arm.ino)
The program in arduino is very basic, it waits for bytes in order of the servos and writes them to the servos.

## Processing Sketch - [Servo_control](/Processing/Servo_control/Servo_control.pde)
The processing test sketch is based on the slider example.
I've added more sliders and a Serial link to the arduino.
The slide ranges were changed according to the servo's angles (0-180)

![](/Processing/Servo_control/Capture.JPG)

## Processing sketch - [randomservo](/Processing/randomservo/randomservo.pde)
This program writes random values between 0-180 every 10 seconds to the arduino

## Processing sketch - [Kinectreadanglescontrolservo](/Processing/Kinectreadanglescontrolservo/Kinectreadanglescontrolservo.pde)
The sketch is based on the example from the Kinect4WinSDK library from here: https://github.com/chungbwc/Kinect4WinSDK
It calculates the angles of the joints from a skeleton and adjusts the slightly for the different servos
More info about the library: http://www.magicandlove.com/blog/research/kinect-for-processing-library/

(Screenshots)

## Images from the GeekPicnic event
![](/Images/GeekPicNic_25_small.jpg)

![](/Images/GeekPicNic_24_small.jpg)

![](/Images/GeekPicNic_19_small.jpg)

![](/Images/GeekPicNic_15_small.jpg)

![](/Images/GeekPicNic_22_small.jpg)

![](/Images/GeekPicNic_18_small.jpg)
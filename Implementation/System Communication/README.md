# Essential Functions to Communicate with the Motor 
<p align=justify> These functions are incorporated to the controllers' codes, which where originally made for digital simulation purposes<br> </p>

## Dependencies
MATLAB Support Package for Arduino Hardware

## Hardware
- an Arduino Board 
- a Feedback DC motor system
- an intermediate custom electronic circuit board that connects the Arduino to the DC motor using the principles of Electronics, made by lab personnel.

## Header Function 
<p align=justify> A crucial function to the initialisation of the system for the day's experiments or for clearing the workspace while sparing variables that do not have to be deleted or might even cause a problem if cleared abruptly. 
Everytime this code is executed, it checks if an arduino object (`ard`) has been created and if `vref` and `V7805` have been set. If not, it proceeds to the respective commands or function calls. If they have been set once, they are not cleared when the whole workspace is cleared after an experiment.<br></p>

## Motor PowerOff function 
<p align=justify>Use this function to immediately shut down the motor, whether it is rotating clockwise or anticlockwise.Recommended usage is during the initialisation part of the code and right after we exit the loop of the Control Process. <br> <\p>

## WriteU and getVtacho/getTheta
<p align=justify> WriteU when combined with one of the getters plays the role of the `lsim()` part of the original simulation codes. In other words, after calculating the new input u, we "write" to the system using `WriteU` and proceed to check how it responds using either `getVtacho` or `getTheta`, depending on the experiment we are carrying out. <br></p>

## setVref_V7805 function
<p align = justify> We call this function upon first powering on our system for the day. After plugging the hardware in to the power supply and connecting our computer to it via the Arduino, we run the `header` file which among others, executes this function. The execution stops and asks for a value, we measure the voltage of the position pin using a multimeter or a digital oscilloscope and input it to the MATLAB command window.
Typical values of Vref and V7805 are around 5 Volts. The code of header function used to clear all workspace variables after an implementation stage experiment spares these variables so they do not have to be set again and again. <br> </p>

## switching_modification function 
<p align = justify> It is necessary to enrich the controllers with this robustness mechanism when using it to control the actual plant that includes unmodeled friction. <br> </p>
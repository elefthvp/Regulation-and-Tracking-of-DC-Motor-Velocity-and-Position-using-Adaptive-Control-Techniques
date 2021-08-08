# Essential Functions to Communicate with the Motor 
<p align=justify> These functions are incorporated to the controllers' codes, which where originally made for digital simulation purposes<br> </p>

## Dependencies
MATLAB Support Package for Arduino Hardware

# Hardware
- an Arduino Board 
- a Feedback DC motor system
- an intermediate custom electronic circuit board that connects the Arduino to the DC motor using the principles of Electronics, made by lab personnel.

## Manual Measurements 
<p align=justify> The following functions are used to acquire voltage data for position and velocity throughout the whole function spectre of the system.<br></p>
### pos_voltage_measurements function
<p align=justify>Function that simplifies the acquisition of voltage data read from the position pin. The process is half-manual half automatic. At first we decide per how many degrees we will measure a new voltage. This function was used to measure per 5 degrees.
During an iteration of the loop, the current position voltage is measured by reading the respective Arduino pin. Then a message appears and we measure this voltage manually and input it to the Command Window. The system then pauses and waits for any key. We then manually move the ouput hub for 5 degrees and press any key. The new iteration takes place and the system now measures the voltage of the position we just got the hub to. We continue this process until we have the voltage measurements for the whole 360-degree spectre.<br></p>

### vel_voltage_measurements
<p align = justify> Similar to the above-mentioned function, it creates a data matrix of the velocity voltage as measured by reading the Arduino pin and by hand. The velocity here changes automatically and the user is only required to measure and input.<br> </p>

## raw_pos2degrees function
<p align=justify>This function loads the previously acquired position voltage data and makes generates a vector of the same length taking into consideration the sample rate that was used (ours was 5). It translates the raw data passed to it as an argument to degrees using linear interpolation.  <br> <\p>

## RPM2u_vel function
<p align=justify>Use this to convert desired RPM to a controller input.<br></p>

## vel_voltage2RPM function
<p align = justify> Gets velocity voltage as an argument and calculates the RPM that it represents. The velocity measured visually usually differs, and this is due to unmodeled friction that has not been taken into consideration in the equations used to calculate the  expected velocity in RPM.<br> </p>

## Displacement Functions

### relative_displacement function
<p align = justify> Use this to rotate the position hub clockwise or anticlockwise for a desired amount of degrees. It uses a fixed velocity to rotate <br></p>

### absolute_displacement function
<p align = justify> Moving the ouptput degree hub manually can feel like a chore, especially when it stops far away from zero after an experiment. This function reads the current position and uses the relative_displacement and raw2pos functions to move the ouptput hub to the desired place. It is a quick and efficient way to set initial conditions.<br></p>

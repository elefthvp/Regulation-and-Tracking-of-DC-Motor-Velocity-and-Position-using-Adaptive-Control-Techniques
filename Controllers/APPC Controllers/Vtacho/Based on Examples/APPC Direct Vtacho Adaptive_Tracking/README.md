
## Title
<b>Direct Adaptive Pole Placement Controller for Output Velocity Voltage control of a DC motor </b>

---

## Mathematical Methodology 
<p align=justify>
The adaptive controller implemented in the main code file "APPC_Vtacho_Direct_Adaptive_Tracking" follows the well-established theoretical analyses of mr. Petros Ioannou and mr. Baris Fidan as presented in their book "Adaptive Control Tutorial".
It more specifically follows the scalar example in section 6.2.2, as the plant under control is a first-order one and the desired trajectory is a sinusoid, thus a shifting one.
<br>
</p>
The controller that is presented is a direct one since for every time fragment we execute an outright parameter estimation of the controller's gains rather than the system parameters a,b. 
<br>
</p>

---

## Plant Model
### First-Order Plant 
<img src="https://latex.codecogs.com/gif.latex?\bg_white&space;\dfrac{vtacho}{u}=\dfrac{k_m&space;k_T}{T_m&space;s&space;&plus;1}=\dfrac{b}{s&plus;a}" title="\dfrac{vtacho}{u}=\dfrac{k_m k_T}{T_m s +1}=\dfrac{b}{s+a}" />

### Parameter Values for Simulation Purposes 
<p align=justify>
Note that the controller does not use the values of the following parameters, but estimates them instead. They are only used as a means of simulation to test the response of the system.<br>
</p>

| Symbol | Value|
|------|-------------|
| km |235.68|
| kT | 0.0037|
| Tm | 0.564|

---

## Degrees of Freedom
### Designer Parameters
| Variable| Description |
|------|-------------|
| interval| The step of the adaptive process, plays the role of the sampling frequency, discretizes the otherwise continuous-time procedure|
| γ | adaptive gain, a scaling constant|

### Reference 
| Variable| Description |
|------|-------------|                         
| ymsym   | The reference signal in symbolic format, set f to choose signal frequency|
|t_space| The time range of the simulation |

---


## Contact me

- [e-mail elefthvp](mailto:el.papaioannou.96@gmail.com "el.papaioannou.96@gmail.com")

---

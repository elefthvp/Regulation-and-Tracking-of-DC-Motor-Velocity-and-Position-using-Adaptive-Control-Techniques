
## Title
<b>Direct Model Reference Adaptive Controller for Output Voltage control of a DC motor </b>

---

## Mathematical Methodology 
<p align=justify>
The adaptive controller implemented in the main code file "Vtacho_Direct_MRAC" follows the well-established theoretical analyses of mr. Petros Ioannou and mr. Baris Fidan as presented in their book "Adaptive Control Tutorial".
It more specifically follows the scalar example in section 5.2.2, as the plant under control is a first-order one.
<br>
</p>
<p align=justify>
As stated in the directory name, a normalization signal does not need to be employed since the original system is stable and the adaptive controller is only used to further improve its response (i.e.in terms of settling time) or estimate its parameters. <br> </p>
<p align = justify>
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

### Model Reference 
| Variable| Description |
|------|-------------|
| am,bm | The user specified model in a state-space symbolisation. For a stable system, am needs to be positive                             |
| r     | The reference signal, sets the desired output amplitude along with the steady-state gain of the reference model defined by am, bm.|
|t_space| The time range of the simulation |

---


## Contact me

- [e-mail elefthvp](mailto:el.papaioannou.96@gmail.com "el.papaioannou.96@gmail.com")

---

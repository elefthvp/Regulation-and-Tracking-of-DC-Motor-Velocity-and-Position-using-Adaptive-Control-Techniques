
## Title
<b>Indirect Adaptive Pole Placement Controller for Output Velocity Voltage control of a DC motor </b>

---

## Mathematical Methodology 
<p align=justify>
The adaptive controller implemented in the main code file "APPC_Vtacho_Indirect_Tracking" follows the well-established theoretical analyses of mr. Petros Ioannou and mr. Baris Fidan as presented in their book "Adaptive Control Tutorial".
It more specifically follows the generalized methodology presented in chapter 6.3. It involves the calculation and manipulation of variables and polynomials that hold a strictly mathematical essence in our analysis, such as the Sylvester Matrix and the P and L polynomials. These requirements make it a complicated piece of software in  terms of development and execution and a controller that does not yield fruitful results, especially when compared to other controllers that present a much better response with less complication in theoretical comprehesion and software development.

<br>
</p>
The controller that is presented is an indirect one since for every time fragment we first estimate the system parameters a,b and then use them to calculate the controller's gains. 
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
| b0| a limit value under which the estimation of b is not allowed to drift|

### Reference 
| Variable| Description |
|------|-------------|                         |
| As | The desired polynomial whose poles our system needs to mimic. Has to be of order 2n+q-1|
|t_space| The time range of the simulation |

---


## Contact me

- [e-mail elefthvp](mailto:el.papaioannou.96@gmail.com "el.papaioannou.96@gmail.com")

---

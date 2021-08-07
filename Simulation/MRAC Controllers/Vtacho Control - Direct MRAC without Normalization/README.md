
## Title
<b>Direct Model Reference Adaptive Controller for Output Voltage control of a DC motor </b>

---

## Mathematical Methodology 
<p align=justify>
The adaptive controller implemented in the main code file "Vtacho_Direct_MRAC" follows the well-established theoretical analyses of mr. Petros Ioannou and mr. Baris Fidan as presented in their book "Adaptive Control Tutorial".
It more specifically follows the scalar example in section 5.2.2, as the plant under control is a first-order one.
<br>
</p>

---

## Plant Model
### First-Order Plant 
https://latex.codecogs.com/gif.latex?%5Cdfrac%7Bvtacho%7D%7Bu%7D%3D%5Cdfrac%7Bk_m%20k_T%7D%7BT_m%20s%20&plus;1%7D%3D%5Cdfrac%7Bb%7D%7Bs&plus;a%7D
###Parameter Values for Simulation Purposes 
<p align=justify>
Note that the controller does not use the values of the following parameters, but estimates them instead. They are only used as a means of simulation to test the response of the system.
| Symbol | Value|
|------|-------------|
| km |235.68|
| kT | 0.0037|
| Tm | 0.564|


## Degrees of Freedom
###Designer Parameters
| Variable| Description |
|------|-------------|
| interval| The step of the adaptive process, plays the role of the sampling frequency, discretizes the otherwise continuous-time procedure|
| γ | adaptive gain, a scaling constant|

### Model Reference 
| Wm | The user specified sampling frequency (`Default: 10 seconds`).|
| r  | The brand and model of the device.|
|t_space| 

---



## Contact

- [e-mail elefthvp](mailto:el.papaioannou.96@gmail.com "el.papaioannou.96@gmail.com")

---

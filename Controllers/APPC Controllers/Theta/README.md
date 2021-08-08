
## Title
<b>Indirect Adaptive Pole Placement Controller for Output Velocity Voltage control of a DC motor </b>


---

## Mathematical Methodology 
<p align=justify>
The adaptive controllers implemented in the main code files follow the well-established theoretical analyses of mr. Petros Ioannou and mr. Baris Fidan as presented in their book "Adaptive Control Tutorial".
They more specifically follow the generalized methodology presented in chapter 6.3. They involve the calculation and manipulation of variables and polynomials that hold a strictly mathematical essence in our analysis, such as the Sylvester Matrix and the P and L polynomials. These requirements make them complicated pieces of software in  terms of development and execution and the resulting controllers do not yield fruitful results, especially when compared to other controllers that present a much better response with less complication in theoretical comprehension and software development.

<br>
</p>
The controllers presented are indirect since for every time fragment we first estimate the system parameters a,b and then use them to calculate the controllers' gains. 
<br>
</p>
<p align=justify> The controllers in the two directories are identical in terms of overall methodology but the order of the desired polynomial As changes according to whether the reference is shifting or not. Certain mathematical manipulations also change to
support the necessary calculations (for example the 'ss' command for state-space model derivation meets our needs in the constant reference case but a custom function 'ThirdOrderCCF' had to be made for the sinusoid trajectory one)<br> </p>
---

## Plant Model
### Second-Order Plant 
<img src="https://latex.codecogs.com/gif.latex?\bg_white&space;\large&space;\dfrac{\theta}{v}&space;=&space;\dfrac{-k_0&space;k_\mu&space;k_M}{T_m&space;s^2&space;&plus;s}&space;=&space;\dfrac{b}{s^2&space;&plus;&space;as}" title="\large \dfrac{\theta}{v} = \dfrac{-k_0 k_\mu k_M}{T_m s^2 +s} = \dfrac{b}{s^2 + as}" />


### Parameter Values for Simulation Purposes 
<p align=justify>
Note that the controllers do not use the values of the following parameters, but estimate them instead. They are only used as a means of simulation to test the response of the system.<br>
</p>

| Symbol | Value|
|------|-------------|
| km |235.68|
| kmu | 0.0278|
| k0 | 0.2347|
| Tm | 0.564|
---

## Degrees of Freedom
### Designer Parameters
| Variable| Description |
|------|-------------|
| interval| The step of the adaptive process, plays the role of the sampling frequency, discretizes the otherwise continuous-time procedure|
| γ | adaptive gain, a scaling constant|
| kp_max| a limit value over which the estimation of kp is not allowed to drift|

### Reference 
| Variable| Description |
|------|-------------|                         
| As | The desired polynomial whose poles our system needs to mimic. Has to be of order 2n+q-1|
|t_space| The time range of the simulation |

---


## Contact me

- [e-mail elefthvp](mailto:el.papaioannou.96@gmail.com "el.papaioannou.96@gmail.com")

---

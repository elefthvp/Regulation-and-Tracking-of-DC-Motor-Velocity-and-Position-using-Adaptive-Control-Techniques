
## Title
<b>Direct Model Reference Adaptive Controller for Output Position Voltage control of a DC motor </b>

---

## Mathematical Methodology 
<p align=justify>
The adaptive controller implemented in the main code file "Direct_MRAC_with_Normalization" follows the well-established theoretical analyses of mr. Petros Ioannou and mr. Baris Fidan as presented in their book "Adaptive Control Tutorial".
It is more specifically based on the methodology of chapter 5.5 but the designer is encouraged to also refer to chapter 5.3 for the main idea behind the methodology, as well as the other essential elements found throughout the book that are required for an engineer to understand and efficiently utilise this control scheme.
<br>
</p>
<p align=justify>
As stated in the directory name, a normalization signal needs to be employed since the original system is unstable (refer to the transfer function presented below) and as it is widely known in control theory, the design of any controller holds no meaning if a system is unstable in the first place. The implemented adaptive controller guarantees stability by bounding the ouptut system used as feedback and estimates its parameters when excited with a sufficiently rich input. <br> </p>
<p align = justify>
The controller that is presented is a direct one since for every time fragment we execute an outright parameter estimation of the controller's gains rather than the system parameters a,b. 
<br>
</p>

---

## Plant Model
### Second-Order Plant 
<img src="https://latex.codecogs.com/gif.latex?\bg_white&space;\large&space;\dfrac{\theta}{v}&space;=&space;\dfrac{-k_0&space;k_\mu&space;k_M}{T_m&space;s^2&space;&plus;s}&space;=&space;\dfrac{b}{s^2&space;&plus;&space;as}" title="\large \dfrac{\theta}{v} = \dfrac{-k_0 k_\mu k_M}{T_m s^2 +s} = \dfrac{b}{s^2 + as}" />


### Parameter Values for Simulation Purposes 
<p align=justify>
Note that the controller does not use the values of the following parameters, but estimates them instead. They are only used as a means of simulation to test the response of the system.<br>
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
| F,g| control law gains, better perceived when in state-space representation |
|rho(1)| initial condition of the rho vector, plays a specifically important role to achieve stability quickly when testing on the actual motor system|

### Model Reference 
| Variable| Description |
|------|-------------|
| Wm| The user specified model in a transfer function symbolisation. Note that its relative degree has to be equal to the plant we aspire to control |                           |
| r     | The reference signal, sets the desired output amplitude along with the steady-state gain of the reference model defined by Wm|
|t_space| The time range of the simulation |

---


## Contact me

- [e-mail elefthvp](mailto:el.papaioannou.96@gmail.com "el.papaioannou.96@gmail.com")

---
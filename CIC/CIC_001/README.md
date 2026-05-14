# CIC Decimation filter
## Technical task
Sampling frequency fs = 1MHz\
Decimation factor R = 5\
CIC filter order N = 7\
Differential delay M = 1\
Cutoff frequency fc = 100 kHz\
fs/R = 200 kHz\
Out of band attenuation > 60 dB\
Input data width Bx = 12
## CIC filter circuit
## CIC filter simulation
![CIC filter](images/cic%20filter.png)
![CIC compensation filter](images/cic%20compensation%20filter.png)
## Testing
For testing 12-bit signed sin wave generator was used. Generator connected directly to the input of the filter.
![Test circuit](images/test%20circuit.png)
![Waveforms](images/test%20waveforms.png)
## Notes
To ensure isolation level more than 60 dB I choose filter order N = 7 and differential delay M = 1. For design of FIR compensation filter frequency sampling method was used. Filter data width B = 29.
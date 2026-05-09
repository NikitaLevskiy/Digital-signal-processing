%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CIC DECIMATION FILTER
clear all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sampling frequency fs
fs = 1e6;

% Filter order N
N = 7;

% Decimation factor R
R = 5;

% Differential delay M
M = 1;

% Frequency vector
f = [0:1:fs];
F = f / (fs / R);

% Gain of CIC decimation filter H
for i = 1:length(f)

    H(i) = abs(sin(pi * M * F(i)) / sin(pi * F(i) / R))^N;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CIC COMPENSATION FILTER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gain if cic compensation filter Hcf
for i = 1:length(f)

    Hcf(i) = abs(sin(pi * F(i) / R) / sin(pi * M * F(i)))^N;

end

% Order of CIC compensation filter (Nlp-1).
Nlp = 32;

% Cutoff frequency fc
fc = 89e3;

% Filter indexes (n and m).
n = [0:Nlp-1];
m = Nlp/2;

% Calculation of amplitude vector (Ak).
fidx = 0;

for i = 1 : m + 1

    if fidx < fc

        Ak(i) = Hcf(fidx + 1);

    end

    fidx = fidx + floor((fs / (2*R)) / (m + 1));

end

Ak(1) = Hcf(2);

% Calculation of FIR filter using frequency sampling method.
h = 0;
w = 0;

for i = 1:length(n)

    temp = 0;

    for j = 1:length(Ak)

        temp = temp + (Ak(j) * cos((2 * pi * j / Nlp) * (n(i) - m)));

    end

    h(i) = (1/Nlp) * (Ak(1) + 2 * temp);

end

for i = 1:Nlp

    w(i) = 0.54 + 0.46 * cos((2 * pi * (n(i) - m)) / (Nlp - 1));

end

h = h .* w;

% Gain of compensation filter using frequency sampling method (Hfs)
for i = 1:length(f)

    Hfs(i) = abs(sum(h .* exp(-1j * 2 * pi * f(i) .* (n - m) ...
              / (fs / (R)))));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;

subplot(2, 2, 1);
xmin = 0; xmax = fs; ymin = -150; ymax = 150;
plot(f, 20*log10(H));
title('Gain of cic decimation filter');
xlabel('Frequency (Hz)');
ylabel('Attenuation (dB)');
axis([xmin xmax ymin ymax]);
grid on;

subplot(2, 2, 3);
xmin = 0; xmax = fs; ymin = -150; ymax = 150;
plot(f, 20*log10(Hcf));
title('Gain of cic ideal compensation filter');
xlabel('Frequency (Hz)');
ylabel('Attenuation (dB)');
axis([xmin xmax ymin ymax]);
grid on;

subplot(2, 2, 4);
xmin = 0; xmax = fs; ymin = -150; ymax = 150;
plot(f, 20*log10(Hfs));
title('Gain of cic real compensation filter');
xlabel('Frequency (Hz)');
ylabel('Attenuation (dB)');
axis([xmin xmax ymin ymax]);
grid on;

subplot(2, 2, 2);
xmin = 0; xmax = fs; ymin = -250; ymax = 10;
plot(f, 20*log10(H .* Hfs));
title('Gain of cic compensated filter');
xlabel('Frequency (Hz)');
ylabel('Attenuation (dB)');
axis([xmin xmax ymin ymax]);
grid on;


figure;

subplot(1, 2, 1);
xmin = 0; xmax = fs; ymin = -100; ymax = -70;
plot(f, 20*log10(Hfs));
title('Gain of compensation filter');
xlabel('Frequency (Hz)');
ylabel('Attenuation (dB)');
axis([xmin xmax ymin ymax]);
grid on;

subplot(1, 2, 2);
xmin = -16; xmax = 15; ymin = min(h); ymax = max(h);
stem(n-m, h);
title('Impulse response of compensation filter');
xlabel('n');
ylabel('h');
axis([xmin xmax ymin ymax]);
grid on;
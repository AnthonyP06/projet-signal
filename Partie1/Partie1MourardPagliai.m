clear all;
clc;
close all;

%% 1) Construction du vecteur e
e = [9.5 7 5 2.5 0 -2.5];

% Construction de l'�cart en fr�quence
f = zeros(1, length(e));
f = 110*10.^(e*log10(2)/6); % Vectorisation de la conversion de l'�cart de ton en fr�quence.
f;

% Longeur d'un demi-ton en Savarts
e_dt = 1000*log10(2)/12;

% Longeur d'un ton en Savarts
e_t = 1000*log10(2)/6;

%% 2.1) Fonction sav2lin.m
    % Fonction permettant de convertir les Savarts en �chelle lin�aire
xsav = [0 25.08 50.17 301.03];
xlin = zeros(1, length(xsav));
xlin = 10.^(xsav/1000);           % Vectorisation de la conversion Savarts -> lin�aire
xlin;

%% 2.2) Fonction lin2sav.m
    % Fonction permettant de convertir l'�chelle lin�aire en Savarts
xlin = [1 2 3];
xsav = zeros(1, length(xlin));
xsav = 1000*log10(xlin);           % Vectorisation de la conversion lin�aire -> Savarts
xsav;

%% Cr�ation et repr�sentation du contenu d'un signal

% D'apr�s le th�or�me de Shannon-Nyquist, il faut choisir une fr�quence
% d'�chantillonnage f_s au moins deux fois sup�rieure � la fr�quence
% maximale pr�sente dans ce signal.

f0 = 110;
T = 5;
fs = 10*f0;
Te = 1/fs;
t = 0:Te:T-Te;
signal = sin(2*pi*f0*t);
sound(signal, fs);

% Graphe du signal sur 10 p�riodes
x=0:Te:10/f0;
y=sin(2*pi*f0*x);
figure;
plot(x,y);
xlabel('Temps(s)');
ylabel('Amplitude');

% (c)

% (d)
% Calcul de DFT
Sdft = abs(fftshift(DFT(signal)));
% Repr�sentation de la DFT
ldft = length(Sdft);
fdft = -fs/2:fs/ldft:fs/2-fs/ldft;
figure;
plot(fdft,Sdft);
xlabel('Fr�quence(Hz)');
ylabel('Amplitude');

% Calcul par la fft
Sfft = abs(fftshift(fft(signal)));
lfft = length(Sfft);
ffft = -fs/2:fs/lfft:fs/2-fs/lfft;
figure;
plot(ffft, Sfft);
xlabel('Fr�quence(Hz)');
ylabel('Amplitude');

% iii.  (cf. compte rendu)

%% iv. Pr�cision de l'analyse par transform�e de Fourier
% Pr�cision
fs = 300;  % Hz
T = 1;  % sec
m = 0:length(signal);
seq = exp(1i*2*pi*(f0/fs)*m);
fbar = linspace(0, 1, 3e3);
Sz = TransformeZ(f0/fs, seq, fbar);

figure;
plot(fdft, Sdft);
hold on;
plot(fdft, Sz);
xlabel('Fr�quence(Hz)');
ylabel('Amplitude');

%% R�solution de l'analyse par transform�e de Fourier

% La r�solution du syst�me au sens du crit�re de Rayleigh est en 1/T.
% Donc lorsque T tend vers l'infini, la r�solution est nulle.

% Cas o� deltaf = 1Hz

deltaf = 1;
t01 = 0:1/fs:T;
yr1 = sin(2*pi*f0*t);
yr2 = sin(2*pi*(f0-deltaf)*t);

Yr = abs(fftshift(DFT(yr1+yr2)));

figure;
plot(fdft, Yr);
xlabel('Frequence(Hz)');
ylabel('Amplitude');


% Cas o� deltaf = 0,5Hz
deltaf = 0,5;
t01 = 0:1/fs:T;
yr1 = sin(2*pi*f0*t);
yr2 = sin(2*pi*(f0-deltaf)*t);

Yr = abs(fftshift(DFT(yr1+yr2)));

figure;
plot(fdft, Yr);
xlabel('Frequence(Hz)');
ylabel('Amplitude');


% Cas o� deltaf = 0,2Hz
deltaf = 0,2;
t01 = 0:1/fs:T;
yr1 = sin(2*pi*f0*t);
yr2 = sin(2*pi*(f0-deltaf)*t);

Yr = abs(fftshift(DFT(yr1+yr2)));

figure;
plot(fdft, Yr);
xlabel('Frequence(Hz)');
ylabel('Amplitude');

%% Illustration du ph�nom�ne de repliement

% Fr�quence d'�chantillonage �gale � 1,5 fois la fr�quence du signal
fs_rep1 = 1.5*f0;
t_rep1 = 0:1/fs_rep1:5;
y_rep1 = sin(2*pi*f0*t_rep1);

Y_rep1 = abs(fftshift(DFT(y_rep1)));
l_rep1 = length(Y_rep1);
fdft_rep1 = -fs_rep1/2:fs_rep1/l_rep1:fs_rep1/2-fs_rep1/l_rep1;

figure;
plot(fdft_rep1, Y_rep1);
xlabel('Fr�quence (Hz)');
ylabel('Amplitude');

% Fr�quence d'�chantillonage �gale � la fr�quence du signal
fs_rep2 = f0;
t_rep2 = 0:1/fs_rep2:5;
y_rep2 = sin(2*pi*f0*t_rep2);

Y_rep2 = abs(fftshift(DFT(y_rep2)));
l_rep2 = length(Y_rep2);
fdft_rep2 = -fs_rep2/2:fs_rep2/l_rep2:fs_rep2/2-fs_rep2/l_rep2;

figure;
plot(fdft_rep2, Y_rep2);
xlabel('Fr�quence (Hz)');
ylabel('Amplitude');

%% Question 4 Traitement simple d'un signal
% Recherche de f0
[m1, ind1] = max(Sdft);             % indice de la valeur maximale de Sdft
f_initiale1 = abs(fdft(ind1));       % on trouve f0

[m2 ,ind2] = max(Sfft);             % m�me m�thode mais avec la fft
f_initiale2 = abs(ffft(ind2));       % on retrouve f0

% Consigne pour accorder la guitare
frequence = 109;   %% A MODIFIER %%   % On remplace 109 par la fr�quence de la corde que l'on veut accorder.

consigne(frequence, f0);

%% Question 5 Robustesse d'un traitement par rapport � un nouveau mod�le de signal
% Ajout des harmoniques
fs = 10*fs;
T = 5;
t = 0:1/fs:T;
l = length(t);

f = -fs/2:fs/l:fs/2-fs/l;

y = sin(2*pi*f0*t) + 0.7*sin(4*pi*f0*t) + 1.3*sin(6*pi*f0*t);

% Analyse par dft
S = abs(fftshift(DFT(y)));

figure;
plot(f, S);
xlabel('Fr�quence (Hz)');
ylabel('Amplitude');

% Recherche de f0
[m, ind] = max(S);
f_initiale = abs(f(ind));

% Consigne d'accordage
consigne(f_origine, f0);
%% Question 6 Question optionnelle

reader('MI3');
reader('MI2');
reader('MI1');

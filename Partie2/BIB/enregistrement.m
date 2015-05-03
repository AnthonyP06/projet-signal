%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Enregistement du signal joue a la guitare %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ce script se lance automatiquement lorsque l'utilisateur choisit
% d'enregistrer lui-meme son signal.

% Frequence d'echantillonnage (Hz)
fs = 44100;

% Enregistrement du bruit pendant 3 secondes
disp('Veuillez attendre le signal pour jouer la note')

y2 = wavrecord(3*fs, fs);
[M(1),i(1)] = max(abs(fftshift(fft(y2))));

disp('Veuillez jouer la note')

% Enregistrement du signal pendant 3 secondes
y = wavrecord(3*fs,fs);
[M(2),i(2)] = max(abs(fftshift(fft(y))));


% On fixe un seuil de securite : le signal doit etre au moins 2 fois plus
% fort que le bruit

if (M(2)/M(1) < 2) 
  disp('Veuillez rejouer la note plus fort')
    clc
    close all
    clear all
else
    disp('La note a bien été reconnue')
end



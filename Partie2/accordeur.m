% Ce script constitue notre accordeur electronique de guitare. 
% Pour l'utiliser, les cellules Observation temporelle et Observation
% frequentielle des signaux n'ont pas necessairement a etre compilees.
% 
% Par ailleurs, les actions a effectuer par l'utilisateur s'affichent dans
% la Command Window.

clear all
clc 
close all
startup;            % Initialise les librairies utilisees
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Definition des valeurs en dur %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nombre de cordes
N_cordes = 6;

% Tableau des frequences des 6 cordes 
e = [82.407 110 146.83 196 246.94 329.63];

% Liste des cordes disponibles
temp = {'MI1', 'LA1', 'RE2', 'SOL2', 'SI2', 'MI3'};

 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Observation temporelle des signaux

son = load(uigetfile('.\DATA'));                    % Ouvre une fenetre de dialogue. Choisir le fichier souhaite
t = 0:1/son.fs:(length(son.y)-1)/son.fs;            % Vecteur temps

name = temp{3};
h1 = figure('Name', 'Allure temporelle du LA1');    % Affichage de l'allure temporelle (==> A CHANGER <== "LA1" par la note chargee)
plot(t, son.y);
grid on;
xlabel('temps (s)');
ylabel('Amplitude du signal');
title('Allure temporelle du LA1');                  % (==> A CHANGER <== "LA1" par la note chargee)
saveas(h1, '.\Figures\LA1temp', 'jpg');             % Sauvegarde du graphe au format JPEG

%% Observation frequentielle des signaux

son = load(uigetfile('.\DATA'));                    % Ouvre une fenetre de dialogue. Choisir le fichier souhaite 

t = 0:1/son.fs:(length(son.y)-1)/son.fs;            % Vecteur temps
Nfft = 2^(nextpow2(length(t)));                     % Nombre de points de la FFT

Sonlin = fftshift(abs(fft(son.y, Nfft)));           % Transformee de Fourier centree
Sondb = 20*log10(Sonlin);                           
f = (0:1/Nfft:(Nfft-1)/Nfft)*son.fs - son.fs/2;     % intervalle de frequence centre en 0 de -fs/2 a +fs/2

h2 = figure('Name', 'Allure frequentielle du LA1'); % Affichage de l'allure frequentielle (==> A CHANGER <== "LA1" par la note chargee)
plot(f, Sondb);                                
xlim([-son.fs/20 son.fs/20]);                       % Reduction de la fenetre d'affichage
grid on;
xlabel('frequence (Hz)');
ylabel('Spectre (db)');
title('Allure frequentielle')                       % (==> A CHANGER <== "LA1" par la note chargee
saveas(h2, './Figures/LA1freq', 'jpg');             % sauvegarde du graphe au format JPEG


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Acquisition du signal 

% Interface utilisateur
choix = menu('Que voulez-vous accorder?','Un signal pre-enregistre', 'Un signal a enregistrer');

if choix==1
    load(uigetfile('*.mat','Choisir la note','.\DATA'));
    clear PDATA
elseif choix==2
    clear PDATA
    disp('Vous avez choisi de jouer la note')
    enregistrement;
end

% Recuperation du signal si c'est un signal enregistre. S'il n'est pas
% enregistre, MatLab decompose grace a la fonction uigetfile le fichier en un signal y et une
% periode d'echantillonnage fs qu'il cree en memoire.
signal = y;
N = length(signal);


 
%% Determination de la frequence de la note jouee et de la corde a accorder

% Filtre du MI1 :

% On applique le filtre a notre signal, puis on recupere les maxima dans chaque plage de frequence des passe-bande.
[Max(1),index(1)] = max(abs(fftshift(fft(filtrage(signal,fs,e(1))))));

% Filtre du LA1 :
[Max(2),index(2)] = max(abs(fftshift(fft(filtrage(signal,fs,e(2))))));


% Filtre du RE2 :
[Max(3),index(3)] = max(abs(fftshift(fft(filtrage(signal,fs,e(3))))));


% Filtre du SOL2 :
[Max(4),index(4)] = max(abs(fftshift(fft(filtrage(signal,fs,e(4))))));


% Filtre du SI2 :
[Max(5),index(5)] = max(abs(fftshift(fft(filtrage(signal,fs,e(5))))));


% Filtre du MI3 :
[Max(6),index(6)] = max(abs(fftshift(fft(filtrage(signal,fs,e(6))))));


% On recupere le maximum des maxima locaux
[M,I] = max(Max);


%% Determination de la frequence fondamentale de la note jouee


xFreq =(-fs/2 : fs/N : fs*(1/2 - 1/N));     % Vecteur des frequences de la fft
f0 = e(I);                                  % (Hz) Freq. du fondamental de la corde a accorder
frec = abs(xFreq(index(I)));                % (Hz) Freq. de la note jouee


%% Affichage de la note jouee

if f0==e(1)
   disp('La note jouee est le MI1')
   
elseif f0==e(2)
   disp('La note jouee est le LA1')
   
elseif f0==e(3)
   disp('La note jouee est le RE2')
   
elseif f0==e(4)
   disp('La note jouee est le SOL2')
   
elseif f0==e(5)
   disp('La note jouee est le SI2')
   
elseif f0==e(6)
   disp('La note jouee est le MI3')
   
end

%% Determination de l'action a effectuer sur la corde

% On teste de maniere sucessive pour savoir dans quel intervalle on se
% trouve et ainsi determiner l'action a effectuer sur la corde
if (frec-f0>sav2lin(1/20*50) && frec-f0<sav2lin(2/20*50))
    disp('Decalage de : +10')
    disp('Desserrer la corde ')
    
elseif (frec-f0>sav2lin(2/20*50) && frec-f0<sav2lin(3/20*50))
    disp('Decalage de : +20')
    disp('Desserrer la corde ')
    
elseif (frec-f0>sav2lin(3/20*50) && frec-f0<sav2lin(4/20*50))
    disp('Decalage de : +30')
    disp('Desserrer la corde ')
    
elseif (frec-f0>sav2lin(4/20*50) && frec-f0<sav2lin(5/20*50))
    disp('Decalage de : +40')
    disp('Desserrer la corde ')
    
elseif (frec-f0>sav2lin(5/20*50))
    disp('Decalage de : +50')
    disp('Desserrer la corde ')
    
    
    
elseif (frec-f0<-sav2lin(1/20*50) && frec-f0>-sav2lin(2/20*50))
    disp('Decalage de : -10')
    disp('Resserrer la corde ')
    
elseif (frec-f0<-sav2lin(2/20*50) && frec-f0>-sav2lin(3/20*50))
    disp('Decalage de : -20')
    disp('Resserrer la corde ')
    
elseif (frec-f0<-sav2lin(3/20*50) && frec-f0>-sav2lin(4/20*50))
    disp('Decalage de : -30')
    disp('Resserrer la corde ')
    
elseif (frec-f0<-sav2lin(4/20*50) && frec-f0>-sav2lin(5/20*50))
    disp('Decalage de : -40')
    disp('Resserrer la corde ')
    
elseif (frec-f0<-sav2lin(5/20*50))
    disp('Decalage de : -50')
    disp('Resserrer la corde ')
    
    
% Enfin, pour un ecart inferieur au 1/20 de ton, on considere que la corde
% est accordee

else disp('La corde est accordee')
end
function [z] = filtrage(y,fs,f)
% Filtre un signal avec un filtre passe bande centre
% en f, de largeur un demi ton

% Bande passante
W1 = sav2lin(lin2sav(f)-lin2sav(2)/24);       % Borne inferieure
W2 = sav2lin(lin2sav(f)+lin2sav(2)/24);       % Borne superieure
W = 2/fs*[W1 W2];                             % Bande passante normalisee

% Filtre de butterworth d'ordre 4 (2*2)
[num, denom] = butter(2,W,'bandpass'); 

% Filtrage du signal
z = filter(num,denom,y);

%% EN OPTION : decommenter toutes les lignes de code pour du contenu supp.
% Affichage du filtre (optionnel) : decommentez la ligne 18 pour les
% afficher
%fvtool(num,denom);

% Affichage des poles de la fonction de transfert (etude de stabilite)
%r = roots(denom);                                   %Calcul des poles

%N_pts = 3600;                                       %(-) Points pour tracer le cercle unite
%theta = 0:2*3.1415/N_pts:2*3.1415*(1-1/N_pts);      %Vecteur trace du cercle unite
%cercle_unit = exp(1i*theta);


%figure;
%plot(r,'+');
%hold on;
%plot(cercle_unit,'r');
%xlim([0.9975 1.001]);
%ylim([-0.05 0.05]);
%grid on;
%legend('Poles','Cercle unite');
%xlabel('Axe reel');
%ylabel('Axe imaginaire');
%title('Poles du filtre de Butterworth');

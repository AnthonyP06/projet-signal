openfunction [xlin] = sav2lin(xsav)
% LIN2SAV(V) ou V est un vecteur renvoie un nouveau vecteur dont chaque
%   coordonnee a ete convertie de l'echelle lineaire a l'echelle en Savart.
%   Par exemple, un octave represente environ 300 Savarts.

xlin = zeros(1, length(xsav));
xlin = 10.^(xsav/1000);           % Vectorisation de la conversion Savarts -> linéaire
end


function [xsav] = lin2sav(xlin)
% LIN2SAV(V) ou V est un vecteur renvoie un nouveau vecteur dont chaque
%   coordonnee a ete convertie de l'echelle lineaire a l'echelle en Savart.
%   Par exemple, un octave represente environ 300 Savarts.

xsav = zeros(1, length(xlin));
xsav = 1000*log10(xlin);           % Vectorisation de la conversion linéaire -> Savarts
end


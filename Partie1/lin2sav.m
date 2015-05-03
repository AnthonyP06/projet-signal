function [xsav] = lin2sav(xlin)
% Fonction convertissant l'échelle linéaire en savart
xsav = zeros(1, length(xlin));
xsav = 1000*log10(xlin);           % Vectorisation de la conversion linéaire -> Savarts
end


function [xlin] = sav2lin(xsav)
% Fonction convertissant les savarts en échelle linéaire
xlin = zeros(1, length(xsav));
xlin = 10.^(xsav/1000);           % Vectorisation de la conversion Savarts -> linéaire
end


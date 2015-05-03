function [xsav] = lin2sav(xlin)
% Fonction convertissant l'�chelle lin�aire en savart
xsav = zeros(1, length(xlin));
xsav = 1000*log10(xlin);           % Vectorisation de la conversion lin�aire -> Savarts
end


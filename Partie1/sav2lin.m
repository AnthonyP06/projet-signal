function [xlin] = sav2lin(xsav)
% Fonction convertissant les savarts en �chelle lin�aire
xlin = zeros(1, length(xsav));
xlin = 10.^(xsav/1000);           % Vectorisation de la conversion Savarts -> lin�aire
end


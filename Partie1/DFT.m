function [ S ] = DFT( y )
%donne la transformée de Fourier discrète d'un signal

l = length(y);                    % necessaire a  la construction de N
N = ((0:1:l-1).')*(0:1:l-1);      % matrice carree pour la multiplication
S = exp((-2*pi*1i*N)/l)*(y)';% matrice carree des exponentielles (vectorisation)
end
                                  
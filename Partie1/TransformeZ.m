function [ Sz ] = TransformeZ(f0, x, fbar)
M = length(x);
Sz = (1-exp(1i*2*pi*(f0-fbar)*M))/(1-exp(1i*2*pi*(f0-fbar)));

end
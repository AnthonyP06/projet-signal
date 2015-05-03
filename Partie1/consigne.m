function [ ] = consigne( freq, f0 )
ton = 100/6*log10(2);                   % un ton
precision = ton/20;                     % Marge d'erreur tol�r�e
delta = lin2sav(freq/f0);               % Diff�rence entre la corde et l'objectif (en Savart)

if(delta > precision)
    fprintf('Desserer \n')              % Affichage
else
    if(delta < -precision)
        fprintf('Resserer \n')          % Affichage
    else
        fprintf('Corde accord�e \n')    % Affichage
    end
end

end


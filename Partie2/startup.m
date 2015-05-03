function startup()
% Cette fonction a pour but d'initialiser l'environnement de travail pour
% l'accordeur electronique de guitare.
% La fonction ne prend aucun argument et est a utiliser en debut de script
% de l'accordeur.

clear all;                  % Efface toute la memoire 
close all;                  % Ferme toutes les fenetres ouvertes
clc;                        % Efface tout l'historique de commande

PDATA = '.\DATA';           % Emplacement du dossier DATA
PBIB = '.\BIB';             % Emplacement du dossier BIB
addpath(genpath(PDATA));    % Chemin d'acces du dossier DATA
addpath(genpath(PBIB));     % Chemin d'acces du dossier BIB
disp('startup completed');  % Affichage de "startup completed"

end


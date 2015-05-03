function [ frequence ] = reader( note )

fileID = fopen('freq_gamme.txt', 'r');
C = textscan(fileID, '%s %s');
l1 = length(note);

    for i = 1:35
        if(length(C{1}{i}) == l1)
            if (C{1}{i}(1:length(C{1}{i})) == note(1:l1))
                frequence = C{2}{i};
            end
        end
    end
fclose(fileID);

end
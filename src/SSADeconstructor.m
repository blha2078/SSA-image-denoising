function [X] = SSADeconstructor(M, u, v, h, w)
    disp('Deconstructing SSA...');
    %getting window size 
    p = u * v;
    q = (h - u + 1) * (w - v + 1);
    
    %setting X/window index to 1
    X_index = 1;

    %creating matrix
    X = zeros(p, q);

    %going through full picture frame from left to right
    for i = 1 : h - u + 1
        %Top to bottom
        for j = 1 : w - v + 1
            %saving points left to right accross window
            for Wi = 1 : u
                %top to bottom accross window
                for Wj = 1 : v
                    X((Wi - 1) * u + Wj, X_index) = M(i + Wi - 1, j + Wj - 1);
                end
            end
            %Moving over to the next vector
            X_index = X_index + 1;
        end
    end
end
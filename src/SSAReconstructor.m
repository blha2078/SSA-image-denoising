function [M_new] = SSAReconstructor(X, u, v, h, w)
    disp('Reconstructing SSA...');
    %getting window size 
    %finding p and q
    p = u * v;
    q = (h - u + 1) * (w - v + 1);
    
    %setting X/window index to 1
    X_index = 1;

    %creating matrix- third dimension to take care of averaging multiples
    M_new_3D = zeros(h, w, 2);

    %going through full picture frame from left to right
    for i = 1 : h - u + 1
        %Top to bottom
        for j = 1 : w - v + 1
            %saving points left to right accross window
            for Wi = 1 : u
                %top to bottom accross window
                for Wj = 1 : v
                    M_new_3D(i + Wi - 1, j + Wj - 1, 1) = M_new_3D(i + Wi - 1, j + Wj - 1, 1) + X((Wi - 1) * u + Wj, X_index);
                    M_new_3D(i + Wi - 1, j + Wj - 1, 2) = M_new_3D(i + Wi - 1, j + Wj - 1, 2) + 1;
                end
            end
            %Moving over to the next vector
            X_index = X_index + 1;
        end
    end
    
    %must now average out the values in the 3 dimensional matrix
    %Use the second layer to do this
    M_new = zeros(h, w);
    for i = 1:h
        for j = 1:w
            M_new(i, j) = M_new_3D(i, j, 1) / M_new_3D(i, j, 2);
            M_new(i, j) = M_new(i, j) + (M_new(i, j) - 127) * .15;
                if M_new(i, j) < 20
                M_new(i, j) = 0;
            end
        end
    end
end
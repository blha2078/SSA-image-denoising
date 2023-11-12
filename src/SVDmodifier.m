function [X_new] = SVDmodifier (X, L, u, v, h, w)
    disp('Modifying SVD...');
    p = u * v;
    q = (h - u + 1) * (w - v + 1);


    XXT = X * transpose(X);
    %----------Display
    %disp('XXtranspose');
    %disp(XXT);

    %finding the SVD of XXT
    [U,S,V] = svd (XXT);
    %U and V are the same since dealing with a symmetric matrix
    
    U_transpose = transpose(U);
    %----------Display
    %U * S * U_transpose

    %{ 
    checking the sum rebuild method
    Rebuilt = zeros(9, 9);
    for it = 1:9
        Rebuilt = Rebuilt + (S(it, it) * U(:, it) * U_transpose(it, :));
    end
    %}
    %----------Display
    %disp('Reconstructed XXT Matrix to check');
    %disp(Rebuilt);


    X_new = zeros(p, q);
    for it = 1:L
        X_new = X_new + (U(:, it) * U_transpose(it, :) * X);
    end
end
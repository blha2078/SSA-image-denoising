

%reading in an image 
original_image = double(imread('Galaxy.jpg'));

%turning image into a greyscale matrix, combining each color channel
greyscale_image = original_image(:,:,1) / 3 + original_image(:,:,2) / 3 + original_image(:,:,3) / 3;

%showing how to edit lighness of image
for i = 1:height(greyscale_image)
    for j = 1:width(greyscale_image)
        greyscale_image(i, j) = greyscale_image(i, j) + (greyscale_image(i, j) - 127) * .15;
        if greyscale_image(i, j) < 20
            greyscale_image(i, j) = 0;
        end
    end
end
figure
imshow(1.2 * uint8(greyscale_image));
title('Greyscale')

%getting the RGB channels from the original matrix
red_channel = original_image(:,:,1);
green_channel = original_image(:,:,2);
blue_channel = original_image(:,:,3);

%showing image once
color_image = cat(3,red_channel,green_channel,blue_channel);
figure;
imshow(uint8(color_image));
title('Original image')

%editting colors- making a red boosted version
red_boosted_image = cat(3,red_channel * 1.5,green_channel ,blue_channel);
figure;
imshow(uint8(red_boosted_image));
title('Red Boosted Version')

%% cropping the image
%creating I matrix of longer egde size
%image is 4608x3456
I_crop = eye(3456);
I_crop (1:400,1:400) = 0;
I_crop (3056:3456, 3056:3456) = 0;
figure
spy(I_crop);
xlabel(sprintf('Number of nonzero elements: %d', nnz(I_crop)))

%getting the RGB channels from the original matrix- must convert to double
%to multiply
red_channel_crop = I_crop * double(red_channel);
green_channel_crop = I_crop * double(green_channel);
blue_channel_crop = I_crop *  double(blue_channel);
cropped_image = cat(3,uint8(red_channel_crop),uint8(green_channel_crop) , uint8(blue_channel_crop));

figure
imshow(cropped_image);
title ('Cropped image');

%% Removing noise from greyscale- LENA image for recreation of example document
%reading in an image 
Lena = double(imread('Lena.jpg'));
h = height(Lena);
w = width(Lena);

%getting window size (square for our purposes now)
u = 10;
v = 10;
%creating L variable for the number of eigenvectors used
L = 1;

X = SSADeconstructor(Lena, u, v, h, w);
%----------Display
disp (X(:, 1:4));

X_new = SVDmodifier(X, L, u, v, h, w);
%----------Display
disp (X_new(:, 1:4));

%Editting Lena
Lena2 = SSAReconstructor(X_new, u, v, h, w);

subplot(2,1,1);
imshow(uint8(Lena));
title('Original')

subplot(2,1,2);
imshow(uint8(Lena2));
title('Editted')

%% Editting the Galaxy Picture
%reading in an image 
Galaxy_color = double(imread('Galaxy-Full.jpg'));
Galaxy = Galaxy_color(:,:,1) / 3 + Galaxy_color(:,:,2) / 3 + Galaxy_color(:,:,3) / 3;
hG = height(Galaxy);
wG = width(Galaxy);
%creating L variable for the number of eigenvectors used
LG = 1;

%{
%for u = v = 1
%----------------------------------------------
%Setting window size
uG = 1;
vG = 1;
%Creating the 'X' matrix for the galaxy matrix
XG1 = SSADeconstructor(Galaxy, uG, vG, hG, wG);
%Creating the SVD modification to the galaxy
XG1_new = SVDmodifier(XG1, LG, uG, vG, hG, wG);
G1 = SSAReconstructor(XG1_new, uG, vG, hG, wG);
subplot(2,2,1)
imshow(uint8(G1));
title('u = v = 1')


%for u = v = 4
%----------------------------------------------
%Setting window size
uG = 4;
vG = 4;
%Creating the 'X' matrix for the galaxy matrix
XG4 = SSADeconstructor(Galaxy, uG, vG, hG, wG);
%Creating the SVD modification to the galaxy
XG4_new = SVDmodifier(XG4, LG, uG, vG, hG, wG);
G4 = SSAReconstructor(XG4_new, uG, vG, hG, wG);
subplot(2,2,2)
imshow(uint8(G4));
title('u = v = 4')



%for u = v = 7
%----------------------------------------------
%Setting window size
uG = 7;
vG = 7;
%Creating the 'X' matrix for the galaxy matrix
XG7 = SSADeconstructor(Galaxy, uG, vG, hG, wG);
%Creating the SVD modification to the galaxy
XG7_new = SVDmodifier(XG7, LG, uG, vG, hG, wG);
G7 = SSAReconstructor(XG7_new, uG, vG, hG, wG);
subplot(2,2,3)
imshow(uint8(G7));
title('u = v = 7')

subplot(2,2,4)
imshow(uint8(Galaxy));
title('Original')

%}

%Setting window size
uG = 4;
vG = 6;
%Creating the 'X' matrix for the galaxy matrix
XG = SSADeconstructor(Galaxy, uG, vG, hG, wG);
%Creating the SVD modification to the galaxy
XG_new = SVDmodifier(XG, LG, uG, vG, hG, wG);
G = SSAReconstructor(XG_new, uG, vG, hG, wG);
figure(2)
imshow(uint8(G));
title('Reduced Noise Full Image: u = 4; v = 6')

%% Editting Galaxy picture: Color

%reading in an image 
Galaxy_color = double(imread('Galaxy-Full.jpg'));
Galaxy_red = 1.05 * Galaxy_color(:,:,1);
Galaxy_green = 1.05 * Galaxy_color(:,:,2);
Galaxy_blue = Galaxy_color(:,:,3);


hG = height(Galaxy_red);
wG = width(Galaxy_red);
%creating L variable for the number of eigenvectors used
LG = 1;
%Setting window size
uG = 4;
vG = 6;

disp('Red...')
%Creating the 'X' matrix for red
XG_red = SSADeconstructor(Galaxy_red, uG, vG, hG, wG);
%Creating the SVD modification to the galaxy
XG_red_new = SVDmodifier(XG_red, LG, uG, vG, hG, wG);
G_red = SSAReconstructor(XG_red_new, uG, vG, hG, wG);

disp('Green...')
%Creating the 'X' matrix for red
XG_green = SSADeconstructor(Galaxy_green, uG, vG, hG, wG);
%Creating the SVD modification to the galaxy
XG_green_new = SVDmodifier(XG_green, LG, uG, vG, hG, wG);
G_green = SSAReconstructor(XG_green_new, uG, vG, hG, wG);

disp('Blue...')
%Creating the 'X' matrix for red
XG_blue = SSADeconstructor(Galaxy_blue, uG, vG, hG, wG);
%Creating the SVD modification to the galaxy
XG_blue_new = SVDmodifier(XG_blue, LG, uG, vG, hG, wG);
G_blue = SSAReconstructor(XG_blue_new, uG, vG, hG, wG);
disp('Concatonating image...')
%showing image (color)
G_color = 1.2 * cat(3,G_red, G_green, G_blue);
figure;
imshow(uint8(G_color));
title('Color image')


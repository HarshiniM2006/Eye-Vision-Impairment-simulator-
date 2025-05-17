% --------------------------
% Eye Vision Impairment Simulator
% Author: You + ChatGPT
% --------------------------

clc;
clear;
close all;

% Load and display the original image
img = imread('peppers.png'); % Change to your own image if you want
figure, imshow(img), title('Normal Vision');

%% 1. Simulating Cataract - Gaussian Blur
% Cataracts scatter light due to lens opacity → blurred vision

blur_strength = 5; % Higher = more blur
cataract_img = imgaussfilt(img, blur_strength);
figure, imshow(cataract_img), title('Cataract Simulation (Blurred Vision)');

%% 2. Simulating Macular Degeneration - Central Vision Loss
% Damage to the macula leads to central vision loss (black spot in center)

% Create a circular black mask at the center
[rows, cols, ~] = size(img);
mask_radius = 60;
[X, Y] = meshgrid(1:cols, 1:rows);
center_x = cols / 2;
center_y = rows / 2;
macular_mask = sqrt((X - center_x).^2 + (Y - center_y).^2) > mask_radius;

% Apply mask to each RGB channel
macular_img = img;
for i = 1:3
    temp = macular_img(:,:,i);
    temp(~macular_mask) = 0; % Make center black
    macular_img(:,:,i) = temp;
end
figure, imshow(macular_img), title('Macular Degeneration Simulation');

%% 3. Simulating Glaucoma - Tunnel Vision (Peripheral Loss)
% Glaucoma leads to optic nerve damage → peripheral vision loss

% Create a peripheral darkness (vignette)
sigma = 150; % Controls tunnel width
glaucoma_mask = fspecial('gaussian', [rows cols], sigma);
glaucoma_mask = mat2gray(glaucoma_mask); % Normalize to 0–1

% Apply mask to each channel
glaucoma_img = img;
for i = 1:3
    glaucoma_img(:,:,i) = uint8(double(glaucoma_img(:,:,i)) .* glaucoma_mask);
end
figure, imshow(glaucoma_img), title('Glaucoma Simulation (Tunnel Vision)');

%% 4. Simulating Deuteranopia (Red-Green Color Blindness)
% Red-Green color blindness — cone cells can't differentiate red/green

% Transformation matrix based on vision science research
T = [0.625, 0.7,   0;
     0.375, 0.3,   0.3;
     0,     0,     0.7];

reshaped_img = double(reshape(img, [], 3)); % Flatten image
cb_img = reshaped_img * T';                 % Matrix transformation
cb_img = uint8(reshape(cb_img, size(img))); % Reshape back to image
figure, imshow(cb_img), title('Deuteranopia Simulation (Color Blindness)');
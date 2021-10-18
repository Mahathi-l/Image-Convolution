%Project 2 Question 1a
% Author - Mahathi Lanka [200425925]
% Inputs - image, kernel, padding type 
% Output - covolved image - using kernels given for spatial filtering
%% Spatial filtering in  RGB images with convolution
input_image = im2double(imread('wolves.png'));
input_image1 = im2double(imread("lena.png"));
input_image1 = rgb2gray(input_image1);
%print(size(input_image));
%filter definition
box_deriv = {1/9*[1,1,1;1,1,1;1,1,1]};
prewitt = {[-1,0,1;-1,0,1;-1,0,1],[-1,-1,-1;0,0,0;1,1,1]};
sobel = {[-1,0,1;-2,0,2;-1,0,1],[1,2,1;0,0,0;-1,-2,-1]};
roberts = {[0,1 ; -1,0],[1,0;0,-1]};
%collecting all the kernels to a list
kernels = horzcat(box_deriv,prewitt,sobel,roberts);

Pad_select = 'Set padding type\n1. Zero Padding\n2. Copy Edge\n3. Wrap around\n4. Reflect across edge\n';

filter_select = ['Set Kernel type\n1. Box Filter 2. Derivative horizontal'...
    ' 3. Derivative vertical\n4. Prewitt horizontal 5. Prewitt vertical\n'...
    '6. Sobel horizontal 7. Sobel vertical\n8. Roberts Horizontal'...
    ' 9 Roberts Vertical\n'];

pad_type = {"zero", "Copy_edge", "Wrap_around","Reflect"};
filter_type = {'Box', 'DerivHorizontal', 'DerivVertical', 'PrewittHorizontal',...
    'PrewittVertical','SobelHorizontal','SobelVertical', 'RobertsHorizontal',...
    'RobertsVertical'};

%to take user inputs
kernel = input(filter_select);
pad = input(Pad_select);

%For RGB images (since we have 3 channels)

if size(input_image,3) == 3
    output(:,:,1) = convolve2D(input_image(:,:,1), kernels{kernel},pad);
    output(:,:,2) = convolve2D(input_image(:,:,2), kernels{kernel},pad);
    output(:,:,3) = convolve2D(input_image(:,:,3), kernels{kernel},pad);
else
% convolving directly
    output = convolve2D2d(input_image, kernels{kernel},pad);
end
ops = (output-min(output(:)))./(max(output(:))-min(output(:)));
if size(input_image1,3)==3 
    output(:,:,1) = convolve2D(input_image(:,:,1), kernels{kernel},pad);
    output(:,:,2) = convolve2D(input_image(:,:,2), kernels{kernel},pad);
    output(:,:,3) = convolve2D(input_image(:,:,3), kernels{kernel},pad);
else
    op1 = convolve2D(input_image1,kernels{kernel},pad);
end
ops1 = (op1-min(op1(:)))./(max(op1(:))-min(op1(:)));
%create a figure to display the results

figure('units', 'normalized', 'outerposition', [0 0 1 1]); 
subplot(2,3,1); 
imshow(input_image);
title('wolves.png');
subplot(2,3,2);
imshow(output);
title('o/p (Negative values Clipped)');
subplot(2,3,3)
imshow(ops);
title('o/p Scaled');
subplot(2,3,4); 
imshow(input_image1);
title('lena.png');
subplot(2,3,5);
imshow(op1);
title('o/p (Negative values Clipped)');
subplot(2,3,6)
imshow(ops1);
title('o/p Scaled');
%save the results to a png file 
fileName = horzcat('Part1a',filter_type{kernel},pad_type{pad},'.png');
print(gcf, fileName,'-dpng', '-r300');
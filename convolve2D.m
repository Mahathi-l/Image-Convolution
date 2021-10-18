%To perform 2D convolution of an image with a given kernel
function[output_image] = conv2d(input_image,kernel,pad)
%To perform 2D convolution of an image
[rows,columns] = size(input_image);
[rows_k,columns_k] = size(kernel);
padded_image = Padding(input_image,kernel,pad);
output_image = input_image;
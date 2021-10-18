function [pad_Image] = Padding(input_image, kernel, pad)

%Padding is done based on input kernel size
%The size of the kernel is used as a reference for
%the amount of padding required. The padding is performed by considering
%padding type and then slicing appropriate indices from original image
%to copy them to the actual image.

[rows,columns] = size(input_image);
[rows_k,columns_k] = size(kernel);
%setting prompts to select padding and respective kernels
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %padding for horizontal derivative filter
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if rows_k==1 && columns_k==2
%zero padding for horizontal filters
    if pad == 1 
        pad_Image= zeros(rows,columns+1);
        pad_Image(:,1:end-1) = input_image;
%copy edge for horizontal filters
    elseif pad == 2
        pad_Image=zeros(rows,columns+1);
        pad_Image(:,1:end-1) = input_image;
        pad_Image(:,end) = input_image(:,end);
% wrap around for horizontal filters
    elseif pad ==3
        pad_Image = zeros(rows,columns+1);
        pad_Image(:,1:end-1) = input_image;
        pad_Image(:,end) = input_image(:,1);
 %reflect across edge for horizontal filters
    elseif pad == 4
        pad_Image= zeros(rows,columns+1);
        pad_Image(:, 1:end-1) = input_image;
        pad_Image(:, end) = input_image(:,end);
    end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %padding for vertical derivative filter
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif rows_k==2 && columns_k==1
 %zero padding for vertical filter
    if pad == 1 
        pad_Image = zeros(rows+1,columns);
        pad_Image(1:end-1,:) = input_image;
    %copy edge
    elseif pad == 2  
        pad_Image = zeros(rows+1,columns);
        pad_Image(1:end-1,:) = input_image;
        pad_Image(end,:) = input_image(end,:);
    %wrap around
    elseif pad == 3 
        pad_Image = zeros(rows+1,columns);
        pad_Image(1:end-1,:) = input_image;
        pad_Image(end,:) = input_image(1,:);
    %reflect across edge
    elseif pad == 4  
        pad_Image = zeros(rows+1,columns); 
        pad_Image(1:end-1,:) = input_image;
        pad_Image(end,:) = input_image(end,:);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for kernels with odd sizes
%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif (mod(rows_k,2)) && (mod(columns_k,2))
%zero padding
    if pad ==1
        pad_Image = zeros(rows+2*floor(rows_k/2),columns+2*floor(columns_k/2));
        pad_Image(ceil(rows_k/2):end-floor(rows_k/2), ceil(columns_k/2):end-floor(columns_k/2)) = input_image;
    elseif pad ==2
        %First performing the zero padding and then replacing the values
        %with the corresponding pixel values
        pad_Image = zeros(rows+ceil(rows_k/2),columns+ceil(columns_k/2)); 
        pad_Image((rows_k+1)/2:end-1, (columns_k+1)/2:end-1) = input_image;
        %attempting to copy edges to newly added image edges with zeros
        pad_Image(ceil(rows_k/2):end-floor(rows_k/2), 1:floor(columns_k/2)) = repmat(input_image(:,1),1,floor(columns_k/2)); 
        pad_Image(ceil(rows_k/2):end-floor(rows_k/2), end-floor(columns_k/2)+1:end) = repmat(input_image(:,end),1,floor(rows_k/2));
        pad_Image(1:floor(rows_k/2),ceil(columns_k/2):end-floor(columns_k/2)) = repmat(input_image(1,:),floor(rows_k/2),1);
        pad_Image(end-floor(rows_k/2)+1:end,ceil(columns_k/2):end-floor(columns_k/2)) = repmat(input_image(end,:),floor(columns_k/2),1);
        %corner cases
        pad_Image(1:floor(rows_k/2), 1:floor(columns_k/2)) = repmat(input_image(1,1), floor(rows_k/2), floor(columns_k/2));
        pad_Image(end-floor(rows_k/2)+1:end, 1:floor(columns_k/2)) = repmat(input_image(end,1), floor(rows_k/2), floor(columns_k/2));
        pad_Image(1:floor(rows_k/2), end-floor(columns_k/2)+1:end) = repmat(input_image(1,end), floor(rows_k/2), floor(columns_k/2));
        pad_Image(end-floor(rows_k/2)+1:end, end-floor(columns_k/2)+1:end) = repmat(input_image(end,end), floor(rows_k/2), floor(columns_k/2));
    elseif pad ==3
        %set up as zero padding 
        pad_Image = zeros(rows+2*floor(rows_k/2),columns+2*floor(columns_k/2));
        pad_Image(ceil(rows_k/2):end-floor(rows_k/2), ceil(columns_k/2):end-floor(columns_k/2)) = input_image;
        %wrap edges from other end to the newly added edges
        pad_Image(floor((rows_k+1)/2):end-floor(rows_k/2), 1:floor(columns_k/2)) = input_image(:,end-floor(columns_k/2)+1:end);
        pad_Image(floor((rows_k+1)/2):end-floor(rows_k/2), end-floor(columns_k/2)+1:end) = input_image(:,1:floor(columns_k/2));
        pad_Image(1:floor(rows_k/2),floor((columns_k+1)/2):end-floor(columns_k/2)) = input_image(end-floor(rows_k/2)+1:end,:); 
        pad_Image(end-floor(rows_k/2)+1:end,floor((columns_k+1)/2):end-floor(columns_k/2)) = input_image(1:floor(rows_k/2),:);
        %corner cases
        pad_Image(1:floor(rows_k/2), 1:floor(columns_k/2)) = input_image(end-floor(rows_k/2)+1:end, end-floor(columns_k/2)+1:end);
        pad_Image(end-floor(rows_k/2)+1:end, 1:floor(columns_k/2)) = input_image(1:floor(rows_k/2), end-floor(columns_k/2)+1:end);
        pad_Image(1:floor(rows_k/2), end-floor(columns_k/2)+1:end) = input_image(end-floor(rows_k/2)+1:end, 1:floor(columns_k/2));
        pad_Image(end-floor(rows_k/2)+1:end, end-floor(columns_k/2)+1:end) = input_image(1:floor(rows_k/2), 1:floor(columns_k/2));
    elseif pad==4
        %set up as zero padding 
        pad_Image = zeros(rows+2*floor(rows_k/2),columns+2*floor(columns_k/2));
        pad_Image(ceil(rows_k/2):end-floor(rows_k/2), ceil(columns_k/2):end-floor(columns_k/2)) = input_image;
        %mirror padding
        pad_Image(floor((rows_k+1)/2):end-floor(rows_k/2), 1:floor(columns_k/2)) = input_image(:,floor(ck/2):-1:1);
        pad_Image(floor((rows_k+1)/2):end-floor(rows_k/2), end-floor(columns_k/2)+1:end) = input_image(:,end:-1:end-floor(columns_k/2)+1);
        pad_Image(1:floor(rows_k/2),floor((columns_k+1)/2):end-floor(columns_k/2)) = input_image(floor(rows_k/2):-1:1,:);
        pad_Image(end-floor(rows_k/2)+1:end,floor((columns_k+1)/2):end-floor(columns_k/2)) = input_image(end:-1:end-floor(rows_k/2)+1,:);
        %corner cases
        pad_Image(1:floor(rows_k/2), 1:floor(columns_k/2)) = input_image(floor(rows_k/2):-1:1, floor(columns_k/2):-1:1);
        pad_Image(end-floor(rows_k/2)+1:end, 1:floor(columns_k/2)) = input_image(end:-1:end-floor(rows_k/2)+1, floor(columns_k/2):-1:1);
        pad_Image(1:floor(rows_k/2), end-floor(columns_k/2)+1:end) = input_image(floor(rows_k/2):-1:1, end:-1:end-floor(columns_k/2)+1);
        pad_Image(end-floor(rows_k/2)+1:end, end-floor(columns_k/2)+1:end) = input_image(end:-1:end-floor(rows_k/2)+1, end:-1:end-floor(columns_k/2)+1);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %padding with even sized kernels
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    if pad == 1
        pad_Image = zeros(rows+rows_k/2,columns+columns_k/2);
        pad_Image(1:end-(rows_k/2), 1:end-(columns_k/2)) = input_image;
    elseif pad == 2
        pad_Image = zeros(rows+rows_k/2,columns+columns_k/2);
        pad_Image(1:end-(rows_k/2), 1:end-(columns_k/2)) = input_image;
        %copy edges to the image
        pad_Image(1:end-(rows_k/2), end-columns_k/2+1:end) = repmat(input_image(:,end), floor(columns_k/2));
        pad_Image(end-rows_k/2+1:end,1:end-(columns_k/2)) = repmat(input_image(end,:), floor(rows_k/2));
        %corner cases
        pad_Image(end-(rows_k/2)+1:end, end-(columns_k/2)+1:end) = repmat(input_image(end,end), floor(rows_k/2),floor(columns_k/2));
    elseif pad == 3
        pad_Image = zeros(rows+rows_k/2,columns+columns_k/2);
        pad_Image(1:end-(rows_k/2), 1:end-(columns_k/2)) = input_image;
        %wrap around edges
        pad_Image(1:end-1, end-columns_k/2+1:end) = input_image(:,1:columns_k/2);
        pad_Image(end-rows_k/2+1:end,1:end-1) = input_image(1:rows_k/2,:);
        %corner case
        pad_Image(end-(rows_k/2)+1:end, end-(columns_k/2)+1:end) = input_image(1:(rows_k/2),1:(columns_k/2));
    elseif pad == 4
        pad_Image = zeros(rows+rows_k/2,columns+columns_k/2);
        pad_Image(1:end-(rows_k/2), 1:end-(columns_k/2)) = input_image;
        %reflect across edge
        pad_Image(1:end-1, end-columns_k/2+1:end) = input_image(:,end:end-columns_k/2+1);
        pad_Image(end-rows_k/2+1:end,1:end-1) = input_image(end:end-rows_k/2+1,:);
        %corner case
        pad_Image(end-(rows_k/2)+1:end, end-(columns_k/2)+1:end) = input_image(end:end-(rows_k/2)+1,end:end-(columns_k/2)+1);
    end
end
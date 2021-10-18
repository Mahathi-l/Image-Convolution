function [fftImg] = dft2(img)
%approach
% use 2 for loops, one to take fft of the rows. Then use
%another one to take the fft of the obtained result from the first
% loop 
    [r,c] = size(img);
    for i = 1:r
        fftImg(i,:) = fft(img(i,:));
    end
    for j = 1:c
        fftImg(:,j) = fft(fftImg(:,j));
    end
    img = (img-min(img(:)))./(max(img(:))-min(img(:)));
    fftImg = fft(fft(img, [],1), [], 2);
end
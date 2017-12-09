% TJ Lilyeblade
% Assignment 5
% 10/09/2017

% This code will read the numbers off a postal code and
% determine what numbers they are

clear all; close all; clc;

% Read and scale input image
I = imread('xcorr/unknown.jpg');
Ithresh = imbinarize(I);
BW = ~Ithresh;

SE = strel('disk', 2);
BW2 = imdilate(BW, SE);

Istats = regionprops(BW2);
Istats([Istats.Area] < 1000) = [];
num = length(Istats);

Ibox = floor([Istats.BoundingBox]);
Ibox = reshape(Ibox,[4,num]);

for k = 1:num
   col1 = Ibox(1);
   col2 = Ibox(1) + Ibox(3);
   row1 = Ibox(2);
   row2 = Ibox(2) + Ibox(4);
   subImage = BW2(row1:row2, col1:col2);
   UnknownImage{k} = subImage;
   UnknownImageScaled{k} = imresize(subImage, [24 12]);
end

% Read and scale comparing template
I2 = imread('xcorr/template.jpg');
Ithresh2 = imbinarize(I2);
BW3 = ~Ithresh2;

SE = strel('disk', 2);
BW4 = imdilate(BW3, SE);

Istats2 = regionprops(BW4);
Istats2([Istats2.Area] < 1000) = [];
num2 = length(Istats2);

 Ibox2 = floor([Istats2.BoundingBox]);
% Ibox2 = reshape(Ibox2,[4,num]);

for k = 1:num
   col1 = Ibox2(1);
   col2 = Ibox2(1) + Ibox2(3);
   row1 = Ibox2(2);
   row2 = Ibox2(2) + Ibox2(4);
   subImage = BW4(row1:row2, col1:col2);
   TemplateImage{k} = subImage;
   TemplateImageScaled{k} = imresize(subImage, [24 12]);
end

imshow(TemplateImage{4});
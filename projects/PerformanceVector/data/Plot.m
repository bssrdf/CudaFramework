﻿% Plotting Performance Tests

clear all;
close all;

fid = fopen('Data.txt');
C = textscan(fid, '%s %d', 1, 'delimiter','\t','commentStyle','#')
blockDimMin = C{1,2};
C = textscan(fid, '%s %d', 1, 'delimiter','\t','commentStyle','#')
blockDimStep = C{1,2};
C = textscan(fid, '%s %d', 1, 'delimiter','\t','commentStyle','#')
blockDimMax = C{1,2};

C = textscan(fid, '%s %d', 1, 'delimiter','\t','commentStyle','#')
gridDimMin = C{1,2};
C = textscan(fid, '%s %d', 1, 'delimiter','\t','commentStyle','#')
gridDimStep = C{1,2};
C = textscan(fid, '%s %d', 1, 'delimiter','\t','commentStyle','#')
gridDimMax = C{1,2};

C = textscan(fid, '%s %d', 1, 'delimiter','\t','commentStyle','#')
nLoops = C{1,2};
C = textscan(fid, '%s %d %d', 3, 'delimiter','\t','commentStyle','#')
N = C{1,2}(1,1);
C = textscan(fid, '%s %d', 1, 'delimiter','\t','commentStyle','#')
nOps = C{1,2};

data = textscan(fid, '%u%u%u%u%f%f', 'delimiter','\t','MultipleDelimsAsOne','1','commentStyle','#')

% Rearrange data!
m = ceil((blockDimMax-blockDimMin)/blockDimStep)+1;
n = ceil((gridDimMax-gridDimMin)/gridDimStep)+1;
Gflops  = reshape(data{1,6},m,n);
BlockMesh  =  reshape(data{1,1},m,n);
ThreadMesh  = reshape(data{1,3},m,n);

[maxFlops,k] = max(data{1,6});
bestThreadDim = data{1,3}(k,1);
bestGridDim = data{1,1}(k,1);

figure(1)
hold on
surf(ThreadMesh, BlockMesh,Gflops,'EdgeColor','none')
xlabel('Thread/Block Size')
ylabel('Block Dimension')
zlabel('Speed [GFlops/sec]')
title({'Performance Vector Addition',['N = ',num2str(N),', nOps: ',num2str(nOps),...
    ', Max Gflops: ', num2str(maxFlops)],[' Best threadDim: ',num2str(bestThreadDim),...
    ', Best gridDim: ',num2str(bestGridDim)]})
%     set(gca,'XTick',[2.^[2:1:15]]);
%     set(gca,'YTick',[2.^[2:2:15]]);
%% Plot multiplicity curves
figure(1)
mult = double(N) ./ (double(BlockMesh) .* double(ThreadMesh));
levels = [1:1:10];
[C,h]=contour(ThreadMesh,BlockMesh,mult,'LineColor',[1,0,0],'LevelList',levels)
clabel(C,h,'FontSize',8,'Color','b')
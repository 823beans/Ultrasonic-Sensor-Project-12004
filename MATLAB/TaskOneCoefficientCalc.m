clear;
close all;
clc;

%Load datasets for fixed distances (0.12,0.20,0.32)
M1 = load('TaskOneReadings1.mat','Distance','Time');
M2 = load('TaskOneReadings2.mat','Distance','Time');
M3 = load('TaskOneReadings3.mat','Distance','Time');
M4 = load('TaskOneReadings4.mat','Distance','Time');
M5 = load('TaskOneReadings5.mat','Distance','Time');

%Initialise variables
dist1 = M1.Distance;
time1 = M1.Time;
dist2 = M2.Distance;
time2 = M2.Time;
dist3 = M3.Distance;
time3 = M3.Time;
time4 = M4.Time;
dist4 = M4.Distance;
time5 = M5.Time;
dist5 = M5.Distance;

dTrue = [0.25 0.5 1.0 1.5 2.0]';

%remove 'Inf' readings from data

dist1(isinf(dist1)) = [];
dist2(isinf(dist2)) = [];
dist3(isinf(dist3)) = [];
dist4(isinf(dist4)) = [];
dist5(isinf(dist5)) = [];

%Apply moving average filter to each dataset
fdDist1 = movmean(dist1,10);
fdDist2 = movmean(dist2, 10);
fdDist3 = movmean(dist3, 10);
fdDist4 = movmean(dist4,10);
fdDist5 = movmean(dist5,10);
%Find the mean of each filtered dataset
barFdDist1 = mean(fdDist1);
barFdDist2 = mean(fdDist2);
barFdDist3 = mean(fdDist3);
barFdDist4 = mean(fdDist4);
barFdDist5 = mean(fdDist5);
dMeasrd = [barFdDist1 barFdDist2 barFdDist3 barFdDist4 barFdDist5];

%Find linear regression of dMeasrd to dTrue

p = polyfit(dMeasrd, dTrue, 1);

grad = p(1);
incpt = p(2);

save('coeffecientsTaskOne.mat','grad','incpt')

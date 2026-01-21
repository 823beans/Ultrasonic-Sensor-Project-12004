clear;
close all;
clc;

%Initialise arduino & ultrasonic library
arduinoObj = arduino();
ultrasonicObj = ultrasonic(arduinoObj,'D11','D12');

%Retrieve coeffecients from .mat file
M = load('coeffecientsTaskOne.mat','grad','incpt');

%Initialise variables and collect true value
distTrue = input('Enter true distance: ');
grad = M.grad;
incpt = M.incpt;

%Measure distance with Ultrasonic Sensor

i =1; % i is our index variable
tic %starts stopwatch
while toc <= 10 %arduino will take measurements for 10 seconds
    dist(2,i) = readDistance(ultrasonicObj); %stores distance of reading
    dist(1,i) = toc; %stores timestamp for that reading of distance
    i = i + 1; %increases index value
end

% Filtering (applying moving average) and Correcting ( applying linear regression relationship) measurements 
calibratedDist = grad * dist(2,:) + incpt;

fltrDist = movmean(dist(2,:),10);
corrDist = movmean(calibratedDist,10);




%Plot a graph of raw data, filtered corrected data and true value against
%time

figure(67)
plot(dist(1,:),dist(2,:),dist(1,:),fltrDist,dist(1,:),corrDist)
yline(distTrue,'m-')
legend('Raw Data','Moving average','Corrected','True Value')


close all
clear
clc

arduinoObj = arduino();
ultrasonicObj = ultrasonic(arduinoObj,'D11','D12');
i = 1;
while 1
    dist(i , 1) = readDistance(ultrasonicObj);
    filtDist = movmean(dist, [10 0]);
    disp(['unfiltered:',num2str(dist(i,1))])
    disp(['filtered: ',num2str(filtDist(i,1))])
    pause(1)
    i = i +1;
end
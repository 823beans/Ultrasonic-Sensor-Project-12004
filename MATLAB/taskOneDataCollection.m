clear;
close all;
clc;

%Initialising Arduino and Ultrasonic sensor
arduinoObj = arduino('COM3','Uno','Libraries','Ultrasonic'); 
ultrasonicObj = ultrasonic(arduinoObj,'D11','D12');

%Main
i =1; % i is our index variable
tic %starts stopwatch
while toc <= 10 %arduino will take measurements for 10 seconds (20 SECONDS FOR 2 metres)
    dist(2,i) = readDistance(ultrasonicObj); %stores distance of reading
    dist(1,i) = toc; %stores timestamp for that reading of distance
    i = i + 1; %increases index value
end


%Creating plot/Creating data file from recorded information
figure(1)
plot(dist(1,:),dist(2,:))
xlabel('Time [s]')
ylabel('Distance [m]') 

 Distance = dist(2,:);
Time = dist(1,:);
 
save('TaskOneReadings5.mat','Time','Distance') %Change Filename to TaskOneReadings(number) to collect multiple datasets
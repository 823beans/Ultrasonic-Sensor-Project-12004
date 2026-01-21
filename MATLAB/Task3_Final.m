close all
clear
clc

arduinoObj = arduino();
ultrasonicObj = ultrasonic(arduinoObj,'D11','D12');
lightCal = 4.5;
i = 0;
sitting = 0;
present = 0;
tic
while i == 0
    sitting = 0; %set sitting and presence variables to false at start of loop
    present = 0;
    PhoVal = readVoltage(arduinoObj,'A1');
    if PhoVal < lightCal %lightCal is the maximum voltage we expect to be at the photodiode when the light is on
        present = 1;
    end
    distance = readDistance(ultrasonicObj);
    if distance < 0.8 %if the distance from the desktop to the floor is less than 0.8 m then the desk is in the sitting position
        sitting = 1;
    end
    disp(['Sitting: ', num2str(sitting), ' present: ', num2str(present)])
    if present == 1 && sitting ==1
        disp('Waiting')
        pause(10) %Real advice says that 30 minutes is the actual time you should spend sitting, but I am using 10 seconds to make the testing process faster
        disp('Stand up')
        for n = 1:10 
            writePWMVoltage(arduinoObj,'D9',1.2)
            pause(0.5)
            writePWMVoltage(arduinoObj,'D9',0)
            pause(0.25) %output in form of flashing LED and message telling user to stand up
        end
    end
end


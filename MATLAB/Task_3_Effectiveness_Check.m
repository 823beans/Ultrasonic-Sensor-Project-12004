close all
clear
clc

arduinoObj = arduino();
ultrasonicObj = ultrasonic(arduinoObj,'D11','D12');
lightCal = 4.5;
sittingTrue = input('Sitting true status?');
presentTrue = input('Present true status?');

for n = 1:1000
    distance(n,1) = readDistance(ultrasonicObj);
    present(n,1) = readVoltage(arduinoObj,'A1');
    if (sittingTrue == 1 && distance(n,1) < 0.8) || (sittingTrue == 0 && distance(n,1) > 0.8)
        sitSuccess(n,1) = 1;
    else
        sitSuccess(n,1) = 0;
    end
    if (presentTrue == 1 && present(n,1) < lightCal) || (presentTrue == 0 && present(n,1) > lightCal)
        presSuccess(n,1) = 1;
    else
        presSuccess(n,1) = 0;
    end
end

results = table((1:1000)', distance,present,sitSuccess,presSuccess,'VariableNames',{'test','distance [m]','V photodiode [V]',' Sitting status success [T/F]','Present status success [T/F]'});

disp(results)
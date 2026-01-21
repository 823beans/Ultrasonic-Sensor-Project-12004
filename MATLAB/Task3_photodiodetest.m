close all
clear
clc

arduinoObj = arduino();

tic
while 1
    PhoVal = readVoltage(arduinoObj,'A1');
    disp(PhoVal ...
        ...
        )
    if toc > 300
        break
    end
end

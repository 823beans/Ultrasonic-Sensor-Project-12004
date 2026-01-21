%ultrasonic test 1
clear
close all
clc

arduinoObj = arduino ('COM3','Uno','Libraries','Ultrasonic'); %board connection
ultrasonicObj = ultrasonic(arduinoObj,'D12','D11');
distance = readDistance(ultrasonicObj)
clear
close all
clc

arduinoObj = arduino();
ultrasonicObj = ultrasonic(arduinoObj,'D11','D12');
dist = ones([100,1]);

for n = 1 : 100
    dist(n) = readDistance(ultrasonicObj);
end

cleanDist = dist(isfinite(dist));
meanDist = mean(cleanDist);
sdDist = std(cleanDist);

m = 0;
for i = 1:100
    if isinf(dist(i)) || dist(i) < (meanDist - 3*sdDist) || dist(i) > (meanDist + 3*sdDist)
        m = m + 1;
    end
end
invalidDist = m;

disp(meanDist)
disp(sdDist)
disp(invalidDist)
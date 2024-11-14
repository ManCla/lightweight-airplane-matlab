% script to call the function for the simulation directly from matlab
% useful for debugging

clear

% define inputs
test_duration = 100.0;
dt = 0.001;
time = 0:dt:test_duration;
% the start altitude is 2000 and the input reference
% is offset to it in the symulink model
rate = 0.005; % rate of ramp per time unit
end_value = 300;
reference_altitude = [
    0*ones(1000,1);
    [0:rate:end_value]';
    end_value*ones(length(time),1); % make vector long enough
   ];
reference_altitude=reference_altitude(1:length(time)); % ensure same length

% call function
altitude = run_asbSkyHogg(test_duration,dt,reference_altitude);

%plot output

plot(altitude)

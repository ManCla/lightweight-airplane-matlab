%{
Inputs:
     - test_duration: duration of simulation
     - dt: sampling time of sim output (NOTE: Simulink uses a variable time step for the simulation)
     - speed_setpoint: speed valus over time (has to ba a matlab column vector)
     - drag_torque_load: load torque values over time (has to ba a matlab column vector)
%}

function output = run_asbSkyHogg(test_duration,dt,reference_altitude)

    simlk_filename = "asbSkyHogg";
    load('asbSkyHoggData.mat')

    time = [0:dt:test_duration]';
    reference_altitude = [time,reference_altitude];

    % create simulation input object and fill it with the needed values
    simIn = Simulink.SimulationInput(simlk_filename);
    simIn = setVariable(simIn,'statdyn',statdyn,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'test_duration',test_duration,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'dt',dt,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'reference_altitude',reference_altitude,'Workspace',simlk_filename);

    simIn = simIn.setModelParameter('SimulationMode','Rapid');
    % simIn = simIn.setModelParameter('RapidAcceleratorUpToDateCheck','off');
    % need to either send the variables as simulation input to the simulink
    % model or to change the scope of the simulink model to this function
    sim_output = sim(simIn);
    altitude = sim_output.sim_output;
    output = altitude;

end

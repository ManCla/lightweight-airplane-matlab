import numpy as np
import matlab.engine
import matplotlib.pyplot as plt

# start matlab engine
eng = matlab.engine.start_matlab()
print(" -- Matlab Engine Started")

# define inputs
# NOTE: - for matlab it is important that they are doubles (hence defined with the .0)
#       - arrays need to be cast to matlab arrays
#       - matlab function will add the time steps to the input arrays
test_duration = 100.0
dt = 0.001
n_steps = int(test_duration/dt)+1
end_value = 300
rate = 0.005
n_steps_ramp = int(end_value/rate)
# the second dimension (,1) is important to make these column vectors
reference_altitude = np.concatenate(#(np.zeros((1000,1)),
                                    #np.reshape(np.linspace(0,end_value,n_steps_ramp),(n_steps_ramp,1)),
                                    0*end_value*np.ones((n_steps,1)))#)
reference_altitude = reference_altitude[0:n_steps]

# run simulink model
print(" -- Start running Simulink model")
out = eng.run_asbSkyHogg(test_duration,
                         dt,
                         matlab.double(reference_altitude))
print(" -- Finished running Simulink model")
# convert matlab array to numpy array
out = np.array(out)

# plot the results
time = np.linspace(0,test_duration,n_steps).transpose()
plt.plot(time,reference_altitude)
plt.plot(time,out)
plt.show()

# close matlab engine
eng.quit()
print(" -- Matlab Engine Quit")

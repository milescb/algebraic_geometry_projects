import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import pandas as pd
from matplotlib import animation, rc
from IPython import display

data_file = "/Users/milescochran-branson/OneDrive - Lawrence University/3.1_classes/Algebriac_geometry/Problem_14_Write-Up/julia_code/data_values.csv"
df = pd.read_csv(data_file)

rc('animation', html='html5')

x1 = df.iloc[:,0]
x2 = df.iloc[:,1]
x3 = df.iloc[:,2]
x4 = df.iloc[:,3]

#Probs a better way to do this than just recreating the axes everytime...
#Didn't have time to optimzie 
def update_plot(theta):
    x1 = df.iloc[:,0]
    x2 = df.iloc[:,1]
    x3 = df.iloc[:,2]
    x4 = df.iloc[:,3]

    x1 = x1 * np.cos(theta) - x2 * np.sin(theta)
    x2 = x2 * np.sin(theta) + x2 * np.cos(theta)

    x = x1 / (1 - x4)
    y = x2 / (1 - x4)
    z = x3 / (1 - x4)

    ax = Axes3D(fig)
    ax.set_xlim(-2, 2)
    ax.set_ylim(-2, 2)
    ax.set_zlim(-2, 2)
    ax.set_axis_off()
    plot = ax.scatter(x, y, z, alpha = 0.2)

    return plot

theta = 0;

x1 = x1 * np.cos(theta) - x2 * np.sin(theta)
x2 = x2 * np.sin(theta) + x2 * np.cos(theta)
x3 = x3
x4 = x4

x = x1 / (1 - x4)
y = x2 / (1 - x4)
z = x3 / (1 - x4)

fig = plt.figure()
ax = Axes3D(fig)

ax.scatter(x, y, z, alpha = 0.2)

ax.set_axis_off()

ax.set_xlim(-2, 2)
ax.set_ylim(-2, 2)
ax.set_zlim(-2, 2)

#numFrames = np.linspace(0.0, 4 * np.pi, 200)
numFrames = np.linspace(0.0, 2 * np.pi, 120)
anim = animation.FuncAnimation(fig, update_plot, frames = numFrames, interval = 1000000, blit = False, save_count = 1500)

#plt.show()

f = r'/Users/milescochran-branson/Desktop/animation.mp4'
writervideo = animation.FFMpegWriter(fps=60) 
anim.save(f, writer=writervideo)
plt.close()
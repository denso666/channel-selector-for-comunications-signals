import matplotlib.pyplot as plt
from random import randint
from math import cos, pi

########################
#       CONSTANTS
########################
A = 0.6
f = 1

########################
#       FUNCTIONS
########################
w = lambda _f : 2 * pi * _f
m = lambda _t : A * cos( w( f ) * _t )
n = lambda : randint( 0, 1 ) * A

########################
#       PLT CONFIG
########################
plt.xlabel('Time (t)')
plt.ylabel('Volts (v)')
plt.title('Better Channel')
plt.grid( True )


if __name__ == '__main__':
    ts = 1/30

    pilot = plt.plot(
        [ m( i * ts ) for i in range(0, 30) ],
        color = "blue",
        linestyle = "dashed",
        marker = "o"
    )

    noise = plt.plot(
        [ ( m( i * ts ) + n() ) for i in range(0, 30) ],
        color = "red",
        linestyle = "dashed"
    )

    plt.show()
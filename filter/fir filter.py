import numpy as np
import matplotlib.pyplot as plt
def todecimal(x,bits):
    assert len(x) <=bits
    n=int(x,2)
    s=1<<(bits-1)
    return (n & s - 1) - (n & s)
tap=8
n1=8
n2=16
n3=32
real_coeff=(1/tap);
coeff_bit=np.binary_repr(int(real_coeff*(2**(n1-1))),n1) #convert coefficient to binary

#generate a test sequence

timeVector=np.linspace(0,2*np.pi,100)
output=np.sin(2*timeVector) + np.cos(3*timeVector) + 0.3*np.random.randn(len(timeVector)) 
plt.plot(output)
plt.show()


list1=[]
for number in output:
    list1(np.binary_repr(int(number*(2**(n1-1))),n2))
with open('input.txt','w') as file:
    for number in list1:
        file.write(number + 'in')

    file.close()
    
        



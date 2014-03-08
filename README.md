ECE281_CE3
==========

_ECE 281 Moore and Melay Elevator Controls_
This lab uses both a Moore and Mealy state device to simulate an elevator moving from floor to floor.

Put simply, "In  _Moore machines_ the outputs depend only on the current state of the machine. In _Mealy machines_, the outputs depend on both the current state and the current inputs" (Digital Design 123). These state machines provide additional capabilites over combinational logic circuits because they have a form of temporary memory which can be used to determine the next state and output. Additionally, these circuits are synchronous because they only change on the rising edge of the clock cycle. This is crucial to keeping everything in-line and correct.

###Defining States
One of the handy features of VHDL is the ability to define new states. In this exercose, _floor_ _ _state_ was defined as either floor1, floor2, floor3, or floor4. What's more, each state was given a respective logic value of 0001, 0010. 0011, and 0100. The connection of logic values to states made it simple to simulate the design in a self chaecking testbench which insured that the elevator moved properly.

###Moore Simulation
This is the simulation of the Moore contorl. It shows the elevator starting at the first floor and moving up one floor at a time, where it stops before moving on. Once it reaches the top it descends back down.
![alt text](https://github.com/byarbrough/ECE281_CE3/blob/master/Moore_screenshot.PNG?raw=true "Moore Testbench")

The simulation shows _reset_ at HIGH, putting the elevator to floor1, indicated by _floor = "0001"_. After this, the elevator goes up one floor at a time, pausing at each floor. Again, _floor_ reads the binary value of the floor. Furthermore, _expected_ _ _floor_ indicates which floor the elevator is expected on. Notice that there is a delay between when this value changes and when the elevator actually gets there. This is because the controller is programed to change only on rising clock edges. This means that the inputs can change but the change is only reflected when the clock cycles from LOW to HIGH.

###Mealy Simulation
Below is the simulation for the Mealy control. The VHDL for this machine is very similar to that of the Moore because it is a relatively circuit and they both do the same thing. The two major differences is the account for inputs creating a direct change and the addition of the nextfloor output.
![alt text](https://github.com/byarbrough/ECE281_CE3/blob/master/Mealy_screenshot.PNG?raw=true "Mealy Testbench")
The Mealy simulation is very similar to the Moore simulation. The testbench code is almost identical because the machines are designed to do the exact same thing. The main differnce is the difference in timing between the two machines. With the Mealy machines, there is more of a step appearance; the expected floor changes and then the actual floor does. This is due to the key differnce between the two machiens: the inputs impact outputs.


###Design Speedbumps
The first hurdle that I had to navigate was in the testbench. I set reset to 1 (sending the elevator to the first floor) but then forgot to set it back down to zero. As a result, the initial simulation had the elevator never coming off the first floor. Eventually, I identified this and it was an easy fix.

Additionally, it took some figuring to determine how to make the change between a Moore and Mealy machine. Although I understood the conceptual difference between the two, it was not until after conversation with others in the class that I realized to change the sensitivities which trigger the process.

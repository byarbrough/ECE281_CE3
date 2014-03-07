ECE281_CE3
==========

_ECE 281 Moore and Melay Elevator Controls_
This lab uses both a Moore and Mealy state device to simulate an elevator moving from floor to floor.

Put simply, a Moore machine is

###Defining States
One of the handy features of VHDL is the ability to define new states. In this case, floor_state was defined as either floor1, floor2, floor3, or floor4. What's more, each respective state was given a respective logic value of 0001, 0010. 0011, and 0100 respectively. The connection of logic values to states made it simple to simulate the design in a self chaecking testbench which insured that the elevator moved properly.

###Moore Simulation
This is the simulation of the Moore contorl. It shows the elevator starting at the first floor and moving up one floor at a time, where it stops before moving on. Once it reaches the top it descends back down.
![alt text](https://github.com/byarbrough/ECE281_CE3/blob/master/Moore_screenshot.PNG?raw=true, "Moore Testbench")

The simulation shows _reset_ at HIGH, putting the elevator to floor1, indicated by _floor = "0001"_. After this, the elevator goes up one floor at a time, pausing at each floor. Again, _floor_ reads the binary value of the floor. Furthermore, _expected_ _ _floor_ indicates which floor the elevator is expected on. Notice that there is a delay between when this value changes and when the elevator actually gets there. This is because the controller is programed to change only on rising clock edges. This means that the inputs can change but the change is only reflected when the clock cycles from LOW to HIGH.

###Design Speedbumps
The first hurdle that I had to navigate was in the testbench. I set reset to 1 (sending the elevator to the first floor) but then forgot to set it back down to zero. As a result, the initial simulation had the elevator never coming off the first floor. Eventually, I identified this and it was an easy fix.

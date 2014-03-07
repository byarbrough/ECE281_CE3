ECE281_CE3
==========

_ECE 281 Moore and Melay Elevator Controls_

###Moore Simulation
This is the simulation of the Moore contorl. It shows the elevator starting at the first floor and moving up one floor at a time, where it stops before moving on. Once it reaches the top it descends back down.
![alt text](https://github.com/byarbrough/ECE281_CE3/blob/master/Moore_screenshot.PNG?raw=true, "Moore Testbench")

###Design Speedbumps
The first hurdle that I had to navigate was in the testbench. I set reset to 1 (sending the elevator to the first floor) but then forgot to set it back down to zero. As a result, the initial simulation had the elevator never coming off the first floor. Eventually, I identified this and it was an easy fix.

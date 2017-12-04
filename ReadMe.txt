Project

Runing project.m 
In order to run the script 3 variables need to be passed to the function
for example:
	Project('Fig-11-b.jpg', 1, 0)

The first is the image you would like to run it on.
	'Your Image Name'

The second value is your choice of filter. At this time we have:
1. anisodiff
2. Leung-Malik
3. Schmid
4. Closing

The third value is if you would like to use a closing morph and when:
0. None
1. At the end
2. At the start
3. End and start
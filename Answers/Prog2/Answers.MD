2. Vector utilization when sweeping sizes
****************** Printing Vector Unit Statistics *******************
Vector Width:              2
Total Vector Instructions: 203782
Vector Utilization:        86.2%
Utilized Vector Lanes:     351182
Total Vector Lanes:        407564
************************ Result Verification *************************
****************** Printing Vector Unit Statistics *******************
Vector Width:              4
Total Vector Instructions: 118197
Vector Utilization:        79.8%
Utilized Vector Lanes:     377274
Total Vector Lanes:        472788
************************ Result Verification *************************
****************** Printing Vector Unit Statistics *******************
Vector Width:              8
Total Vector Instructions: 64417
Vector Utilization:        76.5%
Utilized Vector Lanes:     394298
Total Vector Lanes:        515336
************************ Result Verification *************************
****************** Printing Vector Unit Statistics *******************
Vector Width:              16
Total Vector Instructions: 33687
Vector Utilization:        74.9%
Utilized Vector Lanes:     403770
Total Vector Lanes:        538992
************************ Result Verification *************************

Vector utilization when down as size increases.  My guess is because as
vector size increased so did the change that there was a big difference
between the largest and smallest exponent sizes.  So all the other lanes 
that had finished would be inactive as we waited for the largest exponent 
to finish looping.



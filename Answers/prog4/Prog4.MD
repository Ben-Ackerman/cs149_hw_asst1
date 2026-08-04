1. Speedup with starter code
```
[sqrt serial]:		[570.678] ms
[sqrt ispc]:		[139.752] ms
[sqrt task ispc]:	[20.502] ms
(4.08x speedup from ISPC)
(27.84x speedup from task ISPC)
```

2-3. For the best case scenario on speedup we want a case where we get minimal utilization of the 
SIMD lanes.  So a values array where 1 value take a long time to calc and the other 7 (SIMD width of 8)
finish quickly.  All 8 lanes will need to run instructions until the slow lane value completes.
In Fast Inverse Square, small values near zero are slow, and 1 is the fastest if our initial guess is 1 (where x is Initial guess ^ 2).
For fastest speed up I want all values to be a slow calc so we fully benefit from all 8 lanes being used for every
instruction.  I used 0.00000000000001f to represent a slow calc value as an example.  The smallest positive value is the one we want to use
to generate the best case speedup.
Results on my machine
Best case
```
[sqrt serial]:		[1697.716] ms
   [sqrt ispc]:		[496.411] ms
   [sqrt task ispc]:	[75.378] ms
   (3.42x speedup from ISPC)
   (22.52x speedup from task ISPC)
```
Worst case
```
[sqrt serial]:		[219.195] ms
[sqrt ispc]:		[486.407] ms
[sqrt task ispc]:	[88.913] ms
(0.45x speedup from ISPC)
(2.47x speedup from task ISPC)
```
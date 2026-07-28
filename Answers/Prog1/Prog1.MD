## Learnings.
The M4 mac I ran this one has 10 cores, 4 performance and 6 efficiency (No hyperthreading)

First I tried to achieve the speedup by breaking rows into horizontal partitions and having each thread do one partition.
However, when I graphed out the speedup by number of cores, I could notice that when the thread count was odd it was
actually slower than when the previous even thread count.
After adding the instrumentation inside workerThreadStart I could see this is because program speedup was being slowed down
by the slowest thread (middle).

e.g
```
With three threads
[mandelbrot thread time for threadId 2]:		[51.492] ms
[mandelbrot thread time for threadId 1]:		[150.153] ms
[mandelbrot thread time for threadId 0]:		[52.045] ms
```

```
With two threads
[mandelbrot thread time for threadId 1]:		[118.588] ms
[mandelbrot thread time for threadId 0]:		[118.595] ms
```

Notice in the three thread example the middle thread is much slower (According to Copilot Mandelbrot does much more work
for the middle rows).

So I changed my code to interleave threads so each thread round robins the work for each row.  This gave me a much more 
even speedup.

The speedup appears to top out around ~10 threads.  This makes sense with the M4 having 10 threads.

Doubling the number of threads didn't make a difference.  This adds up with there being no hyperthreading.




## Part 1
1. The maximum speedup with 100% utilization would be 8x. 
However, utilization will be much lower when one instance has much
more work to do than other instances in its gang. For example when
doing view two with tasks and there is lost of spindly fractal arms 
and less blob like shapes I saw the speedup drop from ~20% with view 1 
to ~15%.

## Part 2
1.  I saw a new 2x speed up when using --tasks vs the plain ISPC version
2.  I determined the amount that works best by increasing the launch task
number until I saw diminishing returns. (Note height must be divisible by
number of tasks to maintain correctness.)  Around 80 I started seeing more
variance between runs than benefits from increasing.
```
The official ISPC guidance is only:
“One should launch many more tasks than there are processors in the system to ensure good load-balancing, but not so many that the overhead of scheduling and running tasks dominates the computation.”

```
[Source: ISPC User’s Guide — Task Parallelism](https://ispc.github.io/ispc.html#task-parallelism-launch-and-sync-statements.
On my m4 mac I have around 10 hardware threads, so I did expect the number to be greater than 10.

3.  The threading example in program one was using OS threads.  ISPC uses a user provided
task runner instead.  If the user doesn't provide one it uses the default built in one.
Because tasks have less overhead than creating an OS thread it is less costly to overprovision them
Tasks are run concurrently rather than in parallel.  Which means the task runner decides the size
of the thread pool.  So if we provision 80 tasks but the runner only has one thread
than our tasks will all run on the same thread

For the bonus question:
ChatGPT answer
`foreach` and `launch` target two different levels of parallel hardware:
- `foreach` distributes iterations across the SIMD lanes of one ISPC program instance—a “gang.” The gang usually runs on a single CPU core.
- `launch` creates multiple independent ISPC tasks, which the task system can schedule across multiple CPU cores. Each task still uses SIMD internally.

In principle, an ISPC implementation could automatically split every `foreach` across cores. In practice, that would require deciding when parallel execution is profitable, creating and scheduling tasks, synchronizing at the end, handling nested loops, and preserving assumptions about shared state and execution order. For small loops, that overhead could easily make the program slower. Automatic partitioning could also cause unpredictable performance and oversubscription when the caller is already using threads.
Keeping the mechanisms separate therefore gives the programmer explicit control over granularity:

```text
launch tasks across cores
    └── foreach iterations across SIMD lanes on each core
```
So they are complementary rather than redundant: `launch` expresses coarse-grained multicore parallelism, while `foreach` expresses fine-grained SIMD parallelism. A runtime or higher-level framework could combine them automatically, but ISPC deliberately exposes the distinction so performance costs and scheduling remain predictable.

Also [see original paper](https://ispc.github.io/papers/ispc_inpar_2012.pdf) which talks about interoperability with existing application task systems
"Any complex multi-core C++ application typically has
its own task system or thread pool, which may be custom
designed or may be an existing one such as Microsoft’s Con-
currency Runtime, or Intel Thread Building Blocks. To in-
teroperate with the application’s task system, ispc allows
the user to provide a callback to a task enqueue function,
and then uses this callback to enqueue asynchronous tasks."
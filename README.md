# Economic Load Dispatch

Economic Load Dispatch for **thermal generators** *with* and *without* losses for MATLAB and Python. Algorithms are based on Power Generation, Operation, and Control, Allen J. Wood, Bruce F. Wollenberg, Gerald B. Sheblé (2013).

Economic load dispatch without losses uses the following methods:
* Binary search method: <code>binary_search(data, PD)</code>
* Iterative lambda method: <code>iterative_lambda(data, PD)</code>

Economic load dispatch with losses uses iterative method. Power loss function maximum degree is 2nd order:
* Iterative with losses: <code>iterative_w_losses(data, PD, Ploss)</code>

## How to use (Python)
1. Download <code>ELD.py</code>
2. Create a Jupyter Notebook in the same folder.
3. <code>from ELD import X</code>, where X is the name of the methods mentioned above.
4. Create a <code>numpy.array()</code> containing the cost functions and their generation limits in the form of: <code>[a, b, c, Pmin, Pmax]</code>. See [tutorial](https://github.com/kypexfly/economic-load-dispatch/new/master?readme=1).
5. Call the function.

## Notes
* If you find any error/problem I would appreciate any feedback.
* Code might not work as intented, it's not finished yet imo.
* MATLAB code is being developed, but it's almost the same as Python code. Note that MATLAB runs faster than Python but for everyday case you wouldn't note it.

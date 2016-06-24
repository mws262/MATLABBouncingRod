# Bouncing & sliding rod simulator
## ODE45 event detection example

This is an example of how event detection works in MATLAB with integrator ODE45. A simple rod bounces and tumbles on flat ground until it finally begins sliding.

### Files:
1. MAIN_simulate.m -- Run this first!
2. deriveCollisions.m -- Derives contact map equations to determine how the rod acts after a collision. This file auto-generates:
    * DiscreteCollisionsPt1.m
    * DiscreteCollisionsPt2.m
3. slidingPhase.m -- Equations of motion for the sliding rod.
4. flightPhase.m -- Equations of motion for the flying rod.
5. contact.m -- Conditions passed to ODE45 so it can determine when events occur and what to do.
6. animate.m -- Draw the scene and show what happened during the simulation.

### Video:
https://www.youtube.com/watch?v=G5IpQ53SY6A
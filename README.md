# ANCF_beam

Matlab simulation of a flexible beam modeled with gradient-deficient ANCF beam elements.

## 1. Set problem parameters by modifying the file `ancf_params.m`  

These include:
  - total length (L)
  - radius (r)
  - number of ANCF cable elements (ne)
  
as well as material properties:
  - elasticity modulus (p.E)
  - material density (p.rho)
  
and the end constraints (0: free, 1: ball joint, 2: weld joint)
  - left side (p.leftCnstr)
  - rightSide (p.rightCnstr)

The default parameter values correspond to a cable of length 3 and radius 0.02, clamped at both ends and modeled using 5 ANCF cable elements.  The elasticity modulus is 2e7 and density 7200.

## 2. Call the `ancf_beam` function

Specify
  - duration (TEND)
  - step-size (H)
  - integration method (METHOD)
  
```matlab
ancf_beam   Simulate a flexible noodle modeled with ANCF beam elements
 [data,params] = ancf_beam(TEND, H, METHOD) simulates a noodle over the
   time interval [0,TEND] using a step-size H and the specified method:
   'newmark' - use a DAE formulation and Newmark integration
   'rk2'     - use an ODE formulation and an RK2 method (change value
               'a' in ODE_rk2 to select a different RK2 method; default 
               is midpoint)
   'euler'   - use an ODE formulation and forward Euler integration
```

-------

Sample results

```
>> [data, params] = ancf_beam(1, 1e-3, 'newmark')

data = 

  struct with fields:

      t: [1×1001 double]
      e: [36×1001 double]
     ed: [36×1001 double]
    edd: [36×1001 double]
    lam: [12×1001 double]


params = 

  struct with fields:

            ne: 5
             n: 36
             L: 0.6000
             E: 20000000
             A: 0.0013
             I: 1.2566e-07
           rho: 7200
             g: [3×1 double]
     leftCnstr: 2
    rightCnstr: 2
```

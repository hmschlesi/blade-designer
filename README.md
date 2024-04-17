## Blade Designer
### A tool for perfomance analysis and CAD geometrie generation for wind turbines

This repository includes the executable files for the blade designer as well as it's matlab source code and solidworks makro which handles the geometry generation for the blades and the turbine hub.

The blade is definied by the amount of blades, the Tip Speed Ratio (TSR) as well as the blade diameter and the wind speed at operating point. The blade can be constructed from several airfoils, which can be chosen individually from an integrated airfoil library which stores the profile coordinates as well as the lift and drag coefficent for multiple Angle of Attack. The performance for a design can be evaluated with the help of an integrated Blade Element Method (BEM) which plots the pressure coefficent over TSR and Power over Rotations per Minute. The desing is translated autmatically into a part file for SolidWorks. As a result the hub, the nacell and the blades are created as parts files and combined together in a conceisive assembly.

![Blade Designer Interface](https://github.com/hmschlesi/blade-designer/blob/main/Tool/Screenshot%202024-04-17%20at%2011.30.12.png)

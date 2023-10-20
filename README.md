# DiTTA - Digital Twins for UAVs

![UAV Image](/data/uavDrone.jpg)

## Overview

DiTTA is a project focused on creating digital twins for Unmanned Aerial Vehicles (UAVs) using Ansys Workbench. Digital twins are virtual representations of physical objects, and in this context, they enable comprehensive simulations and analysis of UAV performance and behavior.

This repository contains the following subdirectories:

- [Documentation](#documentation)
- [Simulation](#simulation)
- [Automation](#automation)

## Documentation

The [Documentation](Documentation/) directory contains project-related documentation, design details, and reports. Here, you can find:

- [SciTech 2024 Paper](https://livecsupomona-my.sharepoint.com/personal/zsotoudeh_cpp_edu/_layouts/15/onedrive.aspx?FolderCTID=0x01200025FDA34211638947843A3910CE2D5718&id=%2Fpersonal%2Fzsotoudeh%5Fcpp%5Fedu%2FDocuments%2FARO%2DCS%2DDitta%20Project%20%28Digital%20Twin%29%2F2023%2D2024%2Fto%2Dstart%2FScitech2024%2DDiTTA%2Epdf&parent=%2Fpersonal%2Fzsotoudeh%5Fcpp%5Fedu%2FDocuments%2FARO%2DCS%2DDitta%20Project%20%28Digital%20Twin%29%2F2023%2D2024%2Fto%2Dstart)

## Simulation

The [Simulation](https://github.com/DraitonT/DiTTA-ARO/tree/master/Simulation) directory houses Ansys Workbench project files (.wbpj) used for UAV digital twin simulations. Each subdirectory within this folder corresponds to a specific simulation or analysis task.
- [Beam.wbpj](https://github.com/DraitonT/DiTTA-ARO/blob/master/Simulation/Beam.wbpj): Ansys Workbench project files for damaged beam runs.

## Automation

The [Automation](https://github.com/DraitonT/DiTTA-ARO/tree/master/Automation) directory contains automation scripts and tools used to streamline and automate various aspects of the simulation and post-processing workflow. These scripts are written in [Python](https://www.python.org/) for Ansys DesignModeler and [Javascript](https://www.w3schools.com/Js/) and help with tasks such as modeling, data extraction, result visualization, and batch processing.

### Ansys DesignModeler
- [ansysDesignModelerExample.js](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/DesignModeler/ansysDesignModelerExample.js): Example of utilizing the Ansys DesignModeler API, provided by Ansys to provide a holistic overview of using their functions. 
- [beamModel_mm.js](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/DesignModeler/beamModel_mm.js): Modeling a beam with a cut using mm.
- [beamModel_inches.js](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/DesignModeler/beamModel_mm.js): Modeling a beam with a cut using inches.


### Ansys Mechanical
- [ansysMechanicalExample.py](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/Mechanical/ansysMechanicalExample.py): Example of utilizing the Ansys Mechanical's API to automate analysis and simulations, provided by Ansys to provide a holistic overview of using their functions.
- [beamSim.py](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/Mechanical/beamSim.py): Simulating a load on the Beam Model (For demo purposes only, using the files in Simulation and follow the powerpoint documentation)
- [solutionsAndExport.py](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/Mechanical/solutionsAndExport.py): Adds the key structural analysis objects to the model and exports the results out to the desired folder.

### Parsing
- [resultsCombiner.m](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/Parsing/resultsCombiner.m): Combines the results collected from [solutionsAndExport.py](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/Mechanical/solutionsAndExport.py) into a single .csv file.

## Getting Started

To get started with DiTTA, follow these steps:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/DraitonT/DiTTA-ARO.git
2. Run the [Beam.wbpj](https://github.com/DraitonT/DiTTA-ARO/blob/master/Simulation/Beam.wbpj)
3. Alter the location of the crack with Ansys DesignModeler
4. Go to Ansys Mechanical and run [solutionsAndExport.py](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/Mechanical/solutionsAndExport.py) to run the analysis and export the results from the simulation to text files
5. Run [resultsCombiner.m](https://github.com/DraitonT/DiTTA-ARO/blob/master/Automation/Parsing/resultsCombiner.m) to combine all the results into 1 CSV using MATLAB.

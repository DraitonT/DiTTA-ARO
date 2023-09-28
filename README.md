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

The [Simulation](Simulation/) directory houses Ansys Workbench project files (.wbpj) used for UAV digital twin simulations. Each subdirectory within this folder corresponds to a specific simulation or analysis task.
- [Beam Simulation](Simulation/Beam.wbpj): Ansys Workbench project files for damaged beam runs.
- [Test](Simulation/test.wbpj): A playground hosting Ansys Workbench project files to test out new features with the Automation scripts.

## Automation

The [Automation](Automation/) directory contains automation scripts and tools used to streamline and automate various aspects of the simulation and post-processing workflow. These scripts are written in [Python](https://www.python.org/) for Ansys DesignModeler and [Javascript](https://www.w3schools.com/Js/) and help with tasks such as modeling, data extraction, result visualization, and batch processing.

### Ansys DesignModeler
- [DesignModeler Example](Automation/DesignModeler/ansysDesignModelerExample.js): Example of utilizing the Ansys DesignModeler API, provided by Ansys to provide a holistic overview of using their functions. 
- [Beam Modeler](Automation/DesignModeler/beamModel.js): Modeling a beam with a cut.

### Ansys Mechanical
- [Mechanical Example](Automation/Mechanical/ansysMechanicalExample.py): Example of utilizing the Ansys Mechanical's API to automate analysis and simulations, provided by Ansys to provide a holistic overview of using their functions.
- [Beam Simulation](Automation/Mechanical/beamSim.py): Simulating a load on the Beam Model.

## Getting Started

To get started with DiTTA, follow these steps:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/DiTTA.git

Triangle Mesh Toolbox
version 0.31

Patricio Simari
July 13, 2016

To use the toolbox, include it in your Matlab path using File > Set Path… > Add Folder.

For documentation on each function, use the "help" or "doc" command in the Matlab prompt followed by the function name.

Example:

>> doc meshLoad

Version History

0.31 Added function to load ply format meshes. Mesh loading now skips header lines (those starting with '#') in off files. Corrected a typo in meshSubdivide.

0.3 Added functions for clearing mesh fields, mesh simplification, simple subdivision, field smoothing, vertex adjacencies, exporting mesh fields, as well as removing repeated faces, vertices, sliver faces and unreferenced vertices. Fixed bug in OFF loading function and added .tri format support for export.

0.2: Added functions for computing mesh attributes such as average edge length, bounding box diagonal and volume, face and vertex normals and areas, and face centroids. These are stored as new fields in the mesh structure and can be cleared using the meshClearFields function. A wrapper for mesh decimation is provided in meshSimplify. A discrete curvature estimator is provided in meshLaplaceBeltramiOperator, and functions for generating analytic meshes and their analytic curvature values are also provided. Vertex and face color support is added to meshPlot and a specialized version is provided in meshPlotCurvature in order to normalize curvature ranges in a scale invariant way.

0.1: support for loading from and exporting to simple off and obj files and for plotting meshes.

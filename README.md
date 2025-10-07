# MATLAB_figures_scripts
This repository provides a set of MATLAB utility functions for figure handling, formatting, and exporting, especially for integration with LaTeX documents and Simulink diagrams.

## Functions

- **multisaveFig**  
  Save the current figure or a Simulink block diagram in multiple formats (`.fig`, `.png`, `.svg`).  
  Useful for quickly exporting figures in both editable and publication-ready formats.

- **resize_figure**  
  Resize the current figure to match LaTeX `\includegraphics` scaling (fraction of A4 page width).  
  Ensures exported figures appear at the correct size in LaTeX documents.

- **figure_setup**  
  Configure global default figure settings (font sizes, line widths, LaTeX interpreters).  
  Optionally restore all properties to their factory defaults.

- **defaultcolors**  
  Return colors from a predefined default palette as hex codes.  
  Supports indexed access, special "herder"/"target" colors, and a "show" mode to visualize the palette.

- **triquiver**
  Draw triangular arrowheads instead of quiver arrows.
  Supports the same arguments as `quiver()`.

- **curvedArrow**
  Draw curved arrow. Useful for diagrams.


---

Each function is self-contained and can be added to your MATLAB path independently.  

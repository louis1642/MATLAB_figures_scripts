function resize_figure(perc)
% resize_figure: Resize the current figure to match LaTeX \includegraphics scaling.
%
% Syntax:
%   resize_figure(perc)
%
% Arguments:
%   perc : (numeric) Fraction of the A4 page width (21 cm) that the figure should occupy.
%
% Description:
%   This function resizes the current figure so that its physical size (in centimeters)
%   matches the dimensions specified when inserting it into a LaTeX document using
%   \includegraphics.  
%
%   For example, when including a figure with:
%       \includegraphics[width=0.5\textwidth]{filename}
%   one should first call:
%       resize_figure(0.5)
%   to ensure that the exported figure has the correct width (0.5 * 21 cm) and preserves
%   its aspect ratio. The constant 21 corresponds to the width of a standard A4 page.
%
% Notes:
%   - The figure’s Units property is temporarily set to centimeters to adjust its size,
%     and then restored to its original value without altering the resized dimensions.
%
% See also: saveas, print, exportgraphics

    fig = gcf;
    oldUnits = get(fig, "Units");  % Store original units
    set(fig, "Units", "centimeters");

    pos = get(fig, "Position");
    ratio = pos(4) / pos(3);

    newW = 21 * perc;
    newH = newW * ratio;

    set(fig, "Position", [pos(1:2) newW newH]);

    set(fig, "Units", oldUnits);  % Restore original units

end

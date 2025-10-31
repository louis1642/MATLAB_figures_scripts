function resize_figure(x, options)
% resize_figure: Resize the current figure to match LaTeX \includegraphics scaling.
%
% Syntax:
%   resize_figure(x)
%
% Arguments:
%   x : (numeric) Fraction of the A4 page width (21 cm) that the figure should occupy.
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

arguments
    x (1,1) {mustBeNumeric}
    options.Unit string {mustBeMember(options.Unit,["percentualOfA4", ...
                    "percentualOfUSletterColumn", "percentualOfUSletterFull", ...
                    "centimeters", "points", "pixels"])} = "percentualOfA4"
end

    fig = gcf;
    oldUnits = get(fig, "Units");  % Store original units and wstyle
    oldWindowStyle = get(fig,'WindowStyle');
    set(fig, "Units", "centimeters");
    set(fig, 'WindowStyle', 'normal');

    pos = get(fig, "Position");
    ratio = pos(4) / pos(3);

    switch options.Unit
        case "percentualOfA4"
            newW = 21 * x;
        case "percentualOfUSletterColumn"
            newW = 8.63477 * x;
        case "percentualOfUSletterFull"
            newW = 17.77747 * x;
        case "centimeters"
            newW = x;
        case "points"
            set(fig, "Units", "points");
            newW = x;
            set(fig, "Units", "centimeters");
        case "pixels"
            set(fig, "Units", "pixels");
            newW = x;
            set(fig, "Units", "centimeters");
    end

    newH = newW * ratio;

    set(fig, "Position", [pos(1:2) newW newH]);

    set(fig, "Units", oldUnits);  % Restore original units and wstyle
    set(fig, 'WindowStyle', oldWindowStyle);

end

function figure_setup(arg)
% FIGURE_SETUP Configure or restore default figure properties.
%
%   figure_setup() 
%       Sets default properties for figures, axes, text, legends, colorbars, 
%       and lines to standardized values, including font sizes, line widths, 
%       and LaTeX interpreters.
%
%   figure_setup('restore') 
%       Restores all figure, axes, text, legend, colorbar, and line properties 
%       to their factory defaults.
%
% Inputs:
%   arg (optional) - string
%       If omitted, default styling is applied.
%       If 'restore', all settings are reset to factory defaults.
%
% Notes:
%   - Affects global defaults via the root graphics object (groot).
%   - Does not modify properties of existing figures, only newly created ones.

    
    axes_font_size = 15;
    text_font_size = 15;
    legend_font_size = 13;
    colorbar_font_size = 13;
    line_width = 2;

    if nargin == 0
        set(groot, ...
        'DefaultFigureWindowStyle'          , 'normal', ...
        'DefaultAxesFontSize'               , axes_font_size , ...
        'DefaultTextFontSize'               , text_font_size , ...
        'DefaultLegendFontSize'             , legend_font_size , ...
        'DefaultColorbarFontSize'           , colorbar_font_size , ...
        'DefaultLineLineWidth'              , line_width, ...
        'DefaultTextInterpreter'            , 'latex', ...
        'DefaultLegendInterpreter'          , 'latex', ...
        'DefaultAxesTickLabelInterpreter'   , 'latex' ...
        );
    elseif ischar(arg) && strcmpi(arg,'restore')
        % reset(groot)
        facFigWinStyle = get(groot, 'factoryFigureWindowStyle');
        facAxesSz      = get(groot, 'FactoryAxesFontSize');
        facTextSz      = get(groot, 'FactoryTextFontSize');
        facLegendSz    = get(groot, 'FactoryLegendFontSize');
        facColorbarSz  = get(groot, 'FactoryColorbarFontSize');
        facLineWidth   = get(groot, 'factoryLineLineWidth');
        facTextIntepr  = get(groot, 'factoryTextInterpreter');
        facLegInterpr  = get(groot, 'factoryLegendInterpreter');
        facAxTickInter = get(groot, 'factoryAxesTickLabelInterpreter');
    
        set(groot, ...
            'DefaultFigureWindowStyle',         facFigWinStyle, ...
            'DefaultAxesFontSize',              facAxesSz, ...
            'DefaultTextFontSize',              facTextSz, ...
            'DefaultLegendFontSize',            facLegendSz, ...
            'DefaultColorbarFontSize',          facColorbarSz, ...
            'DefaultLineLineWidth',             facLineWidth, ...
            'DefaultTextInterpreter',           facTextIntepr, ...
            'DefaultLegendInterpreter',         facLegInterpr, ...
            'DefaultAxesTickLabelInterpreter',  facAxTickInter);
    else
        error("Function figure_setup only accepts 'restore' argument to restore factory settings.")
    end



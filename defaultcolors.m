function c = defaultcolors(idx)
    %DEFAULTCOLORS Returns colors from a predefined default palette.
    %
    %   c = defaultcolors()  
    %       Returns the entire default palette as a column vector of hex
    %       color codes.
    %
    %   c = defaultcolors(idx)  
    %       Returns colors corresponding to the numeric indices in `idx`.
    %       If `idx` exceeds the palette length, colors wrap around
    %       cyclically (modulo indexing).  
    %       - idx must be a numeric, nonnegative vector.
    %
    %   c = defaultcolors("show")  
    %       Displays the default palette in a figure, with each color
    %       rendered as a block and labeled with its index.
    %
    %   c = defaultcolors("h")  
    %       Returns the default "herder" color (`#0000FF`).
    %
    %   c = defaultcolors("t")  
    %       Returns the default "target" color (`#FF00FF`).
    %
    % Outputs:
    %   c - One or more hex color codes (string array).
    %
    % Example:
    %   c1 = defaultcolors(1);       % Get the first color
    %   c2 = defaultcolors([2 4 6]); % Get a set of indexed colors
    %   defaultcolors("show");       % Visualize the palette

    
    dc = ["#0072BD", "#D95319", "#EDB120", "#7E2F8E", ...
          "#77AC30", "#4DBEEE", "#A2142F"]';
    
    % Handle the "show" command
    if nargin>0 && strcmpi(idx, "show")
        figure('Color','w');
        hold on
        for i = 1:numel(dc)
            % draw a color block
            rectangle('Position',[i-1,0,1,1], ...
                      'FaceColor',dc(i), ...
                      'EdgeColor','none');
            % label with index
            text(i-1+0.5, 0.7, num2str(i), ...
                 'HorizontalAlignment','center', ...
                 'FontWeight','bold','FontSize',12);
            % % label with hex code
            % text(i-1+0.5, 0.3, dc(i), ...
            %      'HorizontalAlignment','center', ...
            %      'FontSize',10);
        end
        axis equal off
        title('Default Color Palette','FontSize',14);
        return
    end

    % handle 'h' and 't' (default herders/targets color)
    if nargin>0 
        if strcmpi(idx, "h")
            c = "#0000FF";
            return
        elseif strcmpi(idx, "t")
            c = "#FF00FF";
            return
        end
    end
         


    mustBeNonnegative(idx)
    mustBeVector(idx)
    
    % Regular numeric indexing
    idx = idx(:);
    pick = mod(idx-1, numel(dc)) + 1;
    c = dc(pick);
end

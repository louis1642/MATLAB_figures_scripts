function multisaveFig(name_, simulinkName_)
% multisaveFig: Save current figure or Simulink block diagram in multiple formats.
%
% Syntax:
%   multisaveFig(file_name, [optional] simulink_file_name)
%
% Arguments:
%   file_name           : (string) Base name (with optional subfolder) for saved files, without extension.
%                         Supports both "sub/filename" and "sub\filename".
%   simulink_file_name  : (string) Simulink model/block diagram name (optional).
%
% Description:
%   Saves current figure or specified Simulink block diagram in the current folder
%   (or in the specified subfolder, which will be created if missing).
%   Supported formats: .fig, .png, .svg (Simulink: .png, .svg).
%   An EPS export is provided but commented out.
%
% Examples:
%   Save current figure in current folder:
%       multisaveFig("myfigure")
%
%   Save figure in subfolder "plots":
%       multisaveFig("plots/myfigure")
%
%   Save Simulink block diagram:
%       multisaveFig("model_diagram", "mySimulinkModel")

    arguments
        name_ (1,1) string {mustBeNonempty,mustBeNonzeroLengthText}
        simulinkName_ (1,1) string = ""
    end

    % Normalize path separators to current platform
    normName = replace(name_, ["\" "/"], filesep);

    % Split into folder and base name
    [folderPath, baseName, ~] = fileparts(normName);

    % Ensure folder exists if provided
    if ~isempty(folderPath) && ~exist(folderPath, "dir")
        mkdir(folderPath);
    end

    % Build full save path (without extension)
    savePath = fullfile(folderPath, baseName);

    if simulinkName_ == ""
        ffig__ = gcf;
        oldcolor = get(ffig__, "Color");

        % Transparent background & vector-friendly renderer
        set(ffig__, "Color", "none");
        set(ffig__, "Renderer", "Painters");
        set(ffig__, "InvertHardcopy", "off");  % prevent white text turning black

        % Save in different formats
        savefig(ffig__, savePath + ".fig");                           % .fig
        exportgraphics(ffig__, savePath + ".png", "Resolution", 600); % .png (high-res)
        saveas(ffig__, savePath + ".svg");                            % .svg
        % saveas(ffig__, savePath, "epsc");                           % .eps (commented: enable if needed)

        % Restore original color
        set(ffig__, "Color", oldcolor);
    else
        % Save Simulink diagram
        hSim = get_param(simulinkName_, "Handle");
        saveas(hSim, savePath + ".png");  % .png
        saveas(hSim, savePath + ".svg");  % .svg
        % saveas(hSim, savePath, "epsc"); % .eps (commented: enable if needed)
    end
end


%% OLD VERSION UNUSED
% function multisaveFig(name_, simulinkName_)
% % multisaveFig: Save current figure or Simulink block diagram in multiple formats.
% %
% % Syntax:
% %   multisaveFig(file_name, [optional] simulink_file_name)
% %
% % Arguments:
% %   file_name           : (string) Base name for saved files, without extension (required).
% %   simulink_file_name  : (string) Simulink file diagram name (optional).
% %
% % Description:
% %   Saves current figure or specified Simulink block diagram to:
% %   "E:\OneDrive - Università di Napoli Federico II\Tesi magistrale\Luigi Catello\Code\MATLAB\out\"
% %   Supported formats: .fig, .png, .svg (Simulink: .png, .svg).
% %
% % Examples:
% %   Save current figure:
% %       multisaveFig("file_name")
% %   
% %   Save Simulink block diagram:
% %       multisaveFig("file_name", "simulink_file_name")
% 
%     arguments
%         name_ (1,1) string {mustBeNonempty,mustBeNonzeroLengthText}
%         simulinkName_ (1,1) string = ""
%     end
% 
%     % ppath__ = "E:\Uni\MATLAB\DCNL\Bacteria\outputs\";
%     % ppath__ = "E:\OneDrive - Università di Napoli Federico II\Anno V\II Semestre\Control of Complex Networks and Systems\MATLAB\Kuramoto-high-order\outputs\";
%     ppath__ = "E:\OneDrive - Università di Napoli Federico II\Tesi magistrale\Luigi Catello\Code\MATLAB\RL_out\ssmreport\";
% 
%     if (simulinkName_ == "")
%         ffig__ = gcf;
%         oldcolor = get(ffig__, 'Color');
%         set(ffig__, 'Color', 'none')
%         set(ffig__,'Renderer','Painters')
%         set(ffig__,'InvertHardcopy','off')  % fix white text redered as black
%         savefig(strcat(ppath__, name_));                 %.fig
%         % saveas(ffig__, strcat(ppath__, name_, ".png"));  %.png
%         exportgraphics(ffig__, strcat(ppath__, name_, ".png"),'Resolution','600') %.png (high res)
%         saveas(ffig__, strcat(ppath__, name_, '.svg'));  %.svg
%         % saveas(ffig__, strcat(ppath__, name_), 'epsc');  %.eps
% 
%         % restore old color
%         set(ffig__,'Color', oldcolor)
%     else
%         saveas(get_param(simulinkName_,'Handle'), strcat(ppath__, name_, ".png"));  %.png
%         saveas(get_param(simulinkName_,'Handle'), strcat(ppath__, name_, '.svg'));  %.svg
%     end
% end

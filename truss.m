function model = truss(varargin)
    add_library_path();

    % Load the model file.
    for i = 1:nargin
        if varargin{i}(1) ~= '-'
            model = load_model(varargin{i});
        end
    end

    % Solve the model.
    plot_result = false;
    if any(ismember({'-s', '--sovle'}, varargin))
        model = solve_model(model);
        plot_result = true;
    end

    % Plot the model.
    figure_handle = [];
    if any(ismember({'-p', '--plot'}, varargin))
        figure_handle = plot_model(model, plot_result);
    end

end


function add_library_path()
    [parent_path, ~, ~] = fileparts(mfilename('fullpath'));
    libs_path = fullfile(parent_path, 'libs');
    if ~any(strcmp(libs_path, strsplit(path, ':')))
        addpath(libs_path);
    end
end

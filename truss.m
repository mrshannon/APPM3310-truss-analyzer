function model = truss(varargin)
    add_library_path();

    % Load the model file.
    for i = 1:nargin
        if varargin{i}(1) ~= '-'
            model = load_model(varargin{i});
        end
    end

    % Plot the model.
    figure_handle = [];
    if any(ismember({'-p', '--plot'}, varargin))
        figure_handle = plot_model(model);
    end

    % Solve the model.
    if any(ismember({'-s', '--sovle'}, varargin))
        model = solve_model(model);
    else
        return;
    end

    % Plot the result.
    if any(ismember({'-p', '--plot'}, varargin))
        figure_handle = plot_result(model);
    end

end


function add_library_path()
    [parent_path, ~, ~] = fileparts(mfilename('fullpath'));
    libs_path = fullfile(parent_path, 'libs');
    if ~any(strcmp(libs_path, strsplit(path, ':')))
        addpath(libs_path);
    end
end

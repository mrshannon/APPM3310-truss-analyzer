function K = truss(model_file)
    add_library_path();
    model = load_model(model_file);
    K = master_stiffness_matrix(model);
    K = modify_stiffness_matrix(model, K);
    f = force_matrix(model);
end


function add_library_path()
    [parent_path, ~, ~] = fileparts(mfilename('fullpath'));
    libs_path = fullfile(parent_path, 'libs');
    if ~any(strcmp(libs_path, strsplit(path, ':')))
        addpath(libs_path);
    end
end

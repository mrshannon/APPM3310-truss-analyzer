function model = truss(model_file)
    add_library_path();
    model = load_model(model_file);
    model = solve_displacements(model);
    model = solve_stresses(model);
    model = solve_forces(model);
end


function add_library_path()
    [parent_path, ~, ~] = fileparts(mfilename('fullpath'));
    libs_path = fullfile(parent_path, 'libs');
    if ~any(strcmp(libs_path, strsplit(path, ':')))
        addpath(libs_path);
    end
end

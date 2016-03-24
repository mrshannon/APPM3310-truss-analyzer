function Ke = truss(model_file)
    add_library_path();
    model = load_model(model_file);
    for i = 1:numel(model.elements)
        Ke{i} = global_stiffness_matrix(model, i);
    end
end


function add_library_path()
    [parent_path, ~, ~] = fileparts(mfilename('fullpath'));
    libs_path = fullfile(parent_path, 'libs');
    if ~any(strcmp(libs_path, strsplit(path, ':')))
        addpath(libs_path);
    end
end

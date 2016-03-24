function truss(model_file)

    add_library_path();
    model = load_model(model_file);

end


function add_library_path()
    [parent_path, ~, ~] = fileparts(mfilename('fullpath'));
    libs_path = fullfile(parent_path, 'libs');
    if ~any(strcmp(libs_path, strsplit(path, ':')))
        addpath(libs_path);
    end
end
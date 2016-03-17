function truss()

    add_library_path();

end




function add_library_path()
    [parent_path, ~, ~] = fileparts(mfilename('fullpath'));
    libs_path = fullfile(parent_path, 'libs');
    if ~any(strcmp(libs_path, strsplit(path, ':')))
        addpath(libs_path);
    end
end

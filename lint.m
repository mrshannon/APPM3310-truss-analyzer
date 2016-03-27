% lint()
%
%   Run checkcode on each file in the project.
%
function lint()
    files = dir('*.m');
    files = cat(1, files, dir('libs/*.m'));
    files = {files.name};
    checkcode(files{:});
end

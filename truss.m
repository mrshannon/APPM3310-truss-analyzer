% [model, figure_handle] = truss(varargin)
%
%   Loads and optionally plots/solves a truss using the direct stiffness
%   method.  See the samples directory for example input files.
%
% Inputs:
%   <path to config file>
%   -s, --solve
%   -p, --plot
%
%   NOTE: Input order does not matter.  All inputs are strings and have
%         the command line, or print command syntax.
%
% Output:
%   model:
%       Model structure from input file, possibly with solution.
%
%   figure_handle:
%       Handle to figure if truss in plotted.  Otherwise empty.
%
% Examples:
%
%   Solve and plot truss (command line syntax):
%
%       truss -p -s samples/baltimore_truss.json
%
%   Only plot truss:
%
%       result = truss('samples/baltimore_truss.json', '-p');
%
%   Solve but do not plot:
%
%       result = truss('samples/baltimore_truss.json', '-s');
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
% 1. Redistributions of source code must retain the above copyright
%    notice, this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright
%    notice, this list of conditions and the following disclaimer in the
%    documentation and/or other materials provided with the distribution.
%
% 3. Neither the name of the copyright holder nor the names of its
%    contributors may be used to endorse or promote products derived
%    from this software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
% A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
% HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
% LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
% DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
% THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function [model, figure_handle] = truss(varargin)


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


% add_library_path()
%
%   Adds libs directory to the library path.
%
function add_library_path()
    [parent_path, ~, ~] = fileparts(mfilename('fullpath'));
    libs_path = fullfile(parent_path, 'libs');
    if ~any(strcmp(libs_path, strsplit(path, ':')))
        addpath(libs_path);
    end
end

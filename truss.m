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
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

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

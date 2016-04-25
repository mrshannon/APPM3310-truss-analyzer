% model = load_model(file)
%
%   Load model file into MATLAB structure.
%
% Inputs:
%   file:
%       Path to model file.
%
% Output:
%   model:
%       Model structure.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function model = load_model(file)
    raw = parse_json(fileread(file));
    raw = raw{1};
    model.dimensions = raw.dimensions;
    model.nodes = fix_nodes(raw.nodes);
    model.elements = fix_elements(raw.elements);
    model.materials = raw.materials;
    model.forces = fix_forces(raw.forces);
    model.constraints = fix_constraints(raw.constraints);
end


% nodes = fix_nodes(nodes)
%
%   Convert coords from cells to vector.
%
% Input:
%   nodes:
%       Nodes structure with cell arrays for coordinates.
%
% Output:
%   nodes:
%       Nodes structure with vectors for coordinates.
%
function nodes = fix_nodes(nodes)
    nodes = cell2mat(nodes);
    for i = 1:numel(nodes)
        nodes(i).coords = cell2mat(nodes(i).coords);
    end
end


% elements = fix_elements(elements)
%
%   Convert node numbers from cells to vector.
%
% Input:
%   elements:
%       Elements structure with cell arrays for node numbers.
%
% Output:
%   elements:
%       Elements structure with vectors for node numbers.
%
function elements = fix_elements(elements)
    elements = cell2mat(elements);
    for i = 1:numel(elements)
        elements(i).nodes = sort(cell2mat(elements(i).nodes));
    end
end


% forces = fix_forces(forces)
%
%   Convert vector from cells to numerical vector.
%
% Input:
%   forces:
%       Forces structure with cell arrays for vector.
%
% Output:
%   forces:
%       Forces structure with numerical vectors for vector.
%
function forces = fix_forces(forces)
    forces = cell2mat(forces);
    for i = 1:numel(forces)
        forces(i).vector = cell2mat(forces(i).vector);
    end
end


% constraints = fix_constraints(constraints)
%
%   Convert constraint from cells to boolean vector.
%
% Input:
%   constraints:
%       Constraints structure with cell arrays for constraint.
%
% Output:
%   forces:
%       Constraints structure with boolean vectors for constraint.
%
function constraints = fix_constraints(constraints)
    fields = fieldnames(constraints);
    for i = 1:numel(fields)
        constraints.(fields{i}) = cell2mat(constraints.(fields{i}));
    end
end

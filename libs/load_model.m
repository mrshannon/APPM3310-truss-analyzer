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

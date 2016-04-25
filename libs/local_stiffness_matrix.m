% Kbar = local_stiffness_matrix(model, element_number)
%
%   Compute local stiffness matrix for given element number.
%
% Inputs:
%   model:
%       Model structure.
%
%   element_number:
%       Index number of element to calculate EFT for.
%
% Output:
%   Kbar:
%       Local stiffness matrix for <element_number>.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function Kbar = local_stiffness_matrix(model, element_number)
    element = model.elements(element_number);
    material = model.materials.(element.material);
    E = material.modulus;
    A = material.area;
    p1 = model.nodes(element.nodes(1)).coords(1:model.dimensions);
    p2 = model.nodes(element.nodes(2)).coords(1:model.dimensions);
    L = norm(p2 - p1);
    Kbar = (E*A)/L * template_matrix(model.dimensions);
end


% tmp_mat = template_matrix(dimensions)
%
%   Computes the unit stiffness matrix for a given number of dimensions.
%
% Inputs:
%   dimensions:
%       Number of dimensions in problem.
%
% Output:
%   tmp_mat:
%       Unit stiffness matrix for <dimensions>.
function tmp_mat = template_matrix(dimensions)
    tmp_mat = zeros(dimensions);
    tmp_mat(1,1) = 1;
    tmp_mat = [tmp_mat, -tmp_mat; -tmp_mat, tmp_mat];
end

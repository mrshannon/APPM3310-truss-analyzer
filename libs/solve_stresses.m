% model = solve_stresses(model)
%
%   Solve model for stresses.
%
% Inputs:
%   model:
%       Model structure (needs forces).
%
% Output:
%   model:
%       Model structure with stresses added.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function model = solve_stresses(model)
    for i = 1:numel(model.elements)

        % Extract element.
        element = model.elements(i);

        % Generate global displacement vector.
        u = zeros(2*model.dimensions, 1);
        ue = model.nodes(element.nodes(1)).delta;
        u(1:model.dimensions) = ue(1:model.dimensions);
        ue = model.nodes(element.nodes(2)).delta;
        u((1:model.dimensions) + model.dimensions) ...
            = ue(1:model.dimensions);

        % Calculate change in element length.
        T = transformation_matrix(model, i);
        ubar = T*u;
        d = ubar(model.dimensions+1) - ubar(1);

        % Find original length of element.
        p1 = model.nodes(element.nodes(1)).coords(1:model.dimensions);
        p2 = model.nodes(element.nodes(2)).coords(1:model.dimensions);
        L = norm(p2 - p1);

        % Extract modulus of elasticity.
        E = model.materials.(element.material).modulus;

        % Calculate stress in element.
        model.elements(i).stress = E*d/L;

    end
end

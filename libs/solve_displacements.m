% model = solve_displacements(model)
%
%   Solve model for displacements.
%
% Inputs:
%   model:
%       Model structure.
%
% Output:
%   model:
%       Model structure with displacements added.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function model = solve_displacements(model)

    % Setup linear system.
    K = master_stiffness_matrix(model);
    K = modify_stiffness_matrix(model, K);
    f = force_vector(model);

    % Solve the system.
    if sprank(K) < size(K, 1)
        error('Stiffness matrix is singular.');
    end
    u = K\f;

    % Store displacements
    for i = 1:numel(model.nodes)
        idx = (i-1)*model.dimensions + (1:model.dimensions);
        delta = zeros(size(model.nodes(i).coords));
        delta(1:model.dimensions) = u(idx);
        model.nodes(i).delta = delta;
    end

end

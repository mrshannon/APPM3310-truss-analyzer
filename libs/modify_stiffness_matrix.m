% K = modify_stiffness_matrix(model, K)
%
%   Modify stiffness matrix for constraints.
%
% Inputs:
%   model:
%       Model structure.
%
%   K:
%       Master stiffness matrix.
%
% Output:
%   K:
%       Modified master stiffness matrix.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function K = modify_stiffness_matrix(model, K)
    for i = 1:numel(model.nodes)
        node = model.nodes(i);
        idx = (1:model.dimensions) + model.dimensions*(i-1);
        constraint = model.constraints.(node.constraint);
        constraint = constraint(1:model.dimensions);
        constraint_idx = idx(constraint);
        for j = constraint_idx
            K(j,:) = 0;
            K(:,j) = 0;
            K(j,j) = 1;
        end
    end
end

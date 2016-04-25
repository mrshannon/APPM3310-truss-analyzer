% f = force_vector(model)
%
%   This function generates the modified force vector for use with the
%   modified stiffness matrix.
%
% Inputs:
%   model:
%       Model structure.
%
% Output:
%   f:
%       Modified force vector.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function f = force_vector(model)
    f = zeros(numel(model.nodes)*model.dimensions, 1);
    for force = model.forces
        idx = (force.node-1)*model.dimensions + (1:model.dimensions);
        f(idx) = force.vector(1:model.dimensions);
    end
end

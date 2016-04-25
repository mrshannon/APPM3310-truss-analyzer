% model = solve_model(model)
%
%   Solve model for displacements, stresses, and forces.
%
% Inputs:
%   model:
%       Model structure.
%
% Output:
%   model:
%       Model structure with displacements, stresses, and forces added.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function model = solve_model(model)
    model = solve_displacements(model);
    model = solve_stresses(model);
    model = solve_forces(model);
end

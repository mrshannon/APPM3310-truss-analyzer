% model = solve_forces(model)
%
%   Solve model for forces.
%
% Inputs:
%   model:
%       Model structure (needs displacements).
%
% Output:
%   model:
%       Model structure with forces added.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function model = solve_forces(model)
    for i = 1:numel(model.elements)

        % Extract element.
        element = model.elements(i);

        % Extract cross section area of element.
        A = model.materials.(element.material).area;

        % Calculate force in element.
        model.elements(i).force = A*element.stress;

    end
end

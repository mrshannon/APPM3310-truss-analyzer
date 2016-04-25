% Ke = global_stiffness_matrix(model, element_number)
%
%   Compute globalized stiffness matrix for given element number.
%
% Inputs:
%   model:
%       Model structure.
%
%   element_number:
%       Index number of element to calculate EFT for.
%
% Output:
%   Ke:
%       Globalized stiffness matrix for <element_number>.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function Ke = global_stiffness_matrix(model, element_number)
    T = transformation_matrix(model, element_number);
    Kbar = local_stiffness_matrix(model, element_number);
    Ke = transpose(T)*Kbar*T;
end

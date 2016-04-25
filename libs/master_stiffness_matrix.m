% K = master_stiffness_matrix(model, element_number)
%
%   Compute master stiffness matrix for truss.
%
% Inputs:
%   model:
%       Model structure.
%
% Output:
%   K:
%       Master stiffness matrix.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function K = master_stiffness_matrix(model)
    n = model.dimensions*numel(model.nodes);
    K = spalloc(n, n, (model.dimensions^2)*4*numel(model.elements));
    for e = 1:numel(model.elements)
        Ke = global_stiffness_matrix(model, e);
        EFT = element_freedom_table(model, e);
        for i = 1:(model.dimensions*2)
            for j = 1:(model.dimensions*2)
                p = EFT(i);
                q = EFT(j);
                K(p,q) = K(p,q) + Ke(i,j);
            end
        end
    end
end

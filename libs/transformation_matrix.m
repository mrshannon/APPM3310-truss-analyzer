% T = transformation_matrix(model, element_number)
%
%   Compute transformation matrix for given element number.
%
% Inputs:
%   model:
%       Model structure.
%
%   element_number:
%       Index number of element to calculate EFT for.
%
% Output:
%   T:
%       Transformation matrix for <element_number>.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.


function T = transformation_matrix(model, element_number)
    element = model.elements(element_number);
    p1 = model.nodes(element.nodes(1)).coords(1:model.dimensions);
    p2 = model.nodes(element.nodes(2)).coords(1:model.dimensions);
    v = p2-p1;
    u = v/norm(v);
    tmp = [u; null(u)'];
    T = [tmp, zeros(size(tmp)); zeros(size(tmp)), tmp];
end

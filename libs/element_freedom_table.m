% EFT = element_freedom_table(model, element_number)
%
%   Compute Element Freedom Table (EFT) for a given element.
%
% Inputs:
%   model:
%       Model structure.
%
%   element_number:
%       Index number of element to calculate EFT for.
%
% Output:
%   EFT:
%       Element Freedom Table for <element_number>.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function EFT = element_freedom_table(model, element_number)
    element = model.elements(element_number);
    EFT = repmat((element.nodes-1)*model.dimensions, ...
        model.dimensions, 1);
    EFT = EFT + repmat((1:model.dimensions)', 1, 2);
    EFT = reshape(EFT, 1, []);
end

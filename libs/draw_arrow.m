% h = draw_arrow(base, tip)
%
%   Draws a 2D or 3D arrow.
%
% Inputs:
%   base:
%       Coordinates of base of arrow.
%
%   tip:
%       Coordinates of tip of arrow.
%
% Output:
%   h:
%       Handle to arrow.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function h = draw_arrow(base, tip)

    switch numel(base)
        case 2
            h = quiver(base(1), base(2), tip(1)-base(1), tip(2)-base(2), 0);
        case 3
            h = quiver3(base(1), base(2), base(3), ...
                tip(1)-base(1), tip(2)-base(2), tip(3)-base(3), 0);
        otherwise
            error('Invalid number of dimensions %d/', numel(base));
    end

end

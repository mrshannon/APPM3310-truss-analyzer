% rgb = colormap_lookup(value)
%
%   Loads and optionally plots/solves a truss using the direct stiffness
%   method.  See the samples directory for example input files.
%
% Inputs:
%   value:
%       Value to lookup colormap color for.
%
% Output:
%   rgb:
%       RGB color coresponding to <value> for the current colormap.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function rgb = colormap_lookup(value)
    color_axis = caxis();
    colormap_table = colormap();
    idx = linspace(color_axis(1), color_axis(2), ...
        size(colormap_table, 1));
    rgb = interp1(idx, colormap_table, value);
end

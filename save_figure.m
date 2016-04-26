% save_figure(filename, scale_factor)
%
%   Save current figure as a PDF.
%
% Input:
%   filename:
%       Path to save figure to.
%
%   scale_factor:
%       Use a larger number for more complex plots.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function save_figure(filename, scale_factor)
    h = gcf();
    h.PaperSize = [10, 5]*scale_factor;
    h.PaperPosition = [0, 0, 10, 5]*scale_factor;
    print(h, filename, '-dpdf');
    system(sprintf('pdfcrop -margins "30" %s %s', filename, filename));
end

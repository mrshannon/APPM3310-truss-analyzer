% save_figure(filename)
%
%   Save current figure as a PDF.
%
% Input:
%   filename:
%       Path to save figure to.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function save_figure(filename)
    h = gcf();
    h.PaperSize = [20, 10];
    h.PaperPosition = [0, 0, 20, 10];
    print(h, filename, '-dpdf');
    system(sprintf('pdfcrop -margins "30" %s %s', filename, filename));
end

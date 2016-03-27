% Kbar = local_stiffness_matrix(model, element_number)
%
%   Compute local stiffness matrix for given element number.
%
% Inputs:
%   model:
%       Model structure.
%
%   element_number:
%       Index number of element to calculate EFT for.
%
% Output:
%   Kbar:
%       Local stiffness matrix for <element_number>.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
% 1. Redistributions of source code must retain the above copyright
%    notice, this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright
%    notice, this list of conditions and the following disclaimer in the
%    documentation and/or other materials provided with the distribution.
%
% 3. Neither the name of the copyright holder nor the names of its
%    contributors may be used to endorse or promote products derived
%    from this software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
% A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
% HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
% LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
% DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
% THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function Kbar = local_stiffness_matrix(model, element_number)
    element = model.elements(element_number);
    material = model.materials.(element.material);
    E = material.modulus;
    A = material.area;
    p1 = model.nodes(element.nodes(1)).coords(1:model.dimensions);
    p2 = model.nodes(element.nodes(2)).coords(1:model.dimensions);
    L = norm(p2 - p1);
    Kbar = (E*A)/L * template_matrix(model.dimensions);
end


% tmp_mat = template_matrix(dimensions)
%
%   Computes the unit stiffness matrix for a given number of dimensions.
%
% Inputs:
%   dimensions:
%       Number of dimensions in problem.
%
% Output:
%   tmp_mat:
%       Unit stiffness matrix for <dimensions>.
function tmp_mat = template_matrix(dimensions)
    tmp_mat = zeros(dimensions);
    tmp_mat(1,1) = 1;
    tmp_mat = [tmp_mat, -tmp_mat; -tmp_mat, tmp_mat];
end

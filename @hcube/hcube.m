## Copyright (C) 2012 Aarón Bueno Villares
##
## This file is part of FreeGeomPhy.
##
## FreeGeomPhy is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public
## License as published by the Free Software Foundation;
## either version 3 of the License, or (at your option) any
## later version.
##
## FreeGeomPhy is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied
## warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
## PURPOSE.  See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public
## License along with FreeGeomPhy; see the file COPYING.  If not,
## see <http://www.gnu.org/licenses/>.

function hc = hcube(origin, side, alpha, beta, scheme)

  loadPack;

  hc.hfigure = [];

  if (nargin < 1)
    origin = [];
  endif

  if (nargin < 2 || isempty(side))
    side = 1;
  endif

  side = side(:);

  if (!isscalar(side) && length(side) != 3)
    error("hcube: constructor: expecting a scalar o tridimensional value in side argument");
  endif

  if (nargin < 3)
    alpha = [];
  endif

  if (nargin < 4)
    beta = [];
  endif

  if (nargin < 5 || isempty(scheme))
    scheme = { [], [], [], [], [], [] };
  endif

  ## Make equations
  if (isempty(scheme{1}))
    scheme{1} = hx <= 0.5 * side;
  elseif (isa(scheme{1}, "hfunction"))
    scheme{1} = hx <= scheme{1};
  else
    error("hcube: constructor: expecting hfunction objects in scheme cell");
  endif

  if (isempty(scheme{2}))
    scheme{2} = hy <= 0.5 * side;
  elseif (isa(scheme{2}, "hfunction"))
    scheme{2} = hy <= scheme{2};
  else
    error("hcube: constructor: expecting hfunction objects in scheme cell");
  endif

  if (isempty(scheme{3}))
    scheme{3} = hx >= -0.5 * side;
  elseif (isa(scheme{3}, "hfunction"))
    scheme{3} = hx >= scheme{3};
  else
    error("hcube: constructor: expecting hfunction objects in scheme cell");
  endif

  if (isempty(scheme{4}))
    scheme{4} = hy >= -0.5 * side;
  elseif (isa(scheme{4}, "hfunction"))
    scheme{4} = hy >= scheme{4};
  else
    error("hcube: constructor: expecting hfunction objects in scheme cell");
  endif

  if (isempty(scheme{5}))
    scheme{5} = hz <= -0.5 * side;
  elseif (isa(scheme{5}, "hfunction"))
    scheme{5} = hz <= scheme{5};
  else
    error("hcube: constructor: expecting hfunction objects in scheme cell");
  endif

  if (isempty(scheme{6}))
    scheme{6} = hz >= -0.5 * side;
  elseif (isa(scheme{6}, "hfunction"))
    scheme{6} = hz >= scheme{6};
  else
    error("hcube: constructor: expecting hfunction objects in scheme cell");
  endif

  hs = hsystem("&&", scheme{:});
  hfg = hfigure(hs, 3, origin, 1, alpha, beta);

  hc.side = side;
  hc.dfside = side;

  hc = class(hc, "hcube", hfg);

endfunction
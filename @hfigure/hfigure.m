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

function hfg = hfigure(hs, op, dim, origin, scale, alpha, beta)

  if (nargin == 0)
    error("hfigure: constructor: expecting almost a equation system as parameter");
  endif

  if (nargin == 1 && isa(hs, "hfigure"))
    hfg = hs;
    return;
  endif

  if (nargin < 2 || isempty(dim))
    dim = 3;
  elseif (!isscalar(dim) || dim < 2 || dim > 3)
    error("hfigure: constructor: expecting a scalar value (2 or 3) as dimension");
  endif

  if (nargin < 3 || isempty(origin))
    origin = zeros(dim, 1);
  elseif (!isvector(origin) || !isnumeric(origin))
    error("hfigure: constructor: expecting a numeric vector or scalar as origin");
  else
    origin = origin(:);

    if (length(origin) != dim)
      error(["hfigure: constructor: expecting a origin vector with dimension " dim ]);
    endif
  endif

  if (nargin < 4 || isempty(scale))
    scale = 1;
  elseif (!isvector(scale) || !isnumeric(scale))
    error("hfigure: constructor: expecting a numeric vector or scalar as scale");
  else
    scale = scale(:);

    if (length(scale) != 1 && length(scale) != dim)
      error(["hfigure: constructor: expecting scale as scalar value or vector with dimension " dim ]);
    endif

  endif

  if (nargin < 5 || isempty(alpha))
    alpha = 0;
  elseif (!isscalar(alpha))
    error("hfigure: constructor: expecting a scalar as alpha");
  endif

  if (dim == 3)
    if (nargin < 6 || isempty(beta))
      beta = 0;
    elseif (!isscalar(beta))
      error("hfigure: constructor: expecting a scalar as beta");
    endif
  endif

  hfg.hsystem = {};
  hfg.hfigures = {};
  hfg.op = "";

  if (iscell(hs))
    if (!ischar(hs{1}))
      error("hfigure: constructor: expecting a operator (string) as first element of first argument");
    endif

    hfg.op = hs{1};

    if (hfg.op != "+" && hfg.op != "-" && hfg.op != "*")
      error("hfigure: constructor: expecting a valir operator (+, - or *) as first element of first argument");
    endif

    for i = 2:numel(hs)
      hfg.hfigures = { hfg.hfigures{:} hfigure(hs{i}) };
    endfor

  else
    hfg.hsystem = hsystem(hs) < "X";
    hfg.op = "";

  endif

  hfg.dim = dim;

  hfg.origin = origin;
  hfg.scale = scale;
  hfg.alpha = 0;
  hfg.beta = 0;

  hfg.mrot = diag(ones(1, dim), 0);

  hfg = class(hfg, "hfigure");

  hfg = hfg < alpha;

  if (dim == 3)
    hfg = hfg ^ beta;
  endif

  superiorto("hsystem");

endfunction
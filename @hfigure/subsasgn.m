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

function hfg = subasgn(hfg, idx, rhs)

  if (isempty(idx))
    error("hsystem: subsref: expecting a index cell");
  endif

  if (idx(1).type == ".")
    switch (idx(1).subs)
      case "origin"
        if (!isvector(rhs) || !isnumeric(rhs))
          error("hfigure: subsasgn: expecting a numeric vector or scalar as origin");
        endif

        rhs = rhs(:);

        if (length(rhs) != hfg.dim)
          error(["hfigure: subasgn: expecting a origin vector with dimension " dim ]);
        endif

        hfg.origin = rhs;

      case "scale"
        if (!isvector(rhs) || !isnumeric(rhs))
          error("hfigure: subasng: expecting a numeric vector or scalar as scale");
        endif

        rhs = rhs(:);

        if (length(rhs) != 1 && length(rhs) != dim)
          error(["hfigure: subasgn: expecting scale as scalar value or vector with dimension " dim ]);
        endif

        hfg.scale = rhs;

      case "alpha"
        if (!isscalar(rhs))
          error("hfigure: subasgn: expecting a scalar as alpha");
        endif

        rhs = hfg.alpha - rhs;

        hfg = hfg < rhs;

      case "beta"
        if (hfg.dim == 3)
          if (!isscalar(rhs))
            error("hfigure: subasgn: expecting a scalar as alpha");
          endif

          rhs = hfg.beta - rhs;

          hfg = hfg ^ rhs;

        endif

      otherwise
        error("hfigure: subasgn: invalid access element");
    endswitch

  elseif (idx(1).type == "{}")
    hfg.hsystem = subsasgn(hfg.hsystem, idx, rhs);
  else
    error("hfigure: subasgn: invalid access");
  endif

endfunction
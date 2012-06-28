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
    error("hfigure: subsasgn: expecting a index cell");
  endif

  if (idx(1).type == ".")
    if (strcmp(idx(1).subs, "origin"))
      if (!isvector(rhs) || !isnumeric(rhs))
        error("hfigure: subsasgn: expecting a numeric vector or scalar as origin");
      endif

      rhs = rhs(:);

      if (length(rhs) != hfg.dim)
        error(["hfigure: subasgn: expecting a origin vector with dimension " dim ]);
      endif

      hfg.origin = rhs;

    elseif (strcmp(idx(1).subs, "scale"))
      if (!isvector(rhs) || !isnumeric(rhs))
        error("hfigure: subasgn: expecting a numeric vector or scalar as scale");
      endif

      rhs = rhs(:);

      if (length(rhs) != 1 && length(rhs) != dim)
        error(["hfigure: subasgn: expecting scale as scalar value or vector with dimension " dim ]);
      endif

      hfg.scale = rhs;

    elseif (strcmp(idx(1).subs, "alpha"))
      if (!isscalar(rhs))
        error("hfigure: subasgn: expecting a scalar as alpha");
      endif

      rhs = hfg.alpha - rhs;

      hfg = hfg < rhs;

    elseif (strcmp(idx(1).subs, "beta"))
      if (hfg.dim == 3)
        if (!isscalar(rhs))
          error("hfigure: subasgn: expecting a scalar as alpha");
        endif

        rhs = hfg.beta - rhs;

        hfg = hfg ^ rhs;

      endif

    elseif (strcmp(idx(1).subs, "op"))
      if (!ischar(rhs))
        error("hfigure: subasgn: expecting a string as r-value");
      endif

      if (rhs != "+" && rhs != "-" && rhs != "*")
        error("hfigure: subasgn: expecting a valid operator (+, -, * or |) as r-value");
      endif

      hfg.op = rhs;

    else
      error("hfigure: subasgn: invalid access element");

    endif

  elseif (idx(1).type == "{}")
    if (isempty(hfg.hsystem))
      hfg.hfigures = subsasgn(hfg.hfigures, idx, rhs);
    else
      hfg.hsystem = subsasgn(hfg.hsystem, idx, rhs);
    endif

  else
    error("hfigure: subasgn: invalid access");
  endif

endfunction
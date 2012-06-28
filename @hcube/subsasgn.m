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

function hc = subsasgn(hc, idx, rhs)

  if (isempty(idx))
    error("hcube: subsasgn: expecting a index cell");
  endif

  if (idx(1).type == ".")
    if (strcmp(idx(1).subs, "side"))
      rhs = rhs(:);

      if (!isscalar(rhs) && length(rhs) != 3)
        error("hcube: subsasgn: expecting a scalar or tridimensional value");
      endif

      hc.side = rhs;
      hc.hfigure.scale = hc.side ./ hc.dfside;

    elseif (strcmp(idx(1).subs, "scale"))
      rhs = rhs(:);

      if (!isscalar(rhs) && length(rhs) != 3)
        error("hcube: subsasgn: expecting a scalar or tridimensional value");
      endif

      hc.hfigure.scale = rhs;
      hc.side = hc.dfside .* rhs;

    elseif (strcmp(idx(1).subs, "open"))
      if (iscell(rhs))
        rhs = cell2mat(rhs);
      endif

      if (!isnumeric(rhs))
        error("hcube: subsasgn: expecting a numeric element (cell, array or scalar value");
      endif

      rhs = rhs(:);

      for i = 1:length(rhs)
        idx = rhs(i);

        op = hc{idx}{0};

        switch(op)
          case "<="
            op = "<";
          case ">="
            op = ">";
        endswitch

        hc{idx}{0} = op;

      endfor
    elseif (strcmp(idx(1).subs, "close"))
      if (iscell(rhs))
        rhs = cell2mat(rhs);
      endif

      if (!isnumeric(rhs))
        error("hcube: subsasgn: expecting a numeric element (cell, array or scalar value");
      endif

      rhs = rhs(:);

      for i = 1:length(rhs)
        idx = rhs(i);

        op = hc{idx}{0};

        switch(op)
          case "<"
            op = "<=";
          case ">"
            op = ">=";
        endswitch

        hc{idx}{0} = op;

      endfor
    else
      hc.figure = subsasgn(hc.hfigure, idx, rhs);
    endif
  elseif (idx(1).type == "{}")
    if (is_function_handle(rhs))
      rhs = hh(rhs, "X");
    else
      rhs = hfunction(rhs);
    endif

    if (!isa(rhs, "hfunction"))
      error("hcube: subsasgn: expecting a hfunction r-value");
    endif

    loadPack;

    switch(idx(1).subs{1})
      case 1
        hc.hfigure{1}{1} = rhs;
      case 2
        hc.hfigure{2}{1}{1} = rhs;
      case 3
        hc.hfigure{2}{2}{1}{1} = rhs;
      case 4
        hc.hfigure{2}{2}{2}{1}{1} = rhs;
      case 5
        hc.hfigure{2}{2}{2}{2}{1}{1} = rhs;
      case 6
        hc.hfigure{2}{2}{2}{2}{2}{1} = rhs;
      otherwise
        error("hcube: subsasgn: invalid access index, only 1 to 6");
    endswitch
  else
    error("hcube: subsasgn: invalid accessing");
  endif

endfunction
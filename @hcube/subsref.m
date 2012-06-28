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

function v = subsref(hc, idx)

  if (isempty(idx))
    error("hsystem: subsasgn: expecting a index cell");
  endif

  if (idx(1).type == ".")
    if (strcmp(idx(1).subs, "side"))
      v = hc.side;
    elseif (strcmp(idx(1).subs, "dfside"))
      v = hc.dfside;
    else
      v = subsref(hc.hfigure, idx);
    endif
  elseif (idx(1).type == "{}")
    switch (idx(1).subs{1})
      case 1
        v = hc.hfigure{1};
      case 2
        v = hc.hfigure{2}{1};
      case 3
        v = hc.hfigure{2}{2}{1};
      case 4
        v = hc.hfigure{2}{2}{2}{1};
      case 5
        v = hc.hfigure{2}{2}{2}{2}{1};
      case 6
        v = hc.hfigure{2}{2}{2}{2}{2};
      otherwise
        error("hcube: subsref: invalid access index, only 1 to 6");
    endswitch
  else
    v = subsref(hc.hfigure, idx);
  endif

endfunction
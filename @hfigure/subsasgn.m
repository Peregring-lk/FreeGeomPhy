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

function hg = subsasgn(hg, idx, rhs)

  if (idx(1).type == ".")
    if (!isnumeric(rhs))
      error("hfigure: subsasgn: expecting a numeric value");
    endif

    switch (idx(1).subs{1})
      case "origin"
        hs.origin = rhs;
      case "scale"
        hs.scale = rhs;
      case "alpha"
        hs = hs < (rhs - hg.alpha);
      case "beta"
        hs = hs ^ (rhs - hg.beta);
      otherwise
        error("hfigure: subsasgn: invalid object access");
    endswitch
  elseif (idx(1).type == "{}")
    subsasgn(hg.hsystem, idx, rhs);
  else
    error("hfigure: subsasgn: invalid object access");
  endif

endfunction
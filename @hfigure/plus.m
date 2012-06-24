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

function hg = plus(hg, b)

  if (!isa(hg, "hfigure"))
    error("hfigure: plus: expecting a figure as first operand");
  endif

  if (!isa(b, "hfigure") && !isa(b, "hsystem") && !isnumeric(b))
    error("hfigure: plus: expecting a figure, equation system or number as second operand");
  endif

  if (isnumeric(b))
    hg.origin += b;
  else
    if (isa(b, "hfigure"))
      b = b.hsystem;
    endif

    hg.hsystem = hg.hsystem | b;

  endif

endfunction

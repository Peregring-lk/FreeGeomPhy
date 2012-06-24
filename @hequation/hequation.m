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

function he = hequation(a, b, op)

  if (nargin == 0)
    error("hequation: expecting one argument");
  endif

  if (nargin == 1)
    if (isa(a, "hequation"))
      he = a;
    else
      error("hequation: expecting three arguments");
    endif
  elseif (nargin == 2)
    error("hequation: expecting three arguments");
  else
    if (!isa(a, "hfunction"))
      a = hfunction(a);
    endif

    if (!isa(b, "hfunction"))
      b = hfunction(b);
    endif

    if (op != "<" && op != "<=" && op != ">" && op != ">=" && op != "==" && op != "!=")
      error("hequation: expecting an comparision operator");
    endif

    he.hequation = inline([char(a) " " op " " char(b)]);

    he.hfirst = a;
    he.hsecond = b;
    he.op = op;

    he = class(he, "hequation");

  endif

endfunction
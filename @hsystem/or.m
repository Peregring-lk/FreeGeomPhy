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

function hs = or(hs1, hs2)

  if (!isa(hs1, "hsystem") && !(isa(hs1, "hequation")))
    error("hsystem: and: expecting system or equations as operand");
  endif

  if (!isa(hs2, "hsystem") && !(isa(hs2, "hequation")))
    error("hsystem: and: expecting system or equations as operand");
  endif

  hs = hsystem("|", hs1, hs2);

endfunction
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

function subsasgn(hf, idx, rhs)

  if (isempty(idx))
    error("hfunction: expecting an index");
  endif

  if (idx.type == ".") # For internal purposes only.
    if (idx.subs == "hfunction")
      hf0 = hfunction(rhs);
      hf.hfunction = hf0.hfunction;
    else
      error("hfunction: invalid element access");
    endif
  else
    error("hfunction: invalid subscript type");
  endif

endfunction
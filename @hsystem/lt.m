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

function hs = lt(hs, str)

  if (!isvarname(str))
    error("hsystem: lt: expecting name var");
  endif

  args = argnames(hs);

  not_str_idx = find(1 - strcmp(args, str));

  if (isempty(not_str_idx))
    hs.hsystem = inline(char(hs), str);
  else
    hs.hsystem = inline(char(hs), str, args{not_str_idx}{:});
  endif

endfunction
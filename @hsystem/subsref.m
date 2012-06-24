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

function v = subsref(hs, idx)

  if (isempty(idx))
    error("hsystem: expecting an index");
  endif

  if (idx(1).type == "{}")
    if (idx(1).subs{1} > length(hs.equations))
      error("hsystem: invalid array access");
    endif

    if (idx(1).subs{1} == 0)
      v = hs.op;
    else
      idx1 = idx(1).subs{1};

      if (length(idx) > 1)
        if (idx(2).type != "{}")
          error("hsystem: invalid member access");
        else
          idx(1) = [];
          v = subsref(hs.equations{idx1}, idx);
        endif
      else
        v = hs.equations{idx1};
      endif
    endif
  elseif (idx(1).type == "()")
    if (size(idx(1).subs{1}, 1) != 3)
      error("hfunction: subsref: expecting a three dimensional first parameter");
    endif

    v = hs.hsystem(idx(1).subs{1}(1, :), idx(1).subs{1}(2, :), idx(1).subs{1}(3, :), idx.subs{2:end});
  else
    error("hsystem: invalid subscript type");
  endif

endfunction
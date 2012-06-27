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
    error("hsystem: subsref: expecting a index cell");
  endif

  if (idx(1).type == "{}")
    if (idx(1).subs{1} > 2)
      error("hsystem: subsref: invalid member access");
    endif

    if (idx(1).subs{1} == 0)
      v = hs.op;
    else
      idx1 = idx(1);

      if (length(idx) > 1)
        idx(1) = [];
        v = subsref(hs{idx1}, idx);
      else
        if (idx1.subs{1} == 1)
          v = hs.hfirst;
        elseif (idx1.subs{1} == 2)
          v = hs.hsecond;
        else
          error("hsystem: subsref: invalid index access");
        endif

      endif

    endif
  elseif (idx(1).type == "()")
    v = hs.hsystem(idx(1).subs{:});
  endif

endfunction
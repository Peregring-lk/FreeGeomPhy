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

function v = subsref(hf, idx)

  if (isempty(idx))
    error("hsystem: subsref: expecting a index cell");
  endif

  if (idx(1).type == "{}")
    str = char(hf);

    if (hf.idxop > 1)
      str = [ "(" str ")" ];
    endif

    str = [ str "(" _mkaccess(hf, idx(1).subs) ")" ];

    v = hfunction(str, 1, argnames(hf){:});
  elseif (idx(1).type == "()")
    v = hf.hfunction(idx(1).subs{:});
  else
    error("hfunction: subsref: invalid access operator");
  endif

endfunction

function str = _mkaccess(hf, subs)

  str = "";

  if (!isempty(subs))
    arg = subs{1};

    if (isscalar(arg))
      str = num2str(arg);
    elseif (ischar(arg))
      str = arg;
    else
      error("hfunction: subsref: expecting a scalar or string index");
    endif

    for i = 2:length(subs)
      arg = subs{i};

      if (isscalar(arg))
        arg = num2str(arg);
      elseif (!ischar(arg))
        error("hfunction: subsref: expecting a scalar or string index");
      endif

      str = [ str ", " arg ];
    endfor

  endif

endfunction
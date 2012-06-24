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

function hs = heqsystem(op, varargin)

  if (nargin == 0)
    error("heqsystem: expecting almost one argument");
  endif

  if (nargin == 1)
    hs = varargin{1};
  else
    if (op != "&" && op != "|")
      error("heqsystem: expecting a valid comparision operator");
    else
      hs.equations = {};
      hs.op = op;

      h0 = varargin{1};

      if (isa(h0, "heqsystem"))
        if (h0.op == op)
          hs.equations = { h0 };
        else
          hs.equations = { h0 };
        endif

      elseif (isa(h0, "hequation"))
        hs.equations = { h0 };
      else
        error("heqsystem: expecting equations or equation systems");
      endif

      str = "";

      if (isa(h0, "hequation") || (h0.op != hs.op && h0.op == "|"))
        str = [ "(" char(h0) ")" ];
      else
        str = char(h0);
      endif

      for i = 2:length(varargin)
        h0 = varargin{i};

        if (isa(h0, "heqsystem"))
          if (h0.op == op)
            hs.equations = { hs.equations{:} h0 };
          else
            hs.equations = { hs.equations{:} h0 };
          endif

        elseif (isa(h0, "hequation"))
          hs.equations = { hs.equations{:} h0 };
        else
          error("heqsystem: expecting equations or equation systems");
        endif

        if (isa(h0, "hequation") || (h0.op != hs.op && h0.op == "|"))
          str = [ str " " op " " "(" char(h0) ")" ];
        else
          str = [ str " " op " " char(h0) ];
        endif

      endfor

      hs.heqsystem = inline(str);

      hs = class(hs, "heqsystem");
    endif
  endif

endfunction
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

function hs = hsystem(varargin)

  if (nargin == 1)
    if (isa(varargin{1}, "hsystem"))
      hs = varargin{1};
      return;
    elseif (isa(varargin{1}, "hequation"))
      he = varargin{1};

      hs.hsystem = inline(["(" char(he) ")"], argnames(he){:});
      hs.hfirst = he;
      hs.hsecond = [];
      hs.op = "&&";

      hs = class(hs, "hsystem");
      superiorto("hequation");

      return;
    else
      error("hsystem: constructor: expecting a hsystem object");
    endif
  endif

  if (nargin < 2)
    error("hsystem: constructor: expecting almost two arguments");
  endif

  hs.hsystem = [];
  hs.hfirst = [];
  hs.hsecond = [];

  if (!ischar(varargin{1}))
    error("hsystem: constructor: expecting the operator as string");
  endif

  hs.op = varargin{1};

  ## The operador "and" has right asociativity.
  if (hs.op == "&&")
    first = varargin{2};
    second = { varargin{3:end} };
  ## The operator "or" has left asociativity.
  elseif (hs.op == "||")
    first = { varargin{2:end - 1} };
    second = varargin{end};
  else
    error("hsystem: constructor: invalid operator");
  endif

  hs.hfirst = _mkOperand(hs.op, first);
  hs.hsecond = _mkOperand(hs.op, second);

  ## Making variable list
  vars = { argnames(hs.hfirst){:}, argnames(hs.hsecond){:} };

  [ u i ] = unique(vars, "first");
  vars = vars(sort(i));

  ## Making hfunction
  hs.hsystem = inline([ _mkstr(hs.hfirst, hs.op) " " hs.op " " _mkstr(hs.hsecond, hs.op)], vars{:});

  hs = class(hs, "hsystem");

  superiorto("hequation");

endfunction

function hfs = _mkOperand(op, hfs)

  if (length(hfs) == 1)
    if (iscell(hfs))
      hfs = hfs{1};
    endif

    if (!isa(hfs, "hsystem") && !isa(hfs, "hequation"))
      error("hsystem: constructor: expecting equations or system as parameters");
    endif

  else
    hfs = hsystem(op, hfs{:});
  endif

endfunction

function str = _mkstr(hfs, op)

  str = char(hfs);

  if (isa(hfs, "hequation"))
    str = [ "(" str ")" ];
  elseif (op != hfs.op && op == "&&")
    str = [ "(" str ")" ];
  endif

endfunction
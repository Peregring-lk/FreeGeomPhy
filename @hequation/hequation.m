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

function he = hequation(hf1, hf2, op)

  if (nargin == 1)
    if (isa(hf1, "hequation"))
      he = hf1;
      return;
    endif
  endif

  if (nargin < 3)
    error("hequation: constructor: expecting almost three operands");
  endif

  he.hequation = [];
  he.first = [];
  he.second = [];
  he.op = op;

  if (op != "<" && op != "<=" && op != ">" && op != ">=" && op != "==" && op != "!=")
    error("hequation: constructor: expecting an comparision operator");
  endif

  hf1 = hfunction(hf1);
  hf2 = hfunction(hf2);

  he.first = hf1;
  he.second = hf2;

  ## Making variable list
  vars = { argnames(hf1){:}, argnames(hf2){:} };

  [ u i ] = unique(vars, "first");
  vars = vars(sort(i));

  ## Making hfunction
  he.hequation = inline([char(hf1) " " op " " char(hf2)], vars{:});

  he = class(he, "hequation");

  superiorto("hfunction");

endfunction
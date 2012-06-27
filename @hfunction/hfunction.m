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

function hf = hfunction(arg, idxop, varargin)

  ##
  ## Auxiliar case. For internal purposes only.
  ##
  ##  Binary and unary operations. Otherwise, call with almost two parameters.
  ##
  if (nargin == 1)
    if (isa(arg, "hfunction"))
      hf = arg;
    elseif (ischar(arg))
      hf = hv(arg);
    elseif (is_function_handle(arg))
      hf = hh(arg);
    elseif (isscalar(arg))
      hf = hn(arg);
    else
      error("hfunction: constructor: expecting a scalar, string o function handle");
    endif

    return;
  endif

  ##
  ## Standard case.
  ##

  hf.hfunction = [];

  if (!isscalar(idxop))
    error("hfunction: constructor: expecting a scalar number as operator index");
  endif

  hf.idxop = idxop;

  ##  Make the string function
  str = "";

  if (ischar(arg))
    str = arg;
  elseif (is_function_handle(arg))
    str = [ func2str(arg) "(" ];

    if (!isempty(varargin))
      str = [ str varargin{1} ];

      for i = { varargin{2:end} }
        str = [ str ", " i{:} ];
      endfor

    endif

    str = [ str ")" ];

  elseif (isscalar(arg))
    str = num2str(arg);
  else
    error("hfunction: constructor: expecting a string, function handle or scalar number");
  endif

  ## Make the inline function
  hf.hfunction = inline(str, varargin{:});

  hf = class(hf, "hfunction");

endfunction
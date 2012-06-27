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

function hc = hc(a, b, c)

  if (nargin < 2)
    error("hfunction: hc: expecting almost two arguments");
  endif

  if (ischar(a))
    hc = a;
  elseif (isscalar(a))
    hc = num2str(a);
  else
    error("hfunction: hc: expecting string or scalar arguments");
  endif

  if (ischar(b))
    hc = [ hc ":" b ];
  elseif (isscalar(b))
    hc = [ hc ":" num2str(b) ];
  else
    error("hfunction: hc: expecting string or scalar arguments");
  endif

  if (nargin == 3)
    if (ischar(c))
      hc = [ hc ":" c ];
    elseif (isscalar(c))
      hc = [ hc ":" num2str(b) ];
    else
      error("hfunction: hc: expecting string or scalar arguments");
    endif
  endif

endfunction
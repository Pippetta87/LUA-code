-- Fourier series
function partial_sum(n,x)
    partial = 0;
    for k = 1, n, 1 do
        partial = partial + math.sin(k*x)/k
end;
    return partial
end
-- Code to write PGFplots data as coordinates
function print_partial_sum(n,xMin,xMax,npoints,option)
    local delta = (xMax-xMin)/(npoints-1)
    local x = xMin
    if option~=[[]] then
        tex.sprint("\\addplot["..option.."] coordinates{")
    else
        tex.sprint("\\addplot coordinates{")
    end
    for i=1, npoints do
        y = partial_sum(n,x)
        tex.sprint("("..x..","..y..")")
        x = x+delta
end
tex.sprint("}")
end

\begin{comment}
\directlua{dofile("gibbs.lua")}
%\newcommand*{\greatmacro}[2]{%
%\directlua{great("\luatexluaescapestring{#1}", #2)}}
%\begin{luacode*}

\pgfplotsset{width=15cm, height=7cm}
\begin{tikzpicture}\small
\begin{axis}[xmin=-0.2, xmax=31.6, ymin=-1.85, ymax=1.85,
  xtick={0,5,10,15,20,25,30},
  ytick={-1.5,-1.0,-0.5,0.5,1.0,1.5},
  minor x tick num=4,
  minor y tick num=4,
  axis lines=middle,
  axis line style={-}
  ]
% SYNTAX: Partial sum 30, from x = 0 to 10*pi, sampled in 1000 points
\addLUADEDplot[color=blue,smooth]{30}{0}{10*math.pi}{1000};
\end{axis}
\end{tikzpicture}
\end{comment}
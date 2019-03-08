-- Differential equation y’(t) = f(t,y)
-- with f(t,y) = y * cos(t+sqrt(1+y)).
-- Initial condition: y(0) = 1
function f(t,y)
    return y * math.cos(t+math.sqrt(1+y))
end
-- Code to write PGFplots data as coordinates
function print_RKfour(tMax,npoints,option)
    local t0 = 0.0
    local y0 = 1.0
    local h = (tMax-t0)/(npoints-1)
    local t = t0
    local y = y0
    if option~=[[]] then
        tex.sprint("\\addplot["..option.."] coordinates{")
    else
        tex.sprint("\\addplot coordinates{")
    end
    tex.sprint("("..t0..","..y0..")")
for i=1, npoints do
        k1 = h * f(t,y)
k2 = h * f(t+h/2,y+k1/2)
k3 = h * f(t+h/2,y+k2/2)
k4 = h * f(t+h,y+k3)
y = y + (k1+2*k2+2*k3+k4)/6 t=t+h tex.sprint("("..t..","..y..")")
end
    tex.sprint("}")
end

--\directlua{dofile("rungekutta.lua")}
--\pgfplotsset{width=0.9\textwidth, height=0.6\textwidth}
--\begin{tikzpicture}
--\begin{axis}[xmin=-0.5, xmax=30.5, ymin=-0.02, ymax=1.03,
--  xtick={0,5,...,30}, ytick={0,0.2,...,1.0},
--  enlarge x limits=true,
--  minor x tick num=4, minor y tick num=4,
-- axis lines=middle, axis line style={-}
--  ]
--% SYNTAX: Solution of the initial value problem
--% in the interval [0,30] sampled at 200 points
--\addLUADEDplot[color=blue,smooth]{30}{200};
--\end{axis}
--\end{tikzpicture}
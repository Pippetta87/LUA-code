--require("bc")
function outgoing(rc,h,fp,Bg)
tex.print ("starting out", "")
local alpha=math.sqrt(mp/(hbar)^2*Bg)
local arrayout={}
arrayout[1] = 0.0
arrayout[2] = h
for i=2, stepout-1 do
      arrayout[i+1] = (2*arrayout[i]-arrayout[i-1]+h^2*fp[i]*arrayout[i]+h^2/12*(fp[i-1]*arrayout[i-1]-2*fp[i]*arrayout[i]))/(1-h^2/12*fp[i+1])
    end
    return arrayout
end

function ingoing(rc,h,si,fp,Bg)
tex.print ("starting in")tex.print("", "")
local alpha=math.sqrt(mp/(hbar)^2*Bg)
local arrayin={}
arrayin[si] = 0.0
arrayin[si-1] = alpha*h
--tex.sprint("elemento i inw") tex.print("", "")
for i=si-1,1,-1 do
      arrayin[i-1] = (2*arrayin[i]-arrayin[i+1]+h^2*fp[i]*arrayin[i]+h^2/12*(fp[i+1]*arrayin[i+1]-2*fp[i]*arrayin[i]))/(1-h^2/12*fp[i-1])
--tex.sprint(" "..arrayin[i].. ", ")
    end
    return arrayin
end

function discretization(Bg,h,N)
local fp={}
fp[0]=f(Bg,0)
for i=1, N do
fp[i]=f(Bg,h*i)
end

return fp

end

function V(x,V0,R,a) return -V0/(1+math.exp((x-R)/a)) end

function f(Bg,x) return (mp/(hbar)^2)*(V(x,V0,R,a)+Bg) end --u''=m/h^2(V-E)u

function rettadp(x1,y1,x2,y2,y)
local minv=(x2-x1)/(y2-y1)
return x1+minv*(y-y1)
end --return x

function derivate(array,index,h) return (array[index+1]-array[index])/h end


-- parametri discretizzazione e raccordo
range=20 -- fino a dove determino soluzione ES (fm)
step=0.05 -- discretizzazione: distanza tra due passi
raccordo=3.2 -- punto raccordo soluzione in and out (fm) 
stepout=raccordo/step
stepin=(range-raccordo)/step
outw={}
inw={}

-- [E]=MeV, [L]=fm
hbar=973
mp=937 --mev/c^2
--potenziale
R=3.0 --range del potenziale
a=0.2 --spessore transiente
V0=35.0 --profondita
deltaE={}
Bi=2.5 -- valore guess
deltaBi=-0.0001 -- variazione Bi guess
Biaux={}
fpd={}
fpd=discretization(Bi,step,range/step)


for i=1,2 do
outw=outgoing(raccordo,step,fpd,Bi)

t=#outw
tex.sprint("elemento "..t.." outw:", outw[t]) tex.print("", "")
inw=ingoing(raccordo,step,stepin,fpd,Bi)
t=#inw
tex.sprint("lunghezza inw", t) tex.print("", "")
tex.sprint("stepin", stepin) tex.print("", "")
t=1
tex.sprint("elemento "..t.." inw:", inw[t]) tex.print("", "")
t=#deltaE
tex.sprint("lunghezza", [[$\Delta E$]], t) tex.print("", "")
t=#outw
tex.sprint("lunghezza outw", t) tex.print("", "")
t=#inw
tex.sprint("lunghezza inw", t) tex.print("", "")
Biaux[i]=Bi

deltaE[i]=derivate(outw,stepout-1,step)/outw[stepout]-derivate(inw,1,step)/inw[1]

tex.sprint("Bi", Bi) tex.print("", "")
tex.sprint([[$\Delta E_]]..i..[[$]], deltaE[i]) tex.print("", "")

Bi=Bi+i*deltaBi
tex.sprint("Bi", Bi) tex.print("", "")
end

EB=rettadp(Biaux[1],deltaE[1],Biaux[2],deltaE[2],0)
tex.sprint("Binding energy: ", EB) tex.print("", "")
function ex1 ()
    coroutine.yield "HELLO!"
    coroutine.yield "HELLO AGAIN!!"
    return "SEE YOU!"
 end
 
 local ex1_co = coroutine.wrap (ex1)
 
 print (ex1_co ()) -- => HELLO!
 print (ex1_co ()) -- => HELLO AGAIN!!
 print (ex1_co ()) -- => SEE YOU!

-- print (ex1_co ()) -- error


 function ex2 ()
    local a = 0
    local b = 1
 
    coroutine.yield (a)
    coroutine.yield (b)
 
    while true do
       local newval = a + b
       a = b
       b = newval
       coroutine.yield (newval)
    end
 end
 
 local ex2_co = coroutine.wrap (ex2)
 
 print (ex2_co ()) -- =>0
 print (ex2_co ()) -- =>1
 print (ex2_co ()) -- =>1
 print (ex2_co ()) -- =>2
 print (ex2_co ()) -- =>3
 print (ex2_co ()) -- =>5
 print (ex2_co ()) -- =>8
 print (ex2_co ()) -- =>13
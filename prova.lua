texio.write_nl("Special chars: working."
.. "Only backslashes still need a bit of care.")
-- a lua comment: we could use \% below, too

co = coroutine.create (function ()
           print("co", coroutine.yield())
         end)
    coroutine.resume(co)
    coroutine.resume(co, 4, 5)
 
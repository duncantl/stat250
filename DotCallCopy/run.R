dyn.load("foo.so")
x = 0
.Call("R_foo", x)
x  # x has changed.

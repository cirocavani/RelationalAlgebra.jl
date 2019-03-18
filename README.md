# Relation Algebra

Executes Relational Algebra statements.

...

Setup:

```julia
import Pkg
Pkg.activate(".")
Pkg.test()
```

How to test on Julia REPL:

[pizza.jl](examples/pizza.jl)

```julia-repl
julia> include("examples/pizza.jl")
```

(Output)

```text
Person

----------------------------------------------------
|      name      |      age       |     gender     |
----------------------------------------------------
|      Amy       |       16       |     female     |
|      Ben       |       21       |      male      |
|      Cal       |       33       |      male      |
|      Dan       |       13       |      male      |
|      Eli       |       45       |      male      |
|      Fay       |       21       |     female     |
|      Gus       |       24       |      male      |
|      Hil       |       30       |     female     |
|      Ian       |       18       |      male      |
----------------------------------------------------

Frequents

-----------------------------------
|      name      |    pizzeria    |
-----------------------------------
|      Amy       |   Pizza Hut    |
|      Ben       |   Pizza Hut    |
|      Ben       | Chicago Pizza  |
|      Cal       |   Straw Hat    |
|      Cal       | New York Pizza |
|      Dan       |   Straw Hat    |
|      Dan       | New York Pizza |
|      Eli       |   Straw Hat    |
|      Eli       | Chicago Pizza  |
|      Fay       |    Dominos     |
|      Fay       | Little Caesars |
|      Gus       | Chicago Pizza  |
|      Gus       |   Pizza Hut    |
|      Hil       |    Dominos     |
|      Hil       |   Straw Hat    |
|      Hil       |   Pizza Hut    |
|      Ian       | New York Pizza |
|      Ian       |   Straw Hat    |
|      Ian       |    Dominos     |
-----------------------------------

Eats

-----------------------------------
|      name      |     pizza      |
-----------------------------------
|      Amy       |   pepperoni    |
|      Amy       |    mushroom    |
|      Ben       |   pepperoni    |
|      Ben       |     cheese     |
|      Cal       |    supreme     |
|      Dan       |   pepperoni    |
|      Dan       |     cheese     |
|      Dan       |    sausage     |
|      Dan       |    supreme     |
|      Dan       |    mushroom    |
|      Eli       |    supreme     |
|      Eli       |     cheese     |
|      Fay       |    mushroom    |
|      Gus       |    mushroom    |
|      Gus       |    supreme     |
|      Gus       |     cheese     |
|      Hil       |    supreme     |
|      Hil       |     cheese     |
|      Ian       |    supreme     |
|      Ian       |   pepperoni    |
-----------------------------------

Serves

----------------------------------------------------
|    pizzeria    |     pizza      |     price      |
----------------------------------------------------
|   Pizza Hut    |   pepperoni    |       12       |
|   Pizza Hut    |    sausage     |       12       |
|   Pizza Hut    |     cheese     |       9        |
|   Pizza Hut    |    supreme     |       12       |
| Little Caesars |   pepperoni    |      9.75      |
| Little Caesars |    sausage     |      9.5       |
| Little Caesars |     cheese     |       7        |
| Little Caesars |    mushroom    |      9.25      |
|    Dominos     |     cheese     |      9.75      |
|    Dominos     |    mushroom    |       11       |
|   Straw Hat    |   pepperoni    |       8        |
|   Straw Hat    |     cheese     |      9.25      |
|   Straw Hat    |    sausage     |      9.75      |
| New York Pizza |   pepperoni    |       8        |
| New York Pizza |     cheese     |       7        |
| New York Pizza |    supreme     |      8.5       |
| Chicago Pizza  |     cheese     |      7.75      |
| Chicago Pizza  |    supreme     |      8.5       |
----------------------------------------------------

a. Find all pizzerias frequented by at least one person under the age of 18.

------------------
|    pizzeria    |
------------------
|   Pizza Hut    |
|   Straw Hat    |
| New York Pizza |
------------------


b. Find the names of all females who eat either mushroom or pepperoni pizza (or both).

------------------
|      name      |
------------------
|      Amy       |
|      Fay       |
------------------


c. Find the names of all females who eat both mushroom and pepperoni pizza.

------------------
|      name      |
------------------
|      Amy       |
------------------


d. Find all pizzerias that serve at least one pizza that Amy eats for less than $10.00.

------------------
|    pizzeria    |
------------------
| Little Caesars |
|   Straw Hat    |
| New York Pizza |
------------------


e. Find all pizzerias that are frequented by only females or only males.

------------------
|    pizzeria    |
------------------
| Little Caesars |
| Chicago Pizza  |
| New York Pizza |
------------------


f. For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents.
   Return all such person (name) / pizza pairs.

-----------------------------------
|      name      |     pizza      |
-----------------------------------
|      Amy       |    mushroom    |
|      Dan       |    mushroom    |
|      Gus       |    mushroom    |
-----------------------------------


g. Find the names of all people who frequent only pizzerias serving at least one pizza they eat.

------------------
|      name      |
------------------
|      Amy       |
|      Ben       |
|      Dan       |
|      Eli       |
|      Fay       |
|      Gus       |
|      Hil       |
------------------


h. Find the names of all people who frequent every pizzeria serving at least one pizza they eat.

------------------
|      name      |
------------------
|      Fay       |
------------------


i. Find the pizzeria serving the cheapest pepperoni pizza. In the case of ties, return all of the cheapest-pepperoni pizzerias.

------------------
|    pizzeria    |
------------------
|   Straw Hat    |
| New York Pizza |
------------------
```

Solution Notebooks:

a. Find all pizzerias frequented by at least one person under the age of 18.

[ [Pizza Solution A](examples/Pizza%20Solution%20A.ipynb) ]

b. Find the names of all females who eat either mushroom or pepperoni pizza (or both).

[ [Pizza Solution B](examples/Pizza%20Solution%20B.ipynb) ]

c. Find the names of all females who eat both mushroom and pepperoni pizza.

[ [Pizza Solution C](examples/Pizza%20Solution%20C.ipynb) ]

d. Find all pizzerias that serve at least one pizza that Amy eats for less than $10.00.

[ [Pizza Solution D](examples/Pizza%20Solution%20D.ipynb) ]

e. Find all pizzerias that are frequented by only females or only males.

[ [Pizza Solution E](examples/Pizza%20Solution%20E.ipynb) ]

f. For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents.

[ [Pizza Solution F](examples/Pizza%20Solution%20F.ipynb) ]

g. Find the names of all people who frequent only pizzerias serving at least one pizza they eat.

[ [Pizza Solution G](examples/Pizza%20Solution%20G.ipynb) ]

h. Find the names of all people who frequent every pizzeria serving at least one pizza they eat.

[ [Pizza Solution H](examples/Pizza%20Solution%20H.ipynb) ]

i. Find the pizzeria serving the cheapest pepperoni pizza. In the case of ties, return all of the cheapest-pepperoni pizzerias.

[ [Pizza Solution I](examples/Pizza%20Solution%20I.ipynb) ]
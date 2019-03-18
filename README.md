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
a. Find all pizzerias frequented by at least one person under the age of 18

pizzeria 
---
Pizza Hut 
Straw Hat 
New York Pizza 


b. Find the names of all females who eat either mushroom or pepperoni pizza (or both).

name 
---
Amy 
Fay 


c. Find the names of all females who eat both mushroom and pepperoni pizza.

name 
---
Amy 


d. Find all pizzerias that serve at least one pizza that Amy eats for less than $10.00.

pizzeria 
---
Little Caesars 
Straw Hat 
New York Pizza 


e. Find all pizzerias that are frequented by only females or only males.

pizzeria 
---
Little Caesars 
Chicago Pizza 
New York Pizza 


f. For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents.
   Return all such person (name) / pizza pairs.

name pizza 
---
Amy mushroom 
Dan mushroom 
Gus mushroom 


g. Find the names of all people who frequent only pizzerias serving at least one pizza they eat.

name 
---
Amy 
Ben 
Dan 
Eli 
Fay 
Gus 
Hil 


h. Find the names of all people who frequent every pizzeria serving at least one pizza they eat.

name 
---
Fay 


i. Find the pizzeria serving the cheapest pepperoni pizza. In the case of ties, return all of the cheapest-pepperoni pizzerias.

pizzeria 
---
Straw Hat 
New York Pizza
```
# Source: https://lagunita.stanford.edu/c4x/DB/RA/asset/opt-rel-algebra.html

using RelationalAlgebra
import RelationalAlgebra: π

person_attributes = Symbol[:name, :age, :gender]
frequents_attributes = Symbol[:name, :pizzeria]
eats_attributes = Symbol[:name, :pizza]
serves_attributes = Symbol[:pizzeria, :pizza, :price]

person_values = Tuple[
    ("Amy", 16, "female"),
    ("Ben", 21, "male"),
    ("Cal", 33, "male"),
    ("Dan", 13, "male"),
    ("Eli", 45, "male"),
    ("Fay", 21, "female"),
    ("Gus", 24, "male"),
    ("Hil", 30, "female"),
    ("Ian", 18, "male"),
]
frequents_values= Tuple[
    ("Amy", "Pizza Hut"),
    ("Ben", "Pizza Hut"),
    ("Ben", "Chicago Pizza"),
    ("Cal", "Straw Hat"),
    ("Cal", "New York Pizza"),
    ("Dan", "Straw Hat"),
    ("Dan", "New York Pizza"),
    ("Eli", "Straw Hat"),
    ("Eli", "Chicago Pizza"),
    ("Fay", "Dominos"),
    ("Fay", "Little Caesars"),
    ("Gus", "Chicago Pizza"),
    ("Gus", "Pizza Hut"),
    ("Hil", "Dominos"),
    ("Hil", "Straw Hat"),
    ("Hil", "Pizza Hut"),
    ("Ian", "New York Pizza"),
    ("Ian", "Straw Hat"),
    ("Ian", "Dominos"),
]
eats_values= Tuple[
    ("Amy", "pepperoni"),
    ("Amy", "mushroom"),
    ("Ben", "pepperoni"),
    ("Ben", "cheese"),
    ("Cal", "supreme"),
    ("Dan", "pepperoni"),
    ("Dan", "cheese"),
    ("Dan", "sausage"),
    ("Dan", "supreme"),
    ("Dan", "mushroom"),
    ("Eli", "supreme"),
    ("Eli", "cheese"),
    ("Fay", "mushroom"),
    ("Gus", "mushroom"),
    ("Gus", "supreme"),
    ("Gus", "cheese"),
    ("Hil", "supreme"),
    ("Hil", "cheese"),
    ("Ian", "supreme"),
    ("Ian", "pepperoni"),
]
serves_values= Tuple[
    ("Pizza Hut", "pepperoni", 12),
    ("Pizza Hut", "sausage", 12),
    ("Pizza Hut", "cheese", 9),
    ("Pizza Hut", "supreme", 12),
    ("Little Caesars", "pepperoni", 9.75),
    ("Little Caesars", "sausage", 9.5),
    ("Little Caesars", "cheese", 7),
    ("Little Caesars", "mushroom", 9.25),
    ("Dominos", "cheese", 9.75),
    ("Dominos", "mushroom", 11),
    ("Straw Hat", "pepperoni", 8),
    ("Straw Hat", "cheese", 9.25),
    ("Straw Hat", "sausage", 9.75),
    ("New York Pizza", "pepperoni", 8),
    ("New York Pizza", "cheese", 7),
    ("New York Pizza", "supreme", 8.5),
    ("Chicago Pizza", "cheese", 7.75),
    ("Chicago Pizza", "supreme", 8.5),
]

Person = Relation(person_attributes, person_values)
Frequents = Relation(frequents_attributes, frequents_values)
Eats = Relation(eats_attributes, eats_values)
Serves = Relation(serves_attributes, serves_values)

println("Person\n")
println(Person)

println("Frequents\n")
println(Frequents)

println("Eats\n")
println(Eats)

println("Serves\n")
println(Serves)


println("a. Find all pizzerias frequented by at least one person under the age of 18.\n")

# Straw Hat, New York Pizza, Pizza Hut

r1 = σ(Person, :age, <, 18)
r2 = r1 ⨝ Frequents
r3 = π(r2, :pizzeria)

result = [t[1] for t in r3.tuples_values]
@assert length(result) == 3
@assert "Straw Hat" ∈ result
@assert "New York Pizza" ∈ result
@assert "Pizza Hut" ∈ result

println(r3)


println("\nb. Find the names of all females who eat either mushroom or pepperoni pizza (or both).\n")

# Amy, Fay

r1 = σ(Eats, :pizza, ==, "pepperoni")
r2 = σ(Eats, :pizza, ==, "mushroom")
r3 = r1 ∪ r2
r4 = Person ⨝ r3
r5 = σ(r4, :gender, ==, "female")
r6 = π(r5, :name)

result = [t[1] for t in r6.tuples_values]
@assert length(result) == 2
@assert "Amy" ∈ result
@assert "Fay" ∈ result

println(r6)


println("\nc. Find the names of all females who eat both mushroom and pepperoni pizza.\n")

# Amy

r1 = σ(Eats, :pizza, ==, "pepperoni")
r2 = π(r1, :name)
r3 = σ(Eats, :pizza, ==, "mushroom")
r4 = π(r3, :name)
r5 = r2 ∩ r4
r6 = Person ⨝ r5
r7 = σ(r6, :gender, ==, "female")
r8 = π(r7, :name)

result = [t[1] for t in r8.tuples_values]
@assert length(result) == 1
@assert "Amy" ∈ result

println(r8)


println("\nd. Find all pizzerias that serve at least one pizza that Amy eats for less than \$10.00.\n")

# Little Caesars, Straw Hat, New York Pizza

r1 = σ(Eats, :name, ==, "Amy")
r2 = σ(Serves, :price, <, 10.0)
r3 = r1 ⨝ r2
r4 = π(r3, :pizzeria)

result = [t[1] for t in r4.tuples_values]
@assert length(result) == 3
@assert "Little Caesars" ∈ result
@assert "Straw Hat" ∈ result
@assert "New York Pizza" ∈ result

println(r4)


println("\ne. Find all pizzerias that are frequented by only females or only males.\n")

# Little Caesars, Chicago Pizza, New York Pizza

r1 = σ(Person, :gender, ==, "female")
r2 = r1 ⨝ Frequents
r3 = π(r2, :pizzeria)

r4 = σ(Person, :gender, ==, "male")
r5 = r4 ⨝ Frequents
r6 = π(r5, :pizzeria)

r7 = r3 ∪ r6
r8 = r3 ∩ r6

r9 = r7 - r8

result = [t[1] for t in r9.tuples_values]
@assert length(result) == 3
@assert "Little Caesars" ∈ result
@assert "Chicago Pizza" ∈ result
@assert "New York Pizza" ∈ result

println(r9)


println("\nf. For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents.")
println("   Return all such person (name) / pizza pairs.\n")

# Amy: mushroom, Dan: mushroom, Gus: mushroom

r1 = Person ⨝ Frequents
r2 = r1 ⨝ Serves
r3 = π(r2, :name, :pizza)
r4 = Eats - r3

result = r4.tuples_values
@assert length(result) == 3
@assert ("Amy", "mushroom") ∈ result
@assert ("Dan", "mushroom") ∈ result
@assert ("Gus", "mushroom") ∈ result

println(r4)


println("\ng. Find the names of all people who frequent only pizzerias serving at least one pizza they eat.\n")

# Amy, Ben, Dan, Eli, Fay, Gus, Hil

r1 = Eats ⨝ Serves
r2 = π(r1, :name, :pizzeria)
r3 = Frequents - r2
r4 = π(r3, :name)
r5 = π(Person, :name)
r6 = r5 - r4

result = [t[1] for t in r6.tuples_values]
@assert length(result) == 7
@assert "Amy" ∈ result
@assert "Ben" ∈ result
@assert "Dan" ∈ result
@assert "Eli" ∈ result
@assert "Fay" ∈ result
@assert "Gus" ∈ result
@assert "Hil" ∈ result

println(r6)


println("\nh. Find the names of all people who frequent every pizzeria serving at least one pizza they eat.\n")

# Fay

r1 = Eats ⨝ Serves
r2 = π(r1, :name, :pizzeria)
r3 = r2 - Frequents
r4 = π(r3, :name)
r5 = π(Person, :name)
r6 = r5 - r4

result = [t[1] for t in r6.tuples_values]
@assert length(result) == 1
@assert "Fay" ∈ result

println(r6)


println("\ni. Find the pizzeria serving the cheapest pepperoni pizza. In the case of ties, return all of the cheapest-pepperoni pizzerias.\n")

# Straw Hat, New York Pizza

r1 = σ(Serves, :pizza, ==, "pepperoni")
r2 = π(r1, :pizzeria, :price)
r3 = ρ(r2, :pizzeria, :other_pizzeria)
r4 = ρ(r3, :price, :other_price)
r5 = r2 × r4
r6 = σ(r5, :price, >, :other_price)
r7 = π(r6, :pizzeria)
r8 = π(r1, :pizzeria)
r9 = r8 - r7

result = [t[1] for t in r9.tuples_values]
@assert length(result) == 2
@assert "Straw Hat" ∈ result
@assert "New York Pizza" ∈ result

println(r9)


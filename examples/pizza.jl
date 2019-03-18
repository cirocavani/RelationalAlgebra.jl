# Source: https://lagunita.stanford.edu/c4x/DB/RA/asset/opt-rel-algebra.html

using RelationalAlgebra
import RelationalAlgebra: π, ∪, ∩, -

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

println("a. Find all pizzerias frequented by at least one person under the age of 18\n")

# Straw Hat, New York Pizza, Pizza Hut

r1 = σ(Person, :age, <, 18)
r2 = ρ(Frequents, :name, :frequents_name)
r3 = ×(r1, r2)
r4 = σ(r3, :name, ==, :frequents_name)
r5 = π(r4, :pizzeria)

println(r5)

result = [t[1] for t in r5.tuples_values]
@assert length(result) == 3
@assert "Straw Hat" ∈ result
@assert "New York Pizza" ∈ result
@assert "Pizza Hut" ∈ result

println("\nb. Find the names of all females who eat either mushroom or pepperoni pizza (or both).\n")

# Amy, Fay

r1 = σ(Eats, :pizza, ==, "pepperoni")
r2 = σ(Eats, :pizza, ==, "mushroom")
r3 = ∪(r1, r2)
r4 = ρ(r3, :name, :eats_name)
r5 = ×(Person, r4)
r6 = σ(r5, :name, ==, :eats_name)
r7 = σ(r6, :gender, ==, "female")
r8 = π(r7, :name)

println(r8)

result = [t[1] for t in r8.tuples_values]
@assert length(result) == 2
@assert "Amy" ∈ result
@assert "Fay" ∈ result

println("\nc. Find the names of all females who eat both mushroom and pepperoni pizza.\n")

# Amy

r1 = σ(Eats, :pizza, ==, "pepperoni")
r2 = π(r1, :name)
r3 = σ(Eats, :pizza, ==, "mushroom")
r4 = π(r3, :name)
r5 = ∩(r2, r4)
r6 = ρ(r5, :name, :eats_name)
r7 = ×(Person, r6)
r8 = σ(r7, :name, ==, :eats_name)
r9 = σ(r8, :gender, ==, "female")
r10 = π(r9, :name)

println(r10)

result = [t[1] for t in r10.tuples_values]
@assert length(result) == 1
@assert "Amy" ∈ result

println("\nd. Find all pizzerias that serve at least one pizza that Amy eats for less than \$10.00.\n")

# Little Caesars, Straw Hat, New York Pizza

r1 = σ(Serves, :price, <, 10.0)
r2 = σ(Eats, :name, ==, "Amy")
r3 = ρ(r2, :pizza, :eats_pizza)
r4 = ×(r1, r3)
r5 = σ(r4, :pizza, ==, :eats_pizza)
r6 = π(r5, :pizzeria)

println(r6)

result = [t[1] for t in r6.tuples_values]
@assert length(result) == 3
@assert "Little Caesars" ∈ result
@assert "Straw Hat" ∈ result
@assert "New York Pizza" ∈ result

println("\ne. Find all pizzerias that are frequented by only females or only males.\n")

# Little Caesars, Chicago Pizza, New York Pizza

r1 = σ(Person, :gender, ==, "female")
r2 = ρ(r1, :name, :person_name)
r3 = ×(r2, Frequents)
r4 = σ(r3, :person_name, ==, :name)
r5 = π(r4, :pizzeria)

r6 = σ(Person, :gender, ==, "male")
r7 = ρ(r6, :name, :person_name)
r8 = ×(r7, Frequents)
r9 = σ(r8, :person_name, ==, :name)
r10 = π(r9, :pizzeria)

r11 = ∪(r5, r10)
r12 = ∩(r5, r10)

r13 = -(r11, r12)

println(r13)

result = [t[1] for t in r13.tuples_values]
@assert length(result) == 3
@assert "Little Caesars" ∈ result
@assert "Chicago Pizza" ∈ result
@assert "New York Pizza" ∈ result


println("\nf. For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents.")
println("   Return all such person (name) / pizza pairs.\n")

# Amy: mushroom, Dan: mushroom, Gus: mushroom

r1 = ρ(Person, :name, :person_name)
r2 = ×(r1, Frequents)
r3 = σ(r2, :person_name, ==, :name)
r4 = ρ(r3, :pizzeria, :frequents_pizzeria)
r5 = ×(r4, Serves)
r6 = σ(r5, :pizzeria, ==, :frequents_pizzeria)
r7 = π(r6, :name, :pizza)
r8 = Eats - r7

println(r8)

result = r8.tuples_values
@assert length(result) == 3
@assert ("Amy", "mushroom") ∈ result
@assert ("Dan", "mushroom") ∈ result
@assert ("Gus", "mushroom") ∈ result

println("\ng. Find the names of all people who frequent only pizzerias serving at least one pizza they eat.\n")

# Amy, Ben, Dan, Eli, Fay, Gus, Hil

r1 = ρ(Eats, :pizza, :eats_pizza)
r2 = ×(r1, Serves)
r3 = σ(r2, :pizza, ==, :eats_pizza)
r4 = π(r3, :name, :pizzeria)
r5 = -(Frequents, r4)
r6 = π(r5, :name)
r7 = π(Person, :name)
r8 = -(r7, r6)

println(r8)

result = [t[1] for t in r8.tuples_values]
@assert length(result) == 7
@assert "Amy" ∈ result
@assert "Ben" ∈ result
@assert "Dan" ∈ result
@assert "Eli" ∈ result
@assert "Fay" ∈ result
@assert "Gus" ∈ result
@assert "Hil" ∈ result


println("\nh. Find the names of all people who frequent every pizzeria serving at least one pizza they eat.\n")

# Fay

r1 = ρ(Eats, :pizza, :eats_pizza)
r2 = ×(r1, Serves)
r3 = σ(r2, :pizza, ==, :eats_pizza)
r4 = π(r3, :name, :pizzeria)
r5 = -(r4, Frequents)
r6 = π(r5, :name)
r7 = π(Person, :name)
r8 = -(r7, r6)

println(r8)

result = [t[1] for t in r8.tuples_values]
@assert length(result) == 1
@assert "Fay" ∈ result


println("\ni. Find the pizzeria serving the cheapest pepperoni pizza. In the case of ties, return all of the cheapest-pepperoni pizzerias.\n")

# Straw Hat, New York Pizza

r1 = σ(Serves, :pizza, ==, "pepperoni")
r2 = π(r1, :pizzeria, :price)
r3 = ρ(r2, :pizzeria, :other_pizzeria)
r4 = ρ(r3, :price, :other_price)
r5 = ×(r2, r4)
r6 = σ(r5, :price, >, :other_price)
r7 = π(r6, :pizzeria)
r8 = π(r1, :pizzeria)
r9 = -(r8, r7)

println(r9)

result = [t[1] for t in r9.tuples_values]
@assert length(result) == 2
@assert "Straw Hat" ∈ result
@assert "New York Pizza" ∈ result

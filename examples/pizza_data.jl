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

println("Person\n")
println(Person)

println("Frequents\n")
println(Frequents)

println("Eats\n")
println(Eats)

println("Serves\n")
println(Serves)

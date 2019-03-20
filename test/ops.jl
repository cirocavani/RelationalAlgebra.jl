# https://www.geeksforgeeks.org/database-management-system-relational-algebra/

using RelationalAlgebra
using Test

@testset "Projection" begin

    import RelationalAlgebra: π

    attributes_names = Symbol[:A, :B, :C]
    tuples_values = Tuple[
        (1, 2, 4),
        (2, 2, 3),
        (3, 2, 3),
        (4, 3, 4),
    ]
    expected_names = Symbol[:B, :C]
    expected_values = Tuple[
        (2, 4),
        (2, 3),
        (3, 4),
    ]

    R = Relation(attributes_names, tuples_values)
    X = Relation(expected_names, expected_values)

    S = π(R, :B, :C)

    @test S == X

end

@testset "Selection Const Value" begin

    attributes_names = Symbol[:A, :B, :C]
    tuples_values = Tuple[
        (1, 2, 4),
        (2, 2, 3),
        (3, 2, 3),
        (4, 3, 4),
    ]
    expected_values = Tuple[
        (1, 2, 4),
        (4, 3, 4),
    ]

    R = Relation(attributes_names, tuples_values)
    X = Relation(attributes_names, expected_values)

    S = σ(R, :C, >, 3)

    @test S == X

end

@testset "Selection Attribute Value" begin

    attributes_names = Symbol[:A, :B, :C]
    tuples_values = Tuple[
        (1, 2, 4),
        (2, 2, 3),
        (3, 2, 3),
        (4, 3, 4),
    ]
    expected_values = Tuple[
        (3, 2, 3),
        (4, 3, 4),
    ]

    R = Relation(attributes_names, tuples_values)
    X = Relation(attributes_names, expected_values)

    S = σ(R, :A, ==, :C)

    @test S == X

end

@testset "Rename" begin

    R = Relation([:A, :B], [])
    @test_throws ErrorException ρ(R, :X => :Y)
    @test_throws ErrorException ρ(R, :X => :A)
    @test_throws ErrorException ρ(R, :X => :B)
    @test_throws ErrorException ρ(R, :A => :B)
    @test_throws ErrorException ρ(R, :B => :A)

    @test_throws ErrorException ρ(R, :A => :C, :B => :A)

    S = Relation([:X, :Y], [])
    @test ρ(R, :A => :X, :B => :Y) == S

    attributes_names = Symbol[:A, :B, :C]
    tuples_values = Tuple[
        (1, 2, 4),
        (2, 2, 3),
        (3, 2, 3),
        (4, 3, 4),
    ]
    expected_names = Symbol[:X, :Y, :Z]

    R = Relation(attributes_names, tuples_values)
    X = Relation(expected_names, tuples_values)

    S = ρ(R, :A => :X, :B => :Y, :C => :Z)

    @test S == X

end

@testset "Cross Product" begin

    A_attributes = Symbol[:Name, :Age, :Sex]
    A_tuples = Tuple[
        ("Ram", 14, "M"),
        ("Sona", 15, "F"),
        ("Kim", 20, "M"),
    ]
    B_attributes = Symbol[:Id, :Course]
    B_tuples = Tuple[
        (1, "DS"),
        (2, "DBMS"),
    ]
    AB_attributes = Symbol[:Name, :Age, :Sex, :Id, :Course]
    AB_tuples = Tuple[
        ("Ram", 14, "M", 1, "DS"),
        ("Ram", 14, "M", 2, "DBMS"),
        ("Sona", 15, "F", 1, "DS"),
        ("Sona", 15, "F", 2, "DBMS"),
        ("Kim", 20, "M", 1, "DS"),
        ("Kim", 20, "M", 2, "DBMS"),
    ]

    A = Relation(A_attributes, A_tuples)
    B = Relation(B_attributes, B_tuples)
    AB = Relation(AB_attributes, AB_tuples)

    S = A × B

    @test S == AB

end

@testset "Natural Join" begin

    A = Relation([:a], [])
    B = Relation([:b], [])
    @test_throws ErrorException A ⨝ B

    A_attributes = Symbol[:Name, :Id, :Dept_name]
    A_tuples = Tuple[
        ("A", 120, "IT"),
        ("B", 125, "HR"),
        ("C", 110, "Sale"),
        ("D", 111, "IT"),
    ]
    B_attributes = Symbol[:Dept_name, :Manager]
    B_tuples = Tuple[
        ("Sale", "Y"),
        ("Prod", "Z"),
        ("IT", "A"),
    ]
    AB_attributes = Symbol[:Name, :Id, :Dept_name, :Manager]
    AB_tuples = Tuple[
        ("A", 120, "IT", "A"),
        ("C", 110, "Sale", "Y"),
        ("D", 111, "IT", "A"),
    ]

    A = Relation(A_attributes, A_tuples)
    B = Relation(B_attributes, B_tuples)
    AB = Relation(AB_attributes, AB_tuples)

    S = A ⨝ B

    @test S == AB

end

@testset "Set Union" begin

    A_attributes = Symbol[:Name, :Age, :Sex]
    A_tuples = Tuple[
        ("Ram", 14, "M"),
        ("Sona", 15, "F"),
    ]
    B_attributes = Symbol[:Name, :Age, :Sex]
    B_tuples = Tuple[
        ("Sona", 15, "F"),
        ("Kim", 20, "M"),
    ]
    AB_attributes = Symbol[:Name, :Age, :Sex]
    AB_tuples = Tuple[
        ("Ram", 14, "M"),
        ("Sona", 15, "F"),
        ("Kim", 20, "M"),
    ]

    A = Relation(A_attributes, A_tuples)
    B = Relation(B_attributes, B_tuples)
    AB = Relation(AB_attributes, AB_tuples)

    S = A ∪ B

    @test S == AB

end

@testset "Set Intersection" begin

    A_attributes = Symbol[:Name, :Age, :Sex]
    A_tuples = Tuple[
        ("Ram", 14, "M"),
        ("Sona", 15, "F"),
    ]
    B_attributes = Symbol[:Name, :Age, :Sex]
    B_tuples = Tuple[
        ("Sona", 15, "F"),
        ("Kim", 20, "M"),
    ]
    AB_attributes = Symbol[:Name, :Age, :Sex]
    AB_tuples = Tuple[
        ("Sona", 15, "F"),
    ]

    A = Relation(A_attributes, A_tuples)
    B = Relation(B_attributes, B_tuples)
    AB = Relation(AB_attributes, AB_tuples)

    S = A ∩ B

    @test S == AB

end

@testset "Set Subtraction" begin

    A_attributes = Symbol[:Name, :Age, :Sex]
    A_tuples = Tuple[
        ("Ram", 14, "M"),
        ("Sona", 15, "F"),
    ]
    B_attributes = Symbol[:Name, :Age, :Sex]
    B_tuples = Tuple[
        ("Sona", 15, "F"),
        ("Kim", 20, "M"),
    ]
    AB_attributes = Symbol[:Name, :Age, :Sex]
    AB_tuples = Tuple[
        ("Ram", 14, "M"),
    ]

    A = Relation(A_attributes, A_tuples)
    B = Relation(B_attributes, B_tuples)
    AB = Relation(AB_attributes, AB_tuples)

    S = A - B

    @test S == AB

end

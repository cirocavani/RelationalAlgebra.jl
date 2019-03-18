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

    attributes_names = Symbol[:A, :B, :C]
    tuples_values = Tuple[
        (1, 2, 4),
        (2, 2, 3),
        (3, 2, 3),
        (4, 3, 4),
    ]
    expected_names = Symbol[:A, :X, :C]

    R = Relation(attributes_names, tuples_values)
    X = Relation(expected_names, tuples_values)

    S = ρ(R, :B, :X)

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

    S = ×(A, B)

    @test S == AB

end

@testset "Set Union" begin

    import RelationalAlgebra: ∪

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

    S = ∪(A, B)

    @test S == AB

end

@testset "Set Intersection" begin

    import RelationalAlgebra: ∩

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

    S = ∩(A, B)

    @test S == AB

end

@testset "Set Subtraction" begin

    import RelationalAlgebra: -

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

    S = -(A, B)

    @test S == AB

end

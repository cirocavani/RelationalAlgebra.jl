module RelationalAlgebra

import Base: ==, show, ∪, ∩, -

export
    Relation,
    π, projection,
    σ, selection,
    ρ, rename,
    ×, cross_product,
    ⨝, natural_join,
    set_union,
    set_intersection,
    set_subtraction

struct Relation
    attributes_names::Vector{Symbol}
    tuples_values::Vector{Tuple}
end

function ==(relation1::Relation, relation2::Relation)
    return relation1.attributes_names == relation2.attributes_names &&
        relation1.tuples_values == relation2.tuples_values
end

cpad(s::String, n::Integer) = rpad(lpad(s, (n + textwidth(s)) ÷ 2, " "), n, " ")
cpad(s, n::Integer) = cpad(string(s), n)

function show(io::IO, relation::Relation)
    column_width = 14
    attributes_names = [cpad(name, column_width) for name in relation.attributes_names]
    header = string("| ", join(attributes_names, " | "), " |")
    sep = "-"^textwidth(header)
    println(io, sep)
    println(io, header)
    println(io, sep)
    for relation_tuple in relation.tuples_values
        values = [cpad(value, column_width) for value in relation_tuple]
        row = string("| ", join(values, " | "), " |")
        println(io, row)
    end
    println(io, sep)
end


#
# Projection π
#

function projection(relation::Relation, attributes_names::Symbol...)
    isempty(setdiff(attributes_names, relation.attributes_names)) || error("Attribute name not found!")
    attributes_array = collect(attributes_names)
    attributes_indices = map(attributes_array) do attribute_name
        findfirst(relation.attributes_names .== attribute_name)
    end
    tuples_values = [t[attributes_indices] for t in relation.tuples_values]
    unique!(tuples_values)
    return Relation(attributes_array, tuples_values)
end

π(relation::Relation, attributes_names::Symbol...) = projection(relation, attributes_names...)


#
# Selection σ
#

function selection(relation::Relation, attribute_name::Symbol, cmp_operator::Function, value::Symbol)
    attribute_name ∈ relation.attributes_names || error("Attribute name not found!")
    value ∈ relation.attributes_names || error("Value attribute name not found!")
    op1_index = findfirst(relation.attributes_names .== attribute_name)
    op2_index = findfirst(relation.attributes_names .== value)
    tuples_values = filter(relation.tuples_values) do relation_tuple
        op1_value = relation_tuple[op1_index]
        op2_value = relation_tuple[op2_index]
        cmp_operator(op1_value, op2_value)
    end
    return Relation(copy(relation.attributes_names), tuples_values)
end

function selection(relation::Relation, attribute_name::Symbol, cmp_operator::Function, value::Any)
    attribute_name ∈ relation.attributes_names || error("Attribute name not found!")
    op1_index = findfirst(relation.attributes_names .== attribute_name)
    tuples_values = filter(relation.tuples_values) do relation_tuple
        op1_value = relation_tuple[op1_index]
        cmp_operator(op1_value, value)
    end
    return Relation(copy(relation.attributes_names), tuples_values)
end

σ(relation::Relation, attribute_name::Symbol, cmp_operator::Function, value::Symbol) = selection(relation, attribute_name, cmp_operator, value)
σ(relation::Relation, attribute_name::Symbol, cmp_operator::Function, value::Any) = selection(relation, attribute_name, cmp_operator, value)


#
# Rename ρ
#

function rename(relation::Relation, attributes_renames::Pair{Symbol, Symbol}...)
    attributes_names_in, attributes_names_out = zip(attributes_renames...)
    allunique(attributes_names_in) || error("In attribute name duplicated!")
    allunique(attributes_names_out) || error("Out attribute name duplicated!")
    isempty(setdiff(attributes_names_in, relation.attributes_names)) || error("In attribute name not found!")
    isempty(intersect(attributes_names_out, relation.attributes_names)) || error("Out attribute name found!")

    attributes_names = replace(relation.attributes_names, attributes_renames...)
    tuples_values = copy(relation.tuples_values)

    return Relation(attributes_names, tuples_values)
end

ρ(relation::Relation, attributes_renames::Pair{Symbol, Symbol}...) = rename(relation, attributes_renames...)


#
# Cross Product ×
#

function cross_product(relation1::Relation, relation2::Relation)
    isempty(intersect(relation1.attributes_names, relation2.attributes_names)) || error("Attributes with same name found!")
    attributes_names = vcat(relation1.attributes_names, relation2.attributes_names)
    tuples_values = [(t1..., t2...) for t2 in relation2.tuples_values, t1 in relation1.tuples_values]
    tuples_values = reshape(tuples_values, length(tuples_values))
    return Relation(attributes_names, tuples_values)
end

×(relation1::Relation, relation2::Relation) = cross_product(relation1, relation2)


#
# Natural Join ⨝
#

function merge_join(tuple1::Tuple, tuple2::Tuple, tuple2_indices::Vector{Int})
    if isempty(tuple2_indices)
        return tuple1
    end
    return (tuple1..., tuple2[tuple2_indices]...)
end

function test_join(tuple1::Tuple, tuple2::Tuple, tuple1_indices::Vector{Int}, tuple2_indices::Vector{Int})
    return all(tuple1[i] == tuple2[j] for (i, j) in zip(tuple1_indices, tuple2_indices))
end

function natural_join(relation1::Relation, relation2::Relation)
    join_attributes = intersect(relation1.attributes_names, relation2.attributes_names)
    !isempty(join_attributes) || error("Attributes with same name missing!")
    relation1_indices = map(join_attributes) do attribute_name
        findfirst(relation1.attributes_names .== attribute_name)
    end
    relation2_indices = map(join_attributes) do attribute_name
        findfirst(relation2.attributes_names .== attribute_name)
    end
    tuple2_mask = setdiff(1:length(relation2.attributes_names), relation2_indices)
    tuples_values = [
        merge_join(t1, t2, tuple2_mask)
        for t2 in relation2.tuples_values, t1 in relation1.tuples_values
        if test_join(t1, t2, relation1_indices, relation2_indices)]
    attributes_names = union(relation1.attributes_names, relation2.attributes_names)
    return Relation(attributes_names, tuples_values)
end

⨝(relation1::Relation, relation2::Relation) = natural_join(relation1, relation2)


#
# Union ∪
#

function set_union(relation1::Relation, relation2::Relation)
    relation1.attributes_names == relation2.attributes_names || error("Ralations with different attributes!")
    attributes_names = copy(relation1.attributes_names)
    tuples_values = union(relation1.tuples_values, relation2.tuples_values)
    return Relation(attributes_names, tuples_values)
end

∪(relation1::Relation, relation2::Relation) = set_union(relation1, relation2)


#
# Intersection ∩
#

function set_intersection(relation1::Relation, relation2::Relation)
    relation1.attributes_names == relation2.attributes_names || error("Ralations with different attributes!")
    attributes_names = copy(relation1.attributes_names)
    tuples_values = intersect(relation1.tuples_values, relation2.tuples_values)
    return Relation(attributes_names, tuples_values)
end

∩(relation1::Relation, relation2::Relation) = set_intersection(relation1, relation2)


#
# Subtraction -
#

function set_subtraction(relation1::Relation, relation2::Relation)
    relation1.attributes_names == relation2.attributes_names || error("Ralations with different attributes!")
    attributes_names = copy(relation1.attributes_names)
    tuples_values = setdiff(relation1.tuples_values, relation2.tuples_values)
    return Relation(attributes_names, tuples_values)
end

-(relation1::Relation, relation2::Relation) = set_subtraction(relation1, relation2)


end # module

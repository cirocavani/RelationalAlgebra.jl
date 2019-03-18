module RelationalAlgebra

import Base: ==, show, ∪, ∩, -

export
    Relation,
    π, projection,
    σ, selection,
    ρ, rename,
    ×, cross_product,
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
    rows = length(relation.tuples_values)
    for (i, relation_tuple) in enumerate(relation.tuples_values)
        values = [cpad(value, column_width) for value in relation_tuple]
        row = string("| ", join(values, " | "), " |")
        println(io, row)
    end
    println(io, sep)
end

function projection(relation::Relation, attributes_names::Symbol...)
    attributes_indices = map(attributes_names) do attribute_name
        attribute_name ∈ relation.attributes_names || error("Attribute name not found!")
        findfirst(relation.attributes_names .== attribute_name)
    end
    tuples_values = map(relation.tuples_values) do relation_tuple
        projection_vector = map(i -> relation_tuple[i], attributes_indices)
        tuple(projection_vector...)
    end
    unique!(tuples_values)
    return Relation(collect(attributes_names), tuples_values)
end

π(relation::Relation, attributes_names::Symbol...) = projection(relation, attributes_names...)

function selection_filter_const(tuples::Vector{Tuple}, cmp::Function, op1_index::Int, op2_value::Any)
    return filter(tuples) do relation_tuple
        op1_value = relation_tuple[op1_index]
        cmp(op1_value, op2_value)
    end
end

function selection_filter_pair(tuples::Vector{Tuple}, cmp::Function, op1_index::Int, op2_index::Int)
    return filter(tuples) do relation_tuple
        op1_value = relation_tuple[op1_index]
        op2_value = relation_tuple[op2_index]
        cmp(op1_value, op2_value)
    end
end

function selection(relation::Relation, attribute_name::Symbol, operator::Function, value::Any)
    attribute_name ∈ relation.attributes_names || error("Attribute name not found!")
    tuples_values = relation.tuples_values
    op1_index = findfirst(relation.attributes_names .== attribute_name)
    if value isa Symbol
        op2_index = findfirst(relation.attributes_names .== value)
        tuples_values = selection_filter_pair(tuples_values, operator, op1_index, op2_index)
    else
        tuples_values = selection_filter_const(tuples_values, operator, op1_index, value)
    end

    return Relation(copy(relation.attributes_names), tuples_values)
end

σ(relation::Relation, attribute_name::Symbol, operator::Function, value::Any) = selection(relation, attribute_name, operator, value)

function rename(relation::Relation, attribute_name::Symbol, new_attribute_name::Symbol)
    attribute_name ∈ relation.attributes_names || error("Attribute name not found!")
    new_attribute_name ∉ relation.attributes_names || error("New attribute name found!")
    attribute_index = findfirst(relation.attributes_names .== attribute_name)
    attributes_names = copy(relation.attributes_names)
    attributes_names[attribute_index] = new_attribute_name
    return Relation(attributes_names, copy(relation.tuples_values))
end

ρ(relation::Relation, attribute_name::Symbol, new_attribute_name::Symbol) = rename(relation, attribute_name, new_attribute_name)

function cross_product(relation1::Relation, relation2::Relation)
    isempty(intersect(relation1.attributes_names, relation2.attributes_names)) || error("Attributes with same name!")
    attributes_names = vcat(relation1.attributes_names, relation2.attributes_names)
    tuples_values = [(t1..., t2...) for t2 in relation2.tuples_values, t1 in relation1.tuples_values]
    tuples_values = reshape(tuples_values, length(tuples_values))
    return Relation(attributes_names, tuples_values)
end

×(relation1::Relation, relation2::Relation) = cross_product(relation1, relation2)

function set_union(relation1::Relation, relation2::Relation)
    relation1.attributes_names == relation2.attributes_names || error("Ralations with different attributes!")
    attributes_names = copy(relation1.attributes_names)
    tuples_values = union(relation1.tuples_values, relation2.tuples_values)
    return Relation(attributes_names, tuples_values)
end

∪(relation1::Relation, relation2::Relation) = set_union(relation1, relation2)

function set_intersection(relation1::Relation, relation2::Relation)
    relation1.attributes_names == relation2.attributes_names || error("Ralations with different attributes!")
    attributes_names = copy(relation1.attributes_names)
    tuples_values = intersect(relation1.tuples_values, relation2.tuples_values)
    return Relation(attributes_names, tuples_values)
end

∩(relation1::Relation, relation2::Relation) = set_intersection(relation1, relation2)

function set_subtraction(relation1::Relation, relation2::Relation)
    relation1.attributes_names == relation2.attributes_names || error("Ralations with different attributes!")
    attributes_names = copy(relation1.attributes_names)
    tuples_values = setdiff(relation1.tuples_values, relation2.tuples_values)
    return Relation(attributes_names, tuples_values)
end

-(relation1::Relation, relation2::Relation) = set_subtraction(relation1, relation2)

end # module

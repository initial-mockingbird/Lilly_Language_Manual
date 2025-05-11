# Values

## Integer numbers

Integer numbers ranges from \\(-2^{29} .. 2^{29} - 1\\). Any implementation
may support a wider range of numbers.

## Functions

Although functions are reduced internally to closures, they are considered
values.

## Lazy values

Lazy values are always constructed by quoting an expression: \\('e'\\).
As with functions, although they are reduced internally to closures, they are
considered values.

## Tuples

Tuple values are always binary and written as \\((x_1,x_2) \\).

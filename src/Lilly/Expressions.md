# Expressions

\\[
\begin{alignat*}{1}
\textit{expr}
    &&::=   \textit{number}  \\\\
    && \mid \texttt{(} expr \texttt{)} \\\\
    && \mid \textit{ident} \\\\
    && \mid \texttt{'} \textit{expr} \texttt{'} \\\\
    && \mid \texttt{(} \textit{expr} \texttt{,} \textit{expr} \texttt{)} \\\\
    && \mid \texttt{fn} \texttt{(} \textit {type } \textit{ident} \texttt{)}
        [\texttt{ => } \textit{type} ]
        \texttt{ -> } \textit{expr} \\\\
    && \mid \texttt{if (} \textit{expr} \texttt{, } \textit{expr} \texttt{, } \textit{expr} \texttt{)} \\\\
    && \mid \texttt{random (} \textit{expr} \texttt{)} \\\\
    && \mid \texttt{formula (} \textit{expr} \texttt{)} \\\\
    && \mid \texttt{fst (} \textit{expr} \texttt{)} \\\\
    && \mid \texttt{snd (} \textit{expr} \texttt{)} \\\\
    && \mid \textit{expr} \texttt{(} \textit{expr} \texttt{)} \\\\
\end{alignat*}
\\]

## Precedence and Associativity

The table below summarizes the associativity and precedence of the expression operators.
The operators with the highest precedence are at the top.

| Operator             | Associativity |
| -------------------- | ------------- |
| function application | Left          |
| lambda abstractions  | None          |



## Parenthesized expressions

The expression `(e)` denotes the same expression as `e`. Parentheses are mostly used to
apply lambda expressions without binding them to a variable.

## Lambda expressions

The expression `fn (t x) -> e` denotes a lambda expression that takes a single
argument `x` of L-type `t` and returns the value of the expression `e`.
Lambda abstractions `fn (t x) ->`  can be thought as prefix operators with the lowest precedence,
thus we tipically use parentheses to apply them to their arguments if we
dont want to bind them to any names.

Lambda expressions satisfy the principle of declarative correspondence, which
states that variable bindings behave the same in variable definition, reassignment,
lambda expression binding and any other binding.

We can also state the return type of a lambda expression using the alternative syntax
`fn (t x) => ret_t -> e`.

It is important to note that the return value is always evaluated and then return.
So `fn (lazy<Z> x) => Z -> x` is a well typed function.

All of the following are lambda expressions:


```zilly
fn (Z x) -> x
fn (Z x) => Z -> x
fn (Z => Z f) -> fn (Z x) -> f(sub(1)(x))
fn (lazy<Z> x) => Z -> x
```

## Values

Values are expressions who are already in normal form. Zilly has 3 types of values:
functions, integer literals, and tuples of values.

All of the following are values:

```zilly
1
fn (Z x) -> x
(fn (Z x) -> x, 3)
```

## Lazy expressions

The expression `'e'` denotes a lazy expression. They allow us to pass non reduced
expressions such as `sub(1)(y)` to functions and variable assignments, that is
now a variable `x`, aside integer literals and functions, can also hold expressions
which can be evaluated later.

A lazy expression `'e'` is reduced to `e` after one evaluation step.

To preserve static scoping, `'e'` is actually reduced to a closure, where every
variable in `e` is actually a reference.



## Function application

The expression `e0(e1)` denotes the application of the function `e0` to the
argument `e1`. Function application is strict; it evaluates the function first, and the argument
second.

All of the following are function applications:

```zilly
(fn (Z x) -> x)(y);
x(y)
(fn (Z => Z) f -> f(1))(fn (Z x) -> x)
```

## Variables

If `x` is a variable with content `e`, then `x` is evaluated to whatever `e` evaluates to.
This only matters if `x` holds a non-reduced expression

- If `x` holds the value `9`, then `x` evalues to `9`
- If `x` holds the non-reduced expression `sub(1)(y)`, and `y` holds `3`, then `x` will
    evaluate to `2`.
- If `x` holds the expression `'sub(1)(y)''`,
    then `x` will evaluate to `sub(1)(y)`.

Variables are memoized. The semantics of this memoization are discussed in
the [Computing Cycle](./Computing_Cycle.md) section.

## Tuples

The expression `(e0, e1)` denotes a tuple of values. Tuples are evaluated by evaluating
the first and second elements. The first element is evaluated first, and the second last.

The expression `fst(e)` denotes the first element of the tuple `e`, and `snd(e)` denotes
the second element of the tuple `e`. They are the destructors of the tuple.

All of the following are tuples:

```zilly
(1,2)
(1,sub(1)(y))
('x',2)
(1,fn (Z y) -> sub(1)(y))
```


## Truthood

A 0 value is considered false, and any other value is considered true.

## Special forms

Special forms are functions with special properties. Currently Zilly has 2
special forms: `if` and `formula`.

The expression `if (e0, e1, e2)` denotes the conditional expression that evaluates
the expression `e0` and returns the evaluation of `e1` if `e0` is true, and the evaluation
of `e2` otherwise. It is a special form since its non strict in its second and third
argument.

The type of conditional expressions would be `forall t. Z => t -> t -> t` if the type system
had parametric polymorphism

All of the following are well typed conditional expressions:

```zilly
if (1,2,3)
if (0,sub(1)(3),4)
if (1,'4','sub(1)(3)')
if (1,0,'sub(1)(3)')
```


The expression `formula(ident)` returns contents of the variable passed as argument.
Thus, if `x` holds the non reduced expression `sub(1)(y)`, then `formula (x)` will
yield `sub(1)(y)`. It is a special form since it only works on variables.

All of the following are formula expressions:

```zilly
formula (x)
formula(y)
formula(z)
```


## Random expressions

The expression `random (e)` returns a random value between 0 and `e` (exclusive).
The type of `random` is `Z => Z`.

All of the following are well typed random expressions:

```zilly
random (1)
random (sub(1)(3))
random (sub(1)(y))
```

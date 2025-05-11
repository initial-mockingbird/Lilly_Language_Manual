# Type Expressions

\\[
\begin{alignat*}{1}
\textit{type}
    &&::=   \textit{simple-type} \\\\
    && \mid \textit{function-type} \\\\
    && \mid \textit{tuple-type} \\\\
    && \mid \textit{lazy-type} \\\\
\textit{simple-type} &&:= \texttt{Z} \\\\
    && \mid \texttt{(} \textit{type} \texttt{)} \\\\
\textit{function-type} &&::= \textit{type} \texttt{ -> } \textit{type} \\\\
\textit{tuple-type} &&::= \texttt{(} \textit{type} \texttt{,} \textit{type} \texttt{)} \\\\
\textit{lazy-type} &&::= \texttt{lazy<} \textit{type} \\texttt{>}  \\\\
\end{alignat*}
\\]

The table below summarizes the associativity and precedence of the type operators.
With the highest precedence operators at the top.


| Operator | Associativity |
| -------- | ------------- |
| `=>`     | Right         |

## F-transform and L-Types


| `t`                | `F(t)`                          |
|--------------------|---------------------------------|
| \\(Z\\)            | \\(Z\\)                         |
| \\(lazy< a > \\)   | \\(a\\)                         |
| \\(\(t_0, t_1\)\\) | \\(\(F(t_0), F(t_1)\)\\)        |
| \\(t_0 \to t_1\\)  | \\(t_0 \to t_1\\)               |

Every expression in Zilly has a type, evaluating an expression might change that type. The
way we determine whats the type of an expression after evaluation is by applying the
`F-`transform stated above.

Moreover, if the variable `x` was declared with type `t`, we will say that `x` has
L-type `t`; however, whenever the variable `x` is mentioned in an expression context,
it will have type `F(t)`.


## Subtyping

The subtyping relation `<:` follows the rules below:

```
                                   a <: a'  b <: b'
------------ <lazy subtype>   -------------------------<pair subtype>
a <: lazy<a>                       (a,b) <: (a',b')

                arg' <: arg     ret <: ret'
              -------------------------------<function subtype>
                arg -> ret <: arg' -> ret'

```

It is important to note that the `F-`transform respects the subtype relation, that is:

\\[
t_0 <: t_1 \implies F(t_0) <: F(t_1)
\\]

Of the following belong to the subtype relation

```
Z <: lazy<Z>
Z <: lazy<lazy<lazy<Z>>>
lazy<Z> <: lazy<lazy<lazy<lazy<Z>>>>
lazy<Z> -> Z <: Z -> lazy<Z>
```

Casting is done implicitly via subtyping.



## Parenthesized types

The type `(t)` denotes the same type as `t`. Parentheses are mostly used to
facilitate typing higher order functions.

## Function types

The type `t0 -> t1` denotes the type of functions whose formal parameter has
L-type `t0`, and whose return parameter has type `t1`.

We say that a function application `e_0(e_1)` is well typed, if `e_0` has type
`t0 -> t1` and `e_1` has type `t0`.


## Tuple types

The type `(t0, t1)` denotes the type of tuples whose first element has type `t0`
and whose second element has type `t1`.

## Lazy types

The type `lazy<t>` denotes the type of lazy expressions. Lazy expressions are
always constructed by quoting an expression: `'e'` and hold non necessarily
reduced expressions. Thus, if the variable `x` has L-type `lazy<t>`, then the contents
of `x` can hold all of the following non necessarily reduced expressions: `1`,
`sub(1)(2)`, `(1,sub(y)(z))`.

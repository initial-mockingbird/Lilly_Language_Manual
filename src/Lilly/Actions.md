# Actions

\\[
\begin{alignat*}{1}
\textit{actions}
    &&::=   \textit{def} \\\\
    && \mid \textit{reassign} \\\\
    && \mid \textit{expr} \\\\
    && \mid \textit{sys-action} \\\\
\textit{def}
    &&::= \textit{type} \quad \textit{ident} \texttt{ := } \textit{expr} \texttt{;} \\\\
\textit{reassign}
    &&::= \textit{ident} \texttt{ := } \textit{expr} \texttt{;} \\\\
\textit{sys-action}
    &&::= \texttt{sys.} \textit{sys-command} \\\\
\textit{sys-command}
    &&::= \texttt{reset} [\texttt{()}]
\end{alignat*}
\\]

## Evaluating expressions

Every expression is also an action.


## Defining variables

\\[
\begin{alignat*}{1}
\textit{def}
    &&::= \textit{type} \quad \textit{ident} \texttt{ := } \textit{expr} \texttt{;} \\\\
\end{alignat*}
\\]

A variable is bringed into scope by defining it. The statement:

```zilly
Z x := 5;
```

Defines a variable `x` of type `Z` and assigns it the value `5`.

Statements evaluates the right hand side of the assignment, and store the result
inside the variable. This only matters when dealing with lazy expressions.

```zilly
Z x := 5;
lazy<Z> y := 'sub(1)(x)';
x := 6;
y
```

At the end of the previous example, `y` will be `5`, because the value of `x` was
changed to `6`. And thus, when we evaluate `y`, we evaluate `sub(1)(6)` which
reduces to `5`.

## Reassigning variables

\\[
\begin{alignat*}{1}
\textit{reassign}
    &&::= \textit{ident} \texttt{ := } \textit{expr} \texttt{;} \\\\
\end{alignat*}
\\]

Reassigning a variable is done by using the `:=` operator. The statement:

```zilly
x := 5;
```
Stores the value `5` inside the variable `x`.

Reassignments evaluate the right hand side first, and then store the result
inside the variable. This only matters when dealing with lazy expressions.

## Sys Actions

\\[
\begin{alignat*}{1}
\textit{sys-action}
    &&::= \texttt{sys.} \textit{sys-command} \\\\
\textit{sys-command}
    &&::= \texttt{reset} [\texttt{()}] \\\\
\end{alignat*}
\\]

| Sys action    | Description                                            |
|---------------|--------------------------------------------------------|
| `sys.reset()` | Resets the state of the environment to its initial one |

Sys actions do special side effects. Each action is detailed in the table above

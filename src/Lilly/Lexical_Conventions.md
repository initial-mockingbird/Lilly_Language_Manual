# Lexical Conventions

## Source File Encoding

Lilly source files are encoded in UTF-8. Having said so, there is very few places
that accept non-ASCII characters. The only current exception being lambda expressions,
which can be written using the Greek letter lambda \\( \lambda \\) instead of the
ASCII character `fn`.

## Blanks

The following characters are considered blanks: space, horizontal tab `\t`,
carrier return `\r`, line feed `\n`, form feed `\f`, and vertical tab `\v`.
Blanks are ignored and only used to separate tokens and instructions.

## Identifiers

\\[
\begin{alignat*}{2}
\textit{ident} &&::= &&\quad (\textit{letter} \mid \\_ ) \\{ \textit{identifier-tail} \\} \\\\
\textit{identifier-tail} &&::=
    &&\quad \textit{letter} \mid
    \textit{digit}  \mid
    \texttt{\_}    \\\\
\textit{letter} &&::=
    &&\quad (    \texttt{a..z} \\\\
    && &&\quad \mid \texttt{A..Z} \\\\
    && &&\quad \mid U+00DF .. U+00F6 \\\\
    && &&\quad \mid U+00F8 .. U+00FF \\\\
    && &&\quad \mid U+0153 \\\\
    && &&\quad \mid U+0161 \\\\
    && &&\quad \mid U+017E \\\\
    && &&\quad \mid U+00C0 ... U00D6 \\\\
    && &&\quad \mid U+00D8 ... U+00DE \\\\
    && &&\quad \mid U+0152 \\\\
    && &&\quad \mid U+0160 \\\\
    && &&\quad \mid U+017D \\\\
    && &&\quad \mid U+0178 \\\\
    && &&\quad \mid U+1E9E \\\\
    && &&\quad ) \\\\
\textit{digit}  &&::= && \quad \texttt{0..9} \\\\
\end{alignat*}
\\]

Identifiers are sequences of letters, digits, and underscores. They must start with
either a letter or an underscore. Identifiers are case-sensitive and the letters
it accepts is a combination of the ASCII set, the letters
ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ
from the Latin-1 Supplement block, the letters ŠšŽžŒœŸ
from the Latin Extended-A block and the upper case ẞ (U+189E).

Identifier length is unspecified and depends on the implementation.

## Number Literals

\\[
\begin{alignat*}{2}
\textit{number} &&::= &&\quad \textit{integer} \\\\
\textit{integer} &&::= &&\quad \textit{signed-digit} \\ \\{ \textit{digit} \\} \\\\
\textit{signed-digit} &&::= &&\quad (\texttt{- } \textit{digit} \mid \textit{digit}) \\\\
\textit{digit} &&::= &&\quad \texttt{0..9} \\\\
\end{alignat*}
\\]

Currently, Zilly only supports integer literals. They are sequences of digits which can
either be signed or not.

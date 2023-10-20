# C Escape Character Conversion

![Escape-f](https://img.shields.io/badge/escape--f-v0.1.202310-blueviolet)
![Language](https://img.shields.io/badge/-Fortran-734f96?logo=fortran&logoColor=white)
[![license](https://img.shields.io/badge/License-MIT-pink)](LICENSE)

`escape-f` converts the common C escape characters in a string to Fortran characters, so that we can write code like this:

```fortran
print *, escape("Hello,\n\tworld!\n&
                & I'm Fortran!")
```

Instead of, inconveniently:

```fortran
print *, "Hello,"//achar(10)//achar(9)//"world!"//new_line("a")//&
         " I'm Fortran!"
```

Thus, it is convenient for us to use the C escape character style to write the whole string in series in some scenarios, to achieve common functions such as line feed and carriage return, which are generally used to output strings to the screen or text files.
`escape-f` enables `OpenMP` parallelism and uses built-in functions, so in a large number of string conversions, you can also get high performance.

## Supported C escape characters

| Escape character | Meaning | Implementation |
| :--: | :--: | :--: |
| `\a` | Alarm or Beep | ✔️ |
| `\b` | Backspace	 | ✔️ |
| `\f` | Form Feed | ✔️ |
| `\n` | New Line | ✔️ |
| `\r` | Carriage Return | ✔️ |
| `\t` | Horizontal Tab | ✔️ |
| `\v` | Vertical Tab | ✔️ |
| `\0` | NULL | ✔️ |
| `\?` | Question Mark | ✔️ |
| `\'` | Single Quote | ✔️ |
| `\"` | Double Quote | ✔️ |
| `\\` | Backlash | ✔️ |
| `\ddd` | Octal Number | ❌ |
| `\xhh` | Hexadecimal Number | ❌ |

> **Warning**
>
> `\0` has no significant meaning in Fortran, and `escape-f` removes it from the string.

## Usage

Only support [fpm][1] build, other build tools please copy the source code, the code in `ifort/ifx/gfortran` test passed.

Using `escape-f` in the fpm project, add the following to `fpm.toml`:

```toml
[dependencies]
escape-f = { git = "https://github.com/zoziha/escape-f" }
```

Use in Fortran code:

```sh
fpm run --example --all
```

```fortran
program example_escape

    use escape_module, only: escape
    implicit none

    print *, escape("Hello, \n\v\tworld!\n\0")
    print *, escape("Hello,\n&
                &\tworld!\n&
                & I'm Fortran!")

end program example_escape
!> Hello, 
!>
!>       world!
!>
!> Hello,
!>        world!
!> I'm Fortran!
```

## Document

Generate and open the [FORD][2] document:

```sh
ford FORD-doc.md
start build/ford/index.html     # Windows Open the web page
```

## Related string libraries

- [Fortty](https://github.com/awvwgk/fortty): Create colorful terminal applications in Fortran.
- [Fortran-regex](https://github.com/perazz/fortran-regex): Fortran port of the tiny-regex-c library.
- [M_strings](https://github.com/urbanjost/M_strings): Fortran string manipulations.

[1]: https://github.com/fortran-lang/fpm
[2]: https://github.com/Fortran-FOSS-Programmers/ford

<div align='center'>

# C 转义字符转换

![Escape-f](https://img.shields.io/badge/escape--f-v0.1.202310-blueviolet)
![Language](https://img.shields.io/badge/-Fortran-734f96?logo=fortran&logoColor=white)
[![license](https://img.shields.io/badge/License-MIT-pink)](LICENSE)

</div>

`escape-f` 将字符串中常见的 C 转义字符转换为 Fortran 字符，从而我们可以书写如下代码：

```fortran
print *, escape("Hello,\n\tworld!\n&
                & I'm Fortran!")
```

而不是，不方便地：

```fortran
print *, "Hello,"//achar(10)//achar(9)//"world!"//new_line("a")//&
         " I'm Fortran!"
```

从而方便我们在某些场景下使用 C 转义字符风格串联地书写整个字符串，实现换行和回车等常用功能，一般用以向屏幕或文本文件输出字符串。
`escape-f` 使用了 `OpenMP` 并行和内置函数，因此在大量字符串转换时，也可以获得较高的性能，但我并没有测评过。

## 支持的C转义字符

| 转义字符 | 含义 | 实现情况 |
| :---: | :---: | :---: |
| `\a` | 响铃 | ✔️ |
| `\b` | 退格 | ✔️ |
| `\f` | 换页 | ✔️ |
| `\n` | 换行 | ✔️ |
| `\r` | 回车 | ✔️ |
| `\t` | 水平制表符 | ✔️ |
| `\v` | 垂直制表符 | ✔️ |
| `\0` | 空字符 | ✔️ |
| `\?` | 问号 | ✔️ |
| `\'` | 单引号 | ✔️ |
| `\"` | 双引号 | ✔️ |
| `\\` | 反斜杠 | ✔️ |
| `\ddd` | 以八进制数 ddd 表示的字符 | ❌ |
| `\xhh` | 以十六进制数 hh 表示的字符 | ❌ |

> **Warning**
>
> `\0` 在 Fortran 中无显著意义，`escape-f` 会将它从字符串中移除。

## 使用

仅支持 [Fpm][1] 构建，其他构建工具请自行复制源码，代码在 `ifort/ifx/gfortran` 下测试通过。

在 Fpm 项目中使用 `escape-f`，将以下内容添加到 `fpm.toml` 中：

```toml
[dependencies]
escape-f = { git = "https://gitee.com/zoziha/escape-f" }
```

在 Fortran 代码中使用：

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

## 文档

生成并打开 [FORD][2] 文档：

```sh
ford FORD-doc.md
start build/ford/index.html     # Windows 打开网页
```

## 相关字符串函数库

- [Fortty](https://github.com/awvwgk/fortty): 在Fortran中创建丰富多彩的终端应用程序。
- [Fortran-regex](https://github.com/perazz/fortran-regex): tiny-regex-c正则表达式库的Fortran端口。
- [M_strings](https://github.com/urbanjost/M_strings): Fortran字符串操作。

[1]: https://github.com/fortran-lang/fpm
[2]: https://github.com/Fortran-FOSS-Programmers/ford

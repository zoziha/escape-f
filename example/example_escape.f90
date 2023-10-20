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

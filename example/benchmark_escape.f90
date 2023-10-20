program example_escape

    use escape_module, only: escape
    implicit none
    character(:), allocatable :: string
    integer :: N = 1e8
    real :: t1, t2

    string = "Hello, world!\n "//repeat("1", N)

    call cpu_time(t1)
    string = escape(string)
    call cpu_time(t2)

    print *, "N chars: ", N, ", CPU time: ", t2 - t1
    print *, string(1:20)

end program example_escape
!> fpm run --example benchmark_escape --profile release
!>   N chars:    100000000 , CPU time:   0.656250000    
!>  Hello, world!
!>  111111

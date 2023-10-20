module test_escape

    use escape_module, only: escape
    use testdrive, only: new_unittest, unittest_type, error_type, check
    implicit none
    private

    public :: collect_escape

contains

    subroutine collect_escape(testsuite)
        type(unittest_type), allocatable, intent(out) :: testsuite(:)

        allocate (testsuite, source=[ &
                  new_unittest("escape example: none", test_escape_example_none), &
                  new_unittest("escape example: \n", test_escape_example_n) &
                  ])

    end subroutine collect_escape

    subroutine test_escape_example_none(error)
        type(error_type), allocatable, intent(out) :: error

        call check(error, escape("Hello, World!"), "Hello, World!")

    end subroutine test_escape_example_none

    subroutine test_escape_example_n(error)
        type(error_type), allocatable, intent(out) :: error

        call check(error, escape("Hello, \nWorld!"), "Hello, "//achar(10)//"World!")

    end subroutine test_escape_example_n

end module test_escape

program tester
    use, intrinsic :: iso_fortran_env, only: error_unit
    use testdrive, only: run_testsuite, new_testsuite, testsuite_type
    use test_escape, only: collect_escape
    implicit none
    integer :: stat, is
    type(testsuite_type), allocatable :: testsuites(:)
    character(len=*), parameter :: fmt = '("#", *(1x, a))'

    stat = 0

    allocate (testsuites, source=[ &
              new_testsuite("escape", collect_escape) &
              ])

    do is = 1, size(testsuites)
        write (error_unit, fmt) "Testing:", testsuites(is)%name
        call run_testsuite(testsuites(is)%collect, error_unit, stat)
    end do

    if (stat > 0) then
        write (error_unit, '(i0, 1x, a)') stat, "test(s) failed!"
        error stop
    end if

end program tester

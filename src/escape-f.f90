!> @note The escape character `\xhh` `\ddd` is not currently supported
module escape_module

    implicit none

    private
    public :: escape

    character(len=1), parameter :: backslash = '\'
    character(len=1), parameter :: null_char = achar(0)
    character(len=*), parameter :: c_escape_chars = 'abfnrtv\?''"0'
    integer, parameter :: c_escape_ascii(*) = [7, 8, 12, 10, 13, 9, 11, 92, 63, 39, 34, 0]
    character(len=1), parameter :: fortran_escape_chars(*) = achar(c_escape_ascii)

contains

    !> Converting C escape characters to Fortran equivalents
    !> @note C escape characters take up 2 bits, Fortran ASCII characters take up 1 bit.
    function escape(string) result(ans)
        character(len=*), intent(in) :: string  !! input string
        character(:), allocatable :: ans        !! output string
        character(len=1) :: tmp(len(string))
        integer :: i, j, length, count

        length = len(string)
        if (length < 2) then
            allocate(ans, source=string)
            return
        end if

        tmp = transfer(string, tmp)
        count = 0

        !$omp parallel do private(i, j) reduction(+:count)
        do i = 1, length - 1
            if (tmp(i) == backslash) then
                j = index(c_escape_chars, tmp(i + 1))
                if (j > 0) then
                    tmp(i) = null_char    ! mark the backslash by NULL character
                    tmp(i + 1) = fortran_escape_chars(j)
                    count = count + 1
                end if
            end if
        end do

        ans = transfer(pack(tmp, tmp /= null_char), string(:length - count))

    end function escape

end module escape_module

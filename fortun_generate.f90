!--------------------------------------------------------------------------------
!
!> Looks at the files to be compiled depending on the defined tests 
!
!--------------------------------------------------------------------------------
module fortun_generate

  implicit none 

  private

  public :: generate

contains

  !--------------------------------------------------------------------- generate
  subroutine generate()

    implicit none 
  
    call find_tests()

  end subroutine generate


  !------------------------------------------------------------------- find_tests
  !> find the files which have a name starting with 'test_'
  subroutine find_tests()

    implicit none 

    ! first and last columns of a 'ls -l' command
    integer, parameter :: io = 11

    character(1), dimension(:), allocatable :: first_column
    character(256), dimension(:), allocatable ::  last_column
    character(len=256), dimension(8) :: not_used
    integer :: i, line, lines

    call system("ls -l > list.txt")
    
    ! number of files, without the header "total <nb>"
    lines = number_of_lines("list.txt") - 1  
    allocate(first_column(lines), last_column(lines))    ! todo: handle alloc errors

    ! get first and last column
    open(io, file="list.txt", form='formatted')
    read(io,*)
    do line=1,lines
       read(io,*) first_column(line), (not_used(i), i=1,6), last_column(line)
    end do
    close(io)

    ! look in subdirectories, if any
    do line=1,size(first_column)
       if (first_column(line).eq."d") then
          !call update_test_files(last_column(line))
       end if
    end do

    call system("rm list.txt")

  end subroutine find_tests


  !-------------------------------------------------------------- number_of_lines
  !> counts the number of lines in a file
  !! inspired from FortranWiki
  integer function number_of_lines(input_file) result(lines)
    
    use iso_fortran_env, only : iostat_end

    implicit none 

    character(len=*), intent(IN) :: input_file

    integer, parameter :: io = 15
    integer :: stat
    character(len=100) :: buffer
        
    lines = 0
    open(io, file=trim(input_file), form="formatted")
    do  
       read(io, fmt=*, iostat=stat) buffer
       if (stat .eq. iostat_end) exit
       lines = lines + 1
    end do
    close(io)

  end function number_of_lines


end module fortun_generate

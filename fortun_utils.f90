module fortun_utils

  implicit none 

  private

  public :: extend
  public :: CHAR_LENGTH
  public :: number_of_lines

  integer, parameter :: CHAR_LENGTH = 256

  interface extend
     module procedure extend_char
  end interface extend

contains

  !------------------------------------------------------------------ extend_char
  !> extends a character array
  subroutine extend_char(array, extent)
    
    implicit none 
    
    character(len=*), dimension(:), allocatable, intent(IN OUT) :: array
    integer, intent(IN) :: extent

    character(len=CHAR_LENGTH), dimension(:), allocatable :: tmp
    integer :: length
    
    if (.not.allocated(array)) then
       allocate(array(extent))
       array = ""
    else
       length = size(array)

       allocate(tmp(length))
       tmp = array

       deallocate(array)
       allocate(array(length+extent))

       array(1:length) = tmp
       array(length+1:) = ""

       deallocate(tmp)
    end if

  end subroutine extend_char

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


end module fortun_utils

module fortun_utils

  implicit none 

  private

  public :: extend
  public :: CHAR_LENGTH
  public :: number_of_lines
  public :: check_allocation, check_deallocation

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

  !------------------------------------------------------------- check_allocation
  subroutine check_allocation(stat, array_name)

    implicit none 

    integer, intent(IN) :: stat
    character(len=*), intent(IN) :: array_name

    call stop_alloc(stat, array_name, "Allocation")

  end subroutine check_allocation

  !----------------------------------------------------------- check_deallocation
  subroutine check_deallocation(stat, array_name)

    implicit none 

    integer, intent(IN) :: stat
    character(len=*), intent(IN) :: array_name

    call stop_alloc(stat, array_name, "Deallocation")

  end subroutine check_deallocation

  !------------------------------------------------------------------- stop_alloc
  !> helper subroutine for check_[de]alloc
  subroutine stop_alloc(stat, array_name, sub)

    integer, intent(IN) :: stat
    character(len=*), intent(IN) :: array_name
    character(len=*), intent(IN) :: sub


    character(1024) :: error_msg 

    if (stat .ne. 0) then
       error_msg = "Error: "// trim(sub) //" of " // trim(array_name) // " failed."
       print *, trim(error_msg)
       stop
    end if

  end subroutine stop_alloc


end module fortun_utils

module fortun_utils

  implicit none 

  private

  public :: extend

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

    character(len=len(array)), dimension(:), allocatable :: tmp
    integer :: length
    
    length = size(array)
    
    allocate(tmp(length))
    tmp = array

    deallocate(array)
    allocate(array(length+extent))
    
    array(1:length) = tmp
    array(length+1:) = ""
     
    deallocate(tmp)

  end subroutine extend_char



end module fortun_utils

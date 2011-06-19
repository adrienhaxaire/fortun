module fortun_find_sources

  implicit none 

  private

  public :: find_sources

contains

  !-------------------------------------------------------------- find_procedures
  subroutine find_sources(directory, source_files)

    
    use fortun_utils, only : extend, CHAR_LENGTH, number_of_lines, check_allocation

    implicit none 

    integer, parameter :: io = 11
    character(5), parameter :: test_prefix="test_"
    integer, parameter :: LS_COLUMNS = 8, UNUSED_COLUMNS = 6
    
    character(len=*), intent(IN) :: directory
    character(len=*), dimension(:), allocatable, intent(INOUT) :: source_files



  end subroutine find_sources


  




end module fortun_find_sources

module fortun_find_sources

  implicit none 

  private

  public :: find_sources

contains

  !-------------------------------------------------------------- find_procedures
  !> supposing sources are in the default directory. 
  !! if not, must be specified via the option -s, or --source
  !!
  !! open the test find and find calls to source procedures
  !
  subroutine find_sources(directory, source_files)
    
    use fortun_utils, only : CHAR_LENGTH, check_allocation

    implicit none 

    integer, parameter :: io = 11
    character(5), parameter :: test_prefix="test_"
    integer, parameter :: LS_COLUMNS = 8, UNUSED_COLUMNS = 6
    
    character(len=*), intent(IN) :: directory
    character(len=*), dimension(:), allocatable, intent(INOUT) :: source_files
    
    integer :: error

    allocate(source_files(1), stat=error) 
    call check_allocation(error, "'source_files' in find_sources")

    source_files(1) = trim(directory) // "/example/myadd.f90"

  end subroutine find_sources

end module fortun_find_sources

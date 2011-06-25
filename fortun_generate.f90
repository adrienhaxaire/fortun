!--------------------------------------------------------------------------------
!
!> Generate the tests: lists and compiles them
!
!--------------------------------------------------------------------------------
module fortun_generate

  implicit none 

  private

  public :: generate

contains

  !--------------------------------------------------------------------- generate
  subroutine generate(test_dir, src_dir)

    use fortun_utils, only : CHAR_LENGTH
    use fortun_find, only : find_tests, find_sources
    use fortun_compile_tests, only : compile_tests
 
    implicit none 
  
    character(len=*), intent(IN) :: test_dir
    character(len=*), intent(IN) :: src_dir

    character(CHAR_LENGTH), dimension(:), allocatable :: test_files
    character(CHAR_LENGTH), dimension(:), allocatable :: source_files

    call find_tests(trim(test_dir), test_files)

    call find_sources(trim(src_dir), source_files)

    call compile_tests(test_files)

    
  end subroutine generate



end module fortun_generate

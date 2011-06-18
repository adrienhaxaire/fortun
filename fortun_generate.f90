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
  subroutine generate()

    use fortun_utils, only : CHAR_LENGTH
    use fortun_find_tests, only : find_tests

    implicit none 
  
    character(CHAR_LENGTH), dimension(:), allocatable :: test_files

    call find_tests(".",test_files)

    ! compile them

    ! link with the tested subroutines to have a sub-executable

    

  end subroutine generate



end module fortun_generate

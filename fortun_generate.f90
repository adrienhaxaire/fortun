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
    integer :: i

    call find_tests(".",test_files)

    ! compile them
    do i=1,size(test_files)
       call system("gfortran -c "//trim(test_files(i)))
    end do

    ! link with the tested subroutines to have a sub-executable
    ! -> find these subroutines 
    




  end subroutine generate



end module fortun_generate

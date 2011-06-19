!--------------------------------------------------------------------------------
!
!> Generate the tests: lists and compiles them
!
!--------------------------------------------------------------------------------
module fortun_input

  implicit none 

  private

  public :: check_arguments
!  public :: get_cwd

contains


  !----------------------------------------------------------- check_nb_arguments
  !> wrapper subroutine for all arguments handling
  logical function check_arguments() result(are_valid)
    
    implicit none 

    are_valid = .false.

    are_valid = check_nb_arguments()
     
  end function check_arguments

  !----------------------------------------------------------- check_nb_arguments
  !> number of arguments should be odd as "fortun" is counted too
  logical function check_nb_arguments() result(are_valid)
    
    implicit none 

    integer :: count

    count = command_argument_count()
    are_valid  = mod(count,2) .ne. 1
     
  end function check_nb_arguments






end module fortun_input

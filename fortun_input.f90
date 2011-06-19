!--------------------------------------------------------------------------------
!
!> Generate the tests: lists and compiles them
!
!--------------------------------------------------------------------------------
module fortun_input

  implicit none 

  private

  public :: check_arguments
  public :: get_cwd

contains


  !----------------------------------------------------------- check_nb_arguments
  !> wrapper subroutine for all arguments handling
  logical function check_arguments() result(are_valid)
    
    implicit none 

    logical, dimension(2) :: conditions
    integer :: cdt

    !> using temp array to ensure evaluation of checks
    conditions = .false.
    conditions(1) = check_nb_arguments()
    conditions(2) = check_association()

    are_valid = .true.
    do cdt=1,size(conditions)
       are_valid = are_valid .and. conditions(cdt)
    end do

  end function check_arguments


  !----------------------------------------------------------- check_nb_arguments
  !> number of arguments should be even as "fortun" is not counted
  logical function check_nb_arguments() result(are_valid)
    
    implicit none 

    integer :: count

    count = command_argument_count()
    are_valid  = mod(count,2) .eq. 0
     
  end function check_nb_arguments


  !------------------------------------------------------------ check_association
  !> checks the correspondance between option and values
  !! takes 2 arguments and checks if the first one a supported option
  logical function check_association() result(are_valid)

    implicit none 

    character(len=12) ::  arg
    integer :: count, i, pairs, pos

    are_valid = .true.

    count = command_argument_count()
    
    if (count.gt.1) then
       pairs = count / 2
       do i=1,pairs
          pos = 1 + 2 * (i - 1)
          call get_command_argument(pos, arg)
          are_valid = are_valid .and. is_valid_keyword(arg)
       end do
     
    end if

  end function check_association


  !------------------------------------------------------------- is_valid_keyword
  pure logical function is_valid_keyword(argument) result(is_valid)

    implicit none 

    integer, parameter :: nb_supported_keywords = 4

    character(len=*), intent(IN) :: argument

    character(len=12), dimension(nb_supported_keywords) :: supported_keywords
    character(len=len(argument)) :: arg  ! local copy to preserve purity
    integer :: kw

    is_valid = .false.

    supported_keywords = (/&
         & "-d          ", "--directory ", &
         & "-c          ", "--compiler  " /)

    arg = argument
    do kw=1,nb_supported_keywords
       if (trim(arg) .eq. supported_keywords(kw)) is_valid = .true.
    end do

  end function is_valid_keyword

  !-----------------------------------------------------------------------------
  !> wrapper to get the current working directory
  !! if no compiler defined, expects it with the -d option
  subroutine get_cwd(directory)

    implicit none 

    integer, parameter :: longest_compiler_name = 8  ! gfortran

    character(len=*), intent(INOUT) :: directory
    
    character(len=longest_compiler_name) :: compiler

    ! todo: read it from input
    compiler = "gfortran"

    select case (trim(compiler))
       case ("gfortran")
          call getcwd(directory)
       case("ifort")
          call getcwd(directory)
       case default
          if (is_argument_given("-d")) then
             call argument_value("-d", directory)
             else
                print *, "Working directory not found. Please enter it after the "//&
                     &" '-d' keyword, or specify a compiler name."
                stop
          end if
    end select

  end subroutine get_cwd


  !----------------------------------------------------------- get_argument_value
  subroutine argument_value(keyword, argument)

    implicit none

    character(len=*), intent(IN) :: keyword
    character(len=*), intent(INOUT) :: argument

    character(len=len(argument)) :: arg

    integer :: count, pairs, pos, i
    
    count = command_argument_count()

    pairs = count / 2
    do i=1,pairs
       pos = 1 + 2 * (i - 1)
       call get_command_argument(pos, arg)
       if (trim(arg) .eq. trim(keyword)) then
          call get_command_argument((pos + 1), arg)
       end if
    end do

  end subroutine argument_value


  !------------------------------------------------------------ is_argument_given
  logical function is_argument_given(keyword) result(given)

    implicit none 

    character(len=*), intent(IN) :: keyword

    character(len=len(keyword)) :: kw
    integer :: count, pairs, pos, i
    
    given = .false.

    count = command_argument_count()

    pairs = count / 2
    do i=1,pairs
       pos = 1 + 2 * (i - 1)
       call get_command_argument(pos, kw)
       if (trim(kw) .eq. trim(keyword)) then
          given = .true.
       end if
    end do
    
  end function is_argument_given





end module fortun_input

module fortun_compile_tests

  implicit none 

  private

  public :: compile_tests

contains

  !---------------------------------------------------------------- compile_tests
  !> tests should only contain logical functions
  subroutine compile_tests(test_files)

    use fortun_utils, only : CHAR_LENGTH

    implicit none 

    character(len=*), dimension(:), intent(IN) :: test_files

    character(CHAR_LENGTH) :: compile_cmd, cmd_prefix, test_file
    integer :: file, error
    
    cmd_prefix = 'gfortran -c -Wall -g -fbounds-check '
    do file=1,size(test_files)
       test_file = test_files(file)
       compile_cmd = trim(cmd_prefix) // " " // trim(test_file)
       print *, "Compiling " // trim(test_file)
       call system(trim(compile_cmd), status=error)
       if (error .ge. 1) then
          print *, "Error occured during compilation. See log above."
          print *, "The command was: " // trim(compile_cmd)
          print *, "[fortun] stop"
          stop
       end if
    end do

    print *, "Compilation of tests successful."

  end subroutine compile_tests


end module fortun_compile_tests

module fortun_compile

  implicit none 

  private

  public :: compile_tests, compile_sources

contains

  !-------------------------------------------------------------- compile_sources
  subroutine compile_tests(test_files)

    implicit none 

    character(len=*), dimension(:), intent(IN) :: test_files

    print *, "Compiling tests..."

    call compile(test_files)

    print *, "Compilation of tests successful."

  end subroutine compile_tests


  !-------------------------------------------------------------- compile_sources
  subroutine compile_sources(source_files)

    implicit none 

    character(len=*), dimension(:), intent(IN) :: source_files

    print *, "Compiling sources..."

    call compile(source_files)

    print *, "Compilation of source files successful."

  end subroutine compile_sources


  !---------------------------------------------------------------------- compile
  subroutine compile(files)

    use fortun_utils, only : CHAR_LENGTH

    implicit none 

    character(len=*), dimension(:), intent(IN) :: files

    character(CHAR_LENGTH) :: compile_cmd, cmd_prefix, file
    integer :: i, error
    
    cmd_prefix = 'gfortran -c -Wall -g -fbounds-check '
    do i=1,size(files)
       file = files(i)
       compile_cmd = trim(cmd_prefix) // " " // trim(file)
       print *, "Compiling " // trim(file)
       call system(trim(compile_cmd), status=error)
       if (error .ge. 1) then
          print *, "Error occured during compilation. See log above."
          print *, "The command was: " // trim(compile_cmd)
          print *, "[fortun] stop"
          stop
       end if
    end do

  end subroutine compile


end module fortun_compile

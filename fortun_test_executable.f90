module fortun_test_executable

  implicit none

  private

  public :: update_test_executable

contains

  !------------------------------------------------------------------------- link
  !> links the object files from the tests and the source to create an executable
  !! called by fortun. 
  !! todo: need to pass options too
  subroutine update_test_executable()

    implicit none 

    character(255) :: cmd

    call create_test_executable()

    cmd = "gfortran -Wall -g -fbounds-check fortun_test.f90 *.o -o fortun_test"
    call system(trim(cmd))
     
  end subroutine update_test_executable

  !------------------------------------------------------- create_test_executable
  subroutine create_test_executable
    
    implicit none 

    integer, parameter :: io = 12
    character(len=15) :: filename = "fortun_test.f90"

    open(unit=io, file=filename, status="unknown", form="formatted")

    write(io,*) "program fortun_test"

    ! write the test modules needed
    write(io,*) "  use test_myadd"

    write(io,*) "  implicit none"

    ! write the parameters needed to store the results
    ! array with size = nb tests

    ! write the function calls
    write(io,*) "print *, test_myadd_dummy()"

    ! write the log 
    

    write(io,*) "end program fortun_test"


  end subroutine create_test_executable


end module fortun_test_executable

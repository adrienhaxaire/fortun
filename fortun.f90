!------------------------------------------------------------------------
!
!> Main program fortun.
!
!> fortun looks for files starting with 'test_' and compiles them if 
!> needed, then it runs the test written in these files
!
!------------------------------------------------------------------------

program fortun

  use fortun_input, only : check_arguments, get_cwd
  use fortun_generate, only : generate

  implicit none 

  character(len=1024) :: cwd  !< current working directory

  !-- process input: command line arguments, etc
  if (.not.check_arguments()) then 
     ! todo: display help/usage 
     print *, "pb arguments"
     stop
  end if
  
  !-- generation of test executable
  call get_cwd(cwd)
  call generate(trim(cwd))


  !-- run all tests
  ! call system("./fortun_test", stat)    !< only for linux now, should provide a better way


  !-- display results

end program fortun

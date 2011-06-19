!------------------------------------------------------------------------
!
!> Main program fortun.
!
!> fortun looks for files starting with 'test_' and compiles them if 
!> needed, then it runs the test written in these files
!
!------------------------------------------------------------------------

program fortun

  use fortun_input, only : check_arguments
  use fortun_generate, only : generate

  implicit none 

  !-- process input: command line arguments, etc
  if (.not.check_arguments()) then 
     ! todo: display help/usage 
     print *, "wrong number of arguments"
     stop
  end if


  !-- generation of test executable
  call generate()


  !-- run all tests
  ! call system("./fortun_test", stat)    !< only for linux now, should provide a better way


  !-- display results

end program fortun

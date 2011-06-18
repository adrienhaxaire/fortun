!------------------------------------------------------------------------
!
!> Main program fortun.
!
!> fortun looks for files starting with 'test_' and compiles them if 
!> needed, then it runs the test written in these files
!
!------------------------------------------------------------------------

program fortun

  use fortun_generate, only : generate

  implicit none 

  !-- compilation of new tests
  ! check for added/modified tests with timestamp difference
  ! check dependencies
  ! compile them

  !-- generation of test executable
  call generate()


  !-- run all tests
  ! call system("./fortun_test", stat)    !< only for linux now, should provide a better way


  !-- display results

end program fortun

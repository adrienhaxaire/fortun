!--------------------------------------------------------------------------------
!
!> Looks at the files to be compiled depending on the defined tests 
!
!--------------------------------------------------------------------------------
module fortun_generate

  implicit none 

  private

  public :: generate

contains

  subroutine generate()

    character(len=1024) :: dir

    ! parse the directory to find files which have a name starting with 'test_'
    call getcwd(dir)
    call system("ls -l > list.txt")

  end subroutine generate

end module fortun_generate

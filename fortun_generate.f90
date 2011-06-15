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

  !--------------------------------------------------------------------- generate
  subroutine generate()

    use fortun_utils, only : CHAR_LENGTH

    implicit none 
  
    character(CHAR_LENGTH), dimension(:), allocatable :: test_files

    call find_tests(".",test_files)

  end subroutine generate


  !------------------------------------------------------------------- find_tests
  !> find the files which have a name starting with 'test_'
  recursive subroutine find_tests(directory, test_files)

    use fortun_utils, only : extend, CHAR_LENGTH, number_of_lines, check_allocation

    implicit none 

    integer, parameter :: io = 11
    character(5), parameter :: test_prefix="test_"
    integer, parameter :: LS_COLUMNS = 8, UNUSED_COLUMNS = 6
    
    character(len=*), intent(IN) :: directory
    character(len=*), dimension(:), allocatable, intent(INOUT) :: test_files

    character(CHAR_LENGTH) :: cmd
    character(1), dimension(:), allocatable :: first_column
    character(CHAR_LENGTH), dimension(:), allocatable ::  last_column
    character(CHAR_LENGTH), dimension(UNUSED_COLUMNS) :: not_used
    character(len(test_prefix)) :: file_prefix
    integer :: i, line, lines, error

    if (directory .eq. "") then
       return
    else 
       cmd = "ls -l "// trim(directory) //"> list.txt"
    end if

    call system(cmd)

    ! number of lines minus the header "total <nb>" = nb of files/directories
    lines = number_of_lines("list.txt") - 1  

    allocate(first_column(lines), stat=error) 
    call check_allocation(error, "first_column in find_tests")

    allocate(last_column(lines), stat=error) 
    call check_allocation(error, "last_column in find_tests")

    open(io, file="list.txt", form='formatted')
    read(io,*)  ! skip the header 
    do line=1,lines
       read(io,*) first_column(line), (not_used(i), i=1,UNUSED_COLUMNS), &
            last_column(line)
    end do
    close(io)

    call system("rm list.txt")

    do line=1,size(first_column)
       if (first_column(line).eq."d") then
          call find_tests(last_column(line), test_files)
       else 
          file_prefix = last_column(line)(1:len(test_prefix))
          if (file_prefix .eq. test_prefix) then
             call extend(test_files,1)
             test_files(size(test_files)) = trim(directory)// "/" // last_column(line)
          end if
       end if
    end do
    
  end subroutine find_tests

end module fortun_generate

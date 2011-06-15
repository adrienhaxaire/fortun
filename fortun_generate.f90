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

    print *, trim(test_files(1))

  end subroutine generate


  !------------------------------------------------------------------- find_tests
  !> find the files which have a name starting with 'test_'
  recursive subroutine find_tests(directory, test_files)

    use fortun_utils, only : extend, CHAR_LENGTH

    implicit none 

    integer, parameter :: io = 11
    character(5), parameter :: test_prefix="test_"
    integer, parameter :: NB_LS_COLUMNS = 8
  
    character(len=*), intent(IN) :: directory
    character(len=*), dimension(:), allocatable, intent(INOUT) :: test_files

    character(CHAR_LENGTH) :: cmd
    character(1), dimension(:), allocatable :: first_column
    character(CHAR_LENGTH), dimension(:), allocatable ::  last_column
    character(CHAR_LENGTH), dimension(NB_LS_COLUMNS) :: not_used
    character(len(test_prefix)) :: file_prefix
    integer :: i, line, lines

    if (directory .eq. "") then
       return
    else if (directory .eq. ".") then
       cmd = "ls -l > list.txt"
    else 
       cmd = "ls -l "// trim(directory) //"> list.txt"
    end if

    call system(cmd)

    ! number of lines minus the header "total <nb>" = nb of files/directories
    lines = number_of_lines("list.txt") - 1  
    allocate(first_column(lines), last_column(lines))    ! todo: handle alloc errors

    open(io, file="list.txt", form='formatted')
    read(io,*)  ! skip the header 
    do line=1,lines
       read(io,*) first_column(line), (not_used(i), i=1,6), last_column(line)
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



  !-------------------------------------------------------------- number_of_lines
  !> counts the number of lines in a file
  !! inspired from FortranWiki
  integer function number_of_lines(input_file) result(lines)
    
    use iso_fortran_env, only : iostat_end

    implicit none 

    character(len=*), intent(IN) :: input_file

    integer, parameter :: io = 15
    integer :: stat
    character(len=100) :: buffer
        
    lines = 0
    open(io, file=trim(input_file), form="formatted")
    do  
       read(io, fmt=*, iostat=stat) buffer
       if (stat .eq. iostat_end) exit
       lines = lines + 1
    end do
    close(io)

  end function number_of_lines

  



end module fortun_generate

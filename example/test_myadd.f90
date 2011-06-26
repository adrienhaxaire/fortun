module test_myadd

  use fortun_assertions, only : assert_eq

contains

  logical function test_myadd_dummy() result(res)
    implicit none 

    integer :: myadd
    logical :: plus, minus, zero

    plus = assert_eq(myadd(1,2),3)
    minus = assert_eq(myadd(1,-2),-1)
    zero = assert_eq(myadd(0,0),0)

    res = plus .and. minus .and. zero
    
  end function test_myadd_dummy


end module test_myadd

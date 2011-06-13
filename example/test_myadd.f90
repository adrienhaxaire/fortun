module test_myadd

  use fortun_assertions

contains

  logical function test_myadd_negative() result(res)

    res = assert_eq(myadd(1+2),3)

  end function test_myadd_negative


end module test_myadd

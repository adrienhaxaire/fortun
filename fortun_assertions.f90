module fortun_assertions

implicit none 

private

public :: assert_eq, assert_lt, assert_gt, assert_le, assert_ge

interface assert_eq
   module procedure assert_int_eq, assert_real_eq, assert_bool_eq
end interface assert_eq

interface assert_lt
   module procedure assert_int_lt, assert_real_lt
end interface assert_lt

interface assert_le
   module procedure assert_int_le, assert_real_le
end interface assert_le

interface assert_gt
   module procedure assert_int_gt, assert_real_gt
end interface assert_gt

interface assert_ge
   module procedure assert_int_ge, assert_real_ge
end interface assert_ge


contains


  !-- Assertions on equality
  !---------------------------------------------------------------- assert_int_eq
  pure logical function assert_int_eq(a,b) result(res)
    implicit none 
    integer, intent(IN) :: a, b
    res = a .eq. b
  end function assert_int_eq

  !--------------------------------------------------------------- assert_bool_eq
  pure logical function assert_bool_eq(a,b) result(res)
    implicit none 
    logical, intent(IN) :: a, b
    res = a .eqv. b
  end function assert_bool_eq

  !--------------------------------------------------------------- assert_real_eq
  !> default tolerance is 1.e-10 
  pure logical function assert_real_eq(a,b,tolerance) result(res)
    implicit none 
    real, intent(IN) :: a, b
    real, intent(IN), optional :: tolerance 

    real :: tol

    !> using local value tol for tolerance for purity 
    if (present(tolerance)) then
       tol = tolerance
    else
       tol = 1.e-10
    end if

    res = (abs(a)-abs(b)) .le. tol

  end function assert_real_eq


  !-- Assertions on less than
  !---------------------------------------------------------------- assert_int_lt
  pure logical function assert_int_lt(a,b) result(res)
    implicit none 
    integer, intent(IN) :: a, b
    res = a .lt. b
  end function assert_int_lt

  !--------------------------------------------------------------- assert_real_lt
  !> default tolerance is 1.e-10 
  pure logical function assert_real_lt(a,b,tolerance) result(res)
    implicit none 
    real, intent(IN) :: a, b
    real, intent(IN), optional :: tolerance 

    real :: tol

    !> using local value tol for tolerance for purity 
    if (present(tolerance)) then
       tol = tolerance
    else
       tol = 1.e-10
    end if

    res = (a-b) .lt. tol

  end function assert_real_lt


  !-- Assertions on less or equal
  !---------------------------------------------------------------- assert_int_le
  pure logical function assert_int_le(a,b) result(res)
    implicit none 
    integer, intent(IN) :: a, b
    res = a .le. b
  end function assert_int_le

  !--------------------------------------------------------------- assert_real_le
  !> default tolerance is 1.e-10 
  pure logical function assert_real_le(a,b,tolerance) result(res)
    implicit none 
    real, intent(IN) :: a, b
    real, intent(IN), optional :: tolerance 

    real :: tol

    !> using local value tol for tolerance for purity 
    if (present(tolerance)) then
       tol = tolerance
    else
       tol = 1.e-10
    end if

    res = (a-b) .le. tol

  end function assert_real_le


  !-- Assertions on greater than
  !---------------------------------------------------------------- assert_int_gt
  pure logical function assert_int_gt(a,b) result(res)
    implicit none 
    integer, intent(IN) :: a, b
    res = a .gt. b
  end function assert_int_gt

  !--------------------------------------------------------------- assert_real_gt
  !> default tolerance is 1.e-10 
  pure logical function assert_real_gt(a,b,tolerance) result(res)
    implicit none 
    real, intent(IN) :: a, b
    real, intent(IN), optional :: tolerance 

    real :: tol

    !> using local value tol for tolerance for purity 
    if (present(tolerance)) then
       tol = tolerance
    else
       tol = 1.e-10
    end if

    res = (a-b) .gt. tol

  end function assert_real_gt


  !-- Assertions on greater or equal
  !---------------------------------------------------------------- assert_int_ge
  pure logical function assert_int_ge(a,b) result(res)
    implicit none 
    integer, intent(IN) :: a, b
    res = a .ge. b
  end function assert_int_ge

  !--------------------------------------------------------------- assert_real_ge
  !> default tolerance is 1.e-10 
  pure logical function assert_real_ge(a,b,tolerance) result(res)
    implicit none 
    real, intent(IN) :: a, b
    real, intent(IN), optional :: tolerance 

    real :: tol

    !> using local value tol for tolerance for purity 
    if (present(tolerance)) then
       tol = tolerance
    else
       tol = 1.e-10
    end if

    res = (a-b) .ge. tol

  end function assert_real_ge

end module fortun_assertions

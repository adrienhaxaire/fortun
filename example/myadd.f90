! dummy example function
integer function myadd(a,b) result(sum)

  integer, intent(IN) :: a,b 

  sum = a +b

end function myadd


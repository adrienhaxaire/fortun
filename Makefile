
FC := gfortran

FF := -Wall -g -fbounds-check

OBJ := fortun_assertions.o fortun_utils.o fortun_find_tests.o fortun_generate.o


fortun: $(OBJ) fortun.f90
	$(FC) $(FF) $(OBJ) fortun.f90 -o fortun

fortun_utils.o: fortun_utils.f90 
	$(FC) $(FF) -c $< 

fortun_assertions.o: fortun_assertions.f90 
	$(FC) $(FF) -c $< 

fortun_find_tests.o: fortun_find_tests.f90 
	$(FC) $(FF) -c $< 

fortun_generate.o: fortun_generate.f90 
	$(FC) $(FF) -c $< 

clean:
	rm -rf *.o *.mod fortun


FC := gfortran

FF := -Wall -g -fbounds-check

OBJ := fortun_assertions.o fortun_utils.o fortun_find_tests.o\
	fortun_input.o fortun_find_sources.o fortun_find.o\
	fortun_generate.o

fortun: $(OBJ) fortun.f90
	$(FC) $(FF) $(OBJ) fortun.f90 -o fortun

%.o : %.f90
	$(FC) $(FF) -c $< 

clean:
	rm -rf *.o *.mod fortun

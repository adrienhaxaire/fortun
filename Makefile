
FC := gfortran

FF := -Wall -g 

OBJ := fortun_generate.o


fortun: $(OBJ) fortun.f90
	$(FC) $(FF) $(OBJ) fortun.f90 -o fortun

fortun_generate.o: fortun_generate.f90 
	$(FC) $(FF) -c $< 

clean:
	rm -rf *.o *.mod fortun

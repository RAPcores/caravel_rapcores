# RAPCore Caravel Flow

Notes on the Caravel flow:

prereqs (Ubuntu):

`sudo apt install tcl-dev tk-dev csh`

Install magic (this ends up global on the system):

```
git clone https://github.com/RTimothyEdwards/magic.git
cd magic
./configure [options]
make
make install
```

Install Docker:

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04



Run the openlane script:

```
./openlane.sh
```

This will pull openlane (which pulls skywater_pdk and open_pdks).

Run caravel:

```
./caravel.sh
```
```
./caravel.sh
```

Open .mag to see the design:

```
steve@sjkdsk1:~/Ultimachine/rapcore_caravel_flow/caravel/openlane/user_proj_example/runs/user_proj_example/results/magic (master=)$ magic -T sky130A user_proj_example.mag
```

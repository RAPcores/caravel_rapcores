# RAPcore Caravel Flow

https://rapcores.github.io/rapcores/

The Robotic Application Processing Core on the OpenMPW/Caravel Shuttle run sponsored by Google .

RAPcore is a project targeting FPGAs and ASIC devices for the next generation of motor and motion
control applications. It is a peripheral that sits between firmwares and motors to free up
processing on the microcontroller and greatly simplify the motor driver.

## Gate Level Testing

Instructions for running gate-level validation:

Make sure submodules are correct:
```
git submodule init
git submodule update
```

Gate-level testing directory:

```
cd verilog/dv/caravel/rapcore/io_ports
```

```
make clean
make
```

## Features

- Onboard stepper motor commutator with microstepping
- Fixed Point Step-Timing Algorithm
- High-speed Quadrature Encoder Accumulator
- High-Speed SPI Bus

## Build Requirements

See INSTALL.md for local development instructions.

## Documentation

https://rapcores.github.io/rapcores/

## License

[ISC License](https://en.wikipedia.org/wiki/ISC_license).

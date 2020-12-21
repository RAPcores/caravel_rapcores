#include "../../defs.h"

/*
	IO Test:
		- Configures MPRJ lower 8-IO pins as outputs
		- Observes counter value through the MPRJ lower 8 IO pins (in the testbench)
*/

void main()
{
	/*
	IO Control Registers
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 3-bits | 1-bit | 1-bit | 1-bit  | 1-bit  | 1-bit | 1-bit   | 1-bit   | 1-bit | 1-bit | 1-bit   |

	Output: 0000_0110_0000_1110  (0x1808) = GPIO_MODE_USER_STD_OUTPUT
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 110    | 0     | 0     | 0      | 0      | 0     | 0       | 1       | 0     | 0     | 0       |


	Input: 0000_0001_0000_1111 (0x0402) = GPIO_MODE_USER_STD_INPUT_NOPULL
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 001    | 0     | 0     | 0      | 0      | 0     | 0       | 0       | 0     | 1     | 0       |

	*/

	// Configure lower 8-IOs as user output
	// Observe counter value in the testbench
	reg_mprj_io_0  =	GPIO_MODE_USER_STD_OUTPUT;	//	_0_JTAG_IO,
	reg_mprj_io_1  =	GPIO_MODE_USER_STD_OUTPUT;	//	_1_HK_SDO,
	reg_mprj_io_2  =	GPIO_MODE_USER_STD_OUTPUT;	//	_2_HK_SDI,
	reg_mprj_io_3  =	GPIO_MODE_USER_STD_OUTPUT;	//	_3_HK_CSB,
	reg_mprj_io_4  =	GPIO_MODE_USER_STD_OUTPUT;	//	_4_HK_SCK,
	reg_mprj_io_5  =	GPIO_MODE_USER_STD_OUTPUT;	//	_5_RX, RESET_COUNTER_0
	reg_mprj_io_6  =	GPIO_MODE_USER_STD_OUTPUT;	//	_6_TX, RESET_COUNTER_1
	reg_mprj_io_7  =	GPIO_MODE_USER_STD_OUTPUT;	//	_7_IRQ, RESET_COUNTER_2
	reg_mprj_io_8  =	GPIO_MODE_USER_STD_OUTPUT;	//	_8_UNUSED1, RESET_COUNTER_3
	reg_mprj_io_9  =	GPIO_MODE_USER_STD_OUTPUT;	//	_9_UNUSED2, RESET_COUNTER_4
	reg_mprj_io_10 =	GPIO_MODE_USER_STD_OUTPUT;	//	_10_ENOUTPUT,
	reg_mprj_io_11 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_11_ENINPUT,
	reg_mprj_io_12 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_12_ENC_B,
	reg_mprj_io_13 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_13_ENC_A,
	reg_mprj_io_14 =	GPIO_MODE_USER_STD_OUTPUT;	//	_14_PHASE_B1_H,
	reg_mprj_io_15 =	GPIO_MODE_USER_STD_OUTPUT;	//	_15_CHARGEPUMP,
	reg_mprj_io_16 =	GPIO_MODE_USER_STD_OUTPUT;	//	_16_PHASE_B1,
	reg_mprj_io_17 =	GPIO_MODE_USER_STD_OUTPUT;	//	_17_PHASE_B2_H,
	reg_mprj_io_18 =	GPIO_MODE_USER_STD_OUTPUT;	//	_18_PHASE_A2_H,
	reg_mprj_io_19 =	GPIO_MODE_USER_STD_OUTPUT;	//	_19_PHASE_A2,
	reg_mprj_io_20 =	GPIO_MODE_USER_STD_OUTPUT;	//	_20_PHASE_B2,
	reg_mprj_io_21 =	GPIO_MODE_USER_STD_OUTPUT;	//	_21_PHASE_A1_H,
	reg_mprj_io_22 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_22_COPI,
	reg_mprj_io_23 =	GPIO_MODE_USER_STD_OUTPUT;	//	_23_PHASE_A1,
	reg_mprj_io_24 =	GPIO_MODE_USER_STD_OUTPUT;	//	_24_MOVE_DONE,
	reg_mprj_io_25 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_25_analog_cmp1,
	reg_mprj_io_26 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_26_analog_cmp2,
	reg_mprj_io_27 =	GPIO_MODE_USER_STD_OUTPUT;	//	_27_analog_out1,
	reg_mprj_io_28 =	GPIO_MODE_USER_STD_OUTPUT;	//	_28_analog_out2,
	reg_mprj_io_29 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_29_HALT,
	reg_mprj_io_30 =	GPIO_MODE_USER_STD_OUTPUT;	//	_30_STEPOUTPUT,
	reg_mprj_io_31 =	GPIO_MODE_USER_STD_OUTPUT;	//	_31_DIROUTPUT,
	reg_mprj_io_32 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_32_STEPINPUT,
	reg_mprj_io_33 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_33_DIRINPUT,
	reg_mprj_io_34 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_34_CS,
	reg_mprj_io_35 =	GPIO_MODE_USER_STD_INPUT_NOPULL;	//	_35_SCK,
	reg_mprj_io_36 =	GPIO_MODE_USER_STD_BIDIRECTIONAL;	//	_36_CIPO,
	reg_mprj_io_37 =	GPIO_MODE_USER_STD_OUTPUT;	//	_37_BUFFER_DTR

        /* Apply configuration */
        reg_mprj_xfer = 1;
        while (reg_mprj_xfer == 1);

	// Configure LA probes [31:0], [127:64] as inputs to the cpu
	// Configure LA probes [63:32] as outputs from the cpu
	reg_la0_ena = 0xFFFFFFFF;    // [31:0]
	reg_la1_ena = 0x00000000;    // [95:64]
	reg_la2_ena = 0x00000000;    // [63:32]
	reg_la3_ena = 0xFFFFFFFF;    // [127:96]

       //release nReset on 65. Set pin 64 (Enable) as output but stay disabled;
        reg_la2_ena = ~0x3;    // [95:64]
        reg_la2_data = 0x2;    // [95:64]

				//Small delay
				for(int i = 0; i< 2; i++);

	// Set Counter value to zero through LA probes [63:32]
	reg_la2_data = 0x00000003;

}

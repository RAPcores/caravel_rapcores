#!/bin/bash
echo "" > report_drc.txt
for proj in user_project_wrapper rapcore microstepper spi_state_machine quad_enc analog_out chargepump cosine microstep_counter microstepper_control mytimer_10 mytimer_8
do
	echo $proj `grep COUNT $proj/runs/$proj/logs/magic/magic.drc.log` | tee -a report_lvs.txt
done
#cat report_lvs.txt

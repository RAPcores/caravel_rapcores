package require openlane
set script_dir [file dirname [file normalize [info script]]]

prep -design $script_dir -tag user_project_wrapper -overwrite
set save_path $script_dir/../..


run_synthesis
run_floorplan
run_placement
run_cts

set ::env(CURRENT_STAGE) routing
if { $::env(DIODE_INSERTION_STRATEGY) != 0 &&  $::env(DIODE_INSERTION_STRATEGY) != 3  && [info exists ::env(DIODE_CELL)] } {
    if { $::env(DIODE_CELL) ne "" } {
        ins_diode_cells
    }
}
use_original_lefs

global_routing

# insert fill_cells
ins_fill_cells

# for LVS
write_verilog $::env(yosys_result_file_tag)_preroute.v
set_netlist $::env(yosys_result_file_tag)_preroute.v
if { $::env(LEC_ENABLE) } {
    logic_equiv_check -rhs $::env(PREV_NETLIST) -lhs $::env(CURRENT_NETLIST)
}


# detailed routing
add_route_obs
detailed_routing

if { $::env(DIODE_INSERTION_STRATEGY) == 2 } {
    run_antenna_check
    heal_antenna_violators; # modifies the routed DEF
}

if { $::env(LVS_INSERT_POWER_PINS) } {
    write_powered_verilog
    set_netlist $::env(lvs_result_file_tag).powered.v
}


run_magic
run_magic_spice_export

save_views       -lef_path $::env(magic_result_file_tag).lef \
                 -def_path $::env(tritonRoute_result_file_tag).def \
                 -gds_path $::env(magic_result_file_tag).gds \
                 -mag_path $::env(magic_result_file_tag).mag \
                 -save_path $save_path \
                 -tag $::env(RUN_TAG)

run_magic_drc

run_lvs; # requires run_magic_spice_export

run_antenna_check

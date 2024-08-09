.data
prompt_start:   .asciiz "----------------------------------------------------\n"
                .asciiz "     MIPS Car Sensor System Simulation\n"
                .asciiz "----------------------------------------------------\n\n"
prompt_enter:   .asciiz "Press Enter to Start the Simulation...\n\n"
prompt_simstart:.asciiz "[Simulation Started]\n\n"
prompt_input:   .asciiz "Please enter the initial sensor readings:\n\n"
prompt_temp:    .asciiz "Enter Temperature (in °F): "
prompt_speed:   .asciiz "Enter Speed (in mph): "
prompt_fuel:    .asciiz "Enter Fuel Level (%): "
prompt_fuel_percentage:    .asciiz "Enter Fuel Level: "
prompt_reading: .asciiz "\n\nSensor Readings:\n"
warning_fuel:   .asciiz "\n\n[WARNING] Fuel Level below expected level\n\n"
prompt_continue:.asciiz "More sensors reading? enter 1 for yes and 0 for no: "
prompt_updated: .asciiz "\n\nPlease enter updated sensor readings:\n\n"
space: .asciiz "\n"
Fahrenheit: .asciiz "°F"
mph: .asciiz "mph"


.text
.globl main

main:
    # Print start prompt
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_start
    syscall

    # Print enter prompt
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_enter
    syscall

    # Wait for user input (simulate "press Enter")
    li $v0, 12              # syscall code for read_char
    syscall

    # Print simulation started prompt
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_simstart
    syscall

    # Print input prompt
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_input
    syscall

    # Read initial sensor readings
    # Temperature
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_temp
    syscall
    li $v0, 5               # syscall code for read_int
    syscall
    move $t0, $v0           # store temperature in $t0
   
    # Speed
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_speed
    syscall
    li $v0, 5               # syscall code for read_int
    syscall
    move $t1, $v0           # store speed in $t1

    # Fuel Level
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_fuel
    syscall
    li $v0, 5               # syscall code for read_int
    syscall
    move $t2, $v0           # store fuel level in $t2
   
    # Display sensor readings
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_reading
    syscall
    
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_temp
    syscall
    move $a0, $t0           # load temperature to print
    li $v0, 1               # syscall code for print_int
    syscall
    li $v0, 4               # syscall code for print_str
    la $a0, Fahrenheit
    syscall
    li $v0, 4               # syscall code for print_str
    la $a0, space           # newline character
    syscall
    
    
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_speed
    syscall
    move $a0, $t1           # load speed to print
    li $v0, 1               # syscall code for print_int
    syscall
    li $v0, 4               # syscall code for print_str
    la $a0, mph
    syscall
    li $v0, 4               # syscall code for print_str
    la $a0, space            # newline character
    syscall

    li $v0, 4               # syscall code for print_str
    la $a0, prompt_fuel_percentage
    syscall
    move $a0, $t2           # load adjusted fuel level to print
    li $v0, 1               # syscall code for print_int
    syscall
    li $v0, 4               # syscall code for print_str
    la $a0, space            # newline character
    syscall
# Check fuel level and display warning if below expected level
    li $t5, 10              # expected minimum fuel level (%)
    blt $t3, $t5, display_warning
    j more_reading
    
#warning 
display_warning:
    li $v0, 4               # syscall code for print_str
    la $a0, warning_fuel
    syscall
    j more_reading
    
 # Prompt for more readings
more_reading:
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_continue
    syscall
    li $v0, 5               # syscall code for read_int
    syscall
    move $t4, $v0           # store user's choice

    # Handle user's choice
    beq $t4, $zero, exit     # If user enters 0, exit the program
    j update_readings        # Otherwise, jump to update_readings

exit:
    li $v0, 10              # syscall code for exit
    syscall


update_readings:
    # Print updated readings prompt
    li $v0, 4               # syscall code for print_str
    la $a0, prompt_updated
    syscall
    j main                  # return to main to read updated sensor readings

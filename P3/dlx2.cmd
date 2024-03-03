universe = vanilla
executable = dlx
log = dhry.log
should_transfer_files = Yes
when_to_transfer_output = ON_EXIT_OR_EVICT

# Primera configuración
input = input0.s
arguments = "-s final1 -d c -c t -f input0.s"
output = final1
error = final1.err
queue

# Segunda configuración
input = input1.s
arguments = "-s final2 -d c -c t -f input1.s"
output = final2
error = final2.err
queue

# Tercera configuración
input = input2.s
arguments = "-s final3 -d c -c t -f input2.s"
output = final3
error = final3.err
queue

# Cuarta configuración
input = input3.s
arguments = "-s final4 -d c -c t -f input3.s"
output = final4
error = final4.err
queue

# Quinta configuración
input = input4.s
arguments = "-s final5 -d c -c t -f input4.s"
output = final5
error = final5.err
queue

# Sexta configuración
input = input5.s
arguments = "-s final6 -d c -c t -f input5.s"
output = final6
error = final6.err
queue


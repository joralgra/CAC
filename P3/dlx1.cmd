universe = vanilla
executable = dlx
log = dhry.log
input = ordena.s
should_transfer_files = Yes
when_to_transfer_output = ON_EXIT_OR_EVICT

# Primera configuración
arguments = "-s final1 -d p -c p -f ordena.s"
output = final1
error = final1.err
queue

# Segunda configuración
arguments = "-s final2 -d c -c p -f ordena.s"
output = final2
error = final2.err
queue

# Tercera configuración
arguments = "-s final3 -d p -c t -f ordena.s"
output = final3
error = final3.err
queue

# Cuarta configuración
arguments = "-s final4 -d c -c t -f ordena.s"
output = final4
error = final4.err
queue

# Quinta configuración
input = ordena3.s
arguments = "-s final5 -d p -c 3 -f ordena3.s"
output = final5
error = final5.err
queue

# Sexta configuración
arguments = "-s final6 -d c -c 3 -f ordena3.s"
output = final6
error = final6.err
queue

# Séptima configuración
arguments = "-s final7 -d c -c 2 -f ordena3.s"
output = final7
error = final7.err
queue

# Octava configuración
arguments = "-s final8 -d c -c 1 -f ordena3.s"
output = final8
error = final8.err
queue

universe = vanilla
executable = intsin
log = intsin.log

input = in.$(Process)
output = out.$(Process)
error = err.$(Process)

should_transfer_files = Yes
when_to_transfer_output = ON_EXIT_OR_EVICT
queue 50
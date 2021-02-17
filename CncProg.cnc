
%001 (CncProgram)

( TODO: Add code here )

N999 M30

N10 G90     (absolute coordinates)
N20 F300    (Feed rate in measurements units/min)

N30 G04 2   (dwell time 2s)

N50 G01 X80 Y100  (linear move)

N60 G04 2         (dwell time 2s)

N100 G00 X0 Y0    (rapid move to zero)
N999 M30
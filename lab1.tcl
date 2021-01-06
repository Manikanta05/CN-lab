
1. Implement three nodes point – to – point network with duplex links between them. Set the
queue size, vary the bandwidth and find the number of packets dropped.


set ns [new Simulator]

set tf [open lab1.tr w]
$ns trace-all $tf

set nf [open lab1.nam w]
$ns namtrace-all $nf

proc finish { } {
global ns tf nf
ns flush-trace
exec nam lab1.nam &
close $tf
close $nf
exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$n0 label "src/udp0"
$n0 color "red"

$n1 label "src/udp1"
$n1 color "blue"

$n2 label "router"

$n3 label "destination/Null"

$ns duplex-link $n0 $n2 500Mb 200ms DropTail
$ns duplex-link $n1 $n2 500Mb 200ms DropTail
$ns duplex-link $n2 $n3 1Mb 100ms DropTail

$ns queue-limit $n0 $n2 10
$ns queue-limit $n1 $n2 10
$ns queue-limit $n2 $n3 3

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

set null3 [new Agent/Null]
$ns attach-agent $n3 $null3
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

$udp0 set class_ 1
$udp1 set class_ 2

$ns connect $udp0 $null3
$ns connect $udp1 $null3

$cbr1 set packetSize_ 900Mb
$cbr1 set interval_ 0.005

$ns at 0.1 "$cbr0 start"
$ns at 0.1 "$cbr1 start"

$ns at 10.0 "finish"

$ns run




AWK Script

BEGIN{
}
{ 
if ($1=="d")
drop++
}
END{
printf("the total number of %s packets dropped due to congestion is= %d\n",$5,drop);
}

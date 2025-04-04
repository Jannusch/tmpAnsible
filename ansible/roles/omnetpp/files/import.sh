#!/usr/bin/env bash

echo "Setting working dir"
sed -i 's/DEFAULT_WORKSPACE_ARGS="-vmargs -Dosgi\.instance\.area\.default=\$IDEDIR\/\.\.\/samples"/DEFAULT_WORKSPACE_ARGS="-vmargs -Dosgi\.instance\.area\.default=\/workspaces\/omnetpp\.workspace"/g' /opt/omnetpp/bin/opp_ide

echo "Importing Software to OMNeT++"
for i in 'inet' 'veins'; do 
    xvfb-run /opt/omnetpp/bin/omnetpp -data /workspaces/omnetpp.workspace -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -import $i &> import.log

    job=$(pgrep opp)
    speed=0.1
    text=$i
    spin="⢎⡰⢎⡡⢎⡑⢎⠱⠎⡱⢊⡱⢌⡱⢆⡱"

    j=0

    while (test -d /proc/$job)
    do 
        sleep "$speed"
        j=$(( ($j+1) % 8))
        c1=$(echo $spin | cut -c$(( $j*6+1 ))-$(( $j*6+3 )))
        c2=$(echo $spin | cut -c$(( $j*6+4 ))-$(( $j*6+6 )))
        printf "\r\t$text $c1$c2"
    done
    if (ack "JVM terminated. Exit code=1" import.log &> /dev/null) then
        echo -e  "\n\033[31mError while importing\nFor a re-run first delete the folder veins and inet\033[0m"
        echo "Printing log:"
        cat import.log
        exit 1
    fi
    printf "\r\t$text ✔\n"
done 

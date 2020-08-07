#!/bin/sh

#launching the neobot in world and rviz
xterm -e "cd $(pwd)/..;
source devel/setup.bash;
roslaunch neo_simulation simulation.launch" &




sleep 5

# launching amcl
xterm -e "cd $(pwd)/..;
source devel setup.bash;
roslaunch neo_simulation mmo_700_amcl.launch" &

sleep 5

# launching gmapping
xterm -e "cd $(pwd)/..;
source devel/setup.bash;
roslaunch neo_simulation mmo_700_gmapping.launch" &

sleep 5

#launching move base
xterm -e "cd $(pwd)/..;
source devel/setup.bash;
roslaunch neo_simulation mmo_700_move_base.launch" &

sleep 10

#launching goal_Sequence
xterm -e "cd $(pwd)/..;
source devel/setup.bash
roslaunch neo_goal_sequence_driver neo_goal_sequence_driver_visualized.launch" &


sleep 5

#Start the driver by calling:
xterm -e "cd $(pwd)/..;
source devel/setup.bash
rosservice call /goal_sequence_driver/run" &

sleep 20 

#Stop by calling:
xterm -e "cd $(pwd)/..;
source devel/setup.bash
rosservice call /goal_sequence_driver/stop" &


sleep 5 

#launching the neobot move_it
xterm -e "cd $(pwd)/..;
source devel/setup.bash;
roslaunch neo_mmo_700 move_group.launch" &


#!/bin/bash
# written by MiSeon (github.com/MiSeon23)

echo ""
echo "[Note] Target OS version  >>> Ubuntu 18.04.x (Bionic)"
echo "[Note] Target ROS version >>> ROS Melodic"
echo "[Note] Catkin workspace   >>> $HOME/catkin_ws"
echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read

echo "[Set the target OS, ROS version and name of catkin workspace]"
ros_version=${ros_version:="melodic"}
name_catkin_workspace=${name_catkin_workspace:="catkin_ws"}

echo ""
echo "[Add the ROS repository]"
if [ ! -e /etc/apt/sources.list.d/ros-latest.list ]; then
    sudo sh -c 'echo \"deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main\" > /etc/apt/sources.list.d/ros-latest.list'
fi

echo ""
echo "[Download the ROS keys]"
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

echo ""
echo "[Update the package lists]"
sudo apt update -y

echo ""
echo "[Install the ros-desktop]"
sudo apt install ros-melodic-desktop

echo ""
echo "[Initialize rosdep]"
sudo sh -c "rosdep init"
rosdep update

echo ""
echo "[Environment setup and getting rosinstall]"
source /opt/ros/$ros_version/setup.sh
sh -c "echo \"source /opt/ros/$ros_version/setup.bash\" >> ~/.bashrc"
sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential

echo ""
echo "[Make the catkin workspace]"
mkdir -p $HOME/$name_catkin_workspace/src
cd $HOME/$name_catkin_workspace/src
catkin_init_workspace

echo ""
echo "[Set the ROS environment]"
sh -c "echo \"export ROS_MASTER_URI=http://localhost:11311\" >> ~/.bashrc"
sh -c "echo \"export ROS_HOSTNAME=localhost\" >> ~/.bashrc"

source $HOME/.bashrc

echo ""
echo "[!! ROS melodic installation is complete !!]"

exit 0
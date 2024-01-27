#!/bin/bash

echo "Select an option:"
echo "1. Create Container (make.sh)"
echo "2. Create File Index (dir.sh)"
echo "3. Configure Load Balance (loadbalance.sh)"
echo "4. Other Options (all.sh)"

read option

case $option in
    1)
        echo "Executing make.sh..."
        ./make.sh
        ;;
    2)
        echo "Executing dir.sh..."
        ./dir.sh
        ;;
    3)
        echo "Executing loadbalance.sh..."
        ./loadbalance.sh
        ;;
    4)
        echo "Executing all.sh..."
        ./all.sh
        ;;
    *)
        echo "Invalid option"
        ;;
esac

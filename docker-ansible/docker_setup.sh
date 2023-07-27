#!/bin/bash

# Limit the number of containers
limit=30
# Amount of containers to create
amount=0
# Port Base Range
portRange=-1
# Docker image
dockerImage=""
# Check if -n is used
nFlag=false
# Check if -p is used
pFlag=false
# Check if -i is used
iFlag=false

# Check if value is numeric
function isNumeric(){
# Regex of 0-10
re='^[0-9]+$'
# if first parameter is NOT between the regex
if ! [[ $1 =~ $re ]] ; then
        echo "You must pass a numerical value"
        exit 1
fi
}

function errorMsg(){
#echo Script usage: $0 -n <number <= $limit> -p <Port Base Range> -i <Docker Image Name>" >&2
printf "This script will run docker containers by the following command flags:\n  -n    Number of containers to run\n  -p    Port range increases by 1 for each container (Example: 3001, 3002, 3003)\n  -i    container Image\nCommand example: docker_setup -n 3 -p 3000 -i ubuntu\n" 
exit 1
}


# Gets n and p flags
while getopts 'n:p:i:' OPTION; do
  case "$OPTION" in
    n)
	# Check if passed parameter is numeric
	isNumeric $OPTARG

        num="$OPTARG"
        if [[ $num -gt $limit ]] ;
        then
           echo "Please enter less then $limit numbers of containers"
	   exit 1
        else
           amount=$num
        fi
      nFlag=true
      ;;
   p)
	isNumeric $OPTARG

        portRange=$OPTARG
	pFlag=true
      ;;
   i)
      dockerImage=$OPTARG
      iFlag=true
      ;;


    ?)
      errorMsg
      ;;
  esac
done
# Removes all the options that have been parsed by getopts
shift "$(($OPTIND -1))"

if [ "$nFlag" = false ]; then
   errorMsg
fi
if [ "$pFlag" = false ]; then
   errorMsg
fi
if [ "$iFlag" = false ]; then
   errorMsg
fi

echo > contport > conthash

# Create containers
for ((i=1; i<=amount; i++))
do
  # Format ports to base+1 (example: 2001, 2002...)
  port=$((portRange+i))
  #echo "$port:22 $dockerImage"
  docker run -d -p $port:22 $dockerImage 2>&1 | tee -a ./conthash
  echo "$port" >> contport
  sleep 0.2
done


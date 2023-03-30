#!/bin/bash

file=""

echo "Enter path of the .jar file or type skip for default settings"

read path


if [ $path == "skip" ]	
then 

	if [ ! -d "target" ]; then 
		mvn clean install
	fi
	
	for m_file in target/gcviewer*.jar
	do 
		file="$m_file"
	done 	
else 
	file=$path
fi 
 
 echo "$file"

jpackage --name GCViewer --input . --main-jar $file  --type pkg

echo "Installer is generated"
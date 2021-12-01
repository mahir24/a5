#!/bin/bash

#Mahir Rahman, 11/30/21

wekaPath=$1 #use abs path to weka
dirPath=$2 # use abs path to dir

#change CLASSPATH
export CLASSPATH=$CLASSPATH:$wekaPath/weka.jar:$wekaPath/libsvm.jar

#Choose what dirctory you want to be representede as an .arff file
 java weka.core.converters.TextDirectoryLoader -dir $dirPath > $dirPath.arff 


#Convert .arff file into a word vector
 java -Xmx1024m weka.filters.unsupervised.attribute.StringToWordVector  -i $dirPath.arff -o ""$dirPath"_vector".arff -M 2

#Weka Gui does a 10 fold vross validation on the dataset
java -Xmx1024m  weka.classifiers.meta.ClassificationViaRegression -W weka.classifiers.trees.M5P -num-decimal-places 4  -t  ""$dirPath"_vector".arff -d ""$dirPath"_vector".model -c 1





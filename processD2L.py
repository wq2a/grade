#import numpy as np  
import os
import re
import sys

def Process(currDir):

    dir = os.listdir(currDir)   # find the file names

    newDir=currDir + "Grade"
    os.mkdir(newDir)

    for file in dir:
        if ((file != ".DS_Store") and (file != "index.html")):
            orig = file
            arr = re.split("- ", file)

            dirname=arr[1].replace(' ','')
            print dirname
            filename=arr[3]

            dirname = newDir + "/" + dirname
            newfilename = dirname + "/" + filename
            oldfilename = currDir + "/" + orig 

            if (os.path.exists(dirname)):
                os.rename(oldfilename, newfilename)
            else:
                os.mkdir(dirname)
                os.rename(oldfilename, newfilename)

if (__name__ == '__main__'):   

    currDir=sys.argv[1]
    Process(currDir)

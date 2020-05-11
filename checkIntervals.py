import os, re

def checkIntervals(input_dir):
    '''
    check the no. of intervals in all the TextGrid files in a given directory
    Default no. of intervals = 12
    
    Args: input_dir (str) #path
    Output: checkIntervals.txt
    '''
    n = 12
    with open ("checkIntervals.txt", "w") as w:
        for filename in os.listdir(input_dir):          
            if filename.endswith(".TextGrid"):
                with open (filename, "r") as f:
                    found = False
                    for line in f:
                        regex = "\s+intervals:\ssize\s\=\s" + str(n)
                        match = re.search(regex, line)
                        if re.search(regex, line) != None:
                            found = True
                            w.write(filename+" finished validation, no error found\n")
                            break
                    if not found:
                        w.write(filename+" Error: either too many or too few intervals\n")
                f.close()          
    w.close()



def main():
    #windows
    input_dir = str(input("Directory: "))
    checkIntervals(input_dir)


if __name__ == "__main__":
    main()


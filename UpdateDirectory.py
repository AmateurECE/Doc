###############################################################################
# NAME:             UpdateGuides.py
#
# AUTHOR:           Ethan D. Twardy <edtwardy@mtu.edu>
#
# DESCRIPTION:      Updates the Guides.md file to contain links to the latest
#                   information in the repository.
#
# CREATED:          02/27/2019
#
# LAST EDITED:      02/27/2019
###

import os

def findMDFiles():
    """
    Locates all of the .md files in all sub-directories of the current
    directory.
    """
    mdFiles = list()
    for dirpath, dirnames, filenames in os.walk('.'):
        for f in filenames:
            if '.md' in f:
                mdFiles.append(dirpath + '/' + f)
    return mdFiles

def getTitle(mdFilename):
    """Get the markdown title from the file with the name `mdFilename'"""
    with open(mdFilename, 'r') as mdFile:
        line = mdFile.readline()
        try:
            return ' '.join(line.split(' ')[1:-1])
        except IndexError:
            return mdFilename

def makeDirectory(mdFiles):
    """
    Generate Guides.md from the list of .md files in mdFiles
    """
    with open('./Directory.md', 'w') as guideFile:
        guideFile.write('# The Repository Directory #\n')
        for f in mdFiles:
            if f != './Guides.md':
                title = getTitle(f)
                guideFile.write('\n[' + title + '](' + f + ')\n')
    

###############################################################################
# MAIN
###

def main():
    """main@UpdateGuides.py"""
    mdFiles = findMDFiles()
    makeDirectory(mdFiles)

if __name__ == '__main__':
    main()

##############################################################################

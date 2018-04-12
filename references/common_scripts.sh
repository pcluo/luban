# Compress HDF5 
ptrepack -v --chunkshape=auto --propindexes --complevel=9 --complib=blosc in.h5 out.h5

# Convert latex file to word and ppt
pandoc -s appendix_complete.tex -o appendix.docx --bibliography ../Literature/MyCollection.bib

# github
git rm --cached file1.txt
git lfs prune
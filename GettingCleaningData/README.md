# Data science track - Getting and cleaning data
This folder contains the following files:  
* `run_analysis.r`: code used to generate the tidy data called `tidyData.txt` from the original dataset. To run this code, you need to do the following:
  + Make sure that you have the following R libraries installed on your computer: plyr, reshape2, downloader.
  + You do not need to have the original dataset on your computer. The script will download the original dataset from internet. So make sure you are connected to the internet.  
  + If you have the original dataset on your computer, please do the following:  
    Create a folder `dataset` in your working directory  
    Put the original dataset in zip format in this `dataset` folder. Make sure that you original dataset has the following name `UCI_HAR_Dataset.zip`

* `CodeBook.md`: codebook explaining
  + the different operations performed by `run_analysis.r` to obtain `tidyData.txt`.
  + the different variables in `tidyData.txt`

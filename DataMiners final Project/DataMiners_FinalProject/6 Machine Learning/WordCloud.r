
install.packages(repos="http://cran.rstudio.com/","stringr")
install.packages(repos="http://cran.rstudio.com/","tm")
install.packages(repos="http://cran.rstudio.com/","ggmap")
install.packages(repos="http://cran.rstudio.com/","dplyr")
install.packages(repos="http://cran.rstudio.com/","plyr")
install.packages(repos="http://cran.rstudio.com/","wordcloud")
install.packages(repos="http://cran.rstudio.com/","data.table")

library(stringr)
library(tm)
library(ggmap)
library(plyr)
library(dplyr)
library(tm)
library(wordcloud)
library(data.table)

MyData <- fread(file="C:/Users/Gautam/Downloads/Book1.csv", header=TRUE, sep=",")

clean.text = function(x)
{
  # tolower
  x = tolower(x)
  # remove rt
  x = gsub("rt", "", x)
  # remove at
  x = gsub("@\\w+", "", x)
  # remove punctuation
  x = gsub("[[:punct:]]", "", x)
  # remove numbers
  x = gsub("[[:digit:]]", "", x)
  # remove links http
  x = gsub("http\\w+", "", x)
  # remove tabs
  x = gsub("[ |\t]{2,}", "", x)
  # remove blank spaces at the beginning
  x = gsub("^ ", "", x)
  # remove blank spaces at the end
  x = gsub(" $", "", x)
  return(x)
}


# clean texts
MyFinalData_clean = clean.text(MyData)

Data_clean = paste(MyFinalData_clean, collapse=" ")

# remove stop-words
all = removeWords(Data_clean,
                  c(stopwords("english")))

# create corpus
corpus = Corpus(VectorSource(all))

# create term-document matrix
tdm = TermDocumentMatrix(corpus)

# convert as matrix
tdm = as.matrix(tdm)

#cloud formation of the reviews
commonality.cloud(tdm, random.order=FALSE, 
                  colors = brewer.pal(8, "Dark2"),
                  title.size=1.5)

MyFinalData_clean

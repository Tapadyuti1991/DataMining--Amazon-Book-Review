.libPaths("C:/Users/nikan/Desktop/Big Data/R")
setwd("C:/Users/nikan/Desktop/Big Data/R")
install.packages("iotools")
install.packages("data.table")
library(iotools)
library(data.table)
memory.limit(size=10000)

MyData <- fread(file="C:/Users/nikan/Desktop/Big Data/new filtered.csv", header=TRUE)
View(MyData)
MyData<-MyData[!(is.na(MyData$ASIN) | MyData$ASIN==""), ]
MyData<-MyData[!(is.na(MyData$Date) | MyData$Date==""), ]
MyData<-MyData[!(is.na(MyData$Ratings) | MyData$Ratings==""), ]
MyData<-MyData[!(is.na(MyData$ReviewerID) | MyData$ReviewerID==""), ]
MyData<-MyData[!(is.na(MyData$ReviewerName) | MyData$ReviewerName==""), ]

write.csv(MyData, file = "MyData.csv")

View(Part3)
Part3<-outputAsinTitle[!(is.na(outputAsinTitle$ASIN) | outputAsinTitle$ASIN==""), ]
Part3<-Part3[!(is.na(Part3$Title) | Part3$Title==" "), ]
Part3<-Part3[!(is.na(Part3$Genre) | Part3$Genre==" "), ]
Part3<-Part3[!(is.na(Part3$Genre1) | Part3$Genre1==" "), ]
Part3<-Part3[!(is.na(Part3$Author) | Part3$Author==" "), ]


View(Part5)
Part5<-outputAsinTitle5[!(is.na(outputAsinTitle5$ASIN) | outputAsinTitle5$ASIN==""), ]
Part5<-Part5[!(is.na(Part5$Title) | Part5$Title==""), ]
Part5<-Part5[!(is.na(Part5$Genre) | Part5$Genre==""), ]
Part5<-Part5[!(is.na(Part5$Genre1) | Part5$Genre1==""), ]
Part5<-Part5[!(is.na(Part5$Author) | Part5$Author==""), ]


Part7<-outputAsinTitle7[!(is.na(outputAsinTitle7$ASIN) | outputAsinTitle7$ASIN==""), ]
Part7-Part7[!(is.na(Part7$Title) | Part7$Title==" " |Part7$Title=="" ), ]
Part7<-Part7[!(is.na(Part7$Genre) | Part7$Genre==" "), ]
Part7<-Part7[!(is.na(Part7$Genre1) | Part7$Genre1==" "), ]
Part7<-Part7[!(is.na(Part7$Author) | Part7$Author==" "), ]
View(Part7)


Part10<-outputAsinTitle10[!(is.na(outputAsinTitle10$ASIN) | outputAsinTitle10$ASIN==""), ]
Part10-Part10[!(is.na(Part10$Title) | Part10$Title=="" ), ]
Part10<-Part10[!(is.na(Part10$Genre) | Part10$Genre==""), ]
Part10<-Part10[!(is.na(Part10$Genre1) | Part10$Genre1==""), ]
Part10<-Part10[!(is.na(Part10$Author) | Part10$Author==""), ]
View(Part10)


Part14<-Part14.Output[!(is.na(Part14.Output$ASIN) | Part14.Output$ASIN==""), ]
Part14-Part14[!(is.na(Part14$Title) | Part14$Title==" " ), ]
Part14<-Part14[!(is.na(Part14$Genre) | Part14$Genre==" "), ]
Part14<-Part14[!(is.na(Part14$Genre1) | Part14$Genre1==" "), ]
Part14<-Part14[!(is.na(Part14$Author) | Part14$Author==" "), ]
View(Part14)


Part11<-OutputPart11[!(is.na(OutputPart11$ASIN) | OutputPart11$ASIN==""), ]
Part11-Part11[!(is.na(Part11$Title) | Part11$Title=="" ), ]
Part11<-Part11[!(is.na(Part11$Genre) | Part11$Genre==""), ]
Part11<-Part11[!(is.na(Part11$Genre1) | Part11$Genre1==""), ]
Part11<-Part11[!(is.na(Part11$Author) | Part11$Author==""), ]
View(Part11)



Part6<-outputPart6[!(is.na(outputPart6$ASIN) | outputPart6$ASIN==""), ]
Part6-Part6[!(is.na(Part6$Title) | Part6$Title==" " ), ]
Part6<-Part6[!(is.na(Part6$Genre) | Part6$Genre==" " ), ]
Part6<-Part6[!(is.na(Part6$Genre1) | Part6$Genre1==" "), ]
Part6<-Part6[!(is.na(Part6$Author) | Part6$Author==" "), ]
View(Part6)


Part1<-Outpt1[!(is.na(Outpt1$ASIN) | Outpt1$ASIN==""), ]
Part1-Part1[!(is.na(Part1$Title) | Part1$Title=="" ), ]
Part1<-Part1[!(is.na(Part1$Genre) | Part1$Genre=="" ), ]
Part1<-Part1[!(is.na(Part1$Genre1) | Part1$Genre1==""), ]
Part1<-Part1[!(is.na(Part1$Author) | Part1$Author==""), ]
View(Part1)

Part2<-outputAsinPart2[!(is.na(outputAsinPart2$ASIN) | outputAsinPart2$ASIN==""), ]
Part2-Part2[!(is.na(Part2$Title) | Part2$Title==" " ), ]
Part2<-Part2[!(is.na(Part2$Genre) | Part2$Genre==" " ), ]
Part2<-Part2[!(is.na(Part2$Genre1) | Part2$Genre1==" "), ]
Part2<-Part2[!(is.na(Part2$Author) | Part2$Author==" "), ]
View(Part2)


Part13<-Output13[!(is.na(Output13$ASIN) | Output13$ASIN==""), ]
Part13-Part13[!(is.na(Part13$Title) | Part13$Title==" " ), ]
Part13<-Part13[!(is.na(Part13$Genre) | Part13$Genre==" " ), ]
Part13<-Part13[!(is.na(Part13$Genre1) | Part13$Genre1==" "), ]
Part13<-Part13[!(is.na(Part13$Author) | Part13$Author==" "), ]
View(Part13)



NewDate<-rbind(Part1,Part3,Part6,Part11,Part14,Part10,Part7,Part5,Part2,Part13)
View(NewDate)


PartGautam<-completefile
NewDate<-rbind(NewDate,PartGautam)
View(NewDate)


MergeNewData<-merge(MyData,NewDate,all = TRUE)
View(MergeNewData)

write.csv(MergeNewData,"MergedNewData.csv")
sum(is.na(MergeNewData$Title))



MergeNewData-MergeNewData[!(is.na(MergeNewData$Title) | MergeNewData$Title=="" ), ]
MergeNewData<-MergeNewData[!(is.na(MergeNewData$Genre) | MergeNewData$Genre==" " ), ]
MergeNewData<-MergeNewData[!(is.na(MergeNewData$Genre1) | MergeNewData$Genre1==" "), ]
MergeNewData<-MergeNewData[!(is.na(MergeNewData$Author) | MergeNewData$Author==" "), ]


MergedData<-fread(file="C:/Users/nikan/Desktop/Big Data/R/MergedNewData.csv", header=TRUE)
ReviewData<-fread(file="C:/Users/nikan/Desktop/Big Data/reviewdata.csv", header=TRUE)

FinalData<-merge(ReviewData,MergedData,by=c("ASIN","ReviewerID"),all = TRUE)
View(FinalData)
FinalData<-FinalData[!(is.na(FinalData$ASIN) | FinalData$ASIN==" "), ] 
FinalData-FinalData[!(is.na(FinalData$Review_Summary) | FinalData$Review_Summary==" " ), ]
FinalData<-FinalData[!(is.na(FinalData$Genre) | FinalData$Genre==" " ), ]
FinalData<-FinalData[!(is.na(FinalData$ReviewerID) | FinalData$ReviewerID==""), ]
FinalData<-FinalData[!(is.na(FinalData$Review_Text) | FinalData$Review_Text==" "), ]
FinalData<-FinalData[!(is.na(FinalData$Review_Summary) | FinalData$Review_Summary==" "), ]


View(FinalData)
write.csv(FinalData,"FinalData.csv")


LatestData<-merge(helpful,FinalData,by=c("ASIN","ReviewerID"),all = TRUE)
LatestData-LatestData[!(is.na(LatestData$Review_Summary) | LatestData$Review_Summary=="" ), ]
LatestData<-LatestData[!(is.na(LatestData$Genre) | LatestData$Genre=="" ), ]
write.csv(LatestData,"LatestData.csv")
View(MyData)
MyData <- fread(file="C:/Users/nikan/Desktop/Big Data/R/LatestData.csv", header=TRUE)
UniqueGenre<-fread(file="C:/Users/nikan/Desktop/Big Data/R/UniqueGenre.csv", header=TRUE)
UniqueASINID<-fread(file="C:/Users/nikan/Desktop/Big Data/R/UniqueASINID.csv", header=TRUE)
View(UniqueGenre)
UniqueReviewerID<-fread(file="C:/Users/nikan/Desktop/Big Data/R/UniqueReviewerID.csv", header=TRUE)
View(UniqueReviewerID)
colnames(UniqueGenre)[2]<-"Genre1"
colnames(Unique.IDs)[4]<-"ReviewerName"
colnames(Unique.IDs)[6]<-"Title"

MyData<-merge(MyData,UniqueASINID,by="ASIN")
View(MyData)
write.csv(MyData,"MyFinalData.csv")
x<-c(MyData$UniqueReviewerID)+10000
View(x)

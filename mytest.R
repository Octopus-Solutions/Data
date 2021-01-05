library(RCurl)
iris_url= "https://raw.githubusercontent.com/Octopus-Solutions/Data/main/iris.data"
iris_txt = getURL(iris_url)
iris_data = read.csv(textConnection(iris_txt),header =F)

library(plyr)
iris = rename(iris_data,c("V1"="Sepal_Length",
                          "V2"= "Sepal_Width",
                          "V3"= "Petal_Length",
                          "V4"= "Petal_Width",
                          "V5"="Species"))
iris$Species = as.factor(iris$Species)
names(iris)
irisInputs = iris[,-5]

library(randomForest)
model = randomForest(Species~.,
                     data = iris,
                     method = "class")

save(model, file = "model.rda")
mypredict = function(newdata){
  require(randomForest)
  predict(model,newdata,type='response')
}
print(mypredict(iris))

if(!require("devtools")) install.packages(
  "devtools"
)
devtools::install_github("RevolutionAnalytics/azumreml")

library(AzureML)
library(devtools)

wsID = "5af3c835-1b1b-4bd6-9554-88ed6ee5e19f"
wsAuth = ""

ws <- get_workspace( "<your-workspace-name>",
                     subscription_id = "<your-subscription-id>",
                     resource_group = "Octopus" )


  wsobj = workspace(wsID,wsAuth)


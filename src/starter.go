package main

import (
	"github.com/annuums/ci-cd-pipeline/index"
	"github.com/annuums/solanum"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	ginadapter "github.com/awslabs/aws-lambda-go-api-proxy/gin"
	"github.com/gin-gonic/gin"
)

var ginLambda *ginadapter.GinLambda

func handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	if ginLambda == nil {
		server := *solanum.NewSolanum(8080)
		server.GetGinEngine().Use(gin.Logger(), gin.Recovery())

		solanum.NewHelloWorldHandler()

		var indexModule solanum.Module
		indexUri := "/"
		indexModule, _ = index.NewIndexModule(
			server.GetGinEngine().Group(indexUri),
			indexUri,
		)

		server.AddModule(&indexModule)
		server.InitModules()

		ginLambda = ginadapter.New(server.GetGinEngine())
	}

	return ginLambda.Proxy(request)
}

func main() {
	lambda.Start(handler)
}

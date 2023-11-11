package main

import (
	"github.com/annuums/ci-cd-pipeline/index"
	"github.com/annuums/solanum"
	"github.com/gin-gonic/gin"
)

func main() {
	server := *solanum.NewSolanum(5050)
	server.GetGinEngine().Use(gin.Logger(), gin.Recovery())

	solanum.NewHelloWorldHandler()

	var indexModule solanum.Module
	indexUri := "/"
	indexModule, _ = index.NewIndexModule(
		server.GetGinEngine().Group(indexUri),
		indexUri,
	)

	server.AddModule(&indexModule)

	server.Run()
}

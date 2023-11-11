package index

import (
	"log"
	"net/http"

	"github.com/annuums/solanum"
	"github.com/gin-gonic/gin"
)

func NewIndexHandler() *solanum.SolaService {
	return &solanum.SolaService{
		Uri:        "/",
		Method:     http.MethodGet,
		Handler:    indexHandler,
		Middleware: indexMiddleware,
	}
}

func indexHandler(ctx *gin.Context) {
	ctx.JSON(200, "Hello, World! Welcome to CI-CD-Pipeline")
}

func indexMiddleware(ctx *gin.Context) {
	log.Println("Hello Index Middleware")
	ctx.Next()
}

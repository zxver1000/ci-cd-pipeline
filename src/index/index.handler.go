package index

import (
	"log"
	"net/http"

	"github.com/annuums/solanum"
	"github.com/gin-gonic/gin"
)

func NewIndexHandler() []*solanum.SolaService {
	return []*solanum.SolaService{
		{
		Uri:        "/",
		Method:     http.MethodGet,
		Handler:    indexHandler,
		Middleware: nil,
		},
		{
			Uri:        "/",
			Method:     http.MethodPost,
			Handler:    indexHandler2,
			Middleware: nil,
		},
		{
			Uri:        "/",
			Method:     http.MethodPatch,
			Handler:    indexHandler3,
			Middleware: nil,
			},
			
			

	}
}

func indexHandler(ctx *gin.Context) {
	ctx.JSON(200, gin.H{"code" : http.StatusOK,"content": "Health Check OK.Get"})
}
func indexHandler2(ctx *gin.Context) {
	ctx.JSON(200, gin.H{"code" : http.StatusOK,"content": "Health Check OK. Post"})
}

func indexHandler3(ctx *gin.Context) {
	ctx.JSON(200, gin.H{"code" : http.StatusOK,"content": "Health Check OK.Patch"})
}


func indexMiddleware(ctx *gin.Context) {
	log.Println("Hello Index Middleware")
	ctx.Next()
}

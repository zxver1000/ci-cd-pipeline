package index

import (
	"log"

	"github.com/annuums/solanum"
	"github.com/gin-gonic/gin"
)

var indexModule *solanum.SolaModule

func NewIndexModule(router *gin.RouterGroup, uri string) (*solanum.SolaModule, error) {
	if indexModule == nil {
		indexModule, _ = solanum.NewModule(router, uri)
		attachControllers()
	}

	return indexModule, nil
}

func attachControllers() {
	//* Attatching Controller Directly
	var (
		ctr solanum.Controller
		err error
	)

	ctr, err = NewIndexController()

	if err != nil {
		log.Fatal(err)
	}

	indexModule.SetControllers(&ctr)
}

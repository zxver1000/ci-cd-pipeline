package index

import (
	"github.com/annuums/solanum"
)

var indexController *solanum.SolaController

func NewIndexController() (*solanum.SolaController, error) {
	if indexController == nil {
		indexController, _ = solanum.NewController()
		addHandlers()
	}

	return indexController, nil
}

func addHandlers() {
	handlers := NewIndexHandler()

	indexController.AddHandler(handlers...)
}

//* Middleware

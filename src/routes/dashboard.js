var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/usuario/:id", function (req, res) {
  dashboardController.buscarPreferenciasUser(req, res);
});

router.get("/personagens", function (req, res) {
  dashboardController.buscarPersonagensFavoritos(req, res);
});

router.get("/monstros", function (req, res) {
  dashboardController.buscarMonstrosTemidos(req, res);
});

module.exports = router;

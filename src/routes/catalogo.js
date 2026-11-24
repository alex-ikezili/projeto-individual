var express = require("express");
var router = express.Router();

var catalogoController = require("../controllers/catalogoController");

router.get("/personagens", function (req, res) {
    catalogoController.listarPersonagens(req, res);
});

router.get("/monstros", function (req, res) {
    catalogoController.listarMonstros(req, res);
});

module.exports = router;

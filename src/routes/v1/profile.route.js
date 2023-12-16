const express = require("express");
const auth = require("../../middlewares/auth");
const userController = require("../../controllers/user.controller");

const router = express.Router();

router.route("/").get(auth("me"), userController.getProfile);

module.exports = router;

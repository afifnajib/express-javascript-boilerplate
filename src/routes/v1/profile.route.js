const express = require("express");
const auth = require("../../middlewares/auth");
const validate = require("../../middlewares/validate");
const userValidation = require("../../validations/user.validation");
const userController = require("../../controllers/user.controller");

const router = express.Router();

router.route("/").get(auth("manageUsers"), userController.getProfile);
// router
//   .route("change-password")
//   .post(
//     auth("manageUsers"),
//     validate(userValidation.changePassword),
//     userController.changePassword
//   );

module.exports = router;

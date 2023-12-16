const validator = require("validator");
const bcrypt = require("bcryptjs");

const validateEmail = (email) => {
  return validator.isEmail(email);
};

const hashPassword = (password) => {
  const salt = bcrypt.genSaltSync(10);
  const hashpassword = bcrypt.hashSync(password, salt);
  return hashpassword;
};

const isPasswordMatch = (passwordOri, password) => {
  return bcrypt.compareSync(password, passwordOri);
};

module.exports = {
  validateEmail,
  hashPassword,
  isPasswordMatch,
};

const validator = require("validator");
const bcrypt = require("bcryptjs");
class userModel {
  constructor(userData) {
    this.id = userData.id;
    this.name = userData.name;
    this.email = userData.email;
    this.password = userData.password;
    this.role = userData.role;
    this.isEmailVerified = userData.isEmailVerified || false;
    // this.createdAt =
    //   status == "create" ? new Date().toISOString() : userData.createdAt;
    // this.updatedAt = status == "update" ? userData.updatedAt || new Date().toISOString();
  }

  validateEmail() {
    return validator.isEmail(this.email);
  }

  hashPassword() {
    const salt = bcrypt.genSaltSync(10);
    this.password = bcrypt.hashSync(this.password, salt);
  }

  isPasswordMatch(password) {
    return bcrypt.compareSync(password, this.password);
  }
}

module.exports = {
  userModel,
};

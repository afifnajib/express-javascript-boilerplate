const jwt = require("jsonwebtoken");
const { addMinutes, addDays, getUnixTime } = require("date-fns");
// const moment = require('moment');
const httpStatus = require("http-status");
const config = require("../config/config");
const userService = require("./user.service");
// const { Token } = require("../models");
const ApiError = require("../utils/ApiError");
const { tokenTypes } = require("../config/tokens");
const { prisma } = require("../data-source");

/**
 * Generate token
 * @param {ObjectId} userId
 * @param {Moment} expires
 * @param {string} type
 * @param {string} [secret]
 * @returns {string}
 */
const generateToken = (userId, expires, type, secret = config.jwt.secret) => {
  const payload = {
    sub: userId,
    iat: Math.floor(Date.now() / 1000),
    exp: Math.floor(expires / 1000),
    type,
  };
  return jwt.sign(payload, secret);
};

/**
 * Save a token
 * @param {string} token
 * @param {ObjectId} userId
 * @param {Moment} expires
 * @param {string} type
 * @param {boolean} [blacklisted]
 * @returns {Promise<Token>}
 */
const saveToken = async (token, userId, expires, type) => {
  const tokenDoc = await prisma.token.create({
    data: {
      token: token,
      user: {
        connect: {
          id: userId,
        },
      },
      expires: expires,
      type: type,
      revoked: false,
    },
  });
  return tokenDoc;
};

/**
 * Verify token and return token doc (or throw an error if it is not valid)
 * @param {string} token
 * @param {string} type
 * @returns {Promise<Token>}
 */
const verifyToken = async (token, type) => {
  const payload = jwt.verify(token, config.jwt.secret);
  const tokenDoc = await prisma.token.findFirst({
    where: {
      token: token,
      type: type,
      user: {
        id: payload.sub,
      },
      revoked: false,
      expires: {
        gt: new Date(),
      },
    },
  });
  if (!tokenDoc) {
    throw new Error("Token not found");
  }
  if (getUnixTime(tokenDoc.expires) < getUnixTime(new Date())) {
    throw new Error("Token has expired");
  }
  return tokenDoc;
};

/**
 * Generate auth tokens
 * @param {User} user
 * @returns {Promise<Object>}
 */
const generateAuthTokens = async (user) => {
  const now = new Date();
  const accessTokenExpires = addMinutes(
    now,
    config.jwt.accessExpirationMinutes
  );
  const accessToken = generateToken(
    user.id,
    accessTokenExpires,
    tokenTypes.ACCESS
  );

  const refreshTokenExpires = addDays(now, config.jwt.refreshExpirationDays);
  const refreshToken = generateToken(
    user.id,
    refreshTokenExpires,
    tokenTypes.REFRESH
  );

  await saveToken(
    refreshToken,
    user.id,
    refreshTokenExpires,
    tokenTypes.REFRESH
  );

  return {
    access: {
      token: accessToken,
      expires: getUnixTime(accessTokenExpires),
    },
    refresh: {
      token: refreshToken,
      expires: getUnixTime(refreshTokenExpires),
    },
  };
};

/**
 * Generate reset password token
 * @param {string} email
 * @returns {Promise<string>}
 */
const generateResetPasswordToken = async (email) => {
  const user = await userService.getUserByEmail(email);
  if (!user) {
    throw new ApiError(httpStatus.NOT_FOUND, "No users found with this email");
  }
  const expires = addMinutes(
    new Date(),
    config.jwt.resetPasswordExpirationMinutes
  );
  const resetPasswordToken = generateToken(
    user.id,
    expires,
    tokenTypes.RESET_PASSWORD
  );
  await saveToken(
    resetPasswordToken,
    user.id,
    expires,
    tokenTypes.RESET_PASSWORD
  );
  return resetPasswordToken;
};

/**
 * Generate verify email token
 * @param {User} user
 * @returns {Promise<string>}
 */
const generateVerifyEmailToken = async (user) => {
  const expires = addMinutes(
    new Date(),
    config.jwt.verifyEmailExpirationMinutes
  );
  const verifyEmailToken = generateToken(
    user.id,
    expires,
    tokenTypes.VERIFY_EMAIL
  );
  await saveToken(verifyEmailToken, user.id, expires, tokenTypes.VERIFY_EMAIL);
  return verifyEmailToken;
};

module.exports = {
  generateToken,
  saveToken,
  verifyToken,
  generateAuthTokens,
  generateResetPasswordToken,
  generateVerifyEmailToken,
};

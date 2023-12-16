const { prisma } = require("../data-source");
const ApiError = require("../utils/ApiError");
const httpStatus = require("http-status");
const { userModel } = require("../models/user.model");
// const bcrypt = require("bcryptjs");

// const createUser = async (userData) => {
//   const salt = await bcrypt.genSalt(10);
//   const hashedPassword = await bcrypt.hash(userData.password, salt);

//   const exists = await prisma.user.findUnique({
//     where: { email: userData.email },
//   });

//   if (exists) {
//     throw new ApiError(httpStatus.BAD_REQUEST, "Email already exists");
//   }

//   return prisma.user.create({
//     data: {
//       ...userData,
//       password: hashedPassword,
//       role: "user",
//     },
//   });
// };

const createUser = async (userData) => {
  const user = new userModel(userData);
  if (!user.validateEmail()) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Invalid email");
  }
  user.hashPassword();
  const exists = await prisma.user.findUnique({
    where: {
      email: userData.email,
    },
  });
  if (exists) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already exists");
  }
  return prisma.user.create({
    data: {
      ...user,
      role: "user",
    },
  });
};

const findManyUsers = async (params) => {
  const { skip, take, cursor, where, orderBy } = params;

  return prisma.user.findMany({
    skip,
    take,
    cursor,
    where,
    orderBy,
  });
};

const findUniqueUser = async ({ where }) => {
  return prisma.user.findUnique({ where });
};

const getUserByEmail = async (email) => {
  return prisma.user.findUnique({
    where: {
      email: email,
    },
  });
};

const getUserById = async (id) => {
  return prisma.user.findUnique({
    where: {
      id: id,
    },
  });
};

const updateUser = async (params) => {
  return prisma.user.update(params);
};

const deleteUser = async ({ where }) => {
  return prisma.user.delete({ where });
};

module.exports = {
  createUser,
  getUserByEmail,
  getUserById,
  findManyUsers,
  findUniqueUser,
  updateUser,
  deleteUser,
};

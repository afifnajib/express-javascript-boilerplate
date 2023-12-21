const { prisma } = require("../data-source");
const ApiError = require("../utils/ApiError");
const httpStatus = require("http-status");
const { validateEmail, hashPassword } = require("../utils/helpers");

const createUser = async (userData) => {
  const validate = await validateEmail(userData.email);
  if (!validate) throw new ApiError(httpStatus.BAD_REQUEST, "Invalid email");
  const hashedPassword = hashPassword(userData.password);
  const exists = await prisma.user.findUnique({
    where: { email: userData.email },
  });
  if (exists)
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already exists");
  const forAdmin = {
    ...userData,
    password: hashedPassword,
    role: "admin",
  };
  const forUser = {
    ...userData,
    password: hashedPassword,
  };
  return prisma.user.create({
    data: userData.role === undefined ? forAdmin : forUser,
  });

  // const users = [];
  // for (let i = 0; i < userData.length; i++) {
  //   const validate = await validateEmail(userData[i].email);
  //   if (!validate) {
  //     throw new ApiError(httpStatus.BAD_REQUEST, "Invalid email");
  //   }
  //   const hashedPassword = hashPassword(userData[i].password);
  //   const exists = await prisma.user.findUnique({
  //     where: {
  //       email: userData[i].email,
  //     },
  //   });
  //   if (exists) {
  //     throw new ApiError(httpStatus.BAD_REQUEST, "Email already exists");
  //   }
  //   users.push({
  //     ...userData[i],
  //     password: hashedPassword,
  //   });
  // }
  // return prisma.user.createMany({
  //   data: users,
  // });
};

const findManyUsers = async (filter, options) => {
  const users = await prisma.user.findMany({
    where: filter,
    skip: options.skip,
    take: options.take,
    select: {
      id: true,
      name: true,
      email: true,
      role: true,
      isEmailVerified: true,
      createdAt: true,
      updatedAt: true,
    },
  });
  return users;
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

const profileUser = async (req) => {
  const currentUser = req;
  return currentUser;
};

const getUserById = async (id) => {
  const user = await prisma.user.findUnique({ where: { id } });
  if (user) {
    delete user.password;
  }
  return user;
};

const updateUserById = async (params) => {
  const user = await validateEmail(params.data.email);
  if (!user) throw new ApiError(httpStatus.BAD_REQUEST, "Invalid email");
  const hashedPassword = hashPassword(params.data.password);
  const emailExists = await prisma.user.findUnique({
    where: { email: params.data.email },
  });
  if (emailExists)
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already exists");
  return prisma.user.update({
    where: {
      id: params.where.id,
    },
    data: {
      ...params.data,
      password: hashedPassword,
    },
  });
};

const deleteUserById = async (userId) => {
  const tokenExists = await prisma.token.findMany({
    where: { id: userId },
  });
  if (tokenExists.length > 0) {
    await prisma.token.updateMany({
      where: { userId },
      data: { revoked: true },
    });
  }
  return await prisma.user.update({
    where: { id: userId },
    data: {
      deletedAt: new Date(),
    },
  });
};

const managePassword = async (dataPasswords) => {
  return dataPasswords;
};

module.exports = {
  createUser,
  getUserByEmail,
  profileUser,
  getUserById,
  findManyUsers,
  findUniqueUser,
  updateUserById,
  deleteUserById,
  managePassword,
};

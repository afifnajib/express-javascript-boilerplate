const { prisma } = require('../data-source');
const ApiError = require('../utils/ApiError');
const httpStatus = require('http-status');

const createUser = async (userData) => {
  const exists = await prisma.user.findUnique({
    where: { email: userData.email },
  });

  if (exists) {
    throw new ApiError(httpStatus.BAD_REQUEST, 'Email already exists');
  }

  return prisma.user.create({
    data: {
      ...userData,
      role: 'user', // set default role
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

const updateUser = async (params) => {
  return prisma.user.update(params);
};

const deleteUser = async ({ where }) => {
  return prisma.user.delete({ where });
};

module.exports = {
  createUser,
  findManyUsers,
  findUniqueUser,
  updateUser,
  deleteUser,
};

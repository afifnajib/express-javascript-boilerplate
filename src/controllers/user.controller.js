const httpStatus = require('http-status');
const pick = require('../utils/pick');
const ApiError = require('../utils/ApiError');
const catchAsync = require('../utils/catchAsync');

const { createUser, findUniqueUser, findManyUsers, updateUser } = require('../services/user.service');

const register = catchAsync(async (req, res) => {
  const user = await createUser(req.body);
  res.status(httpStatus.CREATED).send(user);
});

const getUsers = catchAsync(async (req, res) => {
  const filter = pick(req.query, ['name', 'role']);
  const options = pick(req.query, ['sortBy', 'limit', 'page']);
  const result = await findManyUsers(filter, options);
  res.send(result);
});

const getUser = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.params.userId);
  if (!user) {
    throw new ApiError(httpStatus.NOT_FOUND, 'User not found');
  }
  res.send(user);
});

const updateUsers = catchAsync(async (req, res) => {
  const user = await updateUser({
    where: { id: req.params.userId },
    data: req.body,
  });

  res.send(pick(user, ['id', 'name', 'email', 'role']));
});

module.exports = {
  register,
  getUsers,
  getUser,
  updateUsers,
};

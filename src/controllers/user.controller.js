const httpStatus = require("http-status");
const pick = require("../utils/pick");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const { paginate } = require("../utils/paginate");

const {
  createUser,
  profileUser,
  getUserById,
  findManyUsers,
  updateUserById,
  deleteUserById,
  managePassword,
} = require("../services/user.service");

const registerUser = catchAsync(async (req, res) => {
  const user = await createUser(req.body);
  res.status(httpStatus.CREATED).send(user);
});

const getUsers = catchAsync(async (req, res) => {
  const filter = pick(req.query, ["name"]);
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 25;
  const options = {
    skip: (page - 1) * limit,
    take: limit,
  };
  const users = await findManyUsers(filter, options);
  const filteredUsers = users.filter((u) => u.role === "user");
  const path = req.baseUrl;
  const paginatedUsers = paginate(filteredUsers, page, limit, path);
  res.send(paginatedUsers);
});

const getProfile = catchAsync(async (req, res) => {
  const profile = await profileUser(req.user);
  if (!profile) {
    throw new ApiError(httpStatus.NOT_FOUND, "User not found");
  }
  res.send(profile);
});

const getUser = catchAsync(async (req, res) => {
  const user = await getUserById(req.params.userId);
  if (!user) {
    throw new ApiError(httpStatus.NOT_FOUND, "User not found");
  }
  res.send(user);
});

const updateUser = catchAsync(async (req, res) => {
  const user = await updateUserById({
    where: { id: req.params.userId },
    data: req.body,
  });
  res.send(user);
  // res.send(pick(user, ["id", "name", "email", "role"]));
});

const deleteUser = catchAsync(async (req, res) => {
  await deleteUserById({
    where: { id: req.params.userId },
  });
  await deleteUserById(req.params.userId);
  res.status(httpStatus.NO_CONTENT).send();
});

const changePassword = catchAsync(async (req, res) => {
  await managePassword(req.body);
  res.status(httpStatus.NO_CONTENT).send();
});

module.exports = {
  registerUser,
  getUsers,
  getUser,
  getProfile,
  updateUser,
  deleteUser,
  changePassword,
};

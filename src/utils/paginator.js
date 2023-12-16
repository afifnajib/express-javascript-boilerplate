const { prisma } = require("../data-source");

function paginate(model) {
  return async (req, res) => {
    const page = req.query.page || 1;
    const limit = req.query.limit || 10;

    const modelData = prisma[model];

    const data = await modelData.findMany({
      skip: (page - 1) * limit,
      take: limit,
    });

    res.paginatedResults = {
      data,
    };
  };
}

module.exports = {
  paginate,
};

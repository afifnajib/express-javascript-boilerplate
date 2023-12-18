const config = require("../config/config");

function paginate(data, page, limit, path) {
  const startIndex = (page - 1) * limit;
  const endIndex = page * limit;

  const results = data.slice(startIndex, endIndex);

  const total = data.length;
  const currentPage = page;
  const lastPage = Math.ceil(total / limit);
  const fullPath = `${config.baseUrl}${path}`;

  const perPage = 25;

  const url = `${config.baseUrl}${path}?page=`;

  const links = {
    first: url + 1,
    last: url + lastPage,
    prev: page <= 1 ? null : url + (page - 1),
    next: page >= lastPage ? null : url + (page + 1),
  };

  const linksMeta = {
    links: [
      {
        url: null,
        label: "&laquo; Previous",
        active: false,
      },
      {
        url: "http://localhost:8000/api/users?page=1",
        label: 1,
        active: true,
      },
      {
        url: null,
        label: "Next &raquo;",
        active: false,
      },
    ],
  };

  const pagination = {
    data: results,
    links,
    meta: {
      current_page: 1,
      from: 1,
      last_page: 1,
      linksMeta,
      path: fullPath,
      per_page: limit,
      to: currentPage,
      lastPage,
      total,
    },
  };
  return pagination;
}

module.exports = { paginate };

// user.model.js

const validator = require('validator');
const bcrypt = require('bcryptjs');

const userModel = {
  name: 'User',

  fields: {
    id: { type: 'uuid', default: { uuid: true } },
    name: { type: 'String', required: true },
    email: {
      type: 'String',
      required: true,
      validate: {
        validator: (value) => validator.isEmail(value),
        message: 'Invalid email',
      },
    },
    password: {
      type: 'String',
      required: true,
    },
    role: { type: 'String', required: true },

    isEmailVerified: { type: 'Boolean', default: false },

    createdAt: { type: 'DateTime', default: { now: true } },

    updatedAt: { type: 'DateTime', default: { now: true } },
  },

  hooks: {
    beforeSave: async (user) => {
      if (user.password) {
        user.password = await bcrypt.hash(user.password, 8);
      }
    },
  },

  methods: {
    validatePassword(password) {
      return bcrypt.compare(password, this.password);
    },
  },
};

module.exports = { userModel };

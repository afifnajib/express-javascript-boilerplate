module.exports = {
  apps: [
    {
      name: "API",
      script: "src/index.js",
      instances: "max",
      exec_mode: "cluster",
      env: {
        NODE_ENV: "production",
      },
    },
  ],
};

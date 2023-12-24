module.exports = {
  version: "2.2.0",
  apps: [
    {
      name: "express",
      cwd: "./",
      script: "src/index.js",
      watch: true,
      log_level: "info",
      exec_mode: "cluster",
      env: {
        NODE_ENV: "production",
      },
    },
  ],
};

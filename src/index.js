const { prisma } = require("./data-source");
const app = require("./app");
const config = require("./config/config");
const logger = require("./config/logger");

(async () => {
  try {
    await prisma.$connect();

    const server = app.listen(config.port, () => {
      logger.info(`Listening on port ${config.port}`);
    });

    const exitHandler = () => {
      if (server) {
        server.close(() => {
          logger.info("Server closed");
          process.exit(1);
        });
      } else {
        process.exit(1);
      }
    };

    const unexpectedErrorHandler = (error) => {
      logger.error(error);
      exitHandler();
    };

    process.on("uncaughtException", unexpectedErrorHandler);
    process.on("unhandledRejection", unexpectedErrorHandler);

    process.on("SIGTERM", () => {
      logger.info("SIGTERM received");
      if (server) {
        server.close();
      }
    });
  } catch (error) {
    logger.error(error);
    process.exit(1);
  }
})();

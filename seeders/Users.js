const { PrismaClient } = require("@prisma/client");
const { faker } = require("@faker-js/faker");
const { hashPassword } = require("../src/utils/helpers");

const prisma = new PrismaClient();

async function main() {
  const seedUsers = Array(10)
    .fill(null)
    .map(() => {
      return {
        name: faker.internet.userName(),
        email: faker.internet.email(),
        password: hashPassword("password2023"),
        role: faker.helpers.arrayElement(["user", "admin"]),
      };
    });
  const adminUser = {
    name: "Administrator",
    email: "admin@example.com",
    password: hashPassword("password"),
    role: "admin",
  };

  const allUsers = [...seedUsers, adminUser];

  await prisma.user.createMany({
    data: allUsers,
  });
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

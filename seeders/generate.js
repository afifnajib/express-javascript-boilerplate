const fs = require("fs-extra");

const seederName = process.argv[2];

if (!seederName) {
  console.log("Please provide seeder name");
  process.exit(1);
}

const fileName = `seeders/${seederName}.js`;
const content = `
const { PrismaClient } = require('@prisma/client');
const { faker } = require('@faker-js/faker');

const prisma = new PrismaClient();

async function main() {
  // Seed data here  
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
`;

fs.writeFileSync(fileName, content);

console.log(`Seeder ${fileName} generated!`);

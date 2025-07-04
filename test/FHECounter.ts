import { ethers } from "hardhat";
import { expect } from "chai";

describe("FHECounter", function () {
  let counter: any;
  let owner: any;
  let alice: any;

  beforeEach(async function () {
    [owner, alice] = await ethers.getSigners();
    const Counter = await ethers.getContractFactory("FHECounter");
    counter = await Counter.deploy();
    await counter.waitForDeployment();
  });

  it("should deploy and return initial encrypted count", async function () {
    const count = await counter.getCount();
    expect(count).to.exist;
    // Здесь count — зашифрованное значение, проверить его напрямую нельзя
  });

  // Пример теста инкремента (требует реального зашифрованного значения и proof)
  it("should increment encrypted count", async function () {
    // Здесь нужно получить зашифрованное значение и proof с помощью FHEVM SDK
    // Пример (псевдокод):
    // const { encrypted, proof } = await fhevm.encryptAndProve(1);
    // await counter.increment(encrypted, proof);

    // Для мок-теста можно просто проверить, что функция вызывается без ошибок
    // await counter.increment("0x00", "0x");
    // expect(await counter.getCount()).to.exist;
  });
});

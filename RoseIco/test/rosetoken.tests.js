const { BN, ether, expectRevert } = require("@openzeppelin/test-helpers");

const { expect } = require("chai");

const Roz = artifacts.require("RoseToken");

contract("Rosetoken", accounts => {
  const name = "RoseToken";
  const symbol = "ROZ";
  const owner = accounts[0];
  const recipient = accounts[1];
  const amount = ether("10");
  const decimals = new BN(18);
  const totalSupply = new BN(10000)*10**decimals;

  
  beforeEach(async() => {
    this.RozInstance = await Roz.new({from: owner});
  });

  it("a un nom", async() => {
    expect(await this.RozInstance.name()).to.equal(name);
  });

  it("a un symbole", async() => {
    expect(await this.RozInstance.symbol()).to.equal(symbol);
  });

  it("a une valeur décimal", async() => {
    expect(await this.RozInstance.decimals()).to.be.bignumber.equal(decimals);
  });

  it("vérifie le montant total des tokens", async() =>{
    expectRevert(await this.RozInstance.totalSupply());
  });

  it("vérifie la balance du propriétaire du contrat", async() =>{
    let balanceOwner = await this.RozInstance.balanceOf(owner);
    let totalSupply = await this.RozInstance.totalSupply();
    expect(balanceOwner).to.be.bignumber.equal(totalSupply);
  });async() =>

  it("vérifie si un transfert est bien effectué", async() =>{
    let balanceOwner = await this.RozInstance.balanceOf(owner);
    let balanceRecipient = await this.RozInstance.balanceOf(recipient);
    
    await this.RozInstance.transfer(recipient, amount,{from: owner});

    let balanceOwnerActual = await this.RozInstance.balanceOf(owner);
    let balanceRecipientActual = await this.RozInstance.balanceOf(recipient);

    expect(balanceOwner.sub(amount)).to.be.bignumber.equal(balanceOwnerActual);

    expect(balanceRecipient.add(amount)).to.be.bignumber.equal(balanceRecipientActual);
  });
});
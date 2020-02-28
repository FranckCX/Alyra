const { BN, expectEvent, expectRevert, constants } = require("@openzeppelin/test-helpers");
const { expect } = require("chai");
const CrowdSale = artifacts.require("Crowdsale");
const RoseToken = artifacts.require("RoseToken");

contract("CrowdSale", async accounts => {
    const owner = accounts[0];
    const wallet = accounts[1];
    
    let crowdSale;
    let roseToken;

    beforeEach(async function() {
        crowdSale = await CrowdSale.new(wallet,{from:owner});
        roseToken = await RoseToken.new();
    }); //async function() == async() =>

    it("vérifie les getters", async() => {
        expect(await crowdSale.getAdmin(), "vérifie le owner").to.be.equal(owner);
        expect(await crowdSale.getWallet(), "vérifie le wallet").to.be.equal(wallet);
        expect(await crowdSale.getToken(), "vérifie le token").to.not.be.an('undefined');
        expect(await crowdSale.getToken()).to.not.be.equal(constants.ZERO_ADDRESS);
    });

    it("vérifie la vente de tokens", async() => {
        let val = new BN(0);
        await expectRevert(crowdSale.venteToken(val, {from:owner}), "Vous ne pouvez pas acheter 0 token, banane");
        
        const val2 = new BN(100);
        // expectEvent(await crowdSale.venteToken(val2, {from:owner}), "Vendu", {vendeur: owner, acheteur: wallet, montant: val2});
       
        expectEvent(await crowdSale.venteToken(val2, {from:owner}), "Vendu", {vendeur: crowdSale.address, acheteur: owner, montant: val2});
    });

    it("vérifie la fonction controle vente", async()=>{
        let val = new BN(100000000);
        await expectRevert(crowdSale._controleVente(val), "Mauvais montant");
    });

});
const { BN, expectEvent, expectRevert } = require("@openzeppelin/test-helpers");
const { expect } = require("chai");

const PlaceDeMarche = artifacts.require("PlaceDeMarche");

contract("PlaceDeMarche", accounts => {
    const owner = accounts[0];
    const candidat = accounts[1];
    const illustrateur = accounts[2];
    const balance = new BN(1);

    // beforeEach(async () => {
    //     placedemarche = await placedemarche.new(name, symbol, decimals, initialAmount, { from: owner });
    // });

    beforeEach(async () => {
        this.PlaceDeMarche = await PlaceDeMarche.new({from: owner});
      });

    it("Test modifier admin", async () => {
        expect(await this.PlaceDeMarche.postuler(owner)).to.be.equal(owner);
        // let estOwner = "0";
        // await expectRevert.unspecified(this.PlaceDeMarche.inscription(estOwner), {from: owner});
    });

    it("Test modifier adresse 0", async() => {
        let adresseNul = "0";
        expect(await this.PlaceDeMarche.inscription(adresseNul), {from: candidat});
    });

    it("Test modifier nestPasBan", async() => {
        let estBan = true;
        await expectRevert.unspecified(this.PlaceDeMarche.bannirUtilisateur(estBan), {from: candidat});
    });

    it("vérifie le modifier minRep de postuler", async() => {
        let rep = 0;
        await expectRevert.unspecified(this.PlaceDeMarche.postuler(rep), {from: candidat});
    });

    it("Vérifie le postulat", async() => {
        let demande = "0";
        await expectRevert.unspecified(this.PlaceDeMarche.postuler(demande), {from: candidat});
        // expect(await this.PlaceDeMarche.postuler(demande), {from: candidat}).to.not.be.equal(constants.ZERO_ADDRESS);
    });

    it("Test inscription", async () => {
        expect(await this.PlaceDeMarche.inscription(owner), { from: owner }.to.be.true);
        
    });
});

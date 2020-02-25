const { BN, expectEvent, expectRevert, constants } = require("@openzeppelin/test-helpers");
const { expect } = require("chai");

const PlaceDeMarche = artifacts.require("PlaceDeMarche");

contract("PlaceDeMarche", accounts => {
    const owner = accounts[0];
    const candidat = accounts[1];
    const candidat2 = accounts[2];
    const illustrateur = accounts[3];
    // const balance = new BN(1);
    //il faut placer un string ici
    const rem = new BN("100");
    const secs = new BN("1546546132");
    const desc = "Description de la misson";
    const minRep = new BN("3");
    const minRep2 = new BN("1");
    // const etat = { OUVERTE:"OUVERTE", ENCOURS:"ENCOURS", FERMEE:"FERMEE" };
    
    beforeEach( async() => {
        this.PlaceDeMarche = await PlaceDeMarche.new({from: owner});
        await this.PlaceDeMarche.inscription(candidat, {from: candidat});
        await this.PlaceDeMarche.ajouterDemande(rem, secs, desc, minRep, {from: candidat, value: new BN("102")});
    });

    // it("Test modifier admin", async() => {
        //     await this.PlaceDeMarche.inscription(owner, {from: owner});
        //     expect(await this.PlaceDeMarche.postuler(owner)).to.be.equal(owner);
    // });
    
    it("test modifier adresse 0", async() => {
        let adresseNul = "0";
        expect(await this.PlaceDeMarche.inscription(adresseNul), {from: candidat});
    });

    
    it("test le post", async() => {
        let demande = "0";
        await expectRevert.unspecified(this.PlaceDeMarche.postuler(demande), {from: candidat});
    });
    
    it("test l'inscription", async() => {
        await expectRevert.unspecified(this.PlaceDeMarche.inscription(candidat, {from: candidat}));
    });
    
    // 1 await expectrevert pour le require
    it("test l'ajout de nouvelle demande", async() => {
        await expectRevert(this.PlaceDeMarche.ajouterDemande(rem, secs, desc, minRep, {from: candidat, value: new BN("100")}), "Déposer la rémunération en ajoutant 2% de frais pour la plateforme.");
    });
    
    it("test de l'event de demande postée", async() => {
        const ajouterDemande = await this.PlaceDeMarche.ajouterDemande(rem, secs, desc, minRep, {from: candidat, value: new BN("102")});
        expectEvent(ajouterDemande, "DemandePostee", {remuneration:rem, timer:secs, description:desc, minReputationRequis:minRep});
    });
    
    it("test nouvelle demande ajout et test du tableau demandes", async() => {
        // const lengthBefore = (await this.placeDeMarche.listerDemande()).length
        await this.PlaceDeMarche.ajouterDemande(rem,secs,desc,minRep, {from:candidat, value: new BN("102")});
        expect(await this.PlaceDeMarche.listerDemandes()).to.have.lengthOf(2);
    });

    it("test postuler pour une offre", async() => {
        await expectRevert.unspecified(this.PlaceDeMarche.postuler(0, {from: candidat}));
    }); //marche tant que le require est commenté il faudra gèrer le require avec Etat.OUVERTE

    it("test de l'event a postulé", async() => {
        const demande = await this.PlaceDeMarche.ajouterDemande(rem, secs, desc, minRep2, {from: candidat, value: new BN("102")});
        const postuler = await this.PlaceDeMarche.postuler(1, {from: candidat});
        expectEvent(postuler, "APostule", {candidat:{from:candidat}, demande:demande});
    });

    it("test accepter une offre", async() => {
        await expectRevert.unspecified(this.PlaceDeMarche.accepterOffre(0, candidat));
    });

    it("test la production de hash", async() => {
        let url = "test de hash";
        expect(await this.PlaceDeMarche.produireHash(url));
    });

    it("test de la livraison", async() => {
        let bytes32 = "0x000000000000";
        await expectRevert.unspecified(this.PlaceDeMarche.livraison(0, bytes32));
    });

    it("test de retrait", async() => {
        await expectRevert.unspecified(this.PlaceDeMarche.retrait(0,{from: candidat}));
        expect(await this.PlaceDeMarche.retrait);
    });// il faut aussi gérer les requires !

    it("test de l'event tranfer", async() => {
        const retrait = await expectRevert.unspecified(this.PlaceDeMarche.retrait(0,{from: candidat}));
        expectEvent(retrait, "Transfer", {receveur:{from:candidat}, montant:rem});
    });

    it("test le modifier minRep pour postuler", async() => {
        let rep = 0;
        await expectRevert.unspecified(this.PlaceDeMarche.postuler(rep), {from: candidat});
    });
    
    it("test le modifier n'est pas ban", async () => {
        await this.PlaceDeMarche.bannirUtilisateur(candidat);
        expectRevert(this.PlaceDeMarche.testModifiers(),"Vous avez été banni.");
    });
    
    // it("Test Modifier address n'Est pas 0", async () => {
        // await expectRevert(this.PlaceDeMarche.testModifiers({from: constants.ZERO_ADDRESS}),"testr votre adresse.");
    // }); ===> ganache UI explose
    
});

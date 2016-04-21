#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: Developpeur
#------------------------------------------------------------

CREATE TABLE Developpeur(
        n_developpeur Int NOT NULL PRIMARY KEY AUTO_INCREMENT,
        Dnom          Varchar (25) ,
        Dpays         Varchar (25)
);


#------------------------------------------------------------
# Table: Editeur
#------------------------------------------------------------

CREATE TABLE Editeur(
        n_editeur Int NOT NULL PRIMARY KEY AUTO_INCREMENT,
        Enom      Varchar (25) ,
        Epays     Varchar (25)
);


#------------------------------------------------------------
# Table: Produit
#------------------------------------------------------------

CREATE TABLE Produit(
        n_produit   Int NOT NULL PRIMARY KEY AUTO_INCREMENT,
        date_sortie Date ,
        nb_ventes   Int
);


#------------------------------------------------------------
# Table: Jeu
#------------------------------------------------------------

CREATE TABLE Jeu(
        n_jeu         Int NOT NULL PRIMARY KEY AUTO_INCREMENT,
        n_developpeur Int ,
		n_editeur     Int ,
        n_produit     Int ,
		nom           Varchar (25) NOT NULL,
        serie         Varchar (25) ,
        genre         Varchar (25) ,
		CONSTRAINT fk_jeu_developpeur FOREIGN KEY (n_developpeur) REFERENCES Developpeur(n_developpeur),
		CONSTRAINT fk_jeu_editeur FOREIGN KEY (n_editeur) REFERENCES Editeur(n_editeur),
		CONSTRAINT fk_jeu_produit FOREIGN KEY (n_produit) REFERENCES Produit(n_produit)
);


#------------------------------------------------------------
# Table: Utilisateur
#------------------------------------------------------------

CREATE TABLE Utilisateur(
        n_utilisateur int (11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
        surnom        Varchar (25) UNIQUE,
        nomU          Varchar (30) ,
        prenomU       Varchar (25) ,
        email         Varchar (40) UNIQUE,
		dateCreation  DATETIME DEFAULT CURRENT_TIMESTAMP
);


#------------------------------------------------------------
# Table: Noter
#------------------------------------------------------------

CREATE TABLE Noter(
        note          Int ,
        avis          Varchar (500) ,
        n_utilisateur Int NOT NULL ,
        n_jeu         Int NOT NULL ,
        CONSTRAINT pk_noter PRIMARY KEY (n_utilisateur ,n_jeu ),
		CONSTRAINT fk_jeu FOREIGN KEY (n_jeu) REFERENCES Jeu(n_jeu),
		CONSTRAINT fk_utilisateur FOREIGN KEY (n_utilisateur) REFERENCES Utilisateur(n_utilisateur)
);

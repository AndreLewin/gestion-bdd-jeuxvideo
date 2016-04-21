# On commence par supprimer le contenu des tables non référencées

DELETE FROM `Noter`;

DELETE FROM `Jeu`;

DELETE FROM `Utilisateur`; 
DELETE FROM `Developpeur`; 
DELETE FROM `Editeur`; 
DELETE FROM `Produit`;

# On met les auto_increment à 1 pour prévoir une nouvelle insertion

ALTER TABLE `Noter` AUTO_INCREMENT = 1;
ALTER TABLE `Jeu` AUTO_INCREMENT = 1;
ALTER TABLE `Utilisateur` AUTO_INCREMENT = 1;
ALTER TABLE `Developpeur` AUTO_INCREMENT = 1;
ALTER TABLE `Editeur` AUTO_INCREMENT = 1;
ALTER TABLE `Produit` AUTO_INCREMENT = 1;
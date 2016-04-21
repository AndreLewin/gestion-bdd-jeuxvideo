#	Ajouter un utilisateur

INSERT INTO utilisateur(surnom, nomU, prenomU, email) VALUES ('pseud', 'nom', 'prenom', 'mail');

#	Supprimer un utilisateur (par le utilisateur ou un administrateur)

DELETE
FROM utilisateur
WHERE surnom = SURNOM -- commande généralisée, à remplacer SURNOM par un surnom existant dans la bdd

#	Donner une note et un commentaire (commande SQL généralisé, à mettre en pratique lors de la deuxième partie du projet) ICI sous forme de jeu d''essais

INSERT INTO noter VALUES(12, 'iciavisiciavisiciavis', 1, 3);
INSERT INTO noter VALUES(7, 'iciavisiciavisiciavis', 1, 5);
INSERT INTO noter VALUES(15, 'iciavisiciavisiciavis', 1, 9);
INSERT INTO noter VALUES(20, 'iciavisiciavisiciavis', 1, 20);
INSERT INTO noter VALUES(3, 'iciavisiciavisiciavis', 1, 7);
INSERT INTO noter VALUES(12, 'iciavisiciavisiciavis', 4, 20); -- il faut avoir effectuer le jeu d''essai ci-dessus en entier pour que le 4 correspond bien à l'utilisateur qui existe
INSERT INTO noter VALUES(11, 'iciavisiciavisiciavis', 4, 3);
INSERT INTO noter VALUES(10, 'iciavisiciavisiciavis', 4, 5);
INSERT INTO noter VALUES(13, 'iciavisiciavisiciavis', 4, 9);
INSERT INTO noter VALUES(8, 'iciavisiciavisiciavis', 4, 7);
INSERT INTO noter VALUES(10, 'iciavisiciavisiciavis', 4, 10);
INSERT INTO noter VALUES(11, 'iciavisiciavisiciavis', 4, 11);


#	DES UPDATES (par rapport aux classement, par rapport aux données utilisateurs...)

	#Changer son surnom (commande peut être appliqué pour tout autre attribut)
	
	UPDATE utilisateur
	SET surnom = ‘test2’
	WHERE surnom = ‘test’

	#Mettre à jour les ventes d’un jeu (générale, ici avec l’exemple de World of Warcraft)
	
	UPDATE produit
	SET nb_ventes = 15000000 -- 15 millions
	WHERE n_produit = (SELECT n_produit FROM jeu WHERE nom = 'World of Warcraft')

#	Un admin qui réinitialise les notes et les avis

DELETE FROM `Noter`;

#	Un admin qui supprime la base de donnée (vider tous les tableaux et garder la structure)

	#	Executer le script vider.sql

## Obtenir une/des information(s) précise(s) 

#	Jeu le plus vendu

SELECT nom, nb_ventes AS 'Nombre de ventes'
FROM jeu NATURAL JOIN produit
	WHERE nb_ventes IN (
		SELECT MAX(nb_ventes)
		FROM produit
		)

#	Moyenne des ventes parmis les vingt jeux enregistrés

SELECT AVG(nb_ventes) AS 'Moyenne des ventes'
FROM produit

#	Jeux qui ne ont pas de série

SELECT n_jeu, nom
FROM jeu
WHERE serie IS NULL

#	Jeux qui ont une série, avec nom de la série

SELECT n_jeu, nom, serie
FROM jeu
WHERE serie IS NOT NULL
	
#    Moyenne des notes (pour tous les jeux) parmis les vingt jeux enregistrés

SELECT AVG(`Note moyenne des utilisateurs`) AS `Moyenne des notes`
FROM (SELECT n_jeu, AVG(note) AS `Note moyenne des utilisateurs`
   		FROM jeu NATURAL JOIN noter
   		GROUP BY n_jeu) sr0
  	FROM jeu NATURAL JOIN noter

#   Note moyenne du TOP 10 associé au nombre de ventes, affiché par ordre décroissant

SELECT nom, nb_ventes, AVG(note) AS `Note moyenne`
FROM noter NATURAL JOIN jeu NATURAL JOIN produit
GROUP BY nom, nb_ventes
ORDER BY nb_ventes DESC
LIMIT 10
    
#    Jeux qui ont plus ou 14 de moyenne par les utilisateurs considérés comme les plus populaires, affiché par ordre décroissant

SELECT n_jeu, nom, AVG(note) AS `Note moyenne`
FROM jeu NATURAL JOIN noter
GROUP BY n_jeu, nom
HAVING AVG(note) >= 14
ORDER BY AVG(note) DESC

#    Voir toutes les notes et avis pour un jeu (exemple : 'RollerCoaster Tycoon')

SELECT n_jeu, nom, avis, note, n_utilisateur, surnom
FROM jeu NATURAL JOIN noter NATURAL JOIN utilisateur
WHERE nom = 'RollerCoaster Tycoon'
    
#    Nombre de utilisateurs enregistrés

SELECT COUNT(n_utilisateur) AS `Nombre utilisateurs`
FROM utilisateur

#    Date depuis quand un utilisateur est inscrit (consulté par le utilisateur)

SELECT surnom, dateCreation AS `Adherent depuis`
FROM utilisateur

## Générer un classement selon les ventes (ordre décroissant)

#    Classement par jeu    

SELECT nom, nb_ventes AS `Nombre de ventes`
FROM jeu NATURAL JOIN produit
ORDER BY nb_ventes DESC

#    Classement selon total vendu par genre

SELECT genre, SUM(nb_ventes) AS `Nombre de ventes`
FROM jeu NATURAL JOIN produit
GROUP BY genre
ORDER BY SUM(nb_ventes) DESC

#    Classement selon total vendu par serie

SELECT serie, SUM(nb_ventes) AS `Nombre de ventes`
FROM jeu NATURAL JOIN produit
WHERE serie is not null
GROUP BY serie
ORDER BY SUM(nb_ventes) DESC

#    Classement selon total vendu par développeur

SELECT Dnom AS `Developpeur`, SUM(nb_ventes) AS `Nombre de ventes`
FROM jeu NATURAL JOIN developpeur NATURAL JOIN produit
   	GROUP BY Dnom
ORDER BY SUM(nb_ventes) DESC

#    Classement selon total vendu par éditeur

SELECT Enom AS `Editeur`, SUM(nb_ventes) AS `Nombre de ventes`
FROM jeu NATURAL JOIN editeur NATURAL JOIN produit
GROUP BY Enom
ORDER BY SUM(nb_ventes) DESC

#    Classement selon note moyenne des utilisateurs en regardant aussi le nombre de ventes pour avoir une information de comparaison

SELECT n_jeu, nom, AVG(note) AS `Note moyenne des utilisateurs`, nb_ventes AS `Nombre de ventes`
FROM jeu NATURAL JOIN noter NATURAL JOIN produit
GROUP BY n_jeu, nom, nb_ventes
ORDER BY AVG(note) DESC

## Appliquer des filtres sur les résultats précédents. Tout requête sur laquelle nous souhaiton appliqué un filtre peut être mis entre parenthèse.

#    Filtrer selon le nombre de résultats (top 3, 5, 10) (ex : 3)

SELECT *
FROM (requête) sr
LIMIT 3

#    Filtrer selon le nombre de ventes (ex : 10 000 000)
    
SELECT *
FROM (requête) sr
WHERE `Nombre de ventes` >= 1e7


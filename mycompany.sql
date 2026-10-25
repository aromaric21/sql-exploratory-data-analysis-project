CREATE TABLE produit(
produit_id INTEGER PRIMARY KEY,
nom_produit VARCHAR(255) UNIQUE,
category VARCHAR(50) NOT NULL,
prix NUMERIC(10, 2) CHECK(prix >= 0)
);

CREATE TABLE client(
client_id INTEGER PRIMARY KEY,
nom_client VARCHAR(255) NOT NULL,
email_client VARCHAR(255) CONSTRAINT CHECK(email_client LIKE '%@%'),
carte_fidelite BOOLEAN NOT NULL DEFAULT FALSE
);

-- Contrainte forte
CREATE TABLE client(
client_id INTEGER PRIMARY KEY,
nom_client VARCHAR(255) NOT NULL,
email_client VARCHAR(255) CONSTRAINT ck_email_arobase CHECK(email_client LIKE '%@%'),
carte_fidelite BOOLEAN NOT NULL DEFAULT FALSE
);

ALTER TABLE client ADD COLUMN carte_fidelite BOOLEAN NOT NULL DEFAULT FALSE;

CREATE TABLE commandes(
ligne_id SERIAL PRIMARY KEY,
commande_id INTEGER NOT NULL,
client_id INTEGER NOT NULL,
produit_id INTEGER NOT NULL,
quantite INT NOT NULL,
prix_total DECIMAL(10, 2) NOT NULL,
FOREIGN KEY(client_id) REFERENCES client(client_id),
FOREIGN KEY(produit_id) REFERENCES produit(produit_id)
);

INSERT INTO produit (produit_id, nom_produit, category, prix) VALUES
(501, 'Ordinateur Portable', 'Electronique', 899.99),
(502, 'Chaise de Bureau', 'Mobilier', 120.50),
(503, 'Stylo à Bille', 'Fournitures de bureau', 1.20),
(504, 'Cafetière', 'Electroménager', 45.00),
(505, 'Téléphone', 'Electronique', 650.75);

SELECT * FROM produit;

INSERT INTO client (email_client, client_id, carte_fidelite, nom_client) VALUES
('jean.dupont@email.com', 101, TRUE, 'Jean Dupont'),
('marie.martin@email.com', 102, FALSE, 'Marie Martin'),
('paul.lefevre@email.com', 103, TRUE, 'Paul Lefevre'),
('sophie.durand@email.com', 104, TRUE, 'ophie Durand'),
('luc.bernard@email.com', 105, TRUE, 'Luc Bernard')
RETURNING*;

INSERT INTO commandes(ligne_id, commande_id, client_id, produit_id, quantite, prix_total) VALUES
(4,2003,101,503,1,5.49);

INSERT INTO commandes(ligne_id, commande_id, client_id, produit_id, quantite, prix_total) VALUES
(1,2001,101,501,2,1799);

INSERT INTO commandes(ligne_id, commande_id, client_id, produit_id, quantite, prix_total) VALUES
(1,2001,101,501,2,1799),
(2,2001,101,502,1,120.50),
(3,2002,103,501,3,2699.97),
(4,2003,101,503,1,5.49),
(5,2004,104,504,5,1750.00)
RETURNING*;

SELECT * FROM commandes;

ALTER TABLE produit ADD COLUMN description VARCHAR(255);

UPDATE produit SET description = 'Description pour le produit 501' WHERE produit_id =501;
UPDATE produit SET description = 'Description pour le produit 502' WHERE produit_id =502;
UPDATE produit SET description = 'Description pour le produit 503' WHERE produit_id =503;
UPDATE produit SET description = 'Description pour le produit 504' WHERE produit_id =504;
UPDATE produit SET description = 'Description pour le produit 505' WHERE produit_id =505;

SELECT * FROM produit;

ALTER TABLE client DROP CONSTRAINT IF EXISTS ck_email_arobase;

ALTER TABLE client ALTER COLUMN email_client SET DEFAULT 'non comminiqué';

INSERT INTO client(client_id, nom_client, carte_fidelite)
VALUES(106, 'François Petit', TRUE);

SELECT * FROM client;

UPDATE commandes SET prix_total = produit.prix * commandes.quantite
FROM produit
WHERE commandes.produit_id = produit.produit_id;

-- On souhaite créer une nouvelle colonne « Premium » dans la table « Produit ».
-- Si le produit a un prix supérieur à 200 €, alors la colonne prendra pour valeur « True ».
-- Sinon la valeur sera à « False » (valeur par défaut)
ALTER TABLE produit ADD COLUMN premium BOOLEAN NOT NULL DEFAULT FALSE;
UPDATE produit SET premium = TRUE WHERE prix > 200;

UPDATE produit
SET premium = CASE
                  WHEN prix > 200 THEN TRUE
                  ELSE FALSE
              END;

SELECT *
FROM produit
ORDER BY prix DESC;
--Une erreur s’est glissé dans les commandes. Vous devez supprimez toutes les références à la commande « 2001 » dans la table « commandes »
SELECT * FROM commandes;
DELETE FROM commandes WHERE commande_id = 2001;
--On souhaite créer une nouvelle colonne « VIP » dans la table « Client ».
--Si la client a acheté pour plus de 1000 € de produits, alors VIP doit être égal à True. Sinon, VIP est égal à False (valeur par défaut).
SELECT * FROM client;
SELECT * FROM produit;
SELECT * FROM commandes;

SELECT client_id
FROM commandes 
GROUP BY client_id
HAVING SUM(prix_total) > 1000;

ALTER TABLE client ADD COLUMN VIP BOOLEAN NOT NULL DEFAULT FALSE;

UPDATE client
SET VIP = TRUE
WHERE client_id IN(
   SELECT client_id
   FROM commandes 
   GROUP BY client_id
   HAVING SUM(prix_total) > 1000
);

-- Les expressions régulières(Regex)
SELECT *
FROM produit
WHERE nom_produit ~'^i';

SELECT *
FROM produit
WHERE nom_produit ~'^[AEIOUaeiou]';

SELECT *
FROM produit
WHERE nom_produit ~'^(i|v)';

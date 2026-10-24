-- Trouvez les clients ayant pour id de territoire 1, 2 ou 3, via la table  Sales.Customer
SELECT *
FROM Sales.customer
WHERE territoryid IN (1, 2, 3);

-- Trouvez les clients ayant pour id de territoire une valeur qui n'est pas entre 1 et 5 via la table  Sales.Customer
SELECT *
FROM Sales.customer
WHERE NOT (territoryid >=1 AND territoryid <=5);

SELECT *
FROM Sales.customer
WHERE territoryid <1 OR territoryid >5;

-- Trouvez les clients ayant pour id de territoire une valeur qui n'est pas entre 1 et 5 
-- et dont le store id est 942, 1022 ou 1340  via la table  Sales.Customer
SELECT *
FROM Sales.customer
WHERE NOT (territoryid >=1 AND territoryid <=5) AND storeid IN (942, 1022, 1340);

-- Clause LIKE
SELECT *
FROM production.product
WHERE name LIKE 'Road%';

SELECT *
FROM production.product
WHERE name LIKE '__a%';

SELECT *
FROM production.product
WHERE name LIKE '_a%' AND name LIKE '%e';

SELECT *
FROM production.product
WHERE name LIKE '_a%e';

SELECT *
FROM production.product
WHERE name ILIKE '%road%';

-- Écrivez une requête pour trouver tous les employés de la table person.person dont le prénom commence par 'J'.
SELECT *
FROM person.person
WHERE firstname LIKE 'J%';

-- Écrivez une requête pour trouver tous les employés de la table person.person dont le deuxième caractère du prénom est 'a'.
SELECT *
FROM person.person
WHERE firstname LIKE '_a%';
-- Écrivez une requête pour trouver tous les employés de la table person.person dont le deuxième caractère du prénom est 'a' et qui se terminent par 'n'.
SELECT *
FROM person.person
WHERE firstname LIKE '_a%n';
-- Écrivez une requête pour trouver tous les employés de la table person.person dont le prénom contient 'jo', indépendamment de la casse.
SELECT *
FROM person.person
WHERE firstname ILIKE '%jo%';

-- Les clause ORDER BY et LIMIT
SELECT *
FROM production.product
ORDER BY listprice ASC
LIMIT 10;

SELECT *
FROM production.product
ORDER BY listprice DESC
LIMIT 5;

SELECT productID, name, productsubcategoryID, listprice
FROM production.product
ORDER BY productsubcategoryid, listprice DESC
LIMIT 100 OFFSET 5;

-- Sélectionnez les 10 premiers employés embauchés en utilisant la table 'humanresources.employee'.
SELECT *
FROM humanresources.employee
LIMIT 10;

SELECT *
FROM humanresources.employee
ORDER BY hiredate ASC
LIMIT 10;
-- Sélectionnez les 5 derniers employés embauchés en utilisant la table 'humanresources.employee'.
SELECT *
FROM humanresources.employee
ORDER BY businessentityid DESC
LIMIT 5;
-- Sélectionnez les 100 employés, classés par jobtitle, puis par date d'arrivée, avec la table 'humanresources.employee'.
SELECT *
FROM humanresources.employee
ORDER BY jobtitle, hiredate ASC
LIMIT 100;

SELECT *
FROM humanresources.employee
ORDER BY jobtitle, hiredate
LIMIT 100;
-- Sélectionnez les 10 employés, classés par jobtitle, puis par date d'arrivée, avec la table 'humanresources.employee', et isoler les lignes 10 à 20
SELECT *
FROM humanresources.employee;

SELECT *
FROM humanresources.employee
ORDER BY jobtitle ASC, hiredate ASC
LIMIT 10 OFFSET 10;

SELECT *
FROM humanresources.employee
ORDER BY jobtitle, hiredate
LIMIT 10 OFFSET 10;

-- Clause GROUP BY
SELECT Vendeur, MAX(Quantity), SUM(Quantity), AVG(Quantity)
FROM Ventes
GROUP BY Vendeur;

SELECT SalesPersonID, count(*) AS OrderCount
FROM Sales.salesorderHeader
GROUP BY SalesPersonID
ORDER BY OrderCount DESC;

SELECT SalesPersonID, count(*) AS OrderCount
FROM Sales.salesorderHeader
WHERE orderDate >= '2004-01-01' AND SalesPersonId IS NOT NULL
GROUP BY SalesPersonID
HAVING count(*) > 100
ORDER BY OrderCount;


SELECT productsubcategoryid, AVG(listPrice) AS AvGPrice,
MAX(listPrice) AS MaxPrice,
MIN(listPrice) AS MinPrice
FROM production.product
GROUP BY productsubcategoryid
ORDER BY AvGPrice DESC;

SELECT productsubcategoryid, productmodelid, COUNT(*) AS productcount
FROM production.product
GROUP BY productsubcategoryid, productmodelid
ORDER BY productCount DESC;

-- Combien de produits y a-t-il dans chaque sous-catégorie ?
-- Comptez le nombre de produits pour chaque sous-catégorie dans la table Production.Product
SELECT *
FROM Production.Product; 

SELECT productsubcategoryid, COUNT(*) AS subcategorycount 
FROM Production.Product
GROUP BY productsubcategoryid;

SELECT productsubcategoryid, COUNT(ProductID) AS subcategorycount 
FROM Production.Product
GROUP BY productsubcategoryid;

SELECT productsubcategoryid, COUNT(ProductID) AS subcategorycount 
FROM Production.Product
GROUP BY productsubcategoryid
ORDER BY subcategorycount DESC;

-- Quel est le poids minimum, maximum et moyen des produits pour chaque sous-catégorie ?
-- Trouver le poids (weigth) minimum, maximum et moyen des produits pour chaque catégorie dans la table Production.Product.
SELECT productsubcategoryid,
MIN(weight) AS MinWeight,
MAX(weight) AS MaxWeight,
AVG(weight) AS AvgWeight
FROM Production.Product
WHERE weight IS NOT NULL AND productsubcategoryid IS NOT NULL
GROUP BY productsubcategoryid;

-- Combien de produits y a-t-il pour chaque combinaison de model (productmodelid) et de coleur (color) ?
SELECT productmodelid, color, COUNT(*) AS productmodelcount, COUNT(*) AS colorcount
FROM Production.Product
GROUP BY productmodelid, color;

-- Quelles sous-catégories (ProductsubCategoryID) de produits ont plus de 10 produits (ProductID) ?
SELECT productsubcategoryid, COUNT(*) AS productsubcategorycount
FROM Production.Product
WHERE productsubcategoryid IS NOT NULL
GROUP BY productsubcategoryid
HAVING COUNT(*) > 10; 

SELECT productsubcategoryid, COUNT(ProductID) AS productsubcategorycount
FROM Production.Product
WHERE productsubcategoryid IS NOT NULL
GROUP BY productsubcategoryid
HAVING COUNT(ProductID) > 10;

SELECT productsubcategoryid, COUNT(ProductID) AS productsubcategorycount
FROM Production.Product
WHERE productsubcategoryid IS NOT NULL
GROUP BY productsubcategoryid
HAVING COUNT(*) > 10
ORDER BY productsubcategorycount DESC;

-- Quelles sous-catégories (ProductsubCategoryID) de produits ont plus de 10 produits (ProductID) dont le prix (listprice) est supérieur à 100$?
SELECT productsubcategoryid, COUNT(*) AS productsubcategorycount
FROM Production.Product
WHERE listprice > 100
GROUP BY productsubcategoryid
HAVING COUNT(*) > 10
ORDER BY productsubcategorycount DESC; 

SELECT productsubcategoryid, COUNT(ProductID) AS productsubcategorycount
FROM Production.Product
WHERE productsubcategoryid IS NOT NULL AND listprice > 100
GROUP BY productsubcategoryid
HAVING COUNT(ProductID) > 10
ORDER BY productsubcategorycount DESC; 

-- Expression conditionnelle
-- Les JOINTURES : INNER JOIN, LEFT/RIGHT JOIN et OUTER JOIN

-- Les JOINTURES : INNER JOIN 
SELECT * FROM production.product;
SELECT * FROM production.productinventory;

SELECT p.productID AS productID, p.name AS productName, c.name AS categoryName
FROM production.product AS p
INNER JOIN production.productModel AS c
ON p.productmodelID = c.productmodelID;

SELECT p.name, i.quantity
FROM production.product AS p
INNER JOIN production.productinventory AS i
ON p.productID = i.productID;

SELECT p.name AS productName, SUM(i.quantity) AS quantity
FROM production.product AS p
INNER JOIN production.productinventory AS i
ON p.productID = i.productID
GROUP BY p.name
ORDER BY quantity DESC;

SELECT m.name AS modelName, SUM(i.quantity) AS quantity
FROM production.product AS p
INNER JOIN production.productinventory AS i
ON p.productID = i.productID
INNER JOIN production.productModel AS m
ON p.productmodelID = m.productmodelID
GROUP BY m.name
ORDER BY quantity DESC;

/* Instructions :
Consultez les tables sales.customer et sales.store et indentifiez la clé de jointure possible
Utilisez une jointure interne (INNER JOIN) pour inclure uniquement les magasins ayant des clients.
Choisir la colonne name de la table sales.store et la renommer en storeName.
Compter le nombre de clients (customerid) pour chaque magasin en utilisant la fonction
d'agrégation count avec GROUP BY et renommer cette colonne  "NumClients"
Triez les résultats par NumClients dans l'ordre décroissant en utilisant ORDER BY.
Quelle requête obtenez vous ? */
SELECT * FROM sales.customer;
SELECT * FROM sales.store;
SELECT * FROM sales.salesperson;

SELECT s.name AS storeName, COUNT(c.customerid) AS NumClient
FROM sales.customer AS c
INNER JOIN sales.store AS s
ON s.businessentityid = s.businessentityid
GROUP BY s.name
ORDER BY NumClient DESC;

SELECT s.name AS storeName, COUNT(c.customerid) AS NumClient
FROM sales.customer AS c
INNER JOIN sales.store AS s
ON c.storeid = s.businessentityid
GROUP BY storeName
ORDER BY NumClient DESC;

-- Les JOINTURES : LEFT/RIGHT JOIN et OUTER JOIN 
-- Quantité de produit vendus: By LEFT JOIN
SELECT p.name AS productName, s.orderqty AS salesQuantity
FROM production.product AS p
LEFT JOIN Sales.Salesorderdetail AS s
ON p.productID = s.productID
LIMIT 100;

-- Suite
SELECT p.name AS productName, COALESCE(SUM(s.orderqty), 0) AS salesQuantity
FROM production.product AS p
LEFT JOIN Sales.Salesorderdetail AS s
ON p.productID = s.productID
GROUP BY productName
ORDER BY salesQuantity DESC
LIMIT 100;

-- By RIGHT JOIN
SELECT p.name AS productName, COALESCE(SUM(s.orderqty), 0) AS salesQuantity
FROM production.product AS p
RIGHT JOIN Sales.Salesorderdetail AS s
ON p.productID = s.productID
GROUP BY productName
ORDER BY salesQuantity DESC
LIMIT 100;

-- OUTER JOIN:
SELECT p.productID AS productName, s.salesorderID AS idCommande
FROM production.product AS p
FULL JOIN Sales.Salesorderdetail AS s
ON p.productID = s.productID
LIMIT 10;

SELECT p.productID AS productName, s.salesorderID AS idCommande
FROM production.product AS p
FULL JOIN Sales.Salesorderdetail AS s
ON p.productID = s.productID
LIMIT 100;

-- Suite
SELECT
    SUM(CASE WHEN p.productID IS NULL THEN 1 ELSE 0 END) AS ventesSansReference,
	SUM(CASE WHEN s.salesorderID IS NULL THEN 1 ELSE 0 END) AS produitSansVente
FROM production.product AS p
FULL JOIN Sales.Salesorderdetail AS s
ON p.productID = s.productID;

/*
Notre but va être de calculer le nombre de ventes réalisées via une offre spéciale, pour chaque produits.
Un produit est vendu sous offre quand son id d'offre (offerid) est différent de "1", dans la table Sales.Salesorderdetail.
Questions pour cet exercice
- Analysez les tables Sales.Salesorderdetail et production.product et repérez la clé de jointure
- Utilisez une jointure externe (celle vous semblant la plus adéquate) pour inclure tous les produits.
- Choisir la colonne name et la renommer en productName
- Sommez les quantités vendues (orderqty) et remplacer les valeurs NULL par zéro en utilisant COALESCE et via GROUP BY
- Sommez la quantité vendue uniquement si specialofferid n'est pas égal à 1 en utilisant la clause CASE.
- Triez les résultats par quantité vendue dans l'ordre décroissant en utilisant ORDER BY.
- Limitez le nombre de lignes dans le résultat à 100 en utilisant LIMIT.
Quelle requête obtenez vous?
*/
SELECT * FROM Sales.Salesorderdetail;
SELECT * FROM production.product;

SELECT p.name AS productName,
       COALESCE(
	         SUM(
               CASE
			       WHEN s.specialofferid <> 1 THEN s.orderqty ELSE 0 END
				 ), 0
			    ) AS quantite_avec_offre
FROM production.product AS p
FULL JOIN  Sales.Salesorderdetail AS s
ON p.productID = s.productID
GROUP BY productName
ORDER BY quantite_avec_offre DESC
LIMIT 100;

SELECT p.name AS productName, COALESCE(SUM(s.orderqty),0) AS quantityvendue,
SUM(CASE WHEN s.specialofferid = 1 THEN 0 ELSE s.orderqty END) AS quantitevendueviaoffre
FROM Sales.Salesorderdetail AS s
RIGHT JOIN production.product AS p
ON p.productID = s.productID
GROUP BY productName
ORDER BY quantityvendue DESC
LIMIT 100;


SELECT *
FROM production.productcategory;

-- Via la table department du schema humanresources, trouvez le nombre de départements présents dans l'entreprise
SELECT *
FROM humanresources.department;
-- ou encore
SELECT
DISTINCT * 
FROM humanresources.department;

-- Via cette même table determinez le nombre de groupe de départements différents sont présents
SELECT DISTINCT groupname
FROM humanresources.department;

-- Affichez un tableau à une colonne avec les noms de categories de produits présents dans la table productcategory du schema production
SELECT name
FROM production.productcategory;

-- Affichez un tableau avec les différentes couleurs proposés par la sociétés pour ses produits, via la table product du schema production
SELECT DISTINCT color
FROM production.product;

-- Affichez les combinaison uniques de d'ID de sous-catégories avec les couleurs de produits, via la table product du schema production
SELECT DISTINCT productsubcategoryID, color
FROM production.product;
-- ou encore
SELECT DISTINCT 
productsubcategoryid,
color
FROM production.product;

-- Les filtres
SELECT *
FROM sales.salesperson
WHERE commissionpct = 0;

SELECT *
FROM production.product
WHERE listPrice >= 100;

SELECT *
FROM production.product
WHERE listPrice < 100;

SELECT name, productnumber
FROM production.product
WHERE listPrice >= 100;

SELECT *
FROM humanresources.employee
WHERE sickleavehours > 60;

SELECT loginid, jobtitle
FROM humanresources.employee
WHERE sickleavehours > 60;

SELECT *
FROM Sales.salesperson
WHERE salesytd > saleslastyear;

SELECT *
FROM Sales.salesperson
WHERE saleslastyear < salesytd;

SELECT businessentityid
FROM Sales.salesperson
WHERE saleslastyear < salesytd;


SELECT *
FROM humanresources.employee
WHERE jobtitle = 'Sales Representative';

SELECT *
FROM production.product
WHERE color IS NULL;

SELECT *
FROM production.product
WHERE size IS NOT NULL;

-- 1. On souhaite prévenir les clients d'une boutique spécifique qu'elle va changer d'adresse.
-- Via la table Sales.Customer, isolez les clients reliés au store id 990
SELECT *
FROM Sales.customer;

SELECT *
FROM Sales.customer
WHERE storeid = 990;

SELECT *
FROM Sales.customer
WHERE storeid <> 990;

-- 2. On souhaite vérifier les informations d'un produit spécifique.
-- Via la table Production.Product, isolez les informations du produit ayant pour nom 'Adjustable Race'
SELECT *
FROM production.product
WHERE name = 'Adjustable Race';

-- 3. On souhaite  trouver les produits dont le prix d'achat est égal au prix de vente.
-- Écrivez une requête SQL pour sélectionner les produits de la table production.product dont le standardcost est égal au listprice
SELECT *
FROM production.product
WHERE safetystocklevel = listprice;

-- 4. On souhaite vérifier que le stock de sécurité est bien toujours supérieur au stock limite de commande.
-- Écrivez une requête SQL pour sélectionner les produits de la table production.product dont le safetystocklevel est inférieur au reorderpoint
SELECT *
FROM production.product
WHERE standardcost <  reorderpoint;

-- 5. on souhaite isoler les zones de ventes en dehors des USA
-- Écrivez une requête SQL pour sélectionner les zones de vente de la table Sales.Salesterritory dont le countryregioncode n'est pas égal à 'US'
SELECT *
FROM Sales.salesterritory
WHERE countryregioncode <> 'US';

SELECT *
FROM Sales.salesterritory
WHERE countryregioncode NOT IN ('US');

SELECT *
FROM Sales.salesterritory
WHERE countryregioncode IS DISTINCT FROM 'US';

-- 6. On souhaite vérifier que tous les produits ont bien un temps de manufacture indiqué
-- Écrivez une requête SQL pour sélectionner les produits de la table production.product dont le daystomanufacture est vide
SELECT *
FROM production.product
WHERE daystomanufacture = 0;

-- 7. On souhaite voir si le poids des produits est parfois indiqué.
-- Écrivez une requête SQL pour sélectionner les  produits de la table production.product, dont le weight n'est pas vide
SELECT *
FROM production.product
WHERE weight <> 0;

SELECT *
FROM production.product
WHERE weight IS NOT NULL;

-- Les filtres combinés
SELECT *
FROM production.product;

SELECT *
FROM production.product
WHERE (color='white' AND price > 80) OR (color='black' AND price > 70);

-- Création d'une base de données
CREATE DATABASE mycompany;
-- Suppression de la base de données creées
DROP DATABASE mycompany;

-- Les expressions régulières(Regex)
SELECT productName
FROM Products
WHERE pructName !~*'Bike';

--1. On souhaite préparer une petite phrase d’information sur les produits et leur modèle de référence pour le site internet d’AdventureWorks.
-- Vous devez faire une concaténation du productNumber et du Name de la table production.product pour obtenir la phrase suivante :
-- « Le produit #Name# correspond à la référence modèle #productNumber# »
--Le nom du produit et le modèle doivent avoir une majuscule à la première lettre.
SELECT * 
FROM production.product;
-- Requête avec l’opérateur ||
SELECT 
'Le produit ' || INITCAP(name) || ' correspond à la référence modèle ' || INITCAP(productNumber) AS Phrase
FROM production.product;

-- Avec CONCAT() (gère les NULL)
SELECT CONCAT('Le produit ', INITCAP(name), ' correspond à la référence modèle ', INITCAP(productnumber)) AS phrase
FROM production.product;

-- Avec FORMAT() (le plus lisible)
SELECT
    FORMAT('Le produit %s correspond à la référence modèle %s', name, productnumber) AS phrase
FROM production.product;

-- Avec gestion proprement les NULL avec ||
SELECT
    'Le produit ' || COALESCE(name, 'inconnu')
    || ' correspond à la référence modèle ' || COALESCE(productnumber, 'inconnue') AS phrase
FROM production.product;

--2. Les noms de certains produits ne sont pas bien compris. Vous devez remplacer les sous-chaines de caractères 
-- suivantes dans la colonne Name de la table production.product :
-- •« Helmet » par « bike helmet »
-- •« Sports Shorts » par « bike Short »
-- Via une Regex, filtrez finalement sur tous les produits contenant « Helmet » ou « Sports Shorts »
SELECT productid, name AS name_original,
       regexp_replace(
        regexp_replace(name, 'Sports Shorts', 'bike Short', 'g'),
        'Helmet', 'bike helmet', 'g'
    ) AS name_corrige
FROM production.product
WHERE name ~ '(Helmet|Sports Shorts)';

SELECT name,
REPLACE(REPLACE(name, 'Helmet', 'bike helmet'), 'Sports Shorts', 'bike Short') AS productNameModified
FROM production.product
WHERE name ~* 'Helmet|Sports Shorts';

-- On vous demande de vérifier la bonne conformité des adresses mails des clients de notre société « my_company ». Les adresses emails doivent respecter ces critères :
---Le prenom ne doit être composé que de caractères
--Un point « . » doit séparer le prénom et le nom
--Le nom ne doit être composé que de caractères
--Après le nom, l’expression doit contenir @email.com, puis se terminer
-- Ecrivez l’expression régulière permettant de filtrer sur les emails ne respectant pas ce pattern.
SELECT *
FROM my_company.customer
WHERE email !~ '^[A-Za-z]+\.[A-Za-z]+@email\.com$';

-- Faites en sorte de ne sélectionner qu’environ 20% des produits de manière aléatoire.
SELECT * FROM production.product;

SELECT * 
FROM production.product
WHERE random() < 0.2;

-- Affichez les colonnes name et priceList, avec un arrondis de priceList à une décimale après la virgule.
SELECT name, ROUND(listprice, 1) AS list_price_arroundi
FROM production.product
WHERE listprice > 0 AND random() < 0.2;

SELECT
    name,
    ROUND(listprice, 1) AS listprice_arrondi
FROM production.product
WHERE listprice > 0;

-- Les fonctions dates
SELECT 
    CURRENT_DATE AS "Date du jour",
	CURRENT_TIME AS "Heure actuelle",
	CURRENT_TIMESTAMP AS "Horodatage actuel",
	NOW() AS "Maintenant";

-- Difference entre deux dates ou horodatages
SELECT
   OrderDate,
   AGE(CURRENT_DATE, OrderDate) AS AgeOfPurchase
FROM Sales.SalesOrderHeader
LIMIT 10;

-- Extraction
SELECT
    OrderDate,
	EXTRACT(MONTH FROM OrderDate) AS Month,
	EXTRACT(DAY FROM OrderDate) AS DAY,
	EXTRACT(HOUR FROM OrderDate) AS Hour,
	EXTRACT(MINUTE FROM OrderDate) AS Minute
FROM Sales.SalesOrderHeader
LIMIT 10;
-- TO_DATE
SELECT
     TextuelDateOnly,
	 TO_DATE(TextuelDateOnly, 'YYYY-MM-DD') AS ConvertedDate
FROM FictiveTable
LIMIT 10;

-- JUSTIFY(*)
SELECT
    Duration,
	JUSTIFY_DAYS(Duration) AS DaysAdjusted,
	JUSTIFY_HOURS(Duration) AS HoursAdjusted,
	JUSTIFY_INTERVAL(Duration) AS FullyAdjusted
FROM Sales.ShipmentDurations	
LIMIT 10;

-- TO_CHAR(date/time, format)
SELECT
    OrderDate,
	TO_CHAR(OrderDate, 'DD/MM/YYYY') AS Format1,
	TO_CHAR(OrderDate, 'Month DD, YYYY') AS Format2,
	TO_CHAR(OrderDate, 'Day, DD-MM-YYYY') AS Format3
FROM Sales.SalesOrderHeader
LIMIT 10;

-- La colonne « Modifieddate » de la table salesorderheader contient le timestamp de la commande.
SELECT * FROM Sales.salesorderheader;
-- On souhaite pouvoir suivre l’évolution du volume de vente et du chiffre d’affaires par année et par mois :
-- 1)Créez 2 nouvelles colonnes, contenant l’année et le mois de la commande
SELECT * FROM Sales.SalesOrderHeader;

SELECT
     salesorderid,
	 EXTRACT(YEAR FROM modifieddate) AS annee,
	 EXTRACT(MONTH FROM modifieddate) AS mois
FROM sales.salesorderheader;
	 
-- 2)Réalisé un groupby sur les 2 colonnes pour obtenir le nombre de commandes (count) et le chiffre d’affaires ( via la colonne subtotal)
-- Faites un tri sur l’année et le mois pour obtenir les données de manière chronologique
-- La colonne « Modifieddate » de la table salesorderheader contient le timestamp de la commande.
-- On souhaite pouvoir afficher des informations au client sur ses achats dans son espace connecté. Pour chaque commande, nous avons besoin d’obtenir la phrase suivante :
-- « Cet achat a été réalisé le #nomJours# #jours# #nomMois# #Année# »
-- Exemple : Cet achat a été réalisé le mardi 3 juin 2015.
-- Si les jours et mois s’affichent en anglais, on omettra ce problème.
SELECT
	 EXTRACT(YEAR FROM modifieddate) AS annee,
	 EXTRACT(MONTH FROM modifieddate) AS mois,
	 COUNT(*)  AS nb_commande,
	 SUM(subtotal) AS chifre_affaire
FROM sales.salesorderheader
GROUP BY
       EXTRACT(YEAR FROM modifieddate),
	   EXTRACT(MONTH FROM modifieddate);

SELECT
    EXTRACT(YEAR  FROM modifieddate) AS annee,
    EXTRACT(MONTH FROM modifieddate) AS mois,
    COUNT(*)                         AS nb_commandes,
    ROUND(SUM(subtotal), 2)          AS chiffre_affaires
FROM sales.salesorderheader
GROUP BY annee, mois
ORDER BY annee, mois;

SELECT
    DATE_TRUNC('month', modifieddate)::date AS mois,
    COUNT(*)      AS nb_commandes,
    SUM(subtotal) AS chiffre_affaires
FROM sales.salesorderheader
GROUP BY 1
ORDER BY 1;

CASE EXTRACT(DOW FROM modifieddate)
    WHEN 0 THEN 'dimanche' WHEN 1 THEN 'lundi'    WHEN 2 THEN 'mardi'
    WHEN 3 THEN 'mercredi' WHEN 4 THEN 'jeudi'    WHEN 5 THEN 'vendredi'
    WHEN 6 THEN 'samedi'
END

SELECT
    salesorderid,
    'Cet achat a été réalisé le '
        || LOWER(TO_CHAR(modifieddate, 'FMDay'))   || ' '
        || EXTRACT(DAY FROM modifieddate)::int     || ' '
        || LOWER(TO_CHAR(modifieddate, 'FMMonth')) || ' '
        || EXTRACT(YEAR FROM modifieddate)::int    AS phrase
FROM sales.salesorderheader;
-- 3) A l’aide des colonnes sellstartdate et sellenddate de la table production.product,
-- calculez le temps durant lequel les produits ont été vendus.

-- Durée en jours (produits dont la vente est terminée)
SELECT * FROM production.product;
SELECT
    productid,
    name,
    sellstartdate,
    sellenddate,
    (sellenddate::date - sellstartdate::date) AS duree_jours
FROM production.product
WHERE sellenddate IS NOT NULL;

-- Durée en jours, mois, années (avec AGE)
SELECT
    productid,
    name,
    AGE(sellenddate, sellstartdate) AS duree
FROM production.product
WHERE sellenddate IS NOT NULL;

-- Produits encore en vente inclus
SELECT
    productid,
    name,
    sellstartdate,
    sellenddate,
    COALESCE(sellenddate, CURRENT_DATE)::date - sellstartdate::date AS duree_jours,
    CASE WHEN sellenddate IS NULL THEN 'En vente' ELSE 'Terminé' END AS statut
FROM production.product
ORDER BY duree_jours DESC;







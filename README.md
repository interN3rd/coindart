# coindart - Hit Bull's Eye With Your Next Trade
Dieses Softwareprojekt wurde erstellt im Rahmen des Moduls "Mobile Systeme", welches im Wintersemester 2021 / 2022 angeboten wurde in der Fachhochschule Kiel. Autoren des Softwareprojekts: Alexander Neumann und Pascal Groß. 

<b>Eine ausführliche Dokumentation des Projektes befindet sich in der Datei MOB-Semesterprojekt-Coindart.pdf</b>.

## Einführung
Die mobile App Coindart bietet ihren Nutzern wichtige Daten und Informationen über den Markt der Kryptowährungen. Der Benutzer erhält eine Übersicht über die meistgehandelten Kryptowährungen und kann das Marktgeschehen live mitverfolgen. Darüber hinaus kann der Benutzer sich in der App registrieren, anmelden und sich mit anderen Benutzern austauschen, um den nächsten gewinnbringen Trade zu planen.

## Technologie
Die App wird geschrieben in der Programmiersprache Dart. Als Entwicklungswerkzeug wird das Framework Flutter verwendet. Zudem werden diverse Bibliotheken eingebunden: unter anderem http und chart.

## Features
•	Die Hauptroute der App ist eine scrollbare Liste, die Daten über Kryptowährungen darstellt

•	Die Daten wiederum werden abgerufen über die CoinMarketCap-API (Webseite: https://coinmarketcap.com/api/ )

•	Der Benutzer kann einen Account registrieren mit einer E-Mail-Adresse und Passwort

•	Für ein einzelnes Listenelement gibt es eine Detailansicht, welche Informationen über die angeklickte Kryptowährung bereitstellt und den aktuellen Preischart als Candlediagramm

• Der Benutzer kann Kryptowährungen kaufen, verkaufen und die gehaltenen Kryptowährungen sowie sein verfügbares (imaginäres) Geld auf einer Profilseite einsehen

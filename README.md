##Pre spravne fungovanie aplikacie
1. Vytvorit v roote (/) zlozku "libs" + nastavit prava pre zapisovanie
2. Vytvorit v roote (/) zlozku "log" + nastavit prava pre zapisovanie
3. V zlozke /app najdete subor mysql_dump.sql. Spustite ho na svojej databaze.
4. V subore /app/config/config.neon upravte pristupove udaje do databazy

***

##Features
- nasadeny Twitter Bootstrap
- Nette upravene, aby nacitavalo templaty z priecinkov podla $_SERVER['HTTP_HOST']. Nastavenia v databaze.
- Staticke ACL (access control list) v konfiguracnom subore
- UserPresenter umoznuje:
 - Registraciu pouzivatelov
 - Aktivovanie pouzivatelskeho konta po overeni emailu
 - Obnovenie zabudnuteho hesla pomocou emailu
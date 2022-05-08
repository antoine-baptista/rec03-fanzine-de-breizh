#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: USERS
#------------------------------------------------------------

CREATE TABLE USERS(
        user_ID               Int  Auto_increment  NOT NULL ,
        user_nom              Varchar (60) NOT NULL ,
        user_prenom           Varchar (60) NOT NULL ,
        user_email            Varchar (180) NOT NULL ,
        user_password         Varchar (255) NOT NULL ,
        user_authentifie      Int ,
        user_role             Varchar (255) ,
        user_date_de_creation TimeStamp NOT NULL
	,CONSTRAINT USERS_PK PRIMARY KEY (user_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: CATEGORIES
#------------------------------------------------------------

CREATE TABLE CATEGORIES(
        categorie_ID               Int  Auto_increment  NOT NULL ,
        categorie_nom              Varchar (50) NOT NULL ,
        categorie_slug             Varchar (80) NOT NULL ,
        categorie_description      Varchar (255) ,
        categorie_date_de_creation TimeStamp NOT NULL
	,CONSTRAINT CATEGORIES_PK PRIMARY KEY (categorie_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: ARTICLES
#------------------------------------------------------------

CREATE TABLE ARTICLES(
        article_ID                  Int  Auto_increment  NOT NULL ,
        article_titre               Varchar (150) NOT NULL ,
        article_slug                Varchar (255) NOT NULL ,
        article_type_de_publication Varchar (20) NOT NULL ,
        article_contenu             Text NOT NULL ,
        article_url_photomedia      Varchar (255) ,
        article_date_de_publication TimeStamp NOT NULL ,
        user_ID                     Int NOT NULL ,
        categorie_ID                Int NOT NULL ,
        ville_id                    Mediumint NOT NULL
	,CONSTRAINT ARTICLES_PK PRIMARY KEY (article_ID)

	,CONSTRAINT ARTICLES_USERS_FK FOREIGN KEY (user_ID) REFERENCES USERS(user_ID)
	,CONSTRAINT ARTICLES_CATEGORIES0_FK FOREIGN KEY (categorie_ID) REFERENCES CATEGORIES(categorie_ID)
	,CONSTRAINT ARTICLES_VILLES1_FK FOREIGN KEY (ville_id) REFERENCES VILLES(ville_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: MESSAGES
#------------------------------------------------------------

CREATE TABLE MESSAGES(
        message_ID         Int  Auto_increment  NOT NULL ,
        message_contenu    Text NOT NULL ,
        message_date_envoi TimeStamp NOT NULL ,
        user_ID            Int NOT NULL
	,CONSTRAINT MESSAGES_PK PRIMARY KEY (message_ID)

	,CONSTRAINT MESSAGES_USERS_FK FOREIGN KEY (user_ID) REFERENCES USERS(user_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: REPONSES
#------------------------------------------------------------

CREATE TABLE REPONSES(
        reponse_ID         Int  Auto_increment  NOT NULL ,
        reponse_contenu    Text NOT NULL ,
        reponse_date_envoi TimeStamp NOT NULL ,
        user_ID            Int NOT NULL ,
        message_ID         Int NOT NULL
	,CONSTRAINT REPONSES_PK PRIMARY KEY (reponse_ID)

	,CONSTRAINT REPONSES_USERS_FK FOREIGN KEY (user_ID) REFERENCES USERS(user_ID)
	,CONSTRAINT REPONSES_MESSAGES0_FK FOREIGN KEY (message_ID) REFERENCES MESSAGES(message_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: TAGS
#------------------------------------------------------------

CREATE TABLE TAGS(
        tag                  Varchar (10) NOT NULL ,
        tag_ID               Int  Auto_increment  NOT NULL ,
        tag_date_de_creation TimeStamp NOT NULL
	,CONSTRAINT TAGS_PK PRIMARY KEY (tag)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: COMMENTER
#------------------------------------------------------------

CREATE TABLE COMMENTER(
        article_ID             Int NOT NULL ,
        user_ID                Int NOT NULL ,
        commentaire            Text NOT NULL ,
        commentaire_validation Bool ,
        commentaire_date       TimeStamp NOT NULL
	,CONSTRAINT COMMENTER_PK PRIMARY KEY (article_ID,user_ID)

	,CONSTRAINT COMMENTER_ARTICLES_FK FOREIGN KEY (article_ID) REFERENCES ARTICLES(article_ID)
	,CONSTRAINT COMMENTER_USERS0_FK FOREIGN KEY (user_ID) REFERENCES USERS(user_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: CONTENIR
#------------------------------------------------------------

CREATE TABLE CONTENIR(
        tag        Varchar (10) NOT NULL ,
        article_ID Int NOT NULL
	,CONSTRAINT CONTENIR_PK PRIMARY KEY (tag,article_ID)

	,CONSTRAINT CONTENIR_TAGS_FK FOREIGN KEY (tag) REFERENCES TAGS(tag)
	,CONSTRAINT CONTENIR_ARTICLES0_FK FOREIGN KEY (article_ID) REFERENCES ARTICLES(article_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: DEPARTEMENTS
#------------------------------------------------------------

CREATE TABLE DEPARTEMENTS(
        departement_id            Int NOT NULL ,
        departement_nom           Varchar (255) ,
        departement_nom_uppercase Varchar (255) ,
        departement_code          Varchar (3) ,
        departement_slug          Varchar (255) ,
        departement_nom_soundex   Varchar (20)
	,CONSTRAINT DEPARTEMENTS_Idx INDEX (departement_code,departement_slug,departement_nom_soundex)
	,CONSTRAINT DEPARTEMENTS_PK PRIMARY KEY (departement_id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: VILLES
#------------------------------------------------------------

CREATE TABLE VILLES(
        ville_id              Mediumint NOT NULL ,
        ville_commune         Varchar (3) ,
        ville_arrondissement  Smallint ,
        ville_canton          Varchar (4) ,
        ville_amdi            Smallint ,
        ville_population_1999 Mediumint ,
        ville_population_2012 Mediumint ,
        ville_densite_2010    Int ,
        ville_surface         Float ,
        ville_longitude_grd   Varchar (9) ,
        ville_latitude_grd    Varchar (8) ,
        ville_longitude_dms   Varchar (9) ,
        ville_latitude_dms    Varchar (8) ,
        ville_zmin            Mediumint ,
        ville_zmax            Mediumint ,
        ville_departement     Varchar (3) ,
        ville_slug            Varchar (255) ,
        ville_nom             Varchar (45) ,
        ville_nom_simple      Varchar (45) ,
        ville_nom_reel        Varchar (45) ,
        ville_nom_soundex     Varchar (20) ,
        ville_nom_metaphone   Varchar (22) ,
        ville_code_postal     Varchar (255) ,
        ville_code_commune    Varchar (5) NOT NULL ,
        ville_population_2010 Mediumint ,
        ville_longitude_deg   Float ,
        ville_latitude_deg    Float ,
        departement_id        Int NOT NULL
	,CONSTRAINT VILLES_Idx INDEX (ville_departement,ville_slug,ville_nom,ville_nom_simple,ville_nom_reel,ville_nom_soundex,ville_nom_metaphone,ville_code_postal,ville_code_commune,ville_population_2010,ville_longitude_deg,ville_latitude_deg)
	,CONSTRAINT VILLES_PK PRIMARY KEY (ville_id)

	,CONSTRAINT VILLES_DEPARTEMENTS_FK FOREIGN KEY (departement_id) REFERENCES DEPARTEMENTS(departement_id)
)ENGINE=InnoDB;

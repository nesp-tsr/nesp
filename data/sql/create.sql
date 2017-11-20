-- MySQL Script generated by MySQL Workbench
-- Mon Nov 20 21:23:13 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema nesp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unit` ;

CREATE TABLE IF NOT EXISTS `unit` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `search_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `search_type` ;

CREATE TABLE IF NOT EXISTS `search_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `source_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `source_type` ;

CREATE TABLE IF NOT EXISTS `source_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `source`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `source` ;

CREATE TABLE IF NOT EXISTS `source` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `source_type_id` INT NULL,
  `provider` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Source_SourceType_idx` (`source_type_id` ASC),
  CONSTRAINT `fk_Source_SourceType`
    FOREIGN KEY (`source_type_id`)
    REFERENCES `source_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t1_site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t1_site` ;

CREATE TABLE IF NOT EXISTS `t1_site` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `source_id` INT NULL,
  `name` VARCHAR(255) NULL,
  `search_type_id` INT NOT NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_T1Site_Source1_idx` (`source_id` ASC),
  INDEX `fk_T1Site_SearchType1_idx` (`search_type_id` ASC),
  CONSTRAINT `fk_T1Site_Source1`
    FOREIGN KEY (`source_id`)
    REFERENCES `source` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T1Site_SearchType1`
    FOREIGN KEY (`search_type_id`)
    REFERENCES `search_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `response_variable_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `response_variable_type` ;

CREATE TABLE IF NOT EXISTS `response_variable_type` (
  `id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t1_survey`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t1_survey` ;

CREATE TABLE IF NOT EXISTS `t1_survey` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `site_id` INT NOT NULL,
  `source_id` INT NOT NULL,
  `source_primary_key` VARCHAR(255) NOT NULL,
  `start_date_d` SMALLINT NULL,
  `start_date_m` SMALLINT NULL,
  `start_date_y` SMALLINT NOT NULL,
  `finish_date_d` SMALLINT NULL,
  `finish_date_m` SMALLINT NULL,
  `finish_date_y` SMALLINT NULL,
  `start_time` TIME NULL,
  `finish_time` TIME NULL,
  `duration_in_minutes` INT NULL,
  `area_in_m2` DOUBLE NULL,
  `length_in_km` DOUBLE NULL,
  `coords` POINT NULL,
  `location` TEXT NULL,
  `positional_accuracy_in_m` DOUBLE NULL,
  `comments` TEXT NULL,
  `response_variable_type_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_T1Survey_T1Site1_idx` (`site_id` ASC),
  INDEX `fk_T1Survey_Source1_idx` (`source_id` ASC),
  UNIQUE INDEX `source_primary_key_UNIQUE` (`source_primary_key` ASC),
  INDEX `fk_t1_survey_response_variable_type1_idx` (`response_variable_type_id` ASC),
  CONSTRAINT `fk_T1Survey_T1Site1`
    FOREIGN KEY (`site_id`)
    REFERENCES `t1_site` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T1Survey_Source1`
    FOREIGN KEY (`source_id`)
    REFERENCES `source` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t1_survey_response_variable_type1`
    FOREIGN KEY (`response_variable_type_id`)
    REFERENCES `response_variable_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taxon_level`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taxon_level` ;

CREATE TABLE IF NOT EXISTS `taxon_level` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taxon_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taxon_status` ;

CREATE TABLE IF NOT EXISTS `taxon_status` (
  `id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taxon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taxon` ;

CREATE TABLE IF NOT EXISTS `taxon` (
  `id` CHAR(6) NOT NULL,
  `ultrataxon` TINYINT(1) NOT NULL,
  `taxon_level_id` INT NOT NULL,
  `spno` SMALLINT NOT NULL,
  `common_name` VARCHAR(255) NOT NULL,
  `scientific_name` VARCHAR(255) NOT NULL,
  `family_common_name` VARCHAR(255) NULL,
  `family_scientific_name` VARCHAR(255) NULL,
  `order` VARCHAR(255) NULL,
  `population` VARCHAR(255) NULL,
  `aust_status_id` INT NULL,
  `epbc_status_id` INT NULL,
  `iucn_status_id` INT NULL,
  `bird_group` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Taxon_TaxonLevel1_idx` (`taxon_level_id` ASC),
  INDEX `fk_taxon_taxon_status1_idx` (`aust_status_id` ASC),
  INDEX `fk_taxon_taxon_status2_idx` (`epbc_status_id` ASC),
  INDEX `fk_taxon_taxon_status3_idx` (`iucn_status_id` ASC),
  CONSTRAINT `fk_Taxon_TaxonLevel1`
    FOREIGN KEY (`taxon_level_id`)
    REFERENCES `taxon_level` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxon_taxon_status1`
    FOREIGN KEY (`aust_status_id`)
    REFERENCES `taxon_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxon_taxon_status2`
    FOREIGN KEY (`epbc_status_id`)
    REFERENCES `taxon_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxon_taxon_status3`
    FOREIGN KEY (`iucn_status_id`)
    REFERENCES `taxon_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taxon_hybrid`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taxon_hybrid` ;

CREATE TABLE IF NOT EXISTS `taxon_hybrid` (
  `id` CHAR(12) NOT NULL COMMENT 'e.g. u123a.b.c',
  `taxon_id` CHAR(6) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_TaxonHybrid_Taxon1_idx` (`taxon_id` ASC),
  CONSTRAINT `fk_TaxonHybrid_Taxon1`
    FOREIGN KEY (`taxon_id`)
    REFERENCES `taxon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t1_sighting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t1_sighting` ;

CREATE TABLE IF NOT EXISTS `t1_sighting` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `survey_id` INT NOT NULL,
  `taxon_id` CHAR(6) NOT NULL,
  `count` DOUBLE NOT NULL,
  `unit_id` INT NOT NULL,
  `breeding` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_T1Sighting_T1Survey1_idx` (`survey_id` ASC),
  INDEX `fk_T1Sighting_Taxon1_idx` (`taxon_id` ASC),
  INDEX `fk_T1Sighting_Unit1_idx` (`unit_id` ASC),
  CONSTRAINT `fk_T1Sighting_T1Survey1`
    FOREIGN KEY (`survey_id`)
    REFERENCES `t1_survey` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T1Sighting_Taxon1`
    FOREIGN KEY (`taxon_id`)
    REFERENCES `taxon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T1Sighting_Unit1`
    FOREIGN KEY (`unit_id`)
    REFERENCES `unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `incidental_sighting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `incidental_sighting` ;

CREATE TABLE IF NOT EXISTS `incidental_sighting` (
  `taxon_id` CHAR(6) NOT NULL,
  `coords` POINT NULL,
  `date` DATE NULL,
  PRIMARY KEY (`taxon_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t2_site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t2_site` ;

CREATE TABLE IF NOT EXISTS `t2_site` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `source_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `search_type_id` INT NOT NULL,
  `geometry` MULTIPOLYGON NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_t2_site_search_type1_idx` (`search_type_id` ASC),
  INDEX `fk_t2_site_source1_idx` (`source_id` ASC),
  CONSTRAINT `fk_t2_site_search_type1`
    FOREIGN KEY (`search_type_id`)
    REFERENCES `search_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t2_site_source1`
    FOREIGN KEY (`source_id`)
    REFERENCES `source` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t2_survey`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t2_survey` ;

CREATE TABLE IF NOT EXISTS `t2_survey` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `site_id` INT NULL,
  `source_id` INT NOT NULL,
  `start_date_d` SMALLINT NULL,
  `start_date_m` SMALLINT NULL,
  `start_date_y` SMALLINT NOT NULL,
  `finish_date_d` SMALLINT NULL,
  `finish_date_m` SMALLINT NULL,
  `finish_date_y` SMALLINT NULL,
  `start_time` TIME NULL,
  `finish_time` TIME NULL,
  `duration_in_minutes` INT NULL,
  `area_in_m2` DOUBLE NULL,
  `length_in_km` DOUBLE NULL,
  `coords` POINT NULL,
  `location` TEXT NULL,
  `positional_accuracy_in_m` DOUBLE NULL,
  `comments` TEXT NULL,
  `search_type_id` INT NULL,
  `source_primary_key` VARCHAR(255) NOT NULL,
  `secondary_source_id` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_T1Survey_Source1_idx` (`source_id` ASC),
  INDEX `fk_T2Survey_SearchType1_idx` (`search_type_id` ASC),
  UNIQUE INDEX `source_primary_key_UNIQUE` (`source_primary_key` ASC),
  INDEX `fk_t2_survey_t2_site1_idx` (`site_id` ASC),
  CONSTRAINT `fk_T1Survey_Source10`
    FOREIGN KEY (`source_id`)
    REFERENCES `source` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T2Survey_SearchType1`
    FOREIGN KEY (`search_type_id`)
    REFERENCES `search_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t2_survey_t2_site1`
    FOREIGN KEY (`site_id`)
    REFERENCES `t2_site` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t2_survey_site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t2_survey_site` ;

CREATE TABLE IF NOT EXISTS `t2_survey_site` (
  `survey_id` INT NOT NULL,
  `site_id` INT NOT NULL,
  PRIMARY KEY (`survey_id`, `site_id`),
  INDEX `fk_T2SurveySite_T2Site1_idx` (`site_id` ASC),
  CONSTRAINT `fk_T2SurveySite_T2Survey1`
    FOREIGN KEY (`survey_id`)
    REFERENCES `t2_survey` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T2SurveySite_T2Site1`
    FOREIGN KEY (`site_id`)
    REFERENCES `t2_site` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t2_sighting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t2_sighting` ;

CREATE TABLE IF NOT EXISTS `t2_sighting` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `survey_id` INT NOT NULL,
  `taxon_id` CHAR(6) NOT NULL,
  `count` DOUBLE NULL,
  `unit_id` INT NULL,
  `breeding` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_T2Sighting_T2Survey1_idx` (`survey_id` ASC),
  INDEX `fk_T2Sighting_Unit1_idx` (`unit_id` ASC),
  INDEX `fk_T2Sighting_Taxon1_idx` (`taxon_id` ASC),
  CONSTRAINT `fk_T2Sighting_T2Survey1`
    FOREIGN KEY (`survey_id`)
    REFERENCES `t2_survey` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T2Sighting_Unit1`
    FOREIGN KEY (`unit_id`)
    REFERENCES `unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T2Sighting_Taxon1`
    FOREIGN KEY (`taxon_id`)
    REFERENCES `taxon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `range`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `range` ;

CREATE TABLE IF NOT EXISTS `range` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t2_ultrataxon_sighting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t2_ultrataxon_sighting` ;

CREATE TABLE IF NOT EXISTS `t2_ultrataxon_sighting` (
  `sighting_id` INT NOT NULL,
  `taxon_id` CHAR(6) NOT NULL,
  `range_id` INT NOT NULL,
  `generated_subspecies` TINYINT(1) NOT NULL,
  INDEX `fk_T2SightingRangeType_RangeType1_idx` (`range_id` ASC),
  PRIMARY KEY (`sighting_id`, `taxon_id`),
  INDEX `fk_T2ProcessedSighting_Taxon1_idx` (`taxon_id` ASC),
  CONSTRAINT `fk_T2SightingRangeType_RangeType1`
    FOREIGN KEY (`range_id`)
    REFERENCES `range` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T2ProcessedSighting_T2Sighting1`
    FOREIGN KEY (`sighting_id`)
    REFERENCES `t2_sighting` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_T2ProcessedSighting_Taxon1`
    FOREIGN KEY (`taxon_id`)
    REFERENCES `taxon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taxon_presence_alpha_hull`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taxon_presence_alpha_hull` ;

CREATE TABLE IF NOT EXISTS `taxon_presence_alpha_hull` (
  `taxon_id` CHAR(6) NOT NULL,
  `range_id` INT NOT NULL,
  `breeding_range_id` INT NULL,
  `geometry` GEOMETRY NOT NULL,
  INDEX `fk_taxon_presence_alpha_hull_range1_idx` (`range_id` ASC),
  CONSTRAINT `fk_taxon_presence_alpha_hull_taxon1`
    FOREIGN KEY (`taxon_id`)
    REFERENCES `taxon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxon_presence_alpha_hull_range1`
    FOREIGN KEY (`range_id`)
    REFERENCES `range` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t2_processed_survey`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t2_processed_survey` ;

CREATE TABLE IF NOT EXISTS `t2_processed_survey` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `site_id` INT NULL,
  `grid_id` INT NULL,
  `search_type_id` INT NULL,
  `start_date_y` SMALLINT NULL,
  `start_date_m` SMALLINT NULL,
  `experimental_design_type_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grid_cell`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grid_cell` ;

CREATE TABLE IF NOT EXISTS `grid_cell` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `x` DOUBLE NULL,
  `y` DOUBLE NULL,
  `grid_size_in_degrees` DOUBLE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `state` ;

CREATE TABLE IF NOT EXISTS `state` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `geometry` MULTIPOLYGON NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `geometry` MULTIPOLYGON NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `species_range`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `species_range` ;

CREATE TABLE IF NOT EXISTS `species_range` (
  `species_id` INT NOT NULL,
  PRIMARY KEY (`species_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taxon_range`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taxon_range` ;

CREATE TABLE IF NOT EXISTS `taxon_range` (
  `taxon_id` CHAR(6) NOT NULL,
  `range_id` INT NOT NULL,
  `breeding_range_id` INT NULL,
  `geometry` MULTIPOLYGON NOT NULL,
  INDEX `fk_taxon_range_range1_idx` (`range_id` ASC),
  INDEX `fk_taxon_range_range2_idx` (`breeding_range_id` ASC),
  INDEX `fk_taxon_range_taxon1_idx` (`taxon_id` ASC),
  CONSTRAINT `fk_taxon_range_range1`
    FOREIGN KEY (`range_id`)
    REFERENCES `range` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxon_range_range2`
    FOREIGN KEY (`breeding_range_id`)
    REFERENCES `range` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxon_range_taxon1`
    FOREIGN KEY (`taxon_id`)
    REFERENCES `taxon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taxon_range_subdiv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taxon_range_subdiv` ;

CREATE TABLE IF NOT EXISTS `taxon_range_subdiv` (
  `taxon_id` CHAR(6) NOT NULL,
  `range_id` INT NOT NULL,
  `breeding_range_id` INT NULL,
  `geometry` MULTIPOLYGON NOT NULL,
  INDEX `fk_taxon_range_range1_idx` (`range_id` ASC),
  INDEX `fk_taxon_range_range2_idx` (`breeding_range_id` ASC),
  INDEX `fk_taxon_range_taxon1_idx` (`taxon_id` ASC),
  CONSTRAINT `fk_taxon_range_range10`
    FOREIGN KEY (`range_id`)
    REFERENCES `range` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxon_range_range20`
    FOREIGN KEY (`breeding_range_id`)
    REFERENCES `range` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxon_range_taxon10`
    FOREIGN KEY (`taxon_id`)
    REFERENCES `taxon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taxon_presence_alpha_hull_subdiv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taxon_presence_alpha_hull_subdiv` ;

CREATE TABLE IF NOT EXISTS `taxon_presence_alpha_hull_subdiv` (
  `taxon_id` CHAR(6) NOT NULL,
  `range_id` INT NOT NULL,
  `breeding_range_id` INT NULL,
  `geometry` GEOMETRY NOT NULL,
  INDEX `fk_taxon_presence_alpha_hull_range1_idx` (`range_id` ASC),
  CONSTRAINT `fk_taxon_presence_alpha_hull_taxon10`
    FOREIGN KEY (`taxon_id`)
    REFERENCES `taxon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taxon_presence_alpha_hull_range10`
    FOREIGN KEY (`range_id`)
    REFERENCES `range` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `t2_processed_sighting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `t2_processed_sighting` ;

CREATE TABLE IF NOT EXISTS `t2_processed_sighting` (
  `survey_id` INT NOT NULL,
  `taxon_id` CHAR(6) NULL,
  `count` DOUBLE NULL,
  `pseudo_absence` TINYINT(1) NULL,
  PRIMARY KEY (`survey_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Placeholder table for view `species_presence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `species_presence` (`spno` INT, `coords` INT);

-- -----------------------------------------------------
-- View `species_presence`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `species_presence` ;
DROP TABLE IF EXISTS `species_presence`;
CREATE  OR REPLACE VIEW `species_presence` AS
SELECT spno, coords FROM t1_survey, t1_sighting, taxon WHERE survey_id = t1_survey.id AND taxon_id = taxon.id
UNION
SELECT spno, coords FROM t2_survey, t2_sighting, taxon WHERE survey_id = t2_survey.id AND taxon_id = taxon.id
UNION
SELECT spno, coords FROM incidental_sighting, taxon WHERE taxon_id = taxon.id;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `search_type`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `search_type` (`id`, `description`) VALUES (1, '2ha 20 minute search');

COMMIT;


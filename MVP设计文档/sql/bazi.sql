-- 用户
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR NOT NULL UNIQUE,
  email VARCHAR NOT NULL UNIQUE,
  password VARCHAR NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 国家
CREATE TABLE countries (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 省市地区
CREATE TABLE regions (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  parent_id INTEGER,
  lng NUMERIC,
  lat NUMERIC,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_parent_id
  FOREIGN KEY (parent_id)
  REFERENCES regions(id)
  ON DELETE NO ACTION
);


-- gender options
-- ('男', '女', '保密')

-- source options
-- ('熟人介绍', '名人年谱', '未知')

-- reliability options, reference: https://www.astro.com/astro-databank/Help:RR
-- ('AA', 'A', 'B', 'C', 'DD', 'X', 'XX')

-- 八字信息
CREATE TABLE infos (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  bazi_1 VARCHAR NOT NULL,
  bazi_2 VARCHAR NOT NULL,
  bazi_3 VARCHAR NOT NULL,
  bazi_4 VARCHAR NOT NULL,
  gender INTEGER NOT NULL,
  birth_country_id INTEGER NOT NULL,
  birth_region_1_id INTEGER,
  birth_region_2_id INTEGER,
  source INTEGER NOT NULL,
  reliability INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_birth_country_id
  FOREIGN KEY (birth_country_id)
  REFERENCES countries(id)
  ON DELETE NO ACTION,

  CONSTRAINT fk_birth_region_1_id
  FOREIGN KEY (birth_region_1_id)
  REFERENCES regions(id)
  ON DELETE NO ACTION,

  CONSTRAINT fk_birth_region_2_id
  FOREIGN KEY (birth_region_2_id)
  REFERENCES regions(id)
  ON DELETE NO ACTION
);

-- 八字案底
CREATE TABLE cases (
  id SERIAL PRIMARY KEY,
  info_id INTEGER,
  marrige VARCHAR,
  wealth VARCHAR,
  profession VARCHAR,
  dependents VARCHAR,
  death VARCHAR,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_info_id
  FOREIGN KEY (info_id)
  REFERENCES infos(id)
  ON DELETE NO ACTION
);

-- 八字点评
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  content VARCHAR NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_user_id
  FOREIGN KEY (user_id)
  REFERENCES users(id)
  ON DELETE NO ACTION
);
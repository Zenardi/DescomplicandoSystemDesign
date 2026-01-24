CONSISTENCY ONE;

CREATE KEYSPACE IF NOT EXISTS loja WITH replication = {'class':'SimpleStrategy','replication_factor':'1'};
USE loja;

CREATE TABLE user_profile (
  user_id text PRIMARY KEY,
  attrs  map<text, text>,     -- atributos livres: "age","city","shirt_size",...
  scores map<text, double>,   -- métricas livres: "nps","trust","reliability",...
  flags  set<text>            -- marcadores livres: "beta","vip",...
);

INSERT INTO user_profile (user_id, attrs, scores, flags)
VALUES ('ana',
        {'age':'29','city':'São Paulo','shirt_size':'M'},
        {'nps':72.5,'reliability':0.98},
        {'vip','beta'});

INSERT INTO user_profile (user_id, attrs, scores, flags)
VALUES ('bruno',
        {'city':'Curitiba','github':'@bruno','favorite_color':'black'},
        {'nps':88.0},
        {'newsletter'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('carla',
 {'age':'31','city':'Porto Alegre','role':'data-eng','shirt_size':'P'},
 {'nps':75.0,'reliability':0.97,'delivery':0.90},
 {'vip','newsletter'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('diego',
 {'age':'28','city':'São Paulo','role':'backend','github':'@diego','favorite_color':'blue'},
 {'nps':82.0,'reliability':0.96,'throughput':0.88},
 {'beta','dark_mode'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('eva',
 {'age':'35','city':'Belo Horizonte','role':'sre','oncall':'true'},
 {'nps':89.0,'reliability':0.99,'availability':0.995},
 {'vip','pager','mentor'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('fernanda',
 {'age':'27','city':'Curitiba','role':'frontend','framework':'react'},
 {'nps':78.5,'quality':0.93},
 {'newsletter'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('gustavo',
 {'age':'33','city':'Recife','role':'platform','cert':'aws-sa'},
 {'nps':84.0,'reliability':0.95,'ownership':0.91},
 {'staff','speaker'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('heitor',
 {'age':'29','city':'Florianópolis','role':'fullstack','stack':'node-go'},
 {'nps':71.0,'quality':0.88,'delivery':0.86},
 {'beta'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('isabela',
 {'age':'30','city':'Fortaleza','role':'qa','automation':'true'},
 {'nps':90.0,'quality':0.97},
 {'vip','dark_mode'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('joao',
 {'age':'26','city':'Salvador','role':'mobile','platform':'ios'},
 {'nps':76.0,'delivery':0.89},
 {'newsletter','beta'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('karina',
 {'age':'34','city':'Porto Alegre','role':'data-science','ml_stack':'pytorch'},
 {'nps':88.0,'reliability':0.94,'research':0.92},
 {'speaker','mentor'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('lucas',
 {'age':'32','city':'Campinas','role':'devops','k8s':'true'},
 {'nps':80.0,'availability':0.992},
 {'pager','dark_mode'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('mariana',
 {'age':'25','city':'Niterói','role':'ux','tools':'figma'},
 {'nps':86.0,'quality':0.95},
 {'newsletter'});

INSERT INTO user_profile (user_id, attrs, scores, flags) VALUES
('natalia',
 {'age':'37','city':'Brasília','role':'security','cert':'cissp'},
 {'nps':92.0,'reliability':0.985,'risk':0.93},
 {'staff','vip'});

CREATE INDEX ON user_profile (KEYS(attrs));

CREATE INDEX ON user_profile (KEYS(scores));
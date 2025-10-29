DROP DATABASE IF EXISTS AGIDPASS;

CREATE DATABASE AGIDPASS;
USE AGIDPASS;

CREATE TABLE CLIENTE (
    cliente_id CHAR(36) PRIMARY KEY,
    cliente_nome VARCHAR(50) NOT NULL,
    cliente_email VARCHAR(50) NOT NULL UNIQUE,
    cliente_imagem VARCHAR(200),
    cliente_telefone VARCHAR(13) NOT NULL,
    cliente_endereco VARCHAR(200) NOT NULL,
    cliente_cpf VARCHAR(11) NOT NULL,
    cliente_senha VARCHAR(100) NOT NULL
);

CREATE TABLE CATEGORIA (
    categoria_id INT PRIMARY KEY,
    categoria_nome VARCHAR(50) NOT NULL
);

CREATE TABLE PROFISSIONAL (
    profissional_id CHAR(36) PRIMARY KEY,
    profissional_nome VARCHAR(50) NOT NULL,
    profissional_imagem VARCHAR(200),
    profissional_cnpj VARCHAR(14) NOT NULL,
    profissional_telefone VARCHAR(13) NOT NULL,
    profissional_endereco VARCHAR(200) NOT NULL,
    profissional_email VARCHAR(50) NOT NULL UNIQUE,
    profissional_senha VARCHAR(100) NOT NULL,
    profissional_descricao VARCHAR(2000) NOT NULL
);

-- 🔁 Nova tabela para relação muitos-para-muitos
CREATE TABLE PROFISSIONAL_CATEGORIA (
    profissional_id CHAR(36) NOT NULL,
    categoria_id INT NOT NULL,
    PRIMARY KEY (profissional_id, categoria_id),
    FOREIGN KEY (profissional_id) REFERENCES PROFISSIONAL(profissional_id) ON DELETE CASCADE,
    FOREIGN KEY (categoria_id) REFERENCES CATEGORIA(categoria_id) ON DELETE CASCADE
);

CREATE TABLE PAGAMENTO (
    pagamento_id CHAR(36) PRIMARY KEY,
    pagamento_nome VARCHAR(50) NOT NULL,
    pagamento_forma_pagamento VARCHAR(50) NOT NULL
);

CREATE TABLE AGENDAMENTO (
    agendamento_id CHAR(36) PRIMARY KEY,
    agendamento_data_agendamento DATE NOT NULL,
    agendamento_horario TIME NOT NULL,
    cliente_id CHAR(36) NOT NULL,
    profissional_id CHAR(36) NOT NULL,
    pagamento_id CHAR(36) NOT NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTE(cliente_id),
    FOREIGN KEY (profissional_id) REFERENCES PROFISSIONAL(profissional_id),
    FOREIGN KEY (categoria_id) REFERENCES CATEGORIA(categoria_id),
    FOREIGN KEY (pagamento_id) REFERENCES PAGAMENTO(pagamento_id)
);

-- Inserindo categorias padrão
INSERT INTO CATEGORIA (categoria_id, categoria_nome) VALUES
(1, 'Cabeleireiro'),
(2, 'Barbeiro'),
(3, 'Manicure'),
(4, 'Pedicure'),
(5, 'Massagem'),
(6, 'Sobrancelhas'),
(7, 'Cílios');

SELECT * FROM CLIENTE;
DELETE FROM CLIENTE where cliente_id = "b849a2fe-915b-41b0-bcd6-930c6a33220e";

ALTER TABLE PROFISSIONAL
MODIFY profissional_imagem VARCHAR(500);


INSERT INTO PROFISSIONAL (
  profissional_id,
  profissional_nome,
  profissional_imagem,
  profissional_cnpj,
  profissional_telefone,
  profissional_endereco,
  profissional_email,
  profissional_senha,
  profissional_descricao
)
VALUES
(
  UUID(),
  'Mariana Lopes',
  'https://images.unsplash.com/photo-1573497161161-c3e7b7b33d7d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzNjUyOXwwfDF8c2VhcmNofDJ8fHNvYnJhbmNlbGhhc3xlbnwwfHx8fDE3MzAxMzg1MzN8MA&ixlib=rb-4.0.3&q=80&w=800',
  '12345678000199',
  '11988776655',
  'Rua das Flores, 120 - São Paulo/SP',
  'mariana.lopes@sobrancelhas.com',
  '12345678',
  'Especialista em design e micropigmentação de sobrancelhas com mais de 5 anos de experiência. Trabalha com técnicas modernas e produtos de alta qualidade.'
),
(
  UUID(),
  'Camila Rocha',
  'https://images.unsplash.com/photo-1600411834830-93873e36beba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzNjUyOXwwfDF8c2VhcmNofDh8fG1hcXVpYWRvcnxlbnwwfHx8fDE3MzAxMzg2MzZ8MA&ixlib=rb-4.0.3&q=80&w=800',
  '98765432000155',
  '21977665544',
  'Av. Atlântica, 890 - Rio de Janeiro/RJ',
  'camila.rocha@makeupstudio.com',
  '12345678',
  'Maquiadora profissional especializada em maquiagem social e artística. Atende no estúdio e também oferece serviço a domicílio.'
),
(
  UUID(),
  'Beatriz Ferreira',
  'https://images.unsplash.com/photo-1599937577325-6df1e1d80b69?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzNjUyOXwwfDF8c2VhcmNofDJ8fGNhYmVsZWlyZWlyb3xlbnwwfHx8fDE3MzAxMzg3MTl8MA&ixlib=rb-4.0.3&q=80&w=800',
  '32165498000177',
  '31998887766',
  'Rua Belo Horizonte, 45 - Belo Horizonte/MG',
  'beatriz.ferreira@hairdesign.com',
  '12345678',
  'Cabeleireira experiente especializada em cortes femininos, coloração e hidratação capilar. Preza pelo cuidado e saúde dos fios.'
);

-- Mariana Lopes → Sobrancelhas (categoria_id = 6)
INSERT INTO PROFISSIONAL_CATEGORIA VALUES (
  (SELECT profissional_id FROM PROFISSIONAL WHERE profissional_email = 'mariana.lopes@sobrancelhas.com'),
  6
);

INSERT INTO CATEGORIA (categoria_id, categoria_nome) VALUES
(8, 'Maquiagem');

-- Camila Rocha → Maquiagem (categoria nova = 8)
INSERT INTO PROFISSIONAL_CATEGORIA VALUES (
  (SELECT profissional_id FROM PROFISSIONAL WHERE profissional_email = 'camila.rocha@makeupstudio.com'),
  8
);

-- Beatriz Ferreira → Cabeleireiro (categoria_id = 1)
INSERT INTO PROFISSIONAL_CATEGORIA VALUES (
  (SELECT profissional_id FROM PROFISSIONAL WHERE profissional_email = 'beatriz.ferreira@hairdesign.com'),
  1
);

SELECT *
FROM PROFISSIONAL p
INNER JOIN PROFISSIONAL_CATEGORIA pc
    ON p.profissional_id = pc.profissional_id;
    
SELECT * from PROFISSIONAL;

SELECT * from CLIENTE


-- Exemplo de como associar várias categorias a um profissional
-- (Depois de cadastrar um profissional)
-- INSERT INTO PROFISSIONAL_CATEGORIA (profissional_id, categoria_id)
-- VALUES ('uuid-do-profissional', 1), ('uuid-do-profissional', 3), ('uuid-do-profissional', 5);

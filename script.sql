-- Atividade de Banco de Dados - Clínica Médica
-- Link para testar online (SQL Fiddle): https://sqlfiddle.com/mysql/online-compiler?id=42619709-0c99-4c0a-87ea-8ea0b121a26c

CREATE TABLE especialidade
(
    id_especialidade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE medico
(
    id_medico INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE paciente
(
    id_paciente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    cpf VARCHAR(14) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200)
);

CREATE TABLE medico_especialidade
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Adicionei um ID geral seguindo o padrão do prof
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medico (id_medico),
    FOREIGN KEY (id_especialidade) REFERENCES especialidade (id_especialidade)
);

CREATE TABLE horario_disponivel
(
    id_horario_disponivel INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    data DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_medico) REFERENCES medico (id_medico)
);

CREATE TABLE agendamento
(
    id_agendamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_horario_disponivel INT NOT NULL,
    data DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medico (id_medico),
    FOREIGN KEY (id_horario_disponivel) REFERENCES horario_disponivel (id_horario_disponivel)
);

INSERT INTO especialidade (nome) VALUES ('Cardiologia');
INSERT INTO especialidade (nome) VALUES ('Dermatologia');
INSERT INTO especialidade (nome) VALUES ('Ortopedia');

INSERT INTO medico (nome, crm, telefone, email) VALUES ('Dr. João Silva', '12345-SP', '11-99999-9991', 'joao@medico.com');
INSERT INTO medico (nome, crm, telefone, email) VALUES ('Dra. Maria Santos', '67890-SP', '11-99999-9992', 'maria@medico.com');
INSERT INTO medico (nome, crm, telefone, email) VALUES ('Dr. Pedro Oliveira', '11122-SP', '11-99999-9993', 'pedro@medico.com');

INSERT INTO medico_especialidade (id_medico, id_especialidade) VALUES (1, 1);
INSERT INTO medico_especialidade (id_medico, id_especialidade) VALUES (2, 2);
INSERT INTO medico_especialidade (id_medico, id_especialidade) VALUES (3, 3);
INSERT INTO medico_especialidade (id_medico, id_especialidade) VALUES (1, 3);

INSERT INTO paciente (nome, data_nascimento, cpf, telefone, email, endereco) VALUES ('Carlos Souza', '1985-05-10', '111.222.333-44', '11-98888-8881', 'carlos@email.com', 'Rua A, 123');
INSERT INTO paciente (nome, data_nascimento, cpf, telefone, email, endereco) VALUES ('Ana Lima', '1990-08-20', '555.666.777-88', '11-98888-8882', 'ana@email.com', 'Rua B, 456');

INSERT INTO horario_disponivel (id_medico, data, hora_inicio, hora_fim, disponivel) VALUES (1, '2025-12-20', '08:00', '09:00', false); -- false porque será agendado
INSERT INTO horario_disponivel (id_medico, data, hora_inicio, hora_fim, disponivel) VALUES (1, '2025-12-20', '09:00', '10:00', true);

INSERT INTO horario_disponivel (id_medico, data, hora_inicio, hora_fim, disponivel) VALUES (2, '2025-12-21', '14:00', '15:00', true);

INSERT INTO agendamento (id_paciente, id_medico, id_horario_disponivel, data, hora_inicio, hora_fim, status) 
VALUES (1, 1, 1, '2025-12-20', '08:00', '09:00', 'Agendado');

SELECT medico.nome, especialidade.nome
FROM medico_especialidade
INNER JOIN especialidade ON medico_especialidade.id_especialidade = especialidade.id_especialidade
INNER JOIN medico ON medico_especialidade.id_medico = medico.id_medico
WHERE medico_especialidade.id_medico = 1;

SELECT medico.nome
FROM medico_especialidade
INNER JOIN especialidade ON medico_especialidade.id_especialidade = especialidade.id_especialidade
INNER JOIN medico ON medico_especialidade.id_medico = medico.id_medico
WHERE especialidade.id_especialidade = 1;

SELECT agendamento.data, agendamento.hora_inicio, paciente.nome AS nome_paciente, medico.nome AS nome_medico, agendamento.status
FROM agendamento
INNER JOIN paciente ON agendamento.id_paciente = paciente.id_paciente
INNER JOIN medico ON agendamento.id_medico = medico.id_medico
WHERE agendamento.id_agendamento = 1;
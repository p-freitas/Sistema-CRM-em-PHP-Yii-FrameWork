-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 24-Out-2018 às 21:25
-- Versão do servidor: 10.1.35-MariaDB
-- versão do PHP: 7.1.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_crm`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `aditivo`
--

CREATE TABLE `aditivo` (
  `id` int(11) NOT NULL,
  `fk_contrato` int(11) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_termino` date NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `justificativa` text NOT NULL,
  `anexo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `aditivo`
--

INSERT INTO `aditivo` (`id`, `fk_contrato`, `numero`, `data_inicio`, `data_termino`, `valor`, `justificativa`, `anexo`) VALUES
(3, 1, '0001', '2018-10-01', '2018-10-18', '50000.00', 'teste', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/0001/1308561.txt');

-- --------------------------------------------------------

--
-- Estrutura da tabela `anexos_documentos`
--

CREATE TABLE `anexos_documentos` (
  `id` int(11) NOT NULL,
  `fk_tipo_documento` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `anexo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `anexos_documentos`
--

INSERT INTO `anexos_documentos` (`id`, `fk_tipo_documento`, `fk_cliente`, `anexo`) VALUES
(21, 3, 46, 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/13646005000138/5650609.txt'),
(22, 4, 76, 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/04151452524/3032566.txt'),
(23, 2, 76, 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/04151452524/9359806.01'),
(25, 3, 79, 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/04151452524/2742227.jpg'),
(26, 4, 79, 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/04151452524/2739770.txt');

-- --------------------------------------------------------

--
-- Estrutura da tabela `atendimento`
--

CREATE TABLE `atendimento` (
  `id` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `fk_contato_cliente` int(11) NOT NULL,
  `fk_usuario` int(11) NOT NULL,
  `fk_usuario_solucao` int(11) DEFAULT NULL,
  `fk_contrato` int(11) NOT NULL,
  `fk_produto` int(11) NOT NULL,
  `fk_tipo_atendimento` int(11) NOT NULL,
  `fk_tipo_ocorrencia` int(11) NOT NULL,
  `data_atendimento` datetime NOT NULL,
  `status` tinyint(4) NOT NULL,
  `solicitacao` text NOT NULL,
  `solucao` text,
  `data_solucao` datetime DEFAULT NULL,
  `numero_atendimento` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `atendimento_anexos`
--

CREATE TABLE `atendimento_anexos` (
  `id` int(11) NOT NULL,
  `fk_atendimento` int(11) NOT NULL,
  `anexo` varchar(255) NOT NULL,
  `descricao` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `audit_trail_entry`
--

CREATE TABLE `audit_trail_entry` (
  `id` int(11) NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `happened_at` int(11) NOT NULL,
  `foreign_pk` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `audit_trail_entry`
--

INSERT INTO `audit_trail_entry` (`id`, `model_type`, `happened_at`, `foreign_pk`, `user_id`, `type`, `data`) VALUES
(1, 'app\\models\\Cliente', 1535980561, '{\"id\":22}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":22},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"10405329000196\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41760-035\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Costa Azul \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Doutor Augusto Lopes Pontes \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-03\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(2, 'app\\models\\ContatoCliente', 1535980561, '{\"id\":57}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":57},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(3, 'app\\models\\Telefone', 1535980561, '{\"id\":33}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":33},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":57},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(4, 'app\\models\\ContatoCliente', 1535980561, '{\"id\":58}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":58},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Davi Barbosa de Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(5, 'app\\models\\Telefone', 1535980561, '{\"id\":34}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":34},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":58},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"33333333333\"}]'),
(6, 'app\\models\\Telefone', 1535980561, '{\"id\":35}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":35},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":58},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"44444444444\"}]'),
(7, 'app\\models\\ContatoCliente', 1535980561, '{\"id\":59}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":59},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(8, 'app\\models\\Telefone', 1535980561, '{\"id\":36}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":36},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":59},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"11111111111\"}]'),
(9, 'app\\models\\Telefone', 1535980561, '{\"id\":37}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":37},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":59},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"22222222222\"}]'),
(10, 'app\\models\\Cliente', 1536000488, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(11, 'app\\models\\Cliente', 1536001191, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(12, 'app\\models\\Cliente', 1536001293, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(13, 'app\\models\\Cliente', 1536002427, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(14, 'app\\models\\Cliente', 1536002453, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(15, 'app\\models\\Cliente', 1536002579, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(16, 'app\\models\\Cliente', 1536002607, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(17, 'app\\models\\Cliente', 1536002617, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(18, 'app\\models\\Cliente', 1536002624, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(19, 'app\\models\\Cliente', 1536002642, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(20, 'app\\models\\Cliente', 1536002663, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(21, 'app\\models\\Cliente', 1536002685, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(22, 'app\\models\\Cliente', 1536002712, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(23, 'app\\models\\Cliente', 1536002714, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(24, 'app\\models\\Cliente', 1536002734, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(25, 'app\\models\\Cliente', 1536002764, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(26, 'app\\models\\Cliente', 1536060946, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(27, 'app\\models\\Cliente', 1536060971, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(28, 'app\\models\\Cliente', 1536061003, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(29, 'app\\models\\Cliente', 1536061074, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(30, 'app\\models\\Cliente', 1536061239, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(31, 'app\\models\\Cliente', 1536061306, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(32, 'app\\models\\Cliente', 1536061351, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(33, 'app\\models\\Cliente', 1536061404, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(34, 'app\\models\\Cliente', 1536061841, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(35, 'app\\models\\Cliente', 1536061868, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(36, 'app\\models\\Cliente', 1536062145, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(37, 'app\\models\\Cliente', 1536062222, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(38, 'app\\models\\Cliente', 1536062276, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(39, 'app\\models\\Cliente', 1536062551, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(40, 'app\\models\\Cliente', 1536062586, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(41, 'app\\models\\Cliente', 1536062741, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(42, 'app\\models\\Cliente', 1536063084, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(43, 'app\\models\\Cliente', 1536064312, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(44, 'app\\models\\Cliente', 1536064320, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(45, 'app\\models\\Cliente', 1536065032, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(46, 'app\\models\\Cliente', 1536065051, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(47, 'app\\models\\Cliente', 1536065076, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(48, 'app\\models\\Cliente', 1536065233, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(49, 'app\\models\\Cliente', 1536065867, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(50, 'app\\models\\Cliente', 1536065904, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(51, 'app\\models\\Cliente', 1536065957, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(52, 'app\\models\\Cliente', 1536066819, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(53, 'app\\models\\ContatoCliente', 1536066819, '{\"id\":60}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":60},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(54, 'app\\models\\Cliente', 1536066860, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(55, 'app\\models\\ContatoCliente', 1536066860, '{\"id\":61}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":61},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(56, 'app\\models\\Cliente', 1536066964, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(57, 'app\\models\\ContatoCliente', 1536066964, '{\"id\":62}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":62},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(58, 'app\\models\\Cliente', 1536067010, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(59, 'app\\models\\ContatoCliente', 1536067010, '{\"id\":63}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":63},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(60, 'app\\models\\ContatoCliente', 1536067010, '{\"id\":64}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":64},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Davi Barbosa de Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(61, 'app\\models\\ContatoCliente', 1536067010, '{\"id\":65}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":65},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(62, 'app\\models\\ContatoCliente', 1536067010, '{\"id\":66}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":66},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(63, 'app\\models\\ContatoCliente', 1536067010, '{\"id\":67}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":67},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(64, 'app\\models\\ContatoCliente', 1536067010, '{\"id\":68}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":68},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(65, 'app\\models\\Cliente', 1536067021, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(66, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":69}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":69},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(67, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":70}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":70},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Davi Barbosa de Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(68, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":71}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":71},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(69, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":72}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":72},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(70, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":73}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":73},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(71, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":74}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":74},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(72, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":75}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":75},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(73, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":76}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":76},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Davi Barbosa de Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(74, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":77}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":77},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(75, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":78}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":78},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(76, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":79}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":79},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(77, 'app\\models\\ContatoCliente', 1536067021, '{\"id\":80}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":80},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(78, 'app\\models\\Cliente', 1536067992, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(79, 'app\\models\\Cliente', 1536068077, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(80, 'app\\models\\Cliente', 1536068086, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(81, 'app\\models\\Cliente', 1536068323, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(82, 'app\\models\\ContatoCliente', 1536068323, '{\"id\":81}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":81},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(83, 'app\\models\\ContatoCliente', 1536068323, '{\"id\":82}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":82},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Davi Barbosa de Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(84, 'app\\models\\Cliente', 1536068484, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760035\",\"to\":\"41760-035\"}]'),
(85, 'app\\models\\Cliente', 1536068503, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"}]'),
(86, 'app\\models\\ContatoCliente', 1536068890, '{\"id\":83}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":83},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Keep\"},{\"attr\":\"email\",\"from\":null,\"to\":\"keep@keep.com.br\"}]'),
(87, 'app\\models\\Telefone', 1536075529, '{\"id\":38}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":38},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":57},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7133413056\"}]'),
(88, 'app\\models\\ContatoCliente', 1536075587, '{\"id\":84}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":84},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Keep\"},{\"attr\":\"email\",\"from\":null,\"to\":\"keep@keep.com.br\"}]'),
(89, 'app\\models\\Telefone', 1536075587, '{\"id\":39}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":39},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":84},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7132851000\"}]'),
(90, 'app\\models\\Telefone', 1536082448, '{\"id\":39}', 2, 'update', '[{\"attr\":\"fk_tipo_telefone\",\"from\":2,\"to\":1}]'),
(91, 'app\\models\\Telefone', 1536082488, '{\"id\":40}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":40},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":84},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7132852000\"}]'),
(92, 'app\\models\\Telefone', 1536153350, '{\"id\":41}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":41},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":57},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(93, 'app\\models\\Telefone', 1536156641, '{\"id\":42}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":42},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":58},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7762132121\"}]'),
(94, 'app\\models\\Telefone', 1536156654, '{\"id\":43}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":43},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":59},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7164651623\"}]'),
(95, 'app\\models\\Telefone', 1536156682, '{\"id\":44}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":44},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":59},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"55555555555\"}]'),
(96, 'app\\models\\ContatoCliente', 1536157173, '{\"id\":85}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":85},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(97, 'app\\models\\Telefone', 1536157173, '{\"id\":45}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":45},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":85},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(98, 'app\\models\\ContatoCliente', 1536157716, '{\"id\":86}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":86},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandieg7@gmail.com\"}]'),
(99, 'app\\models\\Telefone', 1536157716, '{\"id\":46}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":46},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":86},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(100, 'app\\models\\ContatoCliente', 1536157716, '{\"id\":87}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":87},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"wffsd fsdf\"},{\"attr\":\"email\",\"from\":null,\"to\":\" \\tmarcos.dba1995@hotmail.com \"}]'),
(101, 'app\\models\\Telefone', 1536157716, '{\"id\":47}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":47},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":87},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"64564565464\"}]'),
(102, 'app\\models\\ContatoCliente', 1536157716, '{\"id\":88}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":88},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"jjntjjh h\"},{\"attr\":\"email\",\"from\":null,\"to\":\" \\tmarcos.dba1995@hotmail.com \"}]'),
(103, 'app\\models\\Telefone', 1536157716, '{\"id\":48}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":48},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":88},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"64645646456\"}]'),
(104, 'app\\models\\ContatoCliente', 1536157716, '{\"id\":89}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":89},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"gtrgfhm h,hj,, \"},{\"attr\":\"email\",\"from\":null,\"to\":\" \\tmarcos.dba1995@hotmail.com \"}]'),
(105, 'app\\models\\Telefone', 1536157716, '{\"id\":49}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":49},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":89},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"47574745745\"}]'),
(106, 'app\\models\\Telefone', 1536157914, '{\"id\":50}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":50},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":58},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"75566465426\"}]'),
(107, 'app\\models\\Telefone', 1536157914, '{\"id\":51}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":51},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":89},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"8776151423\"}]'),
(108, 'app\\models\\Telefone', 1536158823, '{\"id\":52}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":52},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":87},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"23534535345\"}]'),
(109, 'app\\models\\ContatoCliente', 1536158862, '{\"id\":90}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":90},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(110, 'app\\models\\Telefone', 1536158880, '{\"id\":53}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":53},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":90},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(111, 'app\\models\\ContatoCliente', 1536158978, '{\"id\":91}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":91},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN ARAUJO 2\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com \"}]'),
(112, 'app\\models\\ContatoCliente', 1536159956, '{\"id\":92}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":92},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN ARAUJO \"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com \"}]'),
(113, 'app\\models\\Telefone', 1536159972, '{\"id\":54}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":54},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":92},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(114, 'app\\models\\ContatoCliente', 1536160025, '{\"id\":93}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":93},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcosalmeida@keep.com.br\"}]'),
(115, 'app\\models\\Telefone', 1536160124, '{\"id\":55}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":55},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":93},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"11111111111\"}]'),
(116, 'app\\models\\Telefone', 1536160124, '{\"id\":56}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":56},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":93},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"22222222222\"}]'),
(117, 'app\\models\\ContatoCliente', 1536160124, '{\"id\":94}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":94},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Adimario\"},{\"attr\":\"email\",\"from\":null,\"to\":\"adimario@keep.com.br\"}]'),
(118, 'app\\models\\Telefone', 1536160124, '{\"id\":57}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":57},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":94},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"33333333333\"}]'),
(119, 'app\\models\\ContatoCliente', 1536160124, '{\"id\":95}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":95},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Fabricio\"},{\"attr\":\"email\",\"from\":null,\"to\":\"fabricio@keep.com.br\"}]'),
(120, 'app\\models\\Telefone', 1536160124, '{\"id\":58}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":58},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":95},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"44444444444\"}]'),
(121, 'app\\models\\ContatoCliente', 1536160124, '{\"id\":96}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":96},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Wilton\"},{\"attr\":\"email\",\"from\":null,\"to\":\"wilton@keep.com.br\"}]'),
(122, 'app\\models\\Telefone', 1536160124, '{\"id\":59}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":59},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":96},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"66666666666\"}]'),
(123, 'app\\models\\ContatoCliente', 1536160124, '{\"id\":97}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":97},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Murilo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"murilo@keep.com.br\"}]'),
(124, 'app\\models\\Telefone', 1536160124, '{\"id\":60}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":60},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":97},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(125, 'app\\models\\ContatoCliente', 1536161392, '{\"id\":98}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":98},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(126, 'app\\models\\Telefone', 1536161392, '{\"id\":61}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":61},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":98},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(127, 'app\\models\\ContatoCliente', 1536161392, '{\"id\":99}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":99},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Adimario\"},{\"attr\":\"email\",\"from\":null,\"to\":\"adimario@keep.com.br\"}]'),
(128, 'app\\models\\Telefone', 1536161392, '{\"id\":62}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":62},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":99},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"11111111111\"}]'),
(129, 'app\\models\\Telefone', 1536161392, '{\"id\":63}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":63},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":99},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"22222222222\"}]'),
(130, 'app\\models\\ContatoCliente', 1536161392, '{\"id\":100}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":100},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Fabricio\"},{\"attr\":\"email\",\"from\":null,\"to\":\"fabricio@keep.com.br\"}]'),
(131, 'app\\models\\Telefone', 1536161392, '{\"id\":64}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":64},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":100},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"88888888888\"}]'),
(132, 'app\\models\\ContatoCliente', 1536161392, '{\"id\":101}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":101},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Wilton\"},{\"attr\":\"email\",\"from\":null,\"to\":\"wilton@keep.com.br\"}]'),
(133, 'app\\models\\Telefone', 1536161392, '{\"id\":65}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":65},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":101},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"00000000000\"}]'),
(134, 'app\\models\\ContatoCliente', 1536161571, '{\"id\":102}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":102},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luan@keep.com.br\"}]'),
(135, 'app\\models\\Telefone', 1536161571, '{\"id\":66}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":66},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":102},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(136, 'app\\models\\ContatoCliente', 1536161779, '{\"id\":103}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":103},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luan@keep.com.br\"}]'),
(137, 'app\\models\\Telefone', 1536161779, '{\"id\":67}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":67},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":103},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(138, 'app\\models\\ContatoCliente', 1536161868, '{\"id\":104}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":104},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Adimario\"},{\"attr\":\"email\",\"from\":null,\"to\":\"adimario@keep.com.br\"}]'),
(139, 'app\\models\\Telefone', 1536161868, '{\"id\":68}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":68},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":104},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7132851000\"}]'),
(140, 'app\\models\\Telefone', 1536161868, '{\"id\":69}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":69},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":104},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"00000000000\"}]'),
(141, 'app\\models\\ContatoCliente', 1536161868, '{\"id\":105}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":105},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Fabricio\"},{\"attr\":\"email\",\"from\":null,\"to\":\"fabricio@keep.com.br\"}]'),
(142, 'app\\models\\Telefone', 1536161868, '{\"id\":70}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":70},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":105},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"33333333333\"}]'),
(143, 'app\\models\\Telefone', 1536161868, '{\"id\":71}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":71},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":105},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"22222222222\"}]'),
(144, 'app\\models\\Telefone', 1536162759, '{\"id\":72}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":72},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":103},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"00000000000\"}]'),
(145, 'app\\models\\Telefone', 1536162759, '{\"id\":69}', 2, 'update', '[{\"attr\":\"fk_tipo_telefone\",\"from\":2,\"to\":1}]'),
(146, 'app\\models\\ContatoCliente', 1536162794, '{\"id\":106}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":106},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Murilo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"murilo@keep.com.br\"}]'),
(147, 'app\\models\\Telefone', 1536162794, '{\"id\":73}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":73},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":106},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"66666666666\"}]'),
(148, 'app\\models\\Telefone', 1536163729, '{\"id\":74}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":74},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":106},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"53242342342\"}]'),
(149, 'app\\models\\ContatoCliente', 1536163729, '{\"id\":107}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":107},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luan@gmail.com\"}]'),
(150, 'app\\models\\Telefone', 1536163729, '{\"id\":75}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":75},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":107},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(151, 'app\\models\\ContatoCliente', 1536166994, '{\"id\":108}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":108},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luan@gmail.com \"}]'),
(152, 'app\\models\\Telefone', 1536582367, '{\"id\":76}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":76},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":108},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7133413056\"}]'),
(153, 'app\\models\\Telefone', 1536587003, '{\"id\":77}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":77},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":107},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(154, 'app\\models\\Cargo', 1536667366, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"descricao\",\"from\":null,\"to\":\"Analista de Sistemas\"}]'),
(155, 'app\\models\\ContatoCliente', 1536692786, '{\"id\":109}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":109},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LuanTEC\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luantec@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"LuanTEC\"}]'),
(156, 'app\\models\\ContatoCliente', 1536693179, '{\"id\":110}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":110},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luantec\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luantec@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luantec\"}]'),
(157, 'app\\models\\ContatoCliente', 1536755732, '{\"id\":109}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":109},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luantec\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luantec@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luantec\"}]'),
(158, 'app\\models\\ContatoCliente', 1536755757, '{\"id\":110}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":110},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luantec Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luantec@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luantec Araujo\"}]'),
(159, 'app\\models\\ContatoCliente', 1536755839, '{\"id\":111}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":111},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan TEC\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luantec@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luan TEC\"}]'),
(160, 'app\\models\\ContatoCliente', 1536758128, '{\"id\":112}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":112},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo 2\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego72@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luan Araujo 2\"}]'),
(161, 'app\\models\\ContatoCliente', 1536761119, '{\"id\":113}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":113},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7tec@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luan Araujo\"}]'),
(162, 'app\\models\\ContatoCliente', 1536761570, '{\"id\":114}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":114},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7tec@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luan Araujo teste\"}]'),
(163, 'app\\models\\ContatoCliente', 1536761803, '{\"id\":115}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":115},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luan Araujo teste\"}]'),
(164, 'app\\models\\ContatoCliente', 1536761842, '{\"id\":116}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":116},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luan Araujo teste\"}]'),
(165, 'app\\models\\ContatoCliente', 1536761857, '{\"id\":116}', 2, 'update', '[{\"attr\":\"fk_departamento\",\"from\":3,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":3,\"to\":2}]'),
(166, 'app\\models\\ContatoCliente', 1536761869, '{\"id\":116}', 2, 'update', '[{\"attr\":\"fk_departamento\",\"from\":1,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":2,\"to\":3}]'),
(167, 'app\\models\\ContatoCliente', 1536761884, '{\"id\":117}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":117},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan tec\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luan tec\"}]'),
(168, 'app\\models\\ContatoCliente', 1536761943, '{\"id\":118}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":118},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo Tec\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7tec@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luan Araujo Tec\"}]'),
(169, 'app\\models\\Telefone', 1536761963, '{\"id\":79}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":79},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":118},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(170, 'app\\models\\ContatoCliente', 1536762098, '{\"id\":119}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":119},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo Tec tes\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7tectec@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"Luan Araujo Tec tes\"}]'),
(171, 'app\\models\\Telefone', 1536762163, '{\"id\":80}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":80},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":118},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"77777777777\"}]'),
(172, 'app\\models\\Telefone', 1536762284, '{\"id\":80}', 2, 'update', '[{\"attr\":\"fk_tipo_telefone\",\"from\":2,\"to\":1}]');
INSERT INTO `audit_trail_entry` (`id`, `model_type`, `happened_at`, `foreign_pk`, `user_id`, `type`, `data`) VALUES
(173, 'app\\models\\Telefone', 1536762334, '{\"id\":81}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":81},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":118},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"77777777777\"}]'),
(174, 'app\\models\\Cliente', 1536764350, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"contato_interno@ford.com\",\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":\"41760035\",\"to\":48080070}]'),
(175, 'app\\models\\ContatoCliente', 1536768819, '{\"id\":118}', 2, 'update', '[{\"attr\":\"nome\",\"from\":\"Luan Araujo Tec\",\"to\":\"Luan Araujo Tec analista\"},{\"attr\":\"email\",\"from\":\"luandiego7tec@gmail.com\",\"to\":\"luandiego@gmail.com\"},{\"attr\":\"foto\",\"from\":\"Luan Araujo Tec\",\"to\":\"Luan Araujo Tec analista\"}]'),
(176, 'app\\models\\ContatoCliente', 1536768843, '{\"id\":120}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":120},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"}]'),
(177, 'app\\models\\Telefone', 1536768858, '{\"id\":82}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":82},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":120},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"45634534535\"}]'),
(178, 'app\\models\\ContatoCliente', 1536768893, '{\"id\":118}', 2, 'update', '[{\"attr\":\"fk_departamento\",\"from\":3,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":3,\"to\":2},{\"attr\":\"nome\",\"from\":\"Luan Araujo Tec analista\",\"to\":\"Luan Araujo Analista de Sistemas\"},{\"attr\":\"email\",\"from\":\"luandiego@gmail.com\",\"to\":\"luantec.araujo@gmail.com\"},{\"attr\":\"foto\",\"from\":\"Luan Araujo Tec analista\",\"to\":\"Luan Araujo Analista de Sistemas\"}]'),
(179, 'app\\models\\ContatoCliente', 1536774401, '{\"id\":118}', 2, 'update', '[{\"attr\":\"fk_cargo\",\"from\":2,\"to\":3}]'),
(180, 'app\\models\\ContatoCliente', 1536774415, '{\"id\":118}', 2, 'update', '[{\"attr\":\"fk_departamento\",\"from\":1,\"to\":3}]'),
(181, 'app\\models\\ContatoCliente', 1536774466, '{\"id\":120}', 2, 'update', '[{\"attr\":\"nome\",\"from\":\"Josenita Marise Ailton Araujo\",\"to\":\"Teste \"},{\"attr\":\"email\",\"from\":\"luanaraujo@gmail.com\",\"to\":\"teste@gmail.com\"},{\"attr\":\"foto\",\"from\":\"\",\"to\":\"Teste \"}]'),
(182, 'app\\models\\Telefone', 1536774523, '{\"id\":83}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":83},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":118},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7132851000\"}]'),
(183, 'app\\models\\ContatoCliente', 1536852673, '{\"id\":121}', 1, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":121},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"henrywest@gmail.com\"}]'),
(184, 'app\\models\\ContatoCliente', 1536852686, '{\"id\":121}', 1, 'update', '[{\"attr\":\"fk_cargo\",\"from\":3,\"to\":2},{\"attr\":\"foto\",\"from\":\"\",\"to\":\"Henry Allen West\"}]'),
(185, 'app\\models\\Telefone', 1536852705, '{\"id\":84}', 1, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":84},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":121},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7132851000\"}]'),
(186, 'app\\models\\Telefone', 1536852753, '{\"id\":83}', 1, 'update', '[{\"attr\":\"fk_tipo_telefone\",\"from\":2,\"to\":1}]'),
(187, 'app\\models\\ContatoCliente', 1536852753, '{\"id\":122}', 1, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":122},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Adimário\"},{\"attr\":\"email\",\"from\":null,\"to\":\"adimario@keep.com.br\"}]'),
(188, 'app\\models\\Telefone', 1536852753, '{\"id\":85}', 1, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":85},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":122},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7132851000\"}]'),
(189, 'app\\models\\Cliente', 1536852872, '{\"id\":22}', 1, 'update', '[{\"attr\":\"email\",\"from\":\"luanaraujo@gmail.com\",\"to\":\"josenitamarise@gmail.com\"}]'),
(190, 'app\\models\\ContatoCliente', 1536852872, '{\"id\":120}', 1, 'update', '[{\"attr\":\"fk_cargo\",\"from\":2,\"to\":1}]'),
(191, 'app\\models\\ContatoCliente', 1536852872, '{\"id\":123}', 1, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":123},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"henrywest@gmail.com\"}]'),
(192, 'app\\models\\ContatoCliente', 1536852872, '{\"id\":124}', 1, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":124},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Dona Mita Seu Juca\"},{\"attr\":\"email\",\"from\":null,\"to\":\"josenitamarise@gmail.com\"}]'),
(193, 'app\\models\\TipoAnexo', 1536948663, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"descricao\",\"from\":null,\"to\":\"php\"}]'),
(194, 'app\\models\\AnexosDocumentos', 1536948663, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/2196601.php\"}]'),
(195, 'app\\models\\TipoAnexo', 1536948663, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"descricao\",\"from\":null,\"to\":\"css\"}]'),
(196, 'app\\models\\AnexosDocumentos', 1536948663, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":4},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/5303113.css\"}]'),
(197, 'app\\models\\AnexosDocumentos', 1536948663, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/2331015.php\"}]'),
(198, 'app\\models\\Cliente', 1536951369, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"josenitamarise@gmail.com\",\"to\":\"marcos.dba1995@hotmail.com\"},{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":41130000}]'),
(199, 'app\\models\\Cliente', 1536951571, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"marcos.dba1995@hotmail.com\",\"to\":\"josenitamarise@gmail.com\"},{\"attr\":\"cep\",\"from\":\"41130000\",\"to\":41080070}]'),
(200, 'app\\models\\Cliente', 1536951720, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41080070\",\"to\":48080070},{\"attr\":\"cidade\",\"from\":\"Salvador\",\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":\"Costa Azul \",\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":\"Rua Doutor Augusto Lopes Pontes \",\"to\":\"Rua Alfredo Garcia \"}]'),
(201, 'app\\models\\Cliente', 1537206411, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"josenitamarise@gmail.com\",\"to\":\"luanaraujo@gmail.com\"}]'),
(202, 'app\\models\\Cliente', 1537206698, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luanaraujo@gmail.com\",\"to\":\"luandiego7@gmail.com\"}]'),
(203, 'app\\models\\ContatoCliente', 1537208547, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(204, 'app\\models\\ContatoCliente', 1537208825, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(205, 'app\\models\\Cliente', 1537208985, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":41760035}]'),
(206, 'app\\models\\ContatoCliente', 1537208987, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/9636164.jpeg\"}]'),
(207, 'app\\models\\ContatoCliente', 1537209713, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/829864.jpeg\"}]'),
(208, 'app\\models\\Cliente', 1537209800, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luandiego7@gmail.com\",\"to\":\"marcos.dba1995@hotmail.com\"},{\"attr\":\"cep\",\"from\":\"41760035\",\"to\":48080070}]'),
(209, 'app\\models\\Cliente', 1537210021, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"marcos.dba1995@hotmail.com\",\"to\":\"luandiego7@gmail.com\"}]'),
(210, 'app\\models\\ContatoCliente', 1537210021, '{\"id\":5}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":5},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(211, 'app\\models\\ContatoCliente', 1537210021, '{\"id\":6}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":6},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"josenitamarise@gmail.com\"}]'),
(212, 'app\\models\\Cliente', 1537210189, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luandiego7@gmail.com\",\"to\":\"josenitamarise@gmail.com\"},{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":41080070}]'),
(213, 'app\\models\\Cliente', 1537210336, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"josenitamarise@gmail.com\",\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":\"41080070\",\"to\":48080070}]'),
(214, 'app\\models\\ContatoCliente', 1537210403, '{\"id\":7}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":7},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"josenitamarise@gmail.com\"}]'),
(215, 'app\\models\\ContatoCliente', 1537210403, '{\"id\":8}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":8},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Dona Mita Seu Juca\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(216, 'app\\models\\Cliente', 1537210899, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luandiego7@gmail.com\",\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(217, 'app\\models\\ContatoCliente', 1537210899, '{\"id\":9}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":9},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(218, 'app\\models\\ContatoCliente', 1537210899, '{\"id\":10}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":10},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Davi Barbosa de Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(219, 'app\\models\\Cliente', 1537210975, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"marcos.dba1995@hotmail.com\",\"to\":\"luandiego7@gmail.com\"}]'),
(220, 'app\\models\\ContatoCliente', 1537211220, '{\"id\":11}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":11},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(221, 'app\\models\\ContatoCliente', 1537211220, '{\"id\":12}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":12},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Dona Mita Seu Juca\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(222, 'app\\models\\Cliente', 1537275204, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luandiego7@gmail.com\",\"to\":\"marcos.dba1995@hotmail.com\"},{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":41130000}]'),
(223, 'app\\models\\ContatoCliente', 1537275204, '{\"id\":5}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":5},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Davi Barbosa de Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(224, 'app\\models\\ContatoCliente', 1537275204, '{\"id\":6}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":6},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"josenitamarise@gmail.com\"}]'),
(225, 'app\\models\\Cliente', 1537275608, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"marcos.dba1995@hotmail.com\",\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":\"41130000\",\"to\":48080070}]'),
(226, 'app\\models\\ContatoCliente', 1537277955, '{\"id\":7}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":7},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(227, 'app\\models\\ContatoCliente', 1537277955, '{\"id\":8}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":8},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(228, 'app\\models\\Cliente', 1537277999, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luandiego7@gmail.com\",\"to\":\"airtonaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":41080070}]'),
(229, 'app\\models\\Cliente', 1537278013, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"airtonaraujo@gmail.com\",\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":\"41080070\",\"to\":48080070}]'),
(230, 'app\\models\\Cliente', 1537278037, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luandiego7@gmail.com\",\"to\":\"marcos.dba1995@hotmail.com\"},{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":41130000}]'),
(231, 'app\\models\\Cliente', 1537278389, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"marcos.dba1995@hotmail.com\",\"to\":\"airtonaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":\"41130000\",\"to\":48080070}]'),
(232, 'app\\models\\Cliente', 1537278439, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"airtonaraujo@gmail.com\",\"to\":\"luanaraujo@gmail.com\"}]'),
(233, 'app\\models\\ContatoCliente', 1537278465, '{\"id\":9}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":9},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/1511335.jpeg\"}]'),
(234, 'app\\models\\Cliente', 1537278685, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luanaraujo@gmail.com\",\"to\":\"luandiego7@gmail.com\"}]'),
(235, 'app\\models\\Cliente', 1537278727, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luandiego7@gmail.com\",\"to\":\"josenitamarise@gmail.com\"},{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":41080070}]'),
(236, 'app\\models\\ContatoCliente', 1537279528, '{\"id\":10}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":10},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"}]'),
(237, 'app\\models\\ContatoCliente', 1537279535, '{\"id\":11}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":11},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"}]'),
(238, 'app\\models\\ContatoCliente', 1537279692, '{\"id\":12}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":12},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"}]'),
(239, 'app\\models\\Cliente', 1537279786, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"josenitamarise@gmail.com\",\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":\"41080070\",\"to\":41760035}]'),
(240, 'app\\models\\ContatoCliente', 1537279814, '{\"id\":13}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":13},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(241, 'app\\models\\ContatoCliente', 1537279839, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(242, 'app\\models\\Cliente', 1537280685, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41760035\",\"to\":48080070}]'),
(243, 'app\\models\\Cliente', 1537280746, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":41760035}]'),
(244, 'app\\models\\ContatoCliente', 1537280750, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/6089899.jpeg\"}]'),
(245, 'app\\models\\Cliente', 1537280803, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"luandiego7@gmail.com\",\"to\":\"airtonaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":\"41760035\",\"to\":48080070}]'),
(246, 'app\\models\\ContatoCliente', 1537280803, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(247, 'app\\models\\ContatoCliente', 1537280829, '{\"id\":17}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":17},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"josenitamarise@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/1743438.jpeg\"}]'),
(248, 'app\\models\\Cliente', 1537288500, '{\"id\":22}', 2, 'update', '[{\"attr\":\"email\",\"from\":\"airtonaraujo@gmail.com\",\"to\":\"josenitamarise@gmail.com\"},{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":41080070}]'),
(249, 'app\\models\\ContatoCliente', 1537288500, '{\"id\":18}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":18},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Dona Mita Seu Juca\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(250, 'app\\models\\ContatoCliente', 1537290344, '{\"id\":18}', 2, 'update', '[{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/5527220.jpeg\"}]'),
(251, 'app\\models\\ContatoCliente', 1537290369, '{\"id\":18}', 2, 'update', '[{\"attr\":\"foto\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/5527220.jpeg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/9377371.jpeg\"}]'),
(252, 'app\\models\\Cliente', 1537291562, '{\"id\":23}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":23},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"15245056000183\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Diretores S.A\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41760035\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-18\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(253, 'app\\models\\ContatoCliente', 1537291566, '{\"id\":19}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":19},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":23},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Adimario Filho\"},{\"attr\":\"email\",\"from\":null,\"to\":\"adimario@keep.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/8283108.jpeg\"}]'),
(254, 'app\\models\\Cliente', 1537291735, '{\"id\":24}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":24},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"15245056000183\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Diretores S.A\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41760035\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Costa Azul \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Doutor Augusto Lopes Pontes \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-18\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(255, 'app\\models\\ContatoCliente', 1537291740, '{\"id\":20}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":20},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":24},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Adimario Filho\"},{\"attr\":\"email\",\"from\":null,\"to\":\"adimario@keep.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/5288268.jpeg\"}]'),
(256, 'app\\models\\Cliente', 1537291845, '{\"id\":25}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":25},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"15245056000183\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Diretores S.A\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41760035\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Costa Azul \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Doutor Augusto Lopes Pontes \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-18\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(257, 'app\\models\\ContatoCliente', 1537291849, '{\"id\":21}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":21},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":25},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Adimario Filho\"},{\"attr\":\"email\",\"from\":null,\"to\":\"adimario@keep.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/2989800.jpeg\"}]'),
(258, 'app\\models\\ContatoCliente', 1537291871, '{\"id\":22}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":22},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":25},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Fabricio\"},{\"attr\":\"email\",\"from\":null,\"to\":\"fabricio@keep.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/5730867.png\"}]'),
(259, 'app\\models\\Telefone', 1537291897, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":21},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"7132851000\"}]'),
(260, 'app\\models\\Telefone', 1537308559, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":15},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71991237296\"}]'),
(261, 'app\\models\\Cliente', 1537359377, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"41080070\",\"to\":48080070}]'),
(262, 'app\\models\\ContatoCliente', 1537359379, '{\"id\":23}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":23},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(263, 'app\\models\\ContatoCliente', 1537360679, '{\"id\":24}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":24},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(264, 'app\\models\\ContatoCliente', 1537362005, '{\"id\":25}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":25},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":22},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/images/8691957.jpeg\"}]'),
(265, 'app\\models\\Cliente', 1537378061, '{\"id\":26}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":26},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Diretores S.A\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Costa Azul \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Doutor Augusto Lopes Pontes \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(266, 'app\\models\\Cliente', 1537378793, '{\"id\":27}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":27},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Prefeitura Alagoinhas\"},{\"attr\":\"email\",\"from\":null,\"to\":\"prefeituraalagoinhas@alagoinhas.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(267, 'app\\models\\Cliente', 1537379024, '{\"id\":28}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":28},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Prefeitura Alagoinhas\"},{\"attr\":\"email\",\"from\":null,\"to\":\"prefeituraalagoinhas@alagoinhas.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(272, 'app\\models\\Cliente', 1537379371, '{\"id\":29}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":29},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(273, 'app\\models\\Cliente', 1537379376, '{\"id\":30}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":30},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(274, 'app\\models\\Cliente', 1537379404, '{\"id\":31}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":31},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(275, 'app\\models\\Cliente', 1537379427, '{\"id\":32}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":32},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(276, 'app\\models\\Cliente', 1537379497, '{\"id\":33}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":33},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(277, 'app\\models\\Cliente', 1537379675, '{\"id\":34}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":34},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(278, 'app\\models\\Cliente', 1537379686, '{\"id\":35}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":35},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(279, 'app\\models\\Cliente', 1537380539, '{\"id\":36}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":36},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Prefeitura Alagoinhas\"},{\"attr\":\"email\",\"from\":null,\"to\":\"alagoinhas@alagoinhas.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(282, 'app\\models\\Cliente', 1537380820, '{\"id\":36}', 2, 'delete', '[{\"attr\":\"id\",\"from\":36,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":1,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"13.646.005/0001-38\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"Prefeitura Alagoinhas\",\"to\":null},{\"attr\":\"email\",\"from\":\"alagoinhas@alagoinhas.com\",\"to\":null},{\"attr\":\"cep\",\"from\":\"48080-070\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA\",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Alagoinhas\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Jardim Pedro Braga \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Alfredo Garcia \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"19/09/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null}]'),
(283, 'app\\models\\Cliente', 1537380886, '{\"id\":37}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":37},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(284, 'app\\models\\Cliente', 1537380897, '{\"id\":38}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":38},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(285, 'app\\models\\Cliente', 1537380964, '{\"id\":39}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":39},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(286, 'app\\models\\Cliente', 1537381091, '{\"id\":40}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":40},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(287, 'app\\models\\Cliente', 1537381591, '{\"id\":41}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":41},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(288, 'app\\models\\Cliente', 1537381640, '{\"id\":42}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":42},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(290, 'app\\models\\Cliente', 1537381767, '{\"id\":43}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":43},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(291, 'app\\models\\Cliente', 1537381780, '{\"id\":44}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":44},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Veículos Ford\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]');
INSERT INTO `audit_trail_entry` (`id`, `model_type`, `happened_at`, `foreign_pk`, `user_id`, `type`, `data`) VALUES
(293, 'app\\models\\Cliente', 1537382614, '{\"id\":45}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":45},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Prefeitura Alagoinhas\"},{\"attr\":\"email\",\"from\":null,\"to\":\"prefeituraalagoinha@alagoinhas.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"av principal\"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(301, 'app\\models\\Cliente', 1537382872, '{\"id\":46}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":46},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"13646005000138\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Prefeitura Alagoinhas\"},{\"attr\":\"email\",\"from\":null,\"to\":\"prefeituraalagoinhas@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-19\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(302, 'app\\models\\AnexosDocumentos', 1537382872, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/13646005000138/2578826.txt\"}]'),
(303, 'app\\models\\AnexosDocumentos', 1537382873, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/13646005000138/4897245.txt\"}]'),
(304, 'app\\models\\ContatoCliente', 1537382892, '{\"id\":25}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":25},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Joaquim neto\"},{\"attr\":\"email\",\"from\":null,\"to\":\"joaquim@alagoinhas.com.br\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/13646005000138/1901584.jpeg\"}]'),
(305, 'app\\models\\Telefone', 1537382892, '{\"id\":5}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":5},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":25},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"75975757575\"}]'),
(306, 'app\\models\\AnexosDocumentos', 1537411680, '{\"id\":17}', 2, 'update', '[{\"attr\":\"anexo\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/13646005000138/teste.txt\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/10405329000196/5990071.txt\"}]'),
(307, 'app\\models\\TipoTelefone', 1537446312, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"descricao\",\"from\":null,\"to\":\"Whatsapp\"}]'),
(308, 'app\\models\\AnexosDocumentos', 1537448469, '{\"id\":17}', 2, 'update', '[{\"attr\":\"anexo\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/10405329000196/5990071.txt\",\"to\":null}]'),
(309, 'app\\models\\Telefone', 1537448470, '{\"id\":6}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":6},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":15},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"64564564564\"}]'),
(310, 'app\\models\\Telefone', 1537448470, '{\"id\":7}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":7},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":15},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"53575675756\"}]'),
(311, 'app\\models\\Telefone', 1537448470, '{\"id\":8}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":8},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":15},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"65475656567\"}]'),
(312, 'app\\models\\AnexosDocumentos', 1537449883, '{\"id\":17}', 2, 'update', '[{\"attr\":\"anexo\",\"from\":\"\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/10405329000196/786472.txt\"}]'),
(313, 'app\\models\\AnexosDocumentos', 1537449934, '{\"id\":17}', 2, 'update', '[{\"attr\":\"anexo\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/10405329000196/786472.txt\",\"to\":null}]'),
(314, 'app\\models\\AnexosDocumentos', 1537449956, '{\"id\":17}', 2, 'update', '[{\"attr\":\"anexo\",\"from\":\"\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/10405329000196/5051054.txt\"}]'),
(315, 'app\\models\\AnexosDocumentos', 1537449989, '{\"id\":17}', 2, 'update', '[{\"attr\":\"anexo\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/10405329000196/5051054.txt\",\"to\":null}]'),
(316, 'app\\models\\AnexosDocumentos', 1537450054, '{\"id\":17}', 2, 'update', '[{\"attr\":\"anexo\",\"from\":\"\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/10405329000196/7005477.txt\"}]'),
(317, 'app\\models\\ContatoCliente', 1537460336, '{\"id\":25}', 2, 'update', '[{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/13646005000138/6142297.jpeg\"}]'),
(318, 'app\\models\\ContatoCliente', 1537460360, '{\"id\":25}', 2, 'update', '[{\"attr\":\"fk_departamento\",\"from\":1,\"to\":3},{\"attr\":\"nome\",\"from\":\"Joaquim neto\",\"to\":\"Joaquim neto Prefeito\"}]'),
(319, 'app\\models\\AnexosDocumentos', 1537468077, '{\"id\":18}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":18},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/13646005000138/3781198.png\"}]'),
(320, 'app\\models\\ContatoCliente', 1537468077, '{\"id\":26}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":26},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(321, 'app\\models\\Telefone', 1537546724, '{\"id\":9}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":9},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":26},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"42342342342\"}]'),
(322, 'app\\models\\Telefone', 1537546724, '{\"id\":10}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":10},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":26},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"44353423412\"}]'),
(323, 'app\\models\\ContatoCliente', 1537546724, '{\"id\":27}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":27},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Joseildo Ramos\"},{\"attr\":\"email\",\"from\":null,\"to\":\"joseildo@gmail.com\"}]'),
(324, 'app\\models\\ContatoCliente', 1537546724, '{\"id\":28}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":28},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcelo Ramos\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcelo@gmail.com\"}]'),
(325, 'app\\models\\TipoCliente', 1537558886, '{\"id\":3}', 1, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"descricao\",\"from\":null,\"to\":\"Representante\"},{\"attr\":\"codigo\",\"from\":null,\"to\":5}]'),
(326, 'app\\models\\Cliente', 1537812917, '{\"id\":47}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":47},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(327, 'app\\models\\Cliente', 1537813200, '{\"id\":48}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":48},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(328, 'app\\models\\Cliente', 1537813395, '{\"id\":49}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":49},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(329, 'app\\models\\Cliente', 1537813412, '{\"id\":50}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":50},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(330, 'app\\models\\Cliente', 1537813442, '{\"id\":51}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":51},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(331, 'app\\models\\Cliente', 1537813450, '{\"id\":52}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":52},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(332, 'app\\models\\Cliente', 1537813698, '{\"id\":53}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":53},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"tesrte\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(333, 'app\\models\\Cliente', 1537813733, '{\"id\":54}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":54},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"tesrte\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(334, 'app\\models\\Cliente', 1537814005, '{\"id\":55}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":55},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(335, 'app\\models\\Cliente', 1537814178, '{\"id\":56}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":56},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":3},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(336, 'app\\models\\Cliente', 1537814262, '{\"id\":57}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":57},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":3},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(337, 'app\\models\\Cliente', 1537814296, '{\"id\":58}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":58},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":3},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(338, 'app\\models\\Cliente', 1537814307, '{\"id\":59}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":59},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":3},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(339, 'app\\models\\Cliente', 1537814459, '{\"id\":60}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":60},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(340, 'app\\models\\ContatoCliente', 1537814459, '{\"id\":29}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":29},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":60},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"}]'),
(341, 'app\\models\\Cliente', 1537814709, '{\"id\":61}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":61},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(342, 'app\\models\\ContatoCliente', 1537814709, '{\"id\":30}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":30},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":61},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(343, 'app\\models\\ContatoCliente', 1537814709, '{\"id\":31}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":31},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":61},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Davi Barbosa de Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(344, 'app\\models\\Cliente', 1537814812, '{\"id\":62}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":62},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(345, 'app\\models\\ContatoCliente', 1537814812, '{\"id\":32}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":32},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":62},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"}]'),
(346, 'app\\models\\Telefone', 1537814813, '{\"id\":11}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":11},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":32},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"12323123123\"}]'),
(347, 'app\\models\\Telefone', 1537814813, '{\"id\":12}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":12},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":32},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"23131231231\"}]'),
(348, 'app\\models\\ContatoCliente', 1537814813, '{\"id\":33}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":33},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":62},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"}]'),
(349, 'app\\models\\Cliente', 1537815225, '{\"id\":63}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":63},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":3},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(350, 'app\\models\\ContatoCliente', 1537815225, '{\"id\":34}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":34},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":63},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(351, 'app\\models\\ContatoCliente', 1537815225, '{\"id\":35}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":35},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":63},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Dona Mita Seu Juca\"},{\"attr\":\"email\",\"from\":null,\"to\":\"josenitamarise@gmail.com\"}]'),
(352, 'app\\models\\Cliente', 1537815478, '{\"id\":64}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":64},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(353, 'app\\models\\ContatoCliente', 1537815478, '{\"id\":36}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":36},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":64},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(354, 'app\\models\\Cliente', 1537815505, '{\"id\":65}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":65},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(355, 'app\\models\\ContatoCliente', 1537815505, '{\"id\":37}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":37},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":65},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(356, 'app\\models\\ContatoCliente', 1537815505, '{\"id\":38}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":38},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":65},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(357, 'app\\models\\Cliente', 1537815581, '{\"id\":66}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":66},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(358, 'app\\models\\ContatoCliente', 1537815581, '{\"id\":39}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":39},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":66},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(359, 'app\\models\\ContatoCliente', 1537815582, '{\"id\":40}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":40},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":66},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(360, 'app\\models\\Cliente', 1537816021, '{\"id\":67}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":67},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(361, 'app\\models\\ContatoCliente', 1537816021, '{\"id\":41}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":41},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":67},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(362, 'app\\models\\Telefone', 1537816021, '{\"id\":13}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":13},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":41},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"11111111111\"}]'),
(363, 'app\\models\\Telefone', 1537816021, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":41},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"22222222222\"}]'),
(364, 'app\\models\\ContatoCliente', 1537816021, '{\"id\":42}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":42},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":67},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Dona Mita Seu Juca\"},{\"attr\":\"email\",\"from\":null,\"to\":\"josenitamarise@gmail.com\"}]'),
(365, 'app\\models\\Telefone', 1537816021, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":42},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"33333333333\"}]'),
(366, 'app\\models\\Cliente', 1537816775, '{\"id\":68}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":68},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-24\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(367, 'app\\models\\ContatoCliente', 1537816777, '{\"id\":43}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":43},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":68},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/5238160.jpeg\"}]'),
(368, 'app\\models\\Telefone', 1537816777, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":43},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":1},{\"attr\":\"telefone\",\"from\":null,\"to\":\"22222222222\"}]'),
(369, 'app\\models\\ContatoCliente', 1537816793, '{\"id\":44}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":44},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":68},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"}]'),
(370, 'app\\models\\Cliente', 1537970623, '{\"id\":22}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/10405329000196/9810576.jpg\"}]'),
(371, 'app\\models\\Cliente', 1537970648, '{\"id\":25}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/4922969.jpg\"}]'),
(372, 'app\\models\\Cliente', 1537970672, '{\"id\":46}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/13646005000138/7248561.jpg\"}]'),
(373, 'app\\models\\Cliente', 1537971057, '{\"id\":47}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":47},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Vin Diesel\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/6496607.jpg\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41760035\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Costa Azul \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Doutor Augusto Lopes Pontes \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Condominio Costa do Atlantico\"},{\"attr\":\"numero\",\"from\":null,\"to\":455},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-26\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(374, 'app\\models\\ContatoCliente', 1537971058, '{\"id\":29}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":29},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":47},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Mae\"},{\"attr\":\"email\",\"from\":null,\"to\":\"josenitamarise@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/7937069.jpeg\"}]'),
(375, 'app\\models\\Telefone', 1537971058, '{\"id\":11}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":11},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":29},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"75999717455\"}]'),
(376, 'app\\models\\ContatoCliente', 1537971059, '{\"id\":30}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":30},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":47},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Pai\"},{\"attr\":\"email\",\"from\":null,\"to\":\"ailtonaraujo@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/475827.jpeg\"}]'),
(377, 'app\\models\\Telefone', 1537971059, '{\"id\":12}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":12},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":30},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71999878714\"}]'),
(378, 'app\\models\\ContatoCliente', 1537971059, '{\"id\":31}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":31},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":47},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Irmao\"},{\"attr\":\"email\",\"from\":null,\"to\":\"airtonaraujo@gmail.com\"}]'),
(379, 'app\\models\\Telefone', 1537971059, '{\"id\":13}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":13},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":31},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"75999622530\"}]'),
(380, 'app\\models\\Cliente', 1537971864, '{\"id\":48}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":48},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"03449275000103\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Arcos Dourados Comercio de Alimentos LTDA.\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Mc Donalds\"},{\"attr\":\"email\",\"from\":null,\"to\":\"mcdonalds@mcdonalds.com\"},{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/03.449.275/0001-03/2055112.png\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41701035\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Alphaville I \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Parati \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"av principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":0},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-09-26\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(381, 'app\\models\\ContatoCliente', 1537971864, '{\"id\":32}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":32},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"Ronald\"},{\"attr\":\"email\",\"from\":null,\"to\":\"ronald@mcdonalds.com\"}]'),
(382, 'app\\models\\TipoOrgao', 1538406453, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"descricao\",\"from\":null,\"to\":\"Prefeitura\"},{\"attr\":\"sigla\",\"from\":null,\"to\":\"PFR\"}]'),
(383, 'app\\models\\TipoCliente', 1538406464, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"descricao\",\"from\":null,\"to\":\"Prefeitura\"},{\"attr\":\"codigo\",\"from\":null,\"to\":1}]'),
(384, 'app\\models\\Cliente', 1538442672, '{\"id\":25}', 2, 'update', '[{\"attr\":\"fk_tipo_cliente\",\"from\":2,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":2,\"to\":3},{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/4922969.jpg\",\"to\":null}]'),
(385, 'app\\models\\Cliente', 1538443391, '{\"id\":25}', 2, 'update', '[{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":2}]'),
(386, 'app\\models\\Cliente', 1538445696, '{\"id\":25}', 2, 'update', '[{\"attr\":\"fk_tipo_orgao\",\"from\":2,\"to\":3}]'),
(387, 'app\\models\\Cliente', 1538675720, '{\"id\":25}', 2, 'update', '[{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":2},{\"attr\":\"brasao\",\"from\":\"\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/2785223.jpg\"}]'),
(388, 'app\\models\\Cliente', 1538675753, '{\"id\":25}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/2785223.jpg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/5285058.jpg\"}]'),
(389, 'app\\models\\Cliente', 1538675937, '{\"id\":25}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/5285058.jpg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/7711904.jpg\"}]'),
(390, 'app\\models\\Cliente', 1538676418, '{\"id\":25}', 2, 'update', '[{\"attr\":\"fk_tipo_orgao\",\"from\":2,\"to\":1},{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/7711904.jpg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/657327.jpg\"}]'),
(391, 'app\\models\\Cliente', 1538677899, '{\"id\":25}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/657327.jpg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/373881.jpg\"}]'),
(392, 'app\\models\\Cliente', 1538677994, '{\"id\":25}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/373881.jpg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/2505618.jpg\"}]'),
(393, 'app\\models\\Cliente', 1538678013, '{\"id\":25}', 2, 'update', '[{\"attr\":\"fk_tipo_cliente\",\"from\":4,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":1,\"to\":2},{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/2505618.jpg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/8861001.jpg\"}]'),
(394, 'app\\models\\Cliente', 1538697537, '{\"id\":22}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/10405329000196/9810576.jpg\",\"to\":null}]');
INSERT INTO `audit_trail_entry` (`id`, `model_type`, `happened_at`, `foreign_pk`, `user_id`, `type`, `data`) VALUES
(395, 'app\\models\\Cliente', 1538698091, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10405329000196\",\"to\":\"10.405.329/0001-96\"},{\"attr\":\"cep\",\"from\":\"48080070\",\"to\":\"48080-070\"},{\"attr\":\"data_cadastro\",\"from\":\"2018-09-03\",\"to\":\"03/09/2018\"}]'),
(396, 'app\\models\\Cliente', 1538698100, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/0001-96\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-070\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"03/09/2018\"}]'),
(397, 'app\\models\\Cliente', 1538698254, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(398, 'app\\models\\Cliente', 1538698266, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(399, 'app\\models\\Cliente', 1538698293, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(400, 'app\\models\\Cliente', 1538698328, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(401, 'app\\models\\Cliente', 1538698355, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(402, 'app\\models\\Cliente', 1538698378, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(403, 'app\\models\\Cliente', 1538698385, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(404, 'app\\models\\Cliente', 1538698396, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(405, 'app\\models\\Cliente', 1538698404, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(406, 'app\\models\\Cliente', 1538698418, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(407, 'app\\models\\Cliente', 1538698437, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(408, 'app\\models\\Cliente', 1538698447, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(409, 'app\\models\\Cliente', 1538698458, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(410, 'app\\models\\Cliente', 1538698478, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(411, 'app\\models\\Cliente', 1538698533, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(412, 'app\\models\\Cliente', 1538698549, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(413, 'app\\models\\Cliente', 1538698560, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(414, 'app\\models\\Cliente', 1538698594, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(415, 'app\\models\\Cliente', 1538698603, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(416, 'app\\models\\Cliente', 1538698609, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(417, 'app\\models\\Cliente', 1538700226, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(418, 'app\\models\\Cliente', 1538700483, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(419, 'app\\models\\Cliente', 1538700544, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(420, 'app\\models\\Cliente', 1538700680, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(421, 'app\\models\\Cliente', 1538701067, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(422, 'app\\models\\Cliente', 1538701122, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(423, 'app\\models\\Cliente', 1538701181, '{\"id\":47}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"04151452524\",\"to\":\"041.514.525-24\"},{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/6496607.jpg\",\"to\":null},{\"attr\":\"cep\",\"from\":\"41760035\",\"to\":\"41760-035\"},{\"attr\":\"data_cadastro\",\"from\":\"2018-09-26\",\"to\":\"26/09/2018\"}]'),
(424, 'app\\models\\Cliente', 1538701198, '{\"id\":47}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":\"04.151.452/524_-__\"},{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(425, 'app\\models\\Cliente', 1538701405, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(426, 'app\\models\\Cliente', 1538701441, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(427, 'app\\models\\Cliente', 1538701494, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(428, 'app\\models\\Cliente', 1538701512, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(429, 'app\\models\\Cliente', 1538702357, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(430, 'app\\models\\Cliente', 1538702371, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(431, 'app\\models\\Cliente', 1538702378, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(432, 'app\\models\\Cliente', 1538702390, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(433, 'app\\models\\Cliente', 1538702430, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(434, 'app\\models\\Cliente', 1538702447, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(435, 'app\\models\\Cliente', 1538703533, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"brasao\",\"from\":\"\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/10.405.329/000_-__/6502492.jpg\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(436, 'app\\models\\Cliente', 1538703602, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/10.405.329/000_-__/6502492.jpg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/10.405.329/000_-__/6446363.jpg\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(437, 'app\\models\\Cliente', 1538703660, '{\"id\":47}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"04.151.452/524\",\"to\":\"04.151.452/524_-__\"},{\"attr\":\"brasao\",\"from\":\"\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04.151.452/524_-__/5755518.jpg\"},{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":\"41760-03_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(438, 'app\\models\\Cliente', 1538704306, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":\"10.405.329/000_-__\"},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":\"48080-07_\"},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"30/11/-0001\"}]'),
(439, 'app\\models\\Cliente', 1538705290, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"10.405.329/000\",\"to\":2147483647},{\"attr\":\"cep\",\"from\":\"48080-07\",\"to\":4808007},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"-0001-11-30\"}]'),
(440, 'app\\models\\Cliente', 1538705502, '{\"id\":22}', 2, 'update', '[{\"attr\":\"fk_tipo_cliente\",\"from\":3,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":2,\"to\":3},{\"attr\":\"data_cadastro\",\"from\":\"0000-00-00\",\"to\":\"-0001-11-30\"}]'),
(441, 'app\\models\\Cliente', 1538706961, '{\"id\":22}', 2, 'update', '[{\"attr\":\"cep\",\"from\":\"4808007\",\"to\":48080070}]'),
(442, 'app\\models\\Cliente', 1538711524, '{\"id\":22}', 2, 'update', '[{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":2}]'),
(443, 'app\\models\\Cliente', 1538742428, '{\"id\":22}', 2, 'update', '[{\"attr\":\"fk_tipo_orgao\",\"from\":2,\"to\":3}]'),
(444, 'app\\models\\Cliente', 1538742465, '{\"id\":22}', 2, 'update', '[{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":1}]'),
(445, 'app\\models\\Cliente', 1538742513, '{\"id\":22}', 2, 'update', '[{\"attr\":\"fk_tipo_orgao\",\"from\":1,\"to\":3}]'),
(446, 'app\\models\\Cliente', 1538744587, '{\"id\":49}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":49},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"07/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(447, 'app\\models\\Gestao', 1538744587, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":49},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(448, 'app\\models\\ContatoCliente', 1538744587, '{\"id\":33}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":33},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":49},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@teste.com\"}]'),
(449, 'app\\models\\Telefone', 1538744587, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":33},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71999999999\"}]'),
(450, 'app\\models\\Cliente', 1538745772, '{\"id\":50}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":50},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"16/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-22\"}]'),
(451, 'app\\models\\Gestao', 1538745772, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":50},{\"attr\":\"periodo\",\"from\":null,\"to\":\"09/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(452, 'app\\models\\ContatoCliente', 1538745777, '{\"id\":34}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":34},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":50},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/5439437.png\"}]'),
(453, 'app\\models\\Cliente', 1538745809, '{\"id\":51}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":51},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"16/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-22\"}]'),
(454, 'app\\models\\Gestao', 1538745809, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":51},{\"attr\":\"periodo\",\"from\":null,\"to\":\"09/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(455, 'app\\models\\Cliente', 1538745827, '{\"id\":52}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":52},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"16/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-22\"}]'),
(456, 'app\\models\\Gestao', 1538745827, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":52},{\"attr\":\"periodo\",\"from\":null,\"to\":\"09/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(457, 'app\\models\\Cliente', 1538745945, '{\"id\":53}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":53},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"16/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-22\"}]'),
(458, 'app\\models\\Gestao', 1538745945, '{\"id\":5}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":5},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":53},{\"attr\":\"periodo\",\"from\":null,\"to\":\"09/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(459, 'app\\models\\Cliente', 1538746010, '{\"id\":54}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":54},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"09/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(460, 'app\\models\\Gestao', 1538746010, '{\"id\":6}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":6},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":54},{\"attr\":\"periodo\",\"from\":null,\"to\":\"03/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(461, 'app\\models\\Cliente', 1538746338, '{\"id\":55}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":55},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":22},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":22},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"08/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"2\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-09\"}]'),
(462, 'app\\models\\Gestao', 1538746338, '{\"id\":7}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":7},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":55},{\"attr\":\"periodo\",\"from\":null,\"to\":\"09/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-11\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(463, 'app\\models\\ContatoCliente', 1538746339, '{\"id\":35}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":35},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":55},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"LUAN DIEGO LUZ ARAUJO\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/3414503.jpeg\"}]'),
(464, 'app\\models\\Cliente', 1538747069, '{\"id\":56}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":56},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"01/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(465, 'app\\models\\Gestao', 1538747069, '{\"id\":8}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":8},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":56},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(466, 'app\\models\\ContatoCliente', 1538747069, '{\"id\":36}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":36},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":56},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(467, 'app\\models\\Telefone', 1538747069, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":36},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(468, 'app\\models\\ContatoCliente', 1538747074, '{\"id\":37}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":37},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":56},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Diretoria Cometa\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/372384.png\"}]'),
(469, 'app\\models\\Cliente', 1538747100, '{\"id\":57}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":57},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"01/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(470, 'app\\models\\Gestao', 1538747100, '{\"id\":9}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":9},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":57},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(471, 'app\\models\\ContatoCliente', 1538747100, '{\"id\":38}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":38},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":57},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(472, 'app\\models\\Telefone', 1538747100, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":38},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(473, 'app\\models\\ContatoCliente', 1538747105, '{\"id\":39}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":39},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":57},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Diretoria Cometa\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/9655129.png\"}]'),
(474, 'app\\models\\Cliente', 1538747120, '{\"id\":58}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":58},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"01/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(475, 'app\\models\\Gestao', 1538747120, '{\"id\":10}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":10},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":58},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(476, 'app\\models\\ContatoCliente', 1538747120, '{\"id\":40}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":40},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":58},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(477, 'app\\models\\Telefone', 1538747120, '{\"id\":17}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":17},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":40},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(478, 'app\\models\\ContatoCliente', 1538747125, '{\"id\":41}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":41},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":58},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Diretoria Cometa\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/8936757.png\"}]'),
(479, 'app\\models\\Cliente', 1538747151, '{\"id\":59}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":59},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"01/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(480, 'app\\models\\Gestao', 1538747151, '{\"id\":11}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":11},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":59},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(481, 'app\\models\\ContatoCliente', 1538747151, '{\"id\":42}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":42},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":59},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(482, 'app\\models\\Telefone', 1538747151, '{\"id\":18}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":18},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":42},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(483, 'app\\models\\ContatoCliente', 1538747157, '{\"id\":43}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":43},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":59},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Diretoria Cometa\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/3958181.png\"}]'),
(484, 'app\\models\\Cliente', 1538747158, '{\"id\":60}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":60},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"01/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(485, 'app\\models\\Gestao', 1538747158, '{\"id\":12}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":12},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":60},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(486, 'app\\models\\ContatoCliente', 1538747158, '{\"id\":44}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":44},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":60},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(487, 'app\\models\\Telefone', 1538747158, '{\"id\":19}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":19},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":44},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(488, 'app\\models\\ContatoCliente', 1538747163, '{\"id\":45}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":45},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":60},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Diretoria Cometa\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/4864557.png\"}]'),
(489, 'app\\models\\Cliente', 1538747364, '{\"id\":61}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":61},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"01/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(490, 'app\\models\\Gestao', 1538747364, '{\"id\":13}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":13},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":61},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(491, 'app\\models\\ContatoCliente', 1538747364, '{\"id\":46}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":46},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":61},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(492, 'app\\models\\Telefone', 1538747364, '{\"id\":20}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":20},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":46},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(493, 'app\\models\\ContatoCliente', 1538747370, '{\"id\":47}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":47},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":61},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Diretoria Cometa\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/7594814.png\"}]'),
(494, 'app\\models\\Cliente', 1538747404, '{\"id\":62}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":62},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"01/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(495, 'app\\models\\Gestao', 1538747404, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":62},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(496, 'app\\models\\ContatoCliente', 1538747404, '{\"id\":48}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":48},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":62},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(497, 'app\\models\\Telefone', 1538747404, '{\"id\":21}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":21},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(498, 'app\\models\\ContatoCliente', 1538747411, '{\"id\":49}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":49},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":62},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Diretoria Cometa\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/1479766.png\"}]');
INSERT INTO `audit_trail_entry` (`id`, `model_type`, `happened_at`, `foreign_pk`, `user_id`, `type`, `data`) VALUES
(499, 'app\\models\\Cliente', 1538747439, '{\"id\":63}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":63},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"01/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(500, 'app\\models\\Gestao', 1538747439, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":63},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(501, 'app\\models\\ContatoCliente', 1538747439, '{\"id\":50}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":50},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":63},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(502, 'app\\models\\Telefone', 1538747439, '{\"id\":22}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":22},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":50},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(503, 'app\\models\\Cliente', 1538747448, '{\"id\":64}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":64},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"01/10/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-10-01\"}]'),
(504, 'app\\models\\Gestao', 1538747448, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":64},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(505, 'app\\models\\ContatoCliente', 1538747448, '{\"id\":51}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":51},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":64},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Josenita Marise Luz Araujo Luz Ailton Batista Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"}]'),
(506, 'app\\models\\Telefone', 1538747448, '{\"id\":23}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":23},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":51},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"99999999999\"}]'),
(507, 'app\\models\\ContatoCliente', 1538747458, '{\"id\":52}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":52},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":64},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Diretoria Cometa\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/9752184.png\"}]'),
(508, 'app\\models\\Cliente', 1538747850, '{\"id\":65}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":65},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/9122329.jpg\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA\"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"30/09/2018\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2018-09-30\"}]'),
(509, 'app\\models\\Gestao', 1538747850, '{\"id\":17}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":17},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":65},{\"attr\":\"periodo\",\"from\":null,\"to\":\"02/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(510, 'app\\models\\ContatoCliente', 1538747850, '{\"id\":53}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":53},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":65},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Marcos Davi Barbosa de Almeida\"},{\"attr\":\"email\",\"from\":null,\"to\":\"marcos.dba1995@hotmail.com\"}]'),
(511, 'app\\models\\Telefone', 1538747850, '{\"id\":24}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":24},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":53},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"88888888888\"}]'),
(512, 'app\\models\\ContatoCliente', 1538747851, '{\"id\":54}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":54},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":65},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Henry Allen West\"},{\"attr\":\"email\",\"from\":null,\"to\":\"diretoriasa@direct.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/8020311.jpeg\"}]'),
(513, 'app\\models\\Cliente', 1538759620, '{\"id\":65}', 2, 'update', '[{\"attr\":\"ano_populacao\",\"from\":\"2018\",\"to\":2006},{\"attr\":\"fpm\",\"from\":\"11.00000\",\"to\":11}]'),
(514, 'app\\models\\Gestao', 1538759620, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"02/10/201\",\"to\":\"09/10/2018 - 29/11/2018\"}]'),
(515, 'app\\models\\Cliente', 1538760026, '{\"id\":65}', 2, 'update', '[{\"attr\":\"fpm\",\"from\":\"11.00000\",\"to\":1}]'),
(516, 'app\\models\\Gestao', 1538760026, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"09/10/2018 - 29/11/2018\",\"to\":\"16/10/2018 - 16/10/2018 - 29/11/2018 - 29/11/2018\"}]'),
(517, 'app\\models\\Cliente', 1538760735, '{\"id\":65}', 2, 'update', '[{\"attr\":\"fpm\",\"from\":\"1.00000\",\"to\":1}]'),
(518, 'app\\models\\Gestao', 1538760735, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"16/10/2018 - 16/10/2018\",\"to\":\"17/10/2018 - 17/10/2018 - 30/11/2018 - 30/11/2018\"}]'),
(519, 'app\\models\\Gestao', 1538765022, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"17/10/2018 - 17/10/2018\",\"to\":\"01-01-2014 - 01-01-2018\"}]'),
(520, 'app\\models\\Cliente', 1538791921, '{\"id\":47}', 2, 'update', '[{\"attr\":\"cpf_cnpj\",\"from\":\"04.151.452/524\",\"to\":2147483647},{\"attr\":\"cep\",\"from\":\"41760-03\",\"to\":4176003}]'),
(521, 'app\\models\\Gestao', 1539086926, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014 a 01-01-2018\",\"to\":\"01-01-2013 a 01-01-2018\"}]'),
(522, 'app\\models\\Cliente', 1539086945, '{\"id\":65}', 2, 'update', '[{\"attr\":\"fk_tipo_cliente\",\"from\":4,\"to\":2}]'),
(523, 'app\\models\\Gestao', 1539086945, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2013 a 01-01-2018\",\"to\":\"01-01-2013  a  01-01-2018\"}]'),
(524, 'app\\models\\Gestao', 1539087405, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2013  a  01-01-20\",\"to\":\"01-01-2014 a 01-01-2018\"}]'),
(525, 'app\\models\\Gestao', 1539189113, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014 a 01-01-2018\",\"to\":\"01-01-2014  a  01-01-2018\"}]'),
(526, 'app\\models\\ContatoCliente', 1539189131, '{\"id\":55}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":55},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":65},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/5352881.jpeg\"}]'),
(527, 'app\\models\\Telefone', 1539189131, '{\"id\":25}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":25},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":55},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"77145234234\"}]'),
(528, 'app\\models\\Gestao', 1539189702, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014  a  01-01-20\",\"to\":\"01-01-2014   a   01-01-20\"}]'),
(529, 'app\\models\\ContatoCliente', 1539189702, '{\"id\":53}', 2, 'update', '[{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2000-10-11\"}]'),
(530, 'app\\models\\Gestao', 1539189723, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014   a   01-01-\",\"to\":\"01-01-2014    a    01-01-\"}]'),
(531, 'app\\models\\ContatoCliente', 1539189723, '{\"id\":53}', 2, 'update', '[{\"attr\":\"data_nascimento\",\"from\":\"2000-10-11\",\"to\":\"2018-10-30\"}]'),
(532, 'app\\models\\Gestao', 1539189781, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014    a    01-0\",\"to\":\"01-01-2014     a     01-0\"}]'),
(533, 'app\\models\\ContatoCliente', 1539189781, '{\"id\":53}', 2, 'update', '[{\"attr\":\"data_nascimento\",\"from\":\"2018-10-30\",\"to\":\"2018-10-18\"}]'),
(534, 'app\\models\\Gestao', 1539189811, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014     a     01\",\"to\":\"01-01-2014      a      01\"}]'),
(535, 'app\\models\\Gestao', 1539190515, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014      a      \",\"to\":\"01-01-2014       a       \"}]'),
(536, 'app\\models\\ContatoCliente', 1539190515, '{\"id\":53}', 2, 'update', '[{\"attr\":\"data_nascimento\",\"from\":\"2018-10-18\",\"to\":\"1999-10-06\"}]'),
(537, 'app\\models\\Gestao', 1539190564, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014       a     \",\"to\":\"01-01-2014        a      \"}]'),
(538, 'app\\models\\ContatoCliente', 1539190564, '{\"id\":56}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":56},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":65},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Dona Mita Seu Juca\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"email\",\"from\":null,\"to\":\"josenitamarise@gmail.com\"}]'),
(539, 'app\\models\\Gestao', 1539190607, '{\"id\":17}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014        a    \",\"to\":\"01-01-2014         a     \"}]'),
(540, 'app\\models\\Cliente', 1539194577, '{\"id\":66}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":66},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":4},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-10\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(541, 'app\\models\\Cliente', 1539194592, '{\"id\":66}', 2, 'delete', '[{\"attr\":\"id\",\"from\":66,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":4,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":2,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"teste\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"teste\",\"to\":null},{\"attr\":\"email\",\"from\":\"teste@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"\",\"to\":null},{\"attr\":\"cep\",\"from\":\"41130-000\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Salvador\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Pernambués \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":1,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"10/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"\",\"to\":null},{\"attr\":\"fpm\",\"from\":null,\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"\",\"to\":null}]'),
(542, 'app\\models\\Cliente', 1539194847, '{\"id\":67}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":67},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-10\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(543, 'app\\models\\Cliente', 1539195166, '{\"id\":68}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":68},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Josenita Marise Ailton Araujo\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-10\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(544, 'app\\models\\Cliente', 1539195842, '{\"id\":68}', 2, 'delete', '[{\"attr\":\"id\",\"from\":68,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":2,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"Josenita Marise Ailton Araujo\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"Josenita Marise Ailton Araujo\",\"to\":null},{\"attr\":\"email\",\"from\":\"luanaraujo@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"\",\"to\":null},{\"attr\":\"cep\",\"from\":\"48080-070\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Alagoinhas\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Jardim Pedro Braga \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Alfredo Garcia \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":1,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"10/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"\",\"to\":null},{\"attr\":\"fpm\",\"from\":null,\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"\",\"to\":null}]'),
(545, 'app\\models\\Cliente', 1539195870, '{\"id\":67}', 2, 'delete', '[{\"attr\":\"id\",\"from\":67,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":2,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"Josenita Marise Ailton Araujo\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"Josenita Marise Ailton Araujo\",\"to\":null},{\"attr\":\"email\",\"from\":\"luanaraujo@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"\",\"to\":null},{\"attr\":\"cep\",\"from\":\"48080-070\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Alagoinhas\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Jardim Pedro Braga \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Alfredo Garcia \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":1,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"10/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"\",\"to\":null},{\"attr\":\"fpm\",\"from\":null,\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"\",\"to\":null}]'),
(546, 'app\\models\\Cliente', 1539195889, '{\"id\":69}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":69},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":2},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-10\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(547, 'app\\models\\Cliente', 1539195906, '{\"id\":69}', 2, 'update', '[{\"attr\":\"razao_social\",\"from\":\"teste\",\"to\":\"teste 2\"}]'),
(548, 'app\\models\\ContatoCliente', 1539195929, '{\"id\":57}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":57},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":69},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(549, 'app\\models\\ContatoCliente', 1539195942, '{\"id\":58}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":58},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":69},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(550, 'app\\models\\Cliente', 1539223225, '{\"id\":69}', 2, 'update', '[{\"attr\":\"razao_social\",\"from\":\"teste 2\",\"to\":\"teste\"}]'),
(551, 'app\\models\\ContatoCliente', 1539223583, '{\"id\":58}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":58},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":69},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(552, 'app\\models\\ContatoCliente', 1539223655, '{\"id\":59}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":59},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":69},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(553, 'app\\models\\ContatoCliente', 1539223709, '{\"id\":60}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":60},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":69},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(554, 'app\\models\\ContatoCliente', 1539223932, '{\"id\":61}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":61},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":69},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(555, 'app\\models\\ContatoCliente', 1539224122, '{\"id\":62}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":62},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":69},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(556, 'app\\models\\Telefone', 1539224122, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":62},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"31231231232\"}]'),
(557, 'app\\models\\Cliente', 1539225611, '{\"id\":69}', 2, 'update', '[{\"attr\":\"fk_tipo_cliente\",\"from\":1,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":2,\"to\":3}]'),
(558, 'app\\models\\Gestao', 1539225611, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":69},{\"attr\":\"periodo\",\"from\":null,\"to\":\"31-01-2000 a 30-01-2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1989-02-14\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Airton Araujo\"}]'),
(559, 'app\\models\\Gestao', 1539275069, '{\"id\":1}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"31-01-2000 a 30-01-2018\",\"to\":\"22-10-2018 a 01-01-2018\"}]'),
(560, 'app\\models\\Gestao', 1539275069, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":69},{\"attr\":\"periodo\",\"from\":null,\"to\":\"22-10-2018 a 01-01-2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1989-02-14\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(561, 'app\\models\\Cliente', 1539278654, '{\"id\":70}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":70},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-11\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(562, 'app\\models\\Cliente', 1539278879, '{\"id\":70}', 2, 'delete', '[{\"attr\":\"id\",\"from\":70,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":2,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"teste\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"teste\",\"to\":null},{\"attr\":\"email\",\"from\":\"luanaraujo@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"\",\"to\":null},{\"attr\":\"cep\",\"from\":\"48080-070\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Alagoinhas\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Jardim Pedro Braga \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Alfredo Garcia \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":1,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"11/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"\",\"to\":null},{\"attr\":\"fpm\",\"from\":null,\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"\",\"to\":null}]'),
(563, 'app\\models\\Cliente', 1539279308, '{\"id\":71}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":71},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":11},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-11\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"2006\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2006\"}]'),
(564, 'app\\models\\Cliente', 1539279323, '{\"id\":72}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":72},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luanaraujo@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"48080070\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Alagoinhas\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Jardim Pedro Braga \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Alfredo Garcia \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":11},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-11\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"2006\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2006\"}]'),
(565, 'app\\models\\Cliente', 1539279345, '{\"id\":72}', 2, 'delete', '[{\"attr\":\"id\",\"from\":72,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":2,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"teste\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"teste\",\"to\":null},{\"attr\":\"email\",\"from\":\"luanaraujo@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"\",\"to\":null},{\"attr\":\"cep\",\"from\":\"48080-070\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Alagoinhas\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Jardim Pedro Braga \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Alfredo Garcia \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":11,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"11/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":11,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":11,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"2006\",\"to\":null},{\"attr\":\"fpm\",\"from\":\"11,00\",\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"2006\",\"to\":null}]'),
(566, 'app\\models\\Cliente', 1539279348, '{\"id\":71}', 2, 'delete', '[{\"attr\":\"id\",\"from\":71,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":2,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"teste\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"teste\",\"to\":null},{\"attr\":\"email\",\"from\":\"luanaraujo@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"\",\"to\":null},{\"attr\":\"cep\",\"from\":\"48080-070\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Alagoinhas\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Jardim Pedro Braga \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Alfredo Garcia \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":11,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"11/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":11,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":11,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"2006\",\"to\":null},{\"attr\":\"fpm\",\"from\":\"11,00\",\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"2006\",\"to\":null}]'),
(567, 'app\\models\\Cliente', 1539279635, '{\"id\":73}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":73},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":11},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-11\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"2006\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2006\"}]'),
(568, 'app\\models\\Cliente', 1539279649, '{\"id\":73}', 2, 'delete', '[{\"attr\":\"id\",\"from\":73,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":2,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"teste\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"teste\",\"to\":null},{\"attr\":\"email\",\"from\":\"teste@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"\",\"to\":null},{\"attr\":\"cep\",\"from\":\"41130-000\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Salvador\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Pernambués \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":11,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"11/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":11,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":11,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"2006\",\"to\":null},{\"attr\":\"fpm\",\"from\":\"11,00\",\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"2006\",\"to\":null}]'),
(569, 'app\\models\\Cliente', 1539279796, '{\"id\":74}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":74},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":11},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-11\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"2006\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2006\"}]'),
(570, 'app\\models\\Cliente', 1539279861, '{\"id\":74}', 2, 'delete', '[{\"attr\":\"id\",\"from\":74,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":2,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"teste\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"teste\",\"to\":null},{\"attr\":\"email\",\"from\":\"teste@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"\",\"to\":null},{\"attr\":\"cep\",\"from\":\"41130-000\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Salvador\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Pernambués \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":11,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"11/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":11,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":11,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"2006\",\"to\":null},{\"attr\":\"fpm\",\"from\":\"11,00\",\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"2006\",\"to\":null}]'),
(571, 'app\\models\\Cliente', 1539280415, '{\"id\":75}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":75},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":11},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-11\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":11},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":11},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"2006\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"11\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2006\"}]'),
(572, 'app\\models\\Gestao', 1539280415, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":75},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01-01-2014 a 10-11-2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(573, 'app\\models\\Gestao', 1539280415, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":75},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01-01-2014 a 10-11-2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste2\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1989-02-14\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste2\"}]'),
(574, 'app\\models\\Gestao', 1539280439, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2014 a 10-11-2018\",\"to\":\" a \"}]'),
(575, 'app\\models\\Cliente', 1539284970, '{\"id\":75}', 2, 'update', '[{\"attr\":\"data_situacao\",\"from\":null,\"to\":\"2037 - 29-05-05\"}]'),
(576, 'app\\models\\Cliente', 1539364901, '{\"id\":75}', 2, 'update', '[{\"attr\":\"data_situacao\",\"from\":\"0000-00-00\",\"to\":\"2000-11-30\"},{\"attr\":\"qtd_populacao\",\"from\":11,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":11,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"2006\",\"to\":null},{\"attr\":\"fpm\",\"from\":\"11.00\",\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"2006\",\"to\":null}]'),
(577, 'app\\models\\Gestao', 1539364901, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":75},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/2000 a 01/01/2004\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1970-10-06\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(578, 'app\\models\\AnexosDocumentos', 1539383365, '{\"id\":19}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":19},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/13646005000138/9216263.txt\"}]'),
(579, 'app\\models\\AnexosDocumentos', 1539384752, '{\"id\":20}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":20},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/13646005000138/11935.01\"}]'),
(580, 'app\\models\\AnexosDocumentos', 1539385067, '{\"id\":21}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":21},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":46},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/13646005000138/5650609.txt\"}]'),
(581, 'app\\models\\Cliente', 1539385541, '{\"id\":76}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":76},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"teste 2\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"teste 2\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste2@gmail.com\"},{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/9479974.jpg\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41130000\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Pernambués \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Thomaz Gonzaga - de 372/373 ao fim \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal 2\"},{\"attr\":\"numero\",\"from\":null,\"to\":4},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-12\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":55},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":55},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"2004\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"33\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2005\"}]'),
(582, 'app\\models\\Gestao', 1539385541, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2004 a 16/10/2008\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste 3\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-05-08\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste 3\"}]'),
(583, 'app\\models\\AnexosDocumentos', 1539385541, '{\"id\":22}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":22},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":4},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/04151452524/3032566.txt\"}]'),
(584, 'app\\models\\AnexosDocumentos', 1539385541, '{\"id\":23}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":23},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/04151452524/9359806.01\"}]'),
(585, 'app\\models\\ContatoCliente', 1539385541, '{\"id\":33}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":33},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste 3\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2006-09-26\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste3@gmail.com\"}]'),
(586, 'app\\models\\Telefone', 1539385541, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":33},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"71855451321\"}]'),
(587, 'app\\models\\ContatoCliente', 1539385578, '{\"id\":33}', 2, 'update', '[{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/4853678.png\"}]');
INSERT INTO `audit_trail_entry` (`id`, `model_type`, `happened_at`, `foreign_pk`, `user_id`, `type`, `data`) VALUES
(588, 'app\\models\\Cliente', 1539385645, '{\"id\":77}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":77},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":3},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":1},{\"attr\":\"fk_representante\",\"from\":null,\"to\":48},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"srs\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"sdrsd\"},{\"attr\":\"email\",\"from\":null,\"to\":\"contato_interno@ford.com\"},{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/3593651.jpg\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41760035\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Costa Azul \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Doutor Augusto Lopes Pontes \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"Av. Principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":1},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-12\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1}]'),
(589, 'app\\models\\ContatoCliente', 1539385646, '{\"id\":34}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":34},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":77},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":1},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-15\"},{\"attr\":\"email\",\"from\":null,\"to\":\"luandiego7@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/2019934.png\"}]'),
(590, 'app\\models\\Gestao', 1539385728, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"16-46-451122 a 1231523523\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1989-02-14\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(591, 'app\\models\\Gestao', 1539451561, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/2009 a 01/01/2013\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste 4\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1966-07-17\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste 4\"}]'),
(592, 'app\\models\\Gestao', 1539462005, '{\"id\":5}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":5},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/01 a 01/01/01\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"dsfsdf\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"01-01-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"asdfsdg\"}]'),
(593, 'app\\models\\Gestao', 1539462081, '{\"id\":6}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":6},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/1001 a 01/01/1001\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"sdfsd\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1001-01-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"sdfsdf\"}]'),
(594, 'app\\models\\Gestao', 1539462106, '{\"id\":6}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/1001 a 01/01/1001\",\"to\":\"01/01/2000 a 01/01/2000\"},{\"attr\":\"data_nascimento\",\"from\":\"1001-01-01\",\"to\":\"2010-01-01\"}]'),
(595, 'app\\models\\Gestao', 1539462325, '{\"id\":7}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":7},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/2009 a 01/01/2009\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"sdfsdf\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2009-01-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"sdfsdfsdf\"}]'),
(596, 'app\\models\\Gestao', 1539617357, '{\"id\":2}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"04/10/2004 a 16/10/2008\",\"to\":\"04/10/2004  a  16/10/2008\"}]'),
(597, 'app\\models\\Gestao', 1539617357, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009 a 01/01/2013\",\"to\":\"01/01/2009  a  01/01/2013\"}]'),
(598, 'app\\models\\Gestao', 1539617357, '{\"id\":7}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009 a 01/01/2009\",\"to\":\"01/01/2009  a  01/01/2009\"}]'),
(599, 'app\\models\\Gestao', 1539617357, '{\"id\":8}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":8},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"07/11/2018 a 10/08/2019\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste 46\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-06-12\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste 46\"}]'),
(600, 'app\\models\\Gestao', 1539617377, '{\"id\":2}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"04/10/2004  a  16/10/20\",\"to\":\"04/10/2004   a   16/10/20\"}]'),
(601, 'app\\models\\Gestao', 1539617377, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009  a  01/01/20\",\"to\":\"01/01/2009   a   01/01/20\"}]'),
(602, 'app\\models\\Gestao', 1539617377, '{\"id\":7}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009  a  01/01/20\",\"to\":\"01/01/2009   a   01/01/20\"}]'),
(603, 'app\\models\\Gestao', 1539617377, '{\"id\":8}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"07/11/2018 a 10/08/2019\",\"to\":\"07/11/2018  a 27/08/2020\"}]'),
(604, 'app\\models\\Gestao', 1539617395, '{\"id\":2}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"04/10/2004   a   16/10/\",\"to\":\"04/10/2004    a    16/10/\"}]'),
(605, 'app\\models\\Gestao', 1539617395, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009   a   01/01/\",\"to\":\"01/01/2009    a    01/01/\"}]'),
(606, 'app\\models\\Gestao', 1539617395, '{\"id\":7}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009   a   01/01/\",\"to\":\"01/01/2009    a    01/01/\"}]'),
(607, 'app\\models\\Gestao', 1539617395, '{\"id\":8}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"07/11/2018  a 27/08/202\",\"to\":\"07/11/2018   a 27/08/2020\"}]'),
(608, 'app\\models\\Gestao', 1539617538, '{\"id\":2}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"04/10/2004    a    16/1\",\"to\":\"04/10/2004     a     16/1\"}]'),
(609, 'app\\models\\Gestao', 1539617538, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009    a    01/0\",\"to\":\"01-01-2009 a 25-10-2018\"}]'),
(610, 'app\\models\\Gestao', 1539617538, '{\"id\":7}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009    a    01/0\",\"to\":\"01/01/2009     a 09-11-2018\"}]'),
(611, 'app\\models\\Gestao', 1539617538, '{\"id\":8}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"07/11/2018   a 27/08/20\",\"to\":\"07/11/2018    a 04-09-1920\"}]'),
(612, 'app\\models\\Gestao', 1539617603, '{\"id\":2}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"04/10/2004     a     16\",\"to\":\"04/10/2004      a 10/10/2018\"}]'),
(613, 'app\\models\\Gestao', 1539617603, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2009 a 25-10-2018\",\"to\":\"01-01-2009  a 11/10/2018\"}]'),
(614, 'app\\models\\Gestao', 1539617603, '{\"id\":7}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009     a 09-11-\",\"to\":\"01/01/2009      a 01/11/2018\"}]'),
(615, 'app\\models\\Gestao', 1539617603, '{\"id\":8}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"07/11/2018    a 04-09-1\",\"to\":\"07/11/2018     a 20/09/1901\"}]'),
(616, 'app\\models\\Gestao', 1539617644, '{\"id\":2}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"04/10/2004      a 10/10\",\"to\":\"04/10/2004       a 18/10/2018\"}]'),
(617, 'app\\models\\Gestao', 1539617644, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2009  a 11/10/201\",\"to\":\"01-01-2009   a 08/10/2018\"}]'),
(618, 'app\\models\\Gestao', 1539617644, '{\"id\":7}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009      a 01/11\",\"to\":\"01/01/2009       a 15/10/2018\"}]'),
(619, 'app\\models\\Gestao', 1539617644, '{\"id\":8}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"07/11/2018     a 20/09/\",\"to\":\"07/11/2018      a 26/10/2018\"}]'),
(620, 'app\\models\\Gestao', 1539617821, '{\"id\":2}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"04/10/2004       a 18/1\",\"to\":\"04/10/2004 a 06/11/2018\"}]'),
(621, 'app\\models\\Gestao', 1539617821, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01-01-2009   a 08/10/20\",\"to\":\"01/01/2009 a 04/11/1920\"}]'),
(622, 'app\\models\\Gestao', 1539617821, '{\"id\":7}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009       a 15/1\",\"to\":\"01/01/2009 a 01/11/2018\"}]'),
(623, 'app\\models\\Gestao', 1539617821, '{\"id\":8}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"07/11/2018      a 26/10\",\"to\":\"07/11/2018 a 07/11/2018\"}]'),
(624, 'app\\models\\Gestao', 1539617858, '{\"id\":2}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"04/10/2004 a 06/11/2018\",\"to\":\"04/10/2004  a  06/11/2018\"}]'),
(625, 'app\\models\\Gestao', 1539617858, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009 a 04/11/1920\",\"to\":\"01/01/2009  a  04/11/1920\"}]'),
(626, 'app\\models\\Gestao', 1539617858, '{\"id\":7}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009 a 01/11/2018\",\"to\":\"01/01/2009  a  01/11/2018\"}]'),
(627, 'app\\models\\Gestao', 1539617858, '{\"id\":8}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"07/11/2018 a 07/11/2018\",\"to\":\"07/11/2018  a  07/11/2018\"}]'),
(628, 'app\\models\\Gestao', 1539617858, '{\"id\":9}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":9},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"08/10/2018 a 15/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste 48\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-28\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste 48\"}]'),
(629, 'app\\models\\Gestao', 1539617918, '{\"id\":2}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"04/10/2004  a  06/11/20\",\"to\":\"04/10/2004  a09/10/2018\"}]'),
(630, 'app\\models\\Gestao', 1539617918, '{\"id\":4}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009  a  04/11/19\",\"to\":\"01/01/2009  a24/10/2018\"}]'),
(631, 'app\\models\\Gestao', 1539617918, '{\"id\":7}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"01/01/2009  a  01/11/20\",\"to\":\"01/01/2009  a08/11/1920\"}]'),
(632, 'app\\models\\Gestao', 1539617918, '{\"id\":8}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"07/11/2018  a  07/11/20\",\"to\":\"07/11/2018  a10/11/1920\"}]'),
(633, 'app\\models\\Gestao', 1539617956, '{\"id\":9}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"08/10/2018 a 15/10/2018\",\"to\":\"08/10/2018 a01/10/2018\"}]'),
(634, 'app\\models\\Gestao', 1539617966, '{\"id\":9}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"08/10/2018 a01/10/2018\",\"to\":\"08/10/2018 a13/10/2018\"}]'),
(635, 'app\\models\\Gestao', 1539618104, '{\"id\":9}', 2, 'update', '[{\"attr\":\"periodo\",\"from\":\"08/10/2018 a13/10/2018\",\"to\":\"22/10/2018a08/11/2018\"}]'),
(636, 'app\\models\\Modalidade', 1539638977, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"descricao\",\"from\":null,\"to\":\"Patrimômiio\"}]'),
(637, 'app\\models\\Modalidade', 1539639046, '{\"id\":1}', 2, 'update', '[{\"attr\":\"descricao\",\"from\":\"Patrimômiio\",\"to\":\"Patrimômio\"}]'),
(638, 'app\\models\\Modalidade', 1539639195, '{\"id\":1}', 2, 'update', '[{\"attr\":\"descricao\",\"from\":\"Patrimômio\",\"to\":\"Vitalício\"}]'),
(639, 'app\\models\\Produto', 1539639694, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"codigo\",\"from\":null,\"to\":\"1.123532.212\"},{\"attr\":\"descricao\",\"from\":null,\"to\":\"Patrimônio\"}]'),
(640, 'app\\models\\Gestao', 1539734438, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2000 à 07/10/2004\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1989-02-14\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Kikinos Cavalo\"}]'),
(641, 'app\\models\\Gestao', 1539734451, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2000 à 07/10/2004\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1989-02-14\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Kikinos Cavalo\"}]'),
(642, 'app\\models\\Gestao', 1539737712, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/2001 à 07/10/2004\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Luan Araujo 2\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1989-02-14\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Kikinos Cavalo\"}]'),
(643, 'app\\models\\Cliente', 1539739075, '{\"id\":78}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":78},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Samsung Electronics Co., Ltd.\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Samsung\"},{\"attr\":\"email\",\"from\":null,\"to\":\"samsung@samsung.com\"},{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/916706.jpg\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41760035\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Costa Azul \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Doutor Augusto Lopes Pontes \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"av principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":55},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-16\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":100000},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":90000},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"2008\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"100\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2008\"}]'),
(644, 'app\\models\\Gestao', 1539739075, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/2000 à 31/12/2003\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Lee Jae-yong\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1965-04-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Lee Byung-Chull\"}]'),
(645, 'app\\models\\Gestao', 1539739075, '{\"id\":5}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":5},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/2004 à 31/12/2007\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Lee Jee Chin\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1971-04-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Lan Jen Chun\"}]'),
(646, 'app\\models\\AnexosDocumentos', 1539739075, '{\"id\":24}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":24},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/04151452524/9682518.jpg\"}]'),
(647, 'app\\models\\ContatoCliente', 1539739078, '{\"id\":35}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":35},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"Jade Chan\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1991-08-06\"},{\"attr\":\"email\",\"from\":null,\"to\":\"jade@samsung.com\"}]'),
(648, 'app\\models\\Telefone', 1539739078, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":35},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"65746464645\"}]'),
(649, 'app\\models\\ContatoCliente', 1539739149, '{\"id\":36}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":36},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Jackie Chan\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1979-10-11\"},{\"attr\":\"email\",\"from\":null,\"to\":\"jackie@samasung.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/5278363.jpeg\"}]'),
(650, 'app\\models\\Telefone', 1539739149, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":36},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"45653453453\"}]'),
(651, 'app\\models\\Gestao', 1539739344, '{\"id\":6}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":6},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"27/09/2000 à 16/10/2003\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\" Lee Jae-yong\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1957-10-14\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\" Lee Jae-chong\"}]'),
(652, 'app\\models\\ContatoCliente', 1539740083, '{\"id\":37}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":37},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.om\"}]'),
(653, 'app\\models\\Gestao', 1539740128, '{\"id\":7}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":7},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"03/10/2018 à 01/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"tdts\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-17\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"ysdtsd\"}]'),
(654, 'app\\models\\Gestao', 1539740184, '{\"id\":8}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":8},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018 à 03/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"werwer\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-04\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"werwerwer\"}]'),
(655, 'app\\models\\Gestao', 1539742279, '{\"id\":9}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":9},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"02/10/2018 à 02/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(656, 'app\\models\\Gestao', 1539742323, '{\"id\":10}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":10},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"03/10/2018 à 01/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"eteste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(657, 'app\\models\\Gestao', 1539742524, '{\"id\":11}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":11},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018 à 09/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"w5wrr\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-09\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"rwerew\"}]'),
(658, 'app\\models\\Gestao', 1539742557, '{\"id\":12}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":12},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018 à 09/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"w5wrr\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-09\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"rwerew\"}]'),
(659, 'app\\models\\Gestao', 1539742598, '{\"id\":13}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":13},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"03/10/2018 à 01/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"eteste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(660, 'app\\models\\Gestao', 1539742598, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018 à 09/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"w5wrr\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-09\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"rwerew\"}]'),
(661, 'app\\models\\Gestao', 1539742605, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"03/10/2018 à 01/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"eteste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(662, 'app\\models\\Gestao', 1539742605, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018 à 09/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"w5wrr\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-09\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"rwerew\"}]'),
(663, 'app\\models\\Gestao', 1539742657, '{\"id\":17}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":17},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"05/10/2018 à 02/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(664, 'app\\models\\Gestao', 1539742666, '{\"id\":18}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":18},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"05/10/2018 à 02/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste\"}]'),
(665, 'app\\models\\Gestao', 1539742754, '{\"id\":19}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":19},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"10/10/2018 à 01/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"dgfsdfs\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"sdfsdfsd\"}]'),
(666, 'app\\models\\Gestao', 1539742836, '{\"id\":20}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":20},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"periodo\",\"from\":null,\"to\":\"04/10/2018 à 18/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"dfgdfh\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-09\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"asdae12\"}]'),
(667, 'app\\models\\Telefone', 1539781475, '{\"id\":17}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":17},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":35},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"23131231231\"}]'),
(668, 'app\\models\\ContatoCliente', 1539782207, '{\"id\":37}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":37},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(669, 'app\\models\\ContatoCliente', 1539783316, '{\"id\":38}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":38},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gai.com\"}]'),
(670, 'app\\models\\ContatoCliente', 1539783354, '{\"id\":39}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":39},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gai.com\"}]'),
(671, 'app\\models\\ContatoCliente', 1539783383, '{\"id\":40}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":40},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":78},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"tstte\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gai.com\"}]'),
(672, 'app\\models\\Telefone', 1539786249, '{\"id\":18}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":18},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":40},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"12313123123\"}]'),
(673, 'app\\models\\ContatoCliente', 1539786320, '{\"id\":33}', 2, 'update', '[{\"attr\":\"nome\",\"from\":\"teste 3\",\"to\":\"teste 312312\"}]'),
(674, 'app\\models\\Telefone', 1539786320, '{\"id\":19}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":19},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":33},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"12412412412\"}]'),
(675, 'app\\models\\ContatoCliente', 1539786320, '{\"id\":41}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":41},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":76},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":3},{\"attr\":\"nome\",\"from\":null,\"to\":\"teste33\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-03\"},{\"attr\":\"email\",\"from\":null,\"to\":\"teste@gmail.com\"}]'),
(676, 'app\\models\\Telefone', 1539786320, '{\"id\":20}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":20},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":41},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"23546345235\"}]'),
(677, 'app\\models\\Cliente', 1539786359, '{\"id\":78}', 2, 'delete', '[{\"attr\":\"id\",\"from\":78,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":2,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"Samsung Electronics Co., Ltd.\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"Samsung\",\"to\":null},{\"attr\":\"email\",\"from\":\"samsung@samsung.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/916706.jpg\",\"to\":null},{\"attr\":\"cep\",\"from\":\"41760-035\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Salvador\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Costa Azul \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Doutor Augusto Lopes Pontes \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"av principal\",\"to\":null},{\"attr\":\"numero\",\"from\":55,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"16/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":100000,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":90000,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"2008\",\"to\":null},{\"attr\":\"fpm\",\"from\":\"100,00\",\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"2008\",\"to\":null}]'),
(678, 'app\\models\\Cliente', 1539786450, '{\"id\":78}', 2, 'delete', '[{\"attr\":\"id\",\"from\":78,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":2,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":null},{\"attr\":\"fk_representante\",\"from\":null,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"041.514.525-24\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"Samsung Electronics Co., Ltd.\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"Samsung\",\"to\":null},{\"attr\":\"email\",\"from\":\"samsung@samsung.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/916706.jpg\",\"to\":null},{\"attr\":\"cep\",\"from\":\"41760-035\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA \",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Salvador\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Costa Azul \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Doutor Augusto Lopes Pontes \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"av principal\",\"to\":null},{\"attr\":\"numero\",\"from\":55,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"16/10/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":100000,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":90000,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"2008\",\"to\":null},{\"attr\":\"fpm\",\"from\":\"100,00\",\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"2008\",\"to\":null}]'),
(679, 'app\\models\\Cliente', 1539787363, '{\"id\":79}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":79},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"fk_tipo_cliente\",\"from\":null,\"to\":2},{\"attr\":\"fk_tipo_orgao\",\"from\":null,\"to\":3},{\"attr\":\"cpf_cnpj\",\"from\":null,\"to\":\"04151452524\"},{\"attr\":\"razao_social\",\"from\":null,\"to\":\"Samsung Electronics Co., Ltd.\"},{\"attr\":\"nome_fantasia\",\"from\":null,\"to\":\"Samsung\"},{\"attr\":\"email\",\"from\":null,\"to\":\"samsung@samsung.com\"},{\"attr\":\"brasao\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/4417300.jpg\"},{\"attr\":\"cep\",\"from\":null,\"to\":\"41760035\"},{\"attr\":\"estado\",\"from\":null,\"to\":\"BA \"},{\"attr\":\"cidade\",\"from\":null,\"to\":\"Salvador\"},{\"attr\":\"bairro\",\"from\":null,\"to\":\"Costa Azul \"},{\"attr\":\"endereco\",\"from\":null,\"to\":\"Rua Doutor Augusto Lopes Pontes \"},{\"attr\":\"complemento\",\"from\":null,\"to\":\"av principal\"},{\"attr\":\"numero\",\"from\":null,\"to\":33},{\"attr\":\"data_cadastro\",\"from\":null,\"to\":\"2018-10-17\"},{\"attr\":\"situacao\",\"from\":null,\"to\":1},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":10000},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":9000},{\"attr\":\"ano_populacao\",\"from\":null,\"to\":\"2008\"},{\"attr\":\"fpm\",\"from\":null,\"to\":\"100\"},{\"attr\":\"fpm_ano\",\"from\":null,\"to\":\"2008\"}]'),
(680, 'app\\models\\Gestao', 1539787363, '{\"id\":21}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":21},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":79},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/2000 à 31/12/2003\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Kim Hiu Suk\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1958-10-07\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Lin chen chu\"}]'),
(681, 'app\\models\\Gestao', 1539787363, '{\"id\":22}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":22},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":79},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/2004 à 31/12/2007\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Rock Lee\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1954-03-09\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Gai Sensei\"}]'),
(682, 'app\\models\\Gestao', 1539787363, '{\"id\":23}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":23},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":79},{\"attr\":\"periodo\",\"from\":null,\"to\":\"01/01/2008 à 31/12/2011\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"Kakashi Sensei\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1952-03-05\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"Uchiha Sasuke\"}]'),
(683, 'app\\models\\AnexosDocumentos', 1539787363, '{\"id\":25}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":25},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":79},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/04151452524/2742227.jpg\"}]'),
(684, 'app\\models\\AnexosDocumentos', 1539787363, '{\"id\":26}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":26},{\"attr\":\"fk_tipo_documento\",\"from\":null,\"to\":4},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":79},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/04151452524/2739770.txt\"}]'),
(685, 'app\\models\\ContatoCliente', 1539787363, '{\"id\":42}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":42},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":79},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Uzumaki Naruto\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-11\"},{\"attr\":\"email\",\"from\":null,\"to\":\"naruto@uzumaki.com\"}]'),
(686, 'app\\models\\Telefone', 1539787363, '{\"id\":21}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":21},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":42},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":4},{\"attr\":\"telefone\",\"from\":null,\"to\":\"12121212121\"}]'),
(687, 'app\\models\\Telefone', 1539787363, '{\"id\":22}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":22},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":42},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":3},{\"attr\":\"telefone\",\"from\":null,\"to\":\"23232323232\"}]'),
(688, 'app\\models\\ContatoCliente', 1539787363, '{\"id\":43}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":43},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":79},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":3},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Minato Namikaze Hokage\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2007-10-18\"},{\"attr\":\"email\",\"from\":null,\"to\":\"minato@namikaze.com\"}]'),
(689, 'app\\models\\Telefone', 1539787363, '{\"id\":23}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":23},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":43},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"54545454544\"}]'),
(690, 'app\\models\\ContatoCliente', 1539787363, '{\"id\":44}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":44},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":79},{\"attr\":\"fk_departamento\",\"from\":null,\"to\":1},{\"attr\":\"fk_cargo\",\"from\":null,\"to\":2},{\"attr\":\"nome\",\"from\":null,\"to\":\"Jackie Chan\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"1975-10-15\"},{\"attr\":\"email\",\"from\":null,\"to\":\"jackie@gmail.com\"},{\"attr\":\"foto\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/587673.jpeg\"}]'),
(691, 'app\\models\\Telefone', 1539787364, '{\"id\":24}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":24},{\"attr\":\"fk_contato_cliente\",\"from\":null,\"to\":44},{\"attr\":\"fk_tipo_telefone\",\"from\":null,\"to\":2},{\"attr\":\"telefone\",\"from\":null,\"to\":\"54645456456\"}]'),
(692, 'app\\models\\Gestao', 1539787755, '{\"id\":24}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":24},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":79},{\"attr\":\"periodo\",\"from\":null,\"to\":\"02/10/2018 à 03/10/2018\"},{\"attr\":\"prefeito\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"data_nascimento\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"vice_prefeito\",\"from\":null,\"to\":\"teste 2\"}]'),
(693, 'app\\models\\Produto', 1539792602, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"codigo\",\"from\":null,\"to\":\"2\"},{\"attr\":\"descricao\",\"from\":null,\"to\":\"Compras\"}]'),
(694, 'app\\models\\Produto', 1539792616, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_entidade\",\"from\":null,\"to\":1},{\"attr\":\"codigo\",\"from\":null,\"to\":\"3\"},{\"attr\":\"descricao\",\"from\":null,\"to\":\"Contra Cheque\"}]'),
(695, 'app\\models\\Contrato', 1539802755, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_modalidade\",\"from\":null,\"to\":1},{\"attr\":\"data_inicio\",\"from\":null,\"to\":\"2018-10-17\"},{\"attr\":\"data_termino\",\"from\":null,\"to\":\"2018-11-28\"},{\"attr\":\"valor_global\",\"from\":null,\"to\":\"1000000\"},{\"attr\":\"valor_mensal\",\"from\":null,\"to\":\"20000\"},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/1/8986203.txt\"},{\"attr\":\"status\",\"from\":null,\"to\":\"1\"},{\"attr\":\"objeto\",\"from\":null,\"to\":\"SISTEMA\"},{\"attr\":\"numero\",\"from\":null,\"to\":\"1\"},{\"attr\":\"info_complementar\",\"from\":null,\"to\":\"WEB\"}]'),
(696, 'app\\models\\Contrato', 1539802812, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_modalidade\",\"from\":null,\"to\":1},{\"attr\":\"data_inicio\",\"from\":null,\"to\":\"2018-10-17\"},{\"attr\":\"data_termino\",\"from\":null,\"to\":\"2018-11-28\"},{\"attr\":\"valor_global\",\"from\":null,\"to\":\"1000000\"},{\"attr\":\"valor_mensal\",\"from\":null,\"to\":\"20000\"},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/1/4301306.txt\"},{\"attr\":\"status\",\"from\":null,\"to\":\"1\"},{\"attr\":\"objeto\",\"from\":null,\"to\":\"SISTEMA\"},{\"attr\":\"numero\",\"from\":null,\"to\":\"1\"},{\"attr\":\"info_complementar\",\"from\":null,\"to\":\"WEB\"}]'),
(697, 'app\\models\\ContratoProdutos', 1539802812, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(698, 'app\\models\\ContratoProdutos', 1539802812, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(699, 'app\\models\\ContratoProdutos', 1539802812, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(700, 'app\\models\\Contrato', 1539816301, '{\"id\":2}', 2, 'update', '[{\"attr\":\"anexo\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/1/4301306.txt\",\"to\":null}]'),
(701, 'app\\models\\ContratoProdutos', 1539816311, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(702, 'app\\models\\ContratoProdutos', 1539816311, '{\"id\":5}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":5},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(703, 'app\\models\\ContratoProdutos', 1539816698, '{\"id\":6}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":6},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(704, 'app\\models\\ContratoProdutos', 1539816698, '{\"id\":7}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":7},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(705, 'app\\models\\ContratoProdutos', 1539816698, '{\"id\":8}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":8},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(706, 'app\\models\\ContratoProdutos', 1539816772, '{\"id\":9}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":9},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(707, 'app\\models\\ContratoProdutos', 1539816772, '{\"id\":10}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":10},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(708, 'app\\models\\ContratoProdutos', 1539816772, '{\"id\":11}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":11},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(709, 'app\\models\\ContratoProdutos', 1539817142, '{\"id\":12}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":12},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(710, 'app\\models\\ContratoProdutos', 1539817142, '{\"id\":13}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":13},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(711, 'app\\models\\ContratoProdutos', 1539817142, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(712, 'app\\models\\ContratoProdutos', 1539817160, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(713, 'app\\models\\ContratoProdutos', 1539817160, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(714, 'app\\models\\ContratoProdutos', 1539817160, '{\"id\":17}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":17},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(715, 'app\\models\\ContratoProdutos', 1539817228, '{\"id\":18}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":18},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(716, 'app\\models\\ContratoProdutos', 1539817228, '{\"id\":19}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":19},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(717, 'app\\models\\ContratoProdutos', 1539817229, '{\"id\":20}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":20},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(718, 'app\\models\\Contrato', 1539822923, '{\"id\":1}', 2, 'update', '[{\"attr\":\"anexo\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/1/8986203.txt\",\"to\":null}]'),
(719, 'app\\models\\Contrato', 1539823078, '{\"id\":2}', 2, 'update', '[{\"attr\":\"numero\",\"from\":\"1\",\"to\":1324}]'),
(720, 'app\\models\\Contrato', 1539823089, '{\"id\":1}', 2, 'update', '[{\"attr\":\"numero\",\"from\":\"1\",\"to\":2123}]'),
(721, 'app\\models\\ContratoProdutos', 1539823511, '{\"id\":21}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":21},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(722, 'app\\models\\Cliente', 1539866253, '{\"id\":25}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/8861001.jpg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/8903258.jpg\"}]'),
(723, 'app\\models\\Cliente', 1539866263, '{\"id\":25}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/8903258.jpg\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/1043814.jpg\"}]'),
(724, 'app\\models\\Aditivo', 1539874781, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"numero\",\"from\":null,\"to\":\"0001\"},{\"attr\":\"data_inicio\",\"from\":null,\"to\":\"2017-10-01\"},{\"attr\":\"data_termino\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"valor\",\"from\":null,\"to\":\"50000\"},{\"attr\":\"justificativa\",\"from\":null,\"to\":\"teste outubro\"}]'),
(725, 'app\\models\\Aditivo', 1539875356, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"numero\",\"from\":null,\"to\":\"12312\"},{\"attr\":\"data_inicio\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"data_termino\",\"from\":null,\"to\":\"2018-10-27\"},{\"attr\":\"valor\",\"from\":null,\"to\":\"2342423\"},{\"attr\":\"justificativa\",\"from\":null,\"to\":\"twtds\"}]'),
(726, 'app\\models\\Aditivo', 1539875614, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"numero\",\"from\":null,\"to\":\"0001\"},{\"attr\":\"data_inicio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"data_termino\",\"from\":null,\"to\":\"2018-10-18\"},{\"attr\":\"valor\",\"from\":null,\"to\":\"50000\"},{\"attr\":\"justificativa\",\"from\":null,\"to\":\"teste\"},{\"attr\":\"anexo\",\"from\":null,\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/anexos/0001/1308561.txt\"}]'),
(727, 'app\\models\\ContratoProdutos', 1540216259, '{\"id\":22}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":22},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(728, 'app\\models\\BloqueioProduto', 1540222191, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(729, 'app\\models\\BloqueioProduto', 1540222191, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(730, 'app\\models\\Bloqueio', 1540223007, '{\"id\":1}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":1},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-03\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(731, 'app\\models\\BloqueioProduto', 1540223007, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(732, 'app\\models\\BloqueioProduto', 1540223007, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(733, 'app\\models\\Bloqueio', 1540223197, '{\"id\":2}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":2},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(734, 'app\\models\\Bloqueio', 1540223230, '{\"id\":3}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":3},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]');
INSERT INTO `audit_trail_entry` (`id`, `model_type`, `happened_at`, `foreign_pk`, `user_id`, `type`, `data`) VALUES
(735, 'app\\models\\Bloqueio', 1540223255, '{\"id\":4}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":4},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(736, 'app\\models\\Bloqueio', 1540224147, '{\"id\":5}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":5},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(737, 'app\\models\\BloqueioProduto', 1540224147, '{\"id\":5}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":5},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":5},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(738, 'app\\models\\BloqueioProduto', 1540224147, '{\"id\":6}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":6},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":5},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(739, 'app\\models\\Bloqueio', 1540224766, '{\"id\":6}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":6},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(740, 'app\\models\\Bloqueio', 1540224813, '{\"id\":7}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":7},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(741, 'app\\models\\BloqueioProduto', 1540224813, '{\"id\":7}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":7},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":7},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(742, 'app\\models\\BloqueioProduto', 1540224813, '{\"id\":8}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":8},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":7},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(743, 'app\\models\\Bloqueio', 1540224927, '{\"id\":8}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":8},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(744, 'app\\models\\Bloqueio', 1540224968, '{\"id\":9}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":9},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-08\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(745, 'app\\models\\Bloqueio', 1540225584, '{\"id\":10}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":10},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(746, 'app\\models\\BloqueioProduto', 1540225584, '{\"id\":9}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":9},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":10},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(747, 'app\\models\\Bloqueio', 1540225669, '{\"id\":11}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":11},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(748, 'app\\models\\BloqueioProduto', 1540225669, '{\"id\":10}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":10},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":11},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(749, 'app\\models\\BloqueioProduto', 1540225669, '{\"id\":11}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":11},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":11},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(750, 'app\\models\\Bloqueio', 1540225790, '{\"id\":12}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":12},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-07\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(751, 'app\\models\\BloqueioProduto', 1540225790, '{\"id\":12}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":12},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":12},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(752, 'app\\models\\BloqueioProduto', 1540225790, '{\"id\":13}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":13},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":12},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(753, 'app\\models\\Bloqueio', 1540225858, '{\"id\":13}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":13},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-07\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(754, 'app\\models\\Bloqueio', 1540227057, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-28\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(755, 'app\\models\\Bloqueio', 1540227275, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(756, 'app\\models\\Bloqueio', 1540227312, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(757, 'app\\models\\BloqueioProduto', 1540227312, '{\"id\":14}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":14},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":16},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(758, 'app\\models\\BloqueioProduto', 1540227312, '{\"id\":15}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":15},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":16},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(759, 'app\\models\\Bloqueio', 1540230591, '{\"id\":17}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":17},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(760, 'app\\models\\BloqueioProduto', 1540230591, '{\"id\":16}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":16},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":17},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(761, 'app\\models\\BloqueioProduto', 1540230591, '{\"id\":17}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":17},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":17},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(762, 'app\\models\\Bloqueio', 1540231369, '{\"id\":18}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":18},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-15\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(763, 'app\\models\\Bloqueio', 1540231393, '{\"id\":19}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":19},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(764, 'app\\models\\Bloqueio', 1540231431, '{\"id\":20}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":20},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-09-30\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(765, 'app\\models\\Bloqueio', 1540231843, '{\"id\":21}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":21},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-06\"},{\"attr\":\"data_limite\",\"from\":null,\"to\":\"2018-10-22\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(766, 'app\\models\\Bloqueio', 1540231923, '{\"id\":22}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":22},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(767, 'app\\models\\Bloqueio', 1540232015, '{\"id\":23}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":23},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-11\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(768, 'app\\models\\Bloqueio', 1540232107, '{\"id\":24}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":24},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-16\"},{\"attr\":\"data_limite\",\"from\":null,\"to\":\"2018-10-23\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(769, 'app\\models\\BloqueioProduto', 1540232107, '{\"id\":18}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":18},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":24},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(770, 'app\\models\\BloqueioProduto', 1540232107, '{\"id\":19}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":19},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":24},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(771, 'app\\models\\Bloqueio', 1540232135, '{\"id\":25}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":25},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-10\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(772, 'app\\models\\Cliente', 1540232893, '{\"id\":75}', 2, 'update', '[{\"attr\":\"brasao\",\"from\":\"\",\"to\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/1657836.jpg\"}]'),
(773, 'app\\models\\Bloqueio', 1540234855, '{\"id\":26}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":26},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"data_limite\",\"from\":null,\"to\":\"2018-10-22\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(774, 'app\\models\\BloqueioProduto', 1540234855, '{\"id\":20}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":20},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":26},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(775, 'app\\models\\BloqueioProduto', 1540234855, '{\"id\":21}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":21},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":26},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(776, 'app\\models\\Bloqueio', 1540234928, '{\"id\":27}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":27},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-14\"},{\"attr\":\"data_limite\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(777, 'app\\models\\ContratoProdutos', 1540235026, '{\"id\":23}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":23},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(778, 'app\\models\\Bloqueio', 1540235042, '{\"id\":28}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":28},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"data_limite\",\"from\":null,\"to\":\"2018-10-22\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(779, 'app\\models\\BloqueioProduto', 1540235042, '{\"id\":22}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":22},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":28},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(780, 'app\\models\\Bloqueio', 1540303919, '{\"id\":29}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":29},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"data_limite\",\"from\":null,\"to\":\"2018-10-22\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(781, 'app\\models\\BloqueioProduto', 1540303919, '{\"id\":23}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":23},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":29},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(782, 'app\\models\\BloqueioProduto', 1540303919, '{\"id\":24}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":24},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":29},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(783, 'app\\models\\Bloqueio', 1540333812, '{\"id\":29}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(784, 'app\\models\\Bloqueio', 1540334292, '{\"id\":30}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":30},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-15\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(785, 'app\\models\\BloqueioProduto', 1540334292, '{\"id\":25}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":25},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":30},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(786, 'app\\models\\Bloqueio', 1540336453, '{\"id\":31}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":31},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-08\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(787, 'app\\models\\BloqueioProduto', 1540336453, '{\"id\":26}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":26},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":31},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(788, 'app\\models\\BloqueioProduto', 1540336453, '{\"id\":27}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":27},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":31},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(789, 'app\\models\\Bloqueio', 1540336500, '{\"id\":32}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":32},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-04\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(790, 'app\\models\\Bloqueio', 1540336649, '{\"id\":33}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":33},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(791, 'app\\models\\Bloqueio', 1540386904, '{\"id\":34}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":34},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"data_limite\",\"from\":null,\"to\":\"2018-10-21\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(792, 'app\\models\\BloqueioProduto', 1540386904, '{\"id\":28}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":28},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":34},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(793, 'app\\models\\BloqueioProduto', 1540386904, '{\"id\":29}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":29},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":34},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(794, 'app\\models\\Bloqueio', 1540387062, '{\"id\":30}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(795, 'app\\models\\Bloqueio', 1540387078, '{\"id\":33}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(796, 'app\\models\\Bloqueio', 1540387111, '{\"id\":35}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":35},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-04\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(797, 'app\\models\\BloqueioProduto', 1540387111, '{\"id\":30}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":30},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":35},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(798, 'app\\models\\Bloqueio', 1540389389, '{\"id\":36}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":36},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-11-06\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(799, 'app\\models\\BloqueioProduto', 1540389389, '{\"id\":31}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":31},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":36},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(800, 'app\\models\\Bloqueio', 1540389410, '{\"id\":35}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(801, 'app\\models\\Bloqueio', 1540402721, '{\"id\":34}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(802, 'app\\models\\Bloqueio', 1540402721, '{\"id\":36}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(803, 'app\\models\\Bloqueio', 1540402791, '{\"id\":37}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":37},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(804, 'app\\models\\BloqueioProduto', 1540402791, '{\"id\":32}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":32},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":37},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(805, 'app\\models\\BloqueioProduto', 1540402791, '{\"id\":33}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":33},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":37},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(806, 'app\\models\\Bloqueio', 1540402799, '{\"id\":37}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(807, 'app\\models\\Bloqueio', 1540402808, '{\"id\":38}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":38},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(808, 'app\\models\\BloqueioProduto', 1540402808, '{\"id\":34}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":34},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":38},{\"attr\":\"fk_produto\",\"from\":null,\"to\":1}]'),
(809, 'app\\models\\Bloqueio', 1540402839, '{\"id\":39}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":39},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(810, 'app\\models\\BloqueioProduto', 1540402839, '{\"id\":35}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":35},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":39},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(811, 'app\\models\\Bloqueio', 1540403178, '{\"id\":39}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(812, 'app\\models\\Bloqueio', 1540403192, '{\"id\":40}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":40},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":2},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(813, 'app\\models\\BloqueioProduto', 1540403192, '{\"id\":36}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":36},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":40},{\"attr\":\"fk_produto\",\"from\":null,\"to\":2}]'),
(814, 'app\\models\\Bloqueio', 1540404098, '{\"id\":41}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":41},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(815, 'app\\models\\BloqueioProduto', 1540404098, '{\"id\":37}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":37},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":41},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(816, 'app\\models\\Bloqueio', 1540404227, '{\"id\":41}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(817, 'app\\models\\Bloqueio', 1540404285, '{\"id\":42}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":42},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-01\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(818, 'app\\models\\BloqueioProduto', 1540404285, '{\"id\":38}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":38},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":42},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(819, 'app\\models\\Cliente', 1540404911, '{\"id\":22}', 2, 'delete', '[{\"attr\":\"id\",\"from\":22,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":4,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":null},{\"attr\":\"fk_representante\",\"from\":46,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"03.470.727/0004-73\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"Veículos Ford\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"Ivep\",\"to\":null},{\"attr\":\"email\",\"from\":\"josenitamarise@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/10.405.329/000_-__/6446363.jpg\",\"to\":null},{\"attr\":\"cep\",\"from\":\"48080-070\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA\",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Alagoinhas\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Jardim Pedro Braga \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Alfredo Garcia \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":0,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"03/05/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"0000\",\"to\":null},{\"attr\":\"fpm\",\"from\":null,\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"\",\"to\":null}]'),
(820, 'app\\models\\Bloqueio', 1540405950, '{\"id\":43}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":43},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-03\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(821, 'app\\models\\Bloqueio', 1540406538, '{\"id\":44}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":44},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-05\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(822, 'app\\models\\BloqueioProduto', 1540406538, '{\"id\":39}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":39},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":44},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(823, 'app\\models\\Bloqueio', 1540406554, '{\"id\":45}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":45},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-04\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(824, 'app\\models\\BloqueioProduto', 1540406554, '{\"id\":40}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":40},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":45},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(825, 'app\\models\\Bloqueio', 1540406564, '{\"id\":44}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(826, 'app\\models\\Bloqueio', 1540406564, '{\"id\":45}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(827, 'app\\models\\Bloqueio', 1540407009, '{\"id\":46}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":46},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-03\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(828, 'app\\models\\BloqueioProduto', 1540407009, '{\"id\":41}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":41},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":46},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(829, 'app\\models\\Bloqueio', 1540407026, '{\"id\":46}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(830, 'app\\models\\Bloqueio', 1540407335, '{\"id\":42}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(831, 'app\\models\\Bloqueio', 1540407347, '{\"id\":47}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":47},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(832, 'app\\models\\BloqueioProduto', 1540407347, '{\"id\":42}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":42},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":47},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(833, 'app\\models\\Bloqueio', 1540407353, '{\"id\":47}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(834, 'app\\models\\Bloqueio', 1540407363, '{\"id\":48}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":48},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-02\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(835, 'app\\models\\BloqueioProduto', 1540407363, '{\"id\":43}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":43},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":48},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(836, 'app\\models\\Bloqueio', 1540407369, '{\"id\":48}', 2, 'update', '[{\"attr\":\"status\",\"from\":1,\"to\":0}]'),
(837, 'app\\models\\Bloqueio', 1540407381, '{\"id\":49}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":49},{\"attr\":\"fk_cliente\",\"from\":null,\"to\":48},{\"attr\":\"fk_contrato\",\"from\":null,\"to\":1},{\"attr\":\"fk_usuario\",\"from\":null,\"to\":2},{\"attr\":\"data_bloqueio\",\"from\":null,\"to\":\"2018-10-10\"},{\"attr\":\"status\",\"from\":null,\"to\":1}]'),
(838, 'app\\models\\BloqueioProduto', 1540407381, '{\"id\":44}', 2, 'insert', '[{\"attr\":\"id\",\"from\":null,\"to\":44},{\"attr\":\"fk_bloqueio\",\"from\":null,\"to\":49},{\"attr\":\"fk_produto\",\"from\":null,\"to\":3}]'),
(839, 'app\\models\\Cliente', 1540407573, '{\"id\":22}', 2, 'delete', '[{\"attr\":\"id\",\"from\":22,\"to\":null},{\"attr\":\"fk_entidade\",\"from\":1,\"to\":null},{\"attr\":\"fk_tipo_cliente\",\"from\":4,\"to\":null},{\"attr\":\"fk_tipo_orgao\",\"from\":3,\"to\":null},{\"attr\":\"fk_representante\",\"from\":46,\"to\":null},{\"attr\":\"cpf_cnpj\",\"from\":\"03.470.727/0004-73\",\"to\":null},{\"attr\":\"razao_social\",\"from\":\"Veículos Ford\",\"to\":null},{\"attr\":\"nome_fantasia\",\"from\":\"Ivep\",\"to\":null},{\"attr\":\"email\",\"from\":\"josenitamarise@gmail.com\",\"to\":null},{\"attr\":\"brasao\",\"from\":\"https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/10.405.329/000_-__/6446363.jpg\",\"to\":null},{\"attr\":\"cep\",\"from\":\"48080-070\",\"to\":null},{\"attr\":\"estado\",\"from\":\"BA\",\"to\":null},{\"attr\":\"cidade\",\"from\":\"Alagoinhas\",\"to\":null},{\"attr\":\"bairro\",\"from\":\"Jardim Pedro Braga \",\"to\":null},{\"attr\":\"endereco\",\"from\":\"Rua Alfredo Garcia \",\"to\":null},{\"attr\":\"complemento\",\"from\":\"Av. Principal\",\"to\":null},{\"attr\":\"numero\",\"from\":0,\"to\":null},{\"attr\":\"data_situacao\",\"from\":null,\"to\":null},{\"attr\":\"data_cadastro\",\"from\":\"03/05/2018\",\"to\":null},{\"attr\":\"situacao\",\"from\":1,\"to\":null},{\"attr\":\"qtd_populacao\",\"from\":null,\"to\":null},{\"attr\":\"qtd_eleitor\",\"from\":null,\"to\":null},{\"attr\":\"ano_populacao\",\"from\":\"0000\",\"to\":null},{\"attr\":\"fpm\",\"from\":null,\"to\":null},{\"attr\":\"fpm_ano\",\"from\":\"\",\"to\":null}]');

-- --------------------------------------------------------

--
-- Estrutura da tabela `auth_assignment`
--

CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `auth_assignment`
--

INSERT INTO `auth_assignment` (`item_name`, `user_id`, `created_at`) VALUES
('total', 2, 1535458980);

-- --------------------------------------------------------

--
-- Estrutura da tabela `auth_item`
--

CREATE TABLE `auth_item` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `rule_name` varchar(64) DEFAULT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `group_code` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `auth_item`
--

INSERT INTO `auth_item` (`name`, `type`, `description`, `rule_name`, `data`, `created_at`, `updated_at`, `group_code`) VALUES
('/*', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/aditivo/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/aditivo/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/aditivo/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/aditivo/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/aditivo/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/aditivo/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/aditivo/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/anexos-documentos/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/anexos-documentos/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/anexos-documentos/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/anexos-documentos/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/anexos-documentos/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/anexos-documentos/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/anexos-documentos/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/api/*', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/atendimento-anexos/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento-anexos/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento-anexos/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento-anexos/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento-anexos/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento-anexos/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento-anexos/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/atendimento/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/auth/*', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/auth/addressSearch', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/auth/captcha', 3, NULL, NULL, NULL, 1503329362, 1503329362, NULL),
('/auth/change-own-password', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/auth/confirm-email', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/auth/confirm-email-receive', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/auth/confirm-registration-email', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/auth/login', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/auth/logout', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/auth/password-recovery', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/auth/password-recovery-receive', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/auth/registration', 3, NULL, NULL, NULL, 1503329155, 1503329155, NULL),
('/banco/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/banco/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/banco/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/banco/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/banco/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/banco/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/banco/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/bloqueio/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/bloqueio/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/bloqueio/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/bloqueio/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/bloqueio/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/bloqueio/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/bloqueio/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/busca-ajax', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/get-cargo-atual', 3, NULL, NULL, NULL, 1537885715, 1537885715, NULL),
('/cargo/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/index-card', 3, NULL, NULL, NULL, 1537885860, 1537885860, NULL),
('/cliente/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta-orcamento/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta-orcamento/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta-orcamento/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta-orcamento/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta-orcamento/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta-orcamento/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta-orcamento/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/conta/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contato-cliente/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contato-cliente/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contato-cliente/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contato-cliente/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contato-cliente/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contato-cliente/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contato-cliente/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato-produtos/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato-produtos/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato-produtos/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato-produtos/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato-produtos/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato-produtos/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato-produtos/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/contrato/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/controle-versao/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/controle-versao/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/controle-versao/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/controle-versao/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/controle-versao/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/controle-versao/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/controle-versao/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/debug/*', 3, NULL, NULL, NULL, 1503317369, 1503317369, NULL),
('/debug/default/*', 3, NULL, NULL, NULL, 1503317369, 1503317369, NULL),
('/debug/default/db-explain', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/debug/default/download-mail', 3, NULL, NULL, NULL, 1503317369, 1503317369, NULL),
('/debug/default/index', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/debug/default/toolbar', 3, NULL, NULL, NULL, 1503317369, 1503317369, NULL),
('/debug/default/view', 3, NULL, NULL, NULL, 1503317369, 1503317369, NULL),
('/debug/user/*', 3, NULL, NULL, NULL, 1507315125, 1507315125, NULL),
('/debug/user/reset-identity', 3, NULL, NULL, NULL, 1507315125, 1507315125, NULL),
('/debug/user/set-identity', 3, NULL, NULL, NULL, 1507315125, 1507315125, NULL),
('/departamento/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/departamento/busca-ajax', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/departamento/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/departamento/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/departamento/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/departamento/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/departamento/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/departamento/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/entidade/*', 3, NULL, NULL, NULL, 1507315124, 1507315124, NULL),
('/entidade/busca-ajax', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/entidade/create', 3, NULL, NULL, NULL, 1507315125, 1507315125, NULL),
('/entidade/delete', 3, NULL, NULL, NULL, 1507315124, 1507315124, NULL),
('/entidade/error', 3, NULL, NULL, NULL, 1507315125, 1507315125, NULL),
('/entidade/index', 3, NULL, NULL, NULL, 1507315125, 1507315125, NULL),
('/entidade/update', 3, NULL, NULL, NULL, 1507315125, 1507315125, NULL),
('/entidade/view', 3, NULL, NULL, NULL, 1507315125, 1507315125, NULL),
('/financeiro/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/financeiro/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/financeiro/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/financeiro/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/financeiro/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/financeiro/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/financeiro/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/gestao/*', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/gestao/create', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/gestao/delete', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/gestao/error', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/gestao/index', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/gestao/update', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/gestao/view', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/gii/*', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/gii/default/*', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/gii/default/action', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/gii/default/diff', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/gii/default/index', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/gii/default/preview', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/gii/default/view', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/gridview/*', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/gridview/export/*', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/gridview/export/download', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/gridviewKrajee/*', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/gridviewKrajee/export/*', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/gridviewKrajee/export/download', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/itens-orcamento/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/itens-orcamento/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/itens-orcamento/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/itens-orcamento/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/itens-orcamento/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/itens-orcamento/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/itens-orcamento/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/kint/*', 3, NULL, NULL, NULL, 1503317369, 1503317369, NULL),
('/log/*', 3, NULL, NULL, NULL, 1503317365, 1503317365, NULL),
('/log/delete', 3, NULL, NULL, NULL, 1503317365, 1503317365, NULL),
('/log/index', 3, NULL, NULL, NULL, 1503317365, 1503317365, NULL),
('/log/view', 3, NULL, NULL, NULL, 1503317365, 1503317365, NULL),
('/main/*', 3, NULL, NULL, NULL, 1503317365, 1503317365, NULL),
('/main/error', 3, NULL, NULL, NULL, 1503317365, 1503317365, NULL),
('/modalidade/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/modalidade/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/modalidade/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/modalidade/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/modalidade/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/modalidade/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/modalidade/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/nota-fiscal/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/nota-fiscal/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/nota-fiscal/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/nota-fiscal/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/nota-fiscal/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/nota-fiscal/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/nota-fiscal/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/orcamento-proposta/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/orcamento-proposta/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/orcamento-proposta/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/orcamento-proposta/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/orcamento-proposta/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/orcamento-proposta/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/orcamento-proposta/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/produto/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/produto/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/produto/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/produto/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/produto/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/produto/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/produto/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/requests/*', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/requests/error', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/requests/index', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/requests/mensagem-pdf', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/requests/modal-mensagem', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/requests/report-bug', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/requests/view', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/site/*', 3, NULL, NULL, NULL, 1503317363, 1503317363, NULL),
('/site/addressSearch', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/site/captcha', 3, NULL, NULL, NULL, 1503317363, 1503317363, NULL),
('/site/index', 3, NULL, NULL, NULL, 1503317363, 1503317363, NULL),
('/telefone/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/telefone/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/telefone/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/telefone/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/telefone/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/telefone/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/telefone/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-anexo/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-anexo/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-anexo/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-anexo/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-anexo/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-anexo/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-anexo/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-atendimento/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-atendimento/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-atendimento/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-atendimento/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-atendimento/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-atendimento/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-atendimento/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-cliente/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-cliente/busca-ajax', 3, NULL, NULL, NULL, 1537885715, 1537885715, NULL),
('/tipo-cliente/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-cliente/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-cliente/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-cliente/get-tipo-cliente', 3, NULL, NULL, NULL, 1537885715, 1537885715, NULL),
('/tipo-cliente/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-cliente/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-cliente/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-documento/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-documento/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-documento/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-documento/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-documento/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-documento/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-documento/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-ocorrencia/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-ocorrencia/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-ocorrencia/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-ocorrencia/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-ocorrencia/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-ocorrencia/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-ocorrencia/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-orgao/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-orgao/busca-ajax', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-orgao/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-orgao/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-orgao/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-orgao/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-orgao/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-orgao/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-telefone/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-telefone/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-telefone/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-telefone/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-telefone/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-telefone/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-telefone/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/user-management/*', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/auth-item-group/*', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/bulk-activate', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/bulk-deactivate', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/bulk-delete', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/create', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/delete', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/grid-page-size', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/grid-sort', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/index', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth-item-group/toggle-attribute', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/update', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/auth-item-group/view', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/*', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/addressSearch', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/user-management/auth/captcha', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/change-own-password', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/auth/confirm-email', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/confirm-email-receive', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/confirm-registration-email', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/login', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/logout', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/password-recovery', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/password-recovery-receive', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/auth/registration', 3, NULL, NULL, NULL, 1503317373, 1503317373, NULL),
('/user-management/permission/*', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/permission/bulk-activate', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/permission/bulk-deactivate', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/permission/bulk-delete', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/permission/create', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/permission/delete', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/permission/grid-page-size', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/permission/grid-sort', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/permission/index', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/permission/refresh-routes', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/permission/set-child-permissions', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/permission/set-child-routes', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/permission/toggle-attribute', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/permission/update', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/permission/view', 3, NULL, NULL, NULL, 1503317372, 1503317372, NULL),
('/user-management/role/*', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/role/bulk-activate', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/bulk-deactivate', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/bulk-delete', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/create', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/delete', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/grid-page-size', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/role/grid-sort', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/index', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/set-child-permissions', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/set-child-roles', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/toggle-attribute', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/update', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/role/view', 3, NULL, NULL, NULL, 1503317371, 1503317371, NULL),
('/user-management/user-permission/*', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-permission/set', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user-permission/set-roles', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user-visit-log/*', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/bulk-activate', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/bulk-deactivate', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/bulk-delete', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/create', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/delete', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/grid-page-size', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/grid-sort', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/index', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/toggle-attribute', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/update', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user-visit-log/view', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user/*', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user/bulk-activate', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user/bulk-deactivate', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user/bulk-delete', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user/busca-ajax', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/user-management/user/change-first-password', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user-management/user/change-own-email', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user-management/user/change-password', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user/confirma-cadastro', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user-management/user/create', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user/delete', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user/grid-page-size', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user/grid-sort', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user/index', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user/muda-perfil', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/user-management/user/report-bug', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user-management/user/toggle-attribute', 3, NULL, NULL, NULL, 1503317370, 1503317370, NULL),
('/user-management/user/update', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user-management/user/view', 3, NULL, NULL, NULL, 1503317291, 1503317291, NULL),
('/user/*', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/user/bulk-activate', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/user/bulk-deactivate', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/user/bulk-delete', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/user/busca-ajax', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/user/change-first-password', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user/change-own-email', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user/change-password', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user/confirma-cadastro', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user/create', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user/delete', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/user/grid-page-size', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/user/grid-sort', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/user/index', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user/muda-perfil', 3, NULL, NULL, NULL, 1534344783, 1534344783, NULL),
('/user/report-bug', 3, NULL, NULL, NULL, 1503319035, 1503319035, NULL),
('/user/toggle-attribute', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/user/update', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/user/view', 3, NULL, NULL, NULL, 1503319034, 1503319034, NULL),
('/visita-tec-produto/*', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tec-produto/create', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tec-produto/delete', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tec-produto/error', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tec-produto/index', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tec-produto/update', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tec-produto/view', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tecnica/*', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tecnica/create', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tecnica/delete', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tecnica/error', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tecnica/index', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tecnica/update', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('/visita-tecnica/view', 3, NULL, NULL, NULL, 1539470292, 1539470292, NULL),
('Admin', 1, 'Admin', NULL, NULL, 1503317291, 1503317291, NULL),
('assignRolesToUsers', 2, 'Assign roles to users', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('bindUserToIp', 2, 'Bind user to IP', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('changeOwnPassword', 2, 'Change own password', NULL, NULL, 1503317291, 1503317291, 'userCommonPermissions'),
('changeUserPassword', 2, 'Change user password', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('commonPermission', 2, 'Common permission', NULL, NULL, 1503317286, 1503317286, NULL),
('createUsers', 2, 'Create users', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('default', 1, 'Usuário Padrão', NULL, NULL, 1504034829, 1504034829, NULL),
('deleteUsers', 2, 'Delete users', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('editUserEmail', 2, 'Edit user email', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('editUsers', 2, 'Edit users', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('full', 2, 'acessoTotal', NULL, NULL, 1535457339, 1535457339, 'total'),
('total', 1, 'acessoTotal', NULL, NULL, 1535457374, 1535457374, NULL),
('viewRegistrationIp', 2, 'View registration IP', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('viewUserEmail', 2, 'View user email', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('viewUserRoles', 2, 'View user roles', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('viewUsers', 2, 'View users', NULL, NULL, 1503317291, 1503317291, 'userManagement'),
('viewVisitLog', 2, 'View visit log', NULL, NULL, 1503317291, 1503317291, 'userManagement');

-- --------------------------------------------------------

--
-- Estrutura da tabela `auth_item_child`
--

CREATE TABLE `auth_item_child` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `auth_item_child`
--

INSERT INTO `auth_item_child` (`parent`, `child`) VALUES
('Admin', 'assignRolesToUsers'),
('Admin', 'changeOwnPassword'),
('Admin', 'changeUserPassword'),
('Admin', 'createUsers'),
('Admin', 'deleteUsers'),
('Admin', 'editUsers'),
('Admin', 'viewUsers'),
('assignRolesToUsers', '/user-management/user-permission/set'),
('assignRolesToUsers', '/user-management/user-permission/set-roles'),
('assignRolesToUsers', 'viewUserRoles'),
('assignRolesToUsers', 'viewUsers'),
('changeOwnPassword', '/user-management/auth/change-own-password'),
('changeUserPassword', '/user-management/user/change-password'),
('changeUserPassword', 'viewUsers'),
('commonPermission', '/auth/confirm-email-receive'),
('commonPermission', '/auth/login'),
('commonPermission', '/auth/password-recovery'),
('commonPermission', '/auth/password-recovery-receive'),
('commonPermission', '/user-management/auth/confirm-email-receive'),
('commonPermission', '/user-management/auth/login'),
('commonPermission', '/user-management/auth/password-recovery'),
('commonPermission', '/user-management/auth/password-recovery-receive'),
('createUsers', '/user-management/user/create'),
('createUsers', 'viewUsers'),
('deleteUsers', '/user-management/user/bulk-delete'),
('deleteUsers', '/user-management/user/delete'),
('deleteUsers', 'viewUsers'),
('editUserEmail', 'viewUserEmail'),
('editUsers', '/user-management/user/bulk-activate'),
('editUsers', '/user-management/user/bulk-deactivate'),
('editUsers', '/user-management/user/update'),
('editUsers', 'viewUsers'),
('full', '/*'),
('total', 'Admin'),
('total', 'default'),
('total', 'full'),
('viewUsers', '/user-management/user/grid-page-size'),
('viewUsers', '/user-management/user/index'),
('viewUsers', '/user-management/user/view');

-- --------------------------------------------------------

--
-- Estrutura da tabela `auth_item_group`
--

CREATE TABLE `auth_item_group` (
  `code` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `auth_item_group`
--

INSERT INTO `auth_item_group` (`code`, `name`, `created_at`, `updated_at`) VALUES
('total', 'controleTotal', 1535457309, 1535457309),
('userCommonPermissions', 'User common permission', 1503317291, 1503317291),
('userManagement', 'User management', 1503317291, 1503317291);

-- --------------------------------------------------------

--
-- Estrutura da tabela `auth_rule`
--

CREATE TABLE `auth_rule` (
  `name` varchar(64) NOT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `banco`
--

CREATE TABLE `banco` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  `descricao` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `bloqueio`
--

CREATE TABLE `bloqueio` (
  `id` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `fk_contrato` int(11) DEFAULT NULL,
  `fk_usuario` int(11) NOT NULL,
  `data_bloqueio` date NOT NULL,
  `data_limite` date DEFAULT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `bloqueio_produto`
--

CREATE TABLE `bloqueio_produto` (
  `id` int(11) NOT NULL,
  `fk_bloqueio` int(11) NOT NULL,
  `fk_produto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cargo`
--

CREATE TABLE `cargo` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `cargo`
--

INSERT INTO `cargo` (`id`, `fk_entidade`, `descricao`) VALUES
(1, 1, 'Vendedor'),
(2, 1, 'Diretor'),
(3, 1, 'Analista de Sistemas');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `fk_tipo_cliente` int(11) NOT NULL,
  `fk_tipo_orgao` int(11) NOT NULL,
  `fk_representante` int(11) DEFAULT NULL,
  `cpf_cnpj` varchar(14) NOT NULL,
  `razao_social` varchar(200) NOT NULL,
  `nome_fantasia` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `brasao` varchar(255) DEFAULT NULL,
  `cep` varchar(8) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `data_situacao` date DEFAULT NULL,
  `data_cadastro` date NOT NULL,
  `situacao` tinyint(4) NOT NULL,
  `qtd_populacao` int(11) DEFAULT NULL,
  `qtd_eleitor` int(11) DEFAULT NULL,
  `ano_populacao` varchar(4) DEFAULT NULL,
  `fpm` decimal(10,2) DEFAULT NULL,
  `fpm_ano` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`id`, `fk_entidade`, `fk_tipo_cliente`, `fk_tipo_orgao`, `fk_representante`, `cpf_cnpj`, `razao_social`, `nome_fantasia`, `email`, `brasao`, `cep`, `estado`, `cidade`, `bairro`, `endereco`, `complemento`, `numero`, `data_situacao`, `data_cadastro`, `situacao`, `qtd_populacao`, `qtd_eleitor`, `ano_populacao`, `fpm`, `fpm_ano`) VALUES
(22, 1, 4, 3, 46, '03470727000473', 'Veículos Ford', 'Ivep', 'josenitamarise@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/10.405.329/000_-__/6446363.jpg', '48080070', 'BA', 'Alagoinhas', 'Jardim Pedro Braga ', 'Rua Alfredo Garcia ', 'Av. Principal', 0, NULL, '2018-05-03', 1, NULL, NULL, '0000', NULL, ''),
(25, 1, 1, 2, NULL, '15245056000183', 'Diretores S.A', 'Diretoria Cometa', 'diretoriasa@direct.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/15245056000183/1043814.jpg', '41760035', 'BA', 'Salvador', 'Costa Azul ', 'Rua Doutor Augusto Lopes Pontes ', 'Av. Principal', 0, NULL, '2018-09-18', 1, NULL, NULL, '0000', NULL, ''),
(46, 1, 1, 1, NULL, '13646005000138', 'Prefeitura Alagoinhas', 'Prefeitura Alagoinhas', 'prefeituraalagoinhas@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/13646005000138/7248561.jpg', '48080070', 'BA', 'Alagoinhas', 'Jardim Pedro Braga ', 'Rua Alfredo Garcia ', 'Av. Principal', 0, NULL, '2018-09-19', 1, NULL, NULL, '', NULL, ''),
(47, 1, 1, 2, NULL, '04151452524', 'Luan Araujo', 'Vin Diesel', 'luandiego7@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04.151.452/524_-__/5755518.jpg', '4176003', 'BA', 'Salvador', 'Costa Azul ', 'Rua Doutor Augusto Lopes Pontes ', 'Condominio Costa do Atlantico', 455, NULL, '2017-03-05', 1, NULL, NULL, '0000', NULL, ''),
(48, 1, 2, 1, NULL, '03449275000103', 'Arcos Dourados Comercio de Alimentos LTDA.', 'Mc Donalds', 'mcdonalds@mcdonalds.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/03.449.275/0001-03/2055112.png', '41701035', 'BA', 'Salvador', 'Alphaville I ', 'Rua Parati ', 'av principal', 0, NULL, '2018-09-26', 1, NULL, NULL, NULL, NULL, NULL),
(75, 1, 2, 3, NULL, '04151452524', 'teste', 'teste', 'teste@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/1657836.jpg', '41130000', 'BA ', 'Salvador', 'Pernambués ', 'Rua Thomaz Gonzaga - de 372/373 ao fim ', 'Av. Principal', 11, '2000-11-30', '2018-10-11', 1, NULL, NULL, '', NULL, ''),
(76, 1, 2, 3, NULL, '04151452524', 'teste 2', 'teste 2', 'teste2@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/9479974.jpg', '41130000', 'BA ', 'Salvador', 'Pernambués ', 'Rua Thomaz Gonzaga - de 372/373 ao fim ', 'Av. Principal 2', 4, NULL, '2018-10-12', 1, 55, 55, '2004', '33.00', '2005'),
(77, 1, 3, 1, 48, '04151452524', 'srs', 'sdrsd', 'contato_interno@ford.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/3593651.jpg', '41760035', 'BA ', 'Salvador', 'Costa Azul ', 'Rua Doutor Augusto Lopes Pontes ', 'Av. Principal', 1, NULL, '2018-10-12', 1, NULL, NULL, '', NULL, ''),
(79, 1, 2, 3, NULL, '04151452524', 'Samsung Electronics Co., Ltd.', 'Samsung', 'samsung@samsung.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/041.514.525-24/4417300.jpg', '41760035', 'BA ', 'Salvador', 'Costa Azul ', 'Rua Doutor Augusto Lopes Pontes ', 'av principal', 33, NULL, '2018-10-17', 1, 10000, 9000, '2008', '100.00', '2008');

-- --------------------------------------------------------

--
-- Estrutura da tabela `conta`
--

CREATE TABLE `conta` (
  `id` int(11) NOT NULL,
  `fk_banco` int(11) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `agencia` varchar(20) NOT NULL,
  `descricao` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `contato_cliente`
--

CREATE TABLE `contato_cliente` (
  `id` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `fk_departamento` int(11) NOT NULL,
  `fk_cargo` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `contato_cliente`
--

INSERT INTO `contato_cliente` (`id`, `fk_cliente`, `fk_departamento`, `fk_cargo`, `nome`, `data_nascimento`, `email`, `foto`) VALUES
(15, 22, 3, 3, 'LUAN DIEGO LUZ ARAUJO', NULL, 'luandiego7@gmail.com', NULL),
(17, 22, 1, 2, 'Josenita Marise Ailton Araujo', NULL, 'josenitamarise@gmail.com', NULL),
(21, 25, 3, 2, 'Adimario Filho', '1970-03-05', 'adimario@keep.com', NULL),
(22, 25, 1, 2, 'Fabricio', NULL, 'fabricio@keep.com', NULL),
(25, 46, 3, 2, 'Joaquim neto Prefeito', NULL, 'joaquim@alagoinhas.com.br', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/13646005000138/6142297.jpeg'),
(26, 46, 3, 3, 'Henry Allen West', NULL, 'marcos.dba1995@hotmail.com', NULL),
(27, 46, 1, 2, 'Joseildo Ramos', NULL, 'joseildo@gmail.com', NULL),
(28, 46, 3, 3, 'Marcelo Ramos', NULL, 'marcelo@gmail.com', NULL),
(29, 47, 1, 2, 'Mae', NULL, 'josenitamarise@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/7937069.jpeg'),
(30, 47, 3, 2, 'Pai', NULL, 'ailtonaraujo@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/475827.jpeg'),
(31, 47, 3, 2, 'Irmao', NULL, 'airtonaraujo@gmail.com', NULL),
(32, 48, 1, 1, 'Ronald', NULL, 'ronald@mcdonalds.com', NULL),
(33, 76, 1, 3, 'teste 312312', '2006-09-26', 'teste3@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/4853678.png'),
(34, 77, 1, 1, 'teste', '2018-10-15', 'luandiego7@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/2019934.png'),
(41, 76, 1, 3, 'teste33', '2018-10-03', 'teste@gmail.com', NULL),
(42, 79, 3, 2, 'Uzumaki Naruto', '2018-10-11', 'naruto@uzumaki.com', NULL),
(43, 79, 3, 2, 'Minato Namikaze Hokage', '2007-10-18', 'minato@namikaze.com', NULL),
(44, 79, 1, 2, 'Jackie Chan', '1975-10-15', 'jackie@gmail.com', 'https://s3.sa-east-1.amazonaws.com/cdn.keep/crm/imagens/04151452524/587673.jpeg');

-- --------------------------------------------------------

--
-- Estrutura da tabela `conta_orcamento`
--

CREATE TABLE `conta_orcamento` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `tipo` char(1) NOT NULL,
  `tipo_lancamento` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `contrato`
--

CREATE TABLE `contrato` (
  `id` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `fk_modalidade` int(11) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_termino` date NOT NULL,
  `valor_global` decimal(10,2) NOT NULL,
  `valor_mensal` decimal(10,2) NOT NULL,
  `anexo` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `objeto` varchar(255) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `info_complementar` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `contrato`
--

INSERT INTO `contrato` (`id`, `fk_cliente`, `fk_modalidade`, `data_inicio`, `data_termino`, `valor_global`, `valor_mensal`, `anexo`, `status`, `objeto`, `numero`, `info_complementar`) VALUES
(1, 48, 1, '2018-10-17', '2018-11-28', '1000000.00', '20000.00', '', 1, 'SISTEMA', '2123', 'WEB'),
(2, 48, 1, '2018-10-17', '2018-11-28', '1000000.00', '20000.00', '', 1, 'SISTEMA', '1324', 'WEB');

-- --------------------------------------------------------

--
-- Estrutura da tabela `contrato_produtos`
--

CREATE TABLE `contrato_produtos` (
  `id` int(11) NOT NULL,
  `fk_contrato` int(11) NOT NULL,
  `fk_produto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `contrato_produtos`
--

INSERT INTO `contrato_produtos` (`id`, `fk_contrato`, `fk_produto`) VALUES
(20, 2, 1),
(21, 2, 2),
(23, 1, 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `controle_versao`
--

CREATE TABLE `controle_versao` (
  `id` int(11) NOT NULL,
  `fk_produto` int(11) NOT NULL,
  `fk_usuario` int(11) NOT NULL,
  `data_hora` date NOT NULL,
  `numero_versao` varchar(20) NOT NULL,
  `descricao` text NOT NULL,
  `script` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `departamento`
--

CREATE TABLE `departamento` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `departamento`
--

INSERT INTO `departamento` (`id`, `fk_entidade`, `descricao`) VALUES
(1, 1, 'Depósito'),
(2, 1, 'RH'),
(3, 1, 'Informática');

-- --------------------------------------------------------

--
-- Estrutura da tabela `entidade`
--

CREATE TABLE `entidade` (
  `id` int(11) NOT NULL,
  `cnpj` varchar(14) NOT NULL,
  `razao_social` varchar(200) NOT NULL,
  `nome_fantasia` varchar(100) NOT NULL,
  `insc_municipal` varchar(30) NOT NULL,
  `logo_marca` varchar(255) DEFAULT NULL,
  `cep` varchar(8) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `entidade`
--

INSERT INTO `entidade` (`id`, `cnpj`, `razao_social`, `nome_fantasia`, `insc_municipal`, `logo_marca`, `cep`, `estado`, `cidade`, `bairro`, `endereco`, `complemento`) VALUES
(1, '10405329000196', 'T.O. Sistemas', 'Keep Informática', '9913', 'WCdENBj7J2nEnAQEdnyrk_TyPLikerFa.jpg', '41701-00', 'BA', 'Salvador', 'Alphaville I ', 'Avenida Luís Viana - lado par ', 'Edifício Cosmopolitan');

-- --------------------------------------------------------

--
-- Estrutura da tabela `financeiro`
--

CREATE TABLE `financeiro` (
  `id` int(11) NOT NULL,
  `fk_nota_fiscal` int(11) DEFAULT NULL,
  `fk_cliente` int(11) NOT NULL,
  `fk_conta` int(11) DEFAULT NULL,
  `fk_tipo_documento` int(11) NOT NULL,
  `fk_banco_portador` int(11) NOT NULL,
  `fk_conta_orcamento` int(11) NOT NULL,
  `numero_titulo` varchar(20) NOT NULL,
  `data_emissao` date NOT NULL,
  `tipo` char(1) NOT NULL,
  `vencimento` date NOT NULL,
  `valor_titulo` decimal(10,2) NOT NULL,
  `valor_pgto` decimal(10,2) DEFAULT NULL,
  `data_pgto` date DEFAULT NULL,
  `valor_desconto` decimal(10,2) NOT NULL,
  `data_dev` date DEFAULT NULL,
  `valor_dev` decimal(10,2) DEFAULT NULL,
  `saldo` decimal(10,2) NOT NULL,
  `obs` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `gestao`
--

CREATE TABLE `gestao` (
  `id` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `periodo` varchar(23) NOT NULL,
  `prefeito` varchar(200) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `vice_prefeito` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `gestao`
--

INSERT INTO `gestao` (`id`, `fk_cliente`, `periodo`, `prefeito`, `data_nascimento`, `vice_prefeito`) VALUES
(21, 79, '01/01/2000 à 31/12/2003', 'Kim Hiu Suk', '1958-10-07', 'Lin chen chu'),
(22, 79, '01/01/2004 à 31/12/2007', 'Rock Lee', '1954-03-09', 'Gai Sensei'),
(23, 79, '01/01/2008 à 31/12/2011', 'Kakashi Sensei', '1952-03-05', 'Uchiha Sasuke'),
(24, 79, '02/10/2018 à 03/10/2018', 'teste', '2018-10-02', 'teste 2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `itens_orcamento`
--

CREATE TABLE `itens_orcamento` (
  `id` int(11) NOT NULL,
  `fk_orcamento` int(11) NOT NULL,
  `fk_produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `valor_total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `migration`
--

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m180720_143745_excluiLog', 1538260328);

-- --------------------------------------------------------

--
-- Estrutura da tabela `modalidade`
--

CREATE TABLE `modalidade` (
  `id` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `modalidade`
--

INSERT INTO `modalidade` (`id`, `descricao`) VALUES
(1, 'Vitalício');

-- --------------------------------------------------------

--
-- Estrutura da tabela `nota_fiscal`
--

CREATE TABLE `nota_fiscal` (
  `id` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `fk_usuario` int(11) NOT NULL,
  `numero_nota` varchar(20) NOT NULL,
  `data_emissao` date NOT NULL,
  `competencia` date NOT NULL,
  `descricao_servico` text NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `aliquota_iss` decimal(10,2) NOT NULL,
  `valor_iss` decimal(10,2) NOT NULL,
  `condicao_pagamento` varchar(50) DEFAULT NULL,
  `info_complementar` varchar(255) DEFAULT NULL,
  `rastreamento` varchar(20) DEFAULT NULL,
  `data_entrega` date DEFAULT NULL,
  `situacao` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `orcamento_proposta`
--

CREATE TABLE `orcamento_proposta` (
  `id` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `fk_contato_cliente` int(11) NOT NULL,
  `implantacao_parcela` varchar(20) NOT NULL,
  `implantacao_valor` decimal(10,2) NOT NULL,
  `validade` int(11) NOT NULL,
  `obs` text,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `descricao` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`id`, `fk_entidade`, `codigo`, `descricao`) VALUES
(1, 1, '1.123532.212', 'Patrimônio'),
(2, 1, '2', 'Compras'),
(3, 1, '3', 'Contra Cheque');

-- --------------------------------------------------------

--
-- Estrutura da tabela `requests`
--

CREATE TABLE `requests` (
  `id` bigint(8) NOT NULL,
  `nome_arquivo` varchar(255) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `data_ini_req` datetime NOT NULL,
  `data_fim_req` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `mensagem` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `telefone`
--

CREATE TABLE `telefone` (
  `id` int(11) NOT NULL,
  `fk_contato_cliente` int(11) NOT NULL,
  `fk_tipo_telefone` int(11) NOT NULL,
  `telefone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `telefone`
--

INSERT INTO `telefone` (`id`, `fk_contato_cliente`, `fk_tipo_telefone`, `telefone`) VALUES
(1, 21, 4, '7132851000'),
(2, 15, 3, '71991237296'),
(5, 25, 2, '75975757575'),
(6, 15, 4, '64564564564'),
(7, 15, 4, '53575675756'),
(8, 15, 1, '65475656567'),
(9, 26, 2, '42342342342'),
(10, 26, 4, '44353423412'),
(11, 29, 3, '75999717455'),
(12, 30, 3, '71999878714'),
(13, 31, 4, '75999622530'),
(14, 33, 4, '71855451321'),
(19, 33, 3, '12412412412'),
(20, 41, 4, '23546345235'),
(21, 42, 4, '12121212121'),
(22, 42, 3, '23232323232'),
(23, 43, 2, '54545454544'),
(24, 44, 2, '54645456456');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_anexo`
--

CREATE TABLE `tipo_anexo` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tipo_anexo`
--

INSERT INTO `tipo_anexo` (`id`, `fk_entidade`, `descricao`) VALUES
(1, 1, 'contrato'),
(2, 1, 'aditivo'),
(3, 1, 'certidão'),
(4, 1, 'livro');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_atendimento`
--

CREATE TABLE `tipo_atendimento` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_cliente`
--

CREATE TABLE `tipo_cliente` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tipo_cliente`
--

INSERT INTO `tipo_cliente` (`id`, `fk_entidade`, `descricao`, `codigo`) VALUES
(1, 1, 'Interno', 2),
(2, 1, 'Cliente', 3),
(3, 1, 'Representante', 5),
(4, 1, 'Prefeitura', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `id` int(11) NOT NULL,
  `tipo` varchar(3) NOT NULL,
  `descricao` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_ocorrencia`
--

CREATE TABLE `tipo_ocorrencia` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL,
  `prazo` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_orgao`
--

CREATE TABLE `tipo_orgao` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL,
  `sigla` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tipo_orgao`
--

INSERT INTO `tipo_orgao` (`id`, `fk_entidade`, `descricao`, `sigla`) VALUES
(1, 1, 'Orgão Vendas', 'OV'),
(2, 1, 'Orgão Diretoria', 'OD'),
(3, 1, 'Prefeitura', 'PFR');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_telefone`
--

CREATE TABLE `tipo_telefone` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) NOT NULL,
  `descricao` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tipo_telefone`
--

INSERT INTO `tipo_telefone` (`id`, `fk_entidade`, `descricao`) VALUES
(1, 1, 'Comercial'),
(2, 1, 'Residêncial'),
(3, 1, 'Celular'),
(4, 1, 'Whatsapp');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `fk_entidade` int(11) DEFAULT NULL,
  `nome_completo` varchar(100) NOT NULL,
  `username` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `auth_key` varchar(32) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `superadmin` smallint(6) DEFAULT '0',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `registration_ip` varchar(15) DEFAULT NULL,
  `bind_to_ip` varchar(255) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `email_confirmed` smallint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user`
--

INSERT INTO `user` (`id`, `fk_entidade`, `nome_completo`, `username`, `foto`, `auth_key`, `password_hash`, `confirmation_token`, `status`, `superadmin`, `created_at`, `updated_at`, `registration_ip`, `bind_to_ip`, `email`, `email_confirmed`) VALUES
(1, NULL, '', 'superadmin', NULL, '-HfM62CLTX6rLjmHUhmXYPd6kSx2pOQA', '$2y$13$Io2aMXTTjkdzj.UJgwDQAu8kGcN7J.wqgxTP8zlr3ylgFi59elabe', NULL, 1, 1, 1503317286, 1503320115, NULL, '', '', 0),
(2, 1, 'Luan Araujo', 'luanaraujo', NULL, 'K5wIVbKUBgQ1jB9y9R7MKvwgREQDPUue', '$2y$13$G1CaxfD4PNAns7jcedWhu.MDUjDH4A2RLqHCn9M0jWdZlsme9juGa', NULL, 1, 0, 1535457865, 1535458980, '::1', '', 'luandiego7@gmail.com', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_visit_log`
--

CREATE TABLE `user_visit_log` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `language` char(2) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `visit_time` int(11) NOT NULL,
  `browser` varchar(30) DEFAULT NULL,
  `os` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user_visit_log`
--

INSERT INTO `user_visit_log` (`id`, `token`, `ip`, `language`, `user_agent`, `user_id`, `visit_time`, `browser`, `os`) VALUES
(2, '5b7efb369c4b1', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535048502, 'Chrome', 'Windows'),
(3, '5b7efb5d71647', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 1, 1535048541, 'Edge', 'Windows'),
(4, '5b7efb99a6afd', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535048601, 'Chrome', 'Windows'),
(5, '5b7efbc011f8d', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535048640, 'Chrome', 'Windows'),
(6, '5b80009d444b8', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535115421, 'Chrome', 'Windows'),
(7, '5b80046228949', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 1, 1535116386, 'Edge', 'Windows'),
(8, '5b8038cc813fd', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535129804, 'Chrome', 'Windows'),
(9, '5b83e25112810', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535369809, 'Chrome', 'Windows'),
(10, '5b83f78113f81', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535375233, 'Chrome', 'Windows'),
(11, '5b8442138a762', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535394323, 'Chrome', 'Windows'),
(12, '5b8531de0dc4f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535455710, 'Chrome', 'Windows'),
(13, '5b853a9798d41', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535457943, 'Chrome', 'Windows'),
(14, '5b853b79b1b3a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535458169, 'Chrome', 'Windows'),
(15, '5b853c0b8903f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535458315, 'Chrome', 'Windows'),
(16, '5b853c1beeb9a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535458331, 'Chrome', 'Windows'),
(17, '5b853eb84abab', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535459000, 'Chrome', 'Windows'),
(18, '5b853ecbdd588', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535459019, 'Chrome', 'Windows'),
(19, '5b853f02d6499', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535459074, 'Chrome', 'Windows'),
(20, '5b8541714b899', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535459697, 'Chrome', 'Windows'),
(21, '5b85417f24f46', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535459711, 'Chrome', 'Windows'),
(22, '5b8548fa554bf', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 1, 1535461626, 'Chrome', 'Windows'),
(23, '5b854906bc7b6', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535461638, 'Chrome', 'Windows'),
(24, '5b855259df0fb', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535464025, 'Chrome', 'Windows'),
(25, '5b8557796baf9', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535465337, 'Chrome', 'Windows'),
(26, '5b85583327c1c', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1535465523, 'Edge', 'Windows'),
(27, '5b86861963ecb', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535542809, 'Chrome', 'Windows'),
(28, '5b87d5d70d446', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535628759, 'Chrome', 'Windows'),
(29, '5b87daf3cda25', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1535630067, 'Edge', 'Windows'),
(30, '5b87eea014f49', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535635104, 'Chrome', 'Windows'),
(31, '5b8829dbb4d3f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535650267, 'Chrome', 'Windows'),
(32, '5b882e15dd4ef', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535651349, 'Chrome', 'Windows'),
(33, '5b882e57d54e7', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535651415, 'Chrome', 'Windows'),
(34, '5b888f06cf1b8', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1535676166, 'Firefox', 'Windows'),
(35, '5b8896489e606', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 1, 1535678024, 'Firefox', 'Windows'),
(36, '5b88993a36c7b', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1535678778, 'Firefox', 'Windows'),
(37, '5b892be698436', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1535716326, 'Firefox', 'Windows'),
(38, '5b892e3b0cfee', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535716923, 'Chrome', 'Windows'),
(39, '5b8933e1b2f48', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1535718369, 'Firefox', 'Windows'),
(40, '5b895ab2d1497', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1535728306, 'Edge', 'Windows'),
(41, '5b8d512db193e', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', 2, 1535988013, 'Chrome', 'Windows'),
(42, '5b8d55d6ab710', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1535989206, 'Firefox', 'Windows'),
(43, '5b8e6dc095f0f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1536060864, 'Firefox', 'Windows'),
(44, '5b8f14960abcd', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1536103574, 'Firefox', 'Windows'),
(45, '5b8fc11522d41', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1536147733, 'Firefox', 'Windows'),
(46, '5b8fdc39b86a6', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1536154681, 'Edge', 'Windows'),
(47, '5b901ba20562e', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1536170914, 'Firefox', 'Windows'),
(48, '5b965ebe197db', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536581310, 'Chrome', 'Windows'),
(49, '5b96643aa9bea', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536582714, 'Chrome', 'Windows'),
(50, '5b966d2d52d1b', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1536585005, 'Firefox', 'Windows'),
(51, '5b9681402d1f0', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0', 2, 1536590144, 'Firefox', 'Windows'),
(52, '5b970bab90b84', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536625579, 'Chrome', 'Windows'),
(53, '5b97abf291fd9', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536666610, 'Chrome', 'Windows'),
(54, '5b97bc79cf299', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1536670841, 'Firefox', 'Windows'),
(55, '5b9902104aa8f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536754192, 'Chrome', 'Windows'),
(56, '5b992037cccf1', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1536761911, 'Firefox', 'Windows'),
(57, '5b995b73e7030', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1, 1536777075, 'Chrome', 'Windows'),
(58, '5b995d60797a4', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536777568, 'Chrome', 'Windows'),
(59, '5b9a4c17c0619', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536838679, 'Chrome', 'Windows'),
(60, '5b9a63b29ac78', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1, 1536844722, 'Chrome', 'Windows'),
(61, '5b9a63e776c2b', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1, 1536844775, 'Chrome', 'Windows'),
(62, '5b9a707455a02', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1536847988, 'Firefox', 'Windows'),
(63, '5b9ab0e8b577b', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1536864488, 'Edge', 'Windows'),
(64, '5b9ab3764c292', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536865142, 'Chrome', 'Windows'),
(65, '5b9ab5089f0af', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1536865544, 'Firefox', 'Windows'),
(66, '5b9ba25d6f7b1', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1, 1536926301, 'Chrome', 'Windows'),
(67, '5b9ba2673c40a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536926311, 'Chrome', 'Windows'),
(68, '5b9bd0cac8d6a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1536938186, 'Chrome', 'Windows'),
(69, '5b9bd27c826ee', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1536938620, 'Firefox', 'Windows'),
(70, '5b9f99ffd571f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1537186303, 'Chrome', 'Windows'),
(71, '5b9fca9a2feb0', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537198746, 'Firefox', 'Windows'),
(72, '5ba0e9f631e2d', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1537272310, 'Chrome', 'Windows'),
(73, '5ba10e1157eef', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537281553, 'Firefox', 'Windows'),
(74, '5ba17747185de', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1537308487, 'Chrome', 'Windows'),
(75, '5ba23742a1304', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1537357634, 'Chrome', 'Windows'),
(76, '5ba25bbda1278', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1537366973, 'Chrome', 'Windows'),
(77, '5ba25ea0259cb', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537367712, 'Firefox', 'Windows'),
(78, '5ba296e6883e9', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537382118, 'Firefox', 'Windows'),
(79, '5ba2ed2f8b952', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 2, 1537404207, 'Chrome', 'Windows'),
(80, '5ba388f45cc6c', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1537444084, 'Chrome', 'Windows'),
(81, '5ba38d9603404', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1537445270, 'Chrome', 'Windows'),
(82, '5ba393fd797c3', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537446909, 'Firefox', 'Windows'),
(83, '5ba3ae78cef64', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537453688, 'Firefox', 'Windows'),
(84, '5ba44af5e50c8', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537493749, 'Firefox', 'Windows'),
(85, '5ba4d821239b3', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537529889, 'Firefox', 'Windows'),
(86, '5ba50246d9577', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537540678, 'Firefox', 'Windows'),
(87, '5ba536ad145a2', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 1, 1537554093, 'Firefox', 'Windows'),
(88, '5ba536c4e7177', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537554116, 'Firefox', 'Windows'),
(89, '5ba53a1f1fd6a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 1, 1537554975, 'Firefox', 'Windows'),
(90, '5ba54e12cffa5', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537560082, 'Firefox', 'Windows'),
(91, '5ba56336b4626', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 1, 1537565494, 'Firefox', 'Windows'),
(92, '5ba5658de8724', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 1, 1537566093, 'Chrome', 'Windows'),
(93, '5ba56b218c777', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 1, 1537567521, 'Chrome', 'Windows'),
(94, '5ba56d290670d', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537568041, 'Firefox', 'Windows'),
(95, '5ba5706fcd00b', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 1, 1537568879, 'Firefox', 'Windows'),
(96, '5ba58f764057b', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537576822, 'Firefox', 'Windows'),
(97, '5ba8d6f5f0c5f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537791733, 'Firefox', 'Windows'),
(98, '5ba8ecbe6b162', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1537797310, 'Chrome', 'Windows'),
(99, '5ba8ed352e485', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537797429, 'Firefox', 'Windows'),
(100, '5baa2a69261b3', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1537878633, 'Chrome', 'Windows'),
(101, '5baa5b5730321', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537891159, 'Firefox', 'Windows'),
(102, '5baa841874ec1', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1537901592, 'Edge', 'Windows'),
(103, '5baac6ec0dbde', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537918700, 'Firefox', 'Windows'),
(104, '5baace5888a0c', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537920600, 'Firefox', 'Windows'),
(105, '5bab73b2c7f2b', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1537962930, 'Firefox', 'Windows'),
(106, '5babd510ca68a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1537987856, 'Chrome', 'Windows'),
(107, '5bacc663b855c', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538049635, 'Chrome', 'Windows'),
(108, '5bad553fe6506', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1538086207, 'Firefox', 'Windows'),
(109, '5bad7019885d0', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1538093081, 'Firefox', 'Windows'),
(110, '5bad7081ac46d', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538093185, 'Chrome', 'Windows'),
(111, '5bae238bcd038', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538139019, 'Chrome', 'Windows'),
(112, '5baed9e15bc79', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538185697, 'Chrome', 'Windows'),
(113, '5bafefa0166bc', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538256800, 'Chrome', 'Windows'),
(114, '5baffdd99270a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 1, 1538260441, 'Chrome', 'Windows'),
(115, '5bb039f8aa30a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538275832, 'Chrome', 'Windows'),
(116, '5bb22a446d6f4', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538402884, 'Chrome', 'Windows'),
(117, '5bb286dd7edcc', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538426589, 'Chrome', 'Windows'),
(118, '5bb2bae16360e', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538439905, 'Chrome', 'Windows'),
(119, '5bb577f0c1c35', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1538619376, 'Firefox', 'Windows'),
(120, '5bb6518d2d11e', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538675085, 'Chrome', 'Windows'),
(121, '5bb67815111c4', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538684949, 'Chrome', 'Windows'),
(122, '5bb74fc8733a5', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538740168, 'Chrome', 'Windows'),
(123, '5bb7a0ecab2e7', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538760940, 'Chrome', 'Windows'),
(124, '5bb819b18dc8f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538791857, 'Chrome', 'Windows'),
(125, '5bb906088651e', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1538852360, 'Chrome', 'Windows'),
(126, '5bbc96844c227', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539085956, 'Chrome', 'Windows'),
(127, '5bbce1bb25efd', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539105211, 'Chrome', 'Windows'),
(128, '5bbd2ec50f16d', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539124933, 'Chrome', 'Windows'),
(129, '5bbd620f70f7f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1539138063, 'Edge', 'Windows'),
(130, '5bbdeaa1a8022', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1539173025, 'Edge', 'Windows'),
(131, '5bbdf71f9dcff', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539176223, 'Chrome', 'Windows'),
(132, '5bbe05a0e00d8', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539179936, 'Chrome', 'Windows'),
(133, '5bbea60cd8987', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539221004, 'Chrome', 'Windows'),
(134, '5bbf3f0b6c463', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539260171, 'Chrome', 'Windows'),
(135, '5bbff97dacc42', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539307901, 'Chrome', 'Windows'),
(136, '5bc23758dbb64', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1539454808, 'Edge', 'Windows'),
(137, '5bc23be16fbf6', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1539455969, 'Firefox', 'Windows'),
(138, '5bc273b93fe20', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 1, 1539470265, 'Chrome', 'Windows'),
(139, '5bc273e1d6c8d', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539470305, 'Chrome', 'Windows'),
(140, '5bc274f29e437', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539470578, 'Chrome', 'Windows'),
(141, '5bc49d754488d', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1539612021, 'Firefox', 'Windows'),
(142, '5bc49f5b33955', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1539612507, 'Firefox', 'Windows'),
(143, '5bc4fbe882a45', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539636200, 'Chrome', 'Windows'),
(144, '5bc5d0670249a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1539690599, 'Firefox', 'Windows'),
(145, '5bc723c675d56', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1539777478, 'Firefox', 'Windows'),
(146, '5bc777114e51b', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1539798801, 'Chrome', 'Windows'),
(147, '5bc7b2ac6f046', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1539814060, 'Firefox', 'Windows'),
(148, '5bc87e3467095', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1539866164, 'Firefox', 'Windows'),
(149, '5bc9071170928', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1539901201, 'Firefox', 'Windows'),
(150, '5bcdf8b08afcf', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1540225200, 'Firefox', 'Windows'),
(151, '5bcddc090fd63', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1540217865, 'Chrome', 'Windows'),
(152, '5bcdef53dc896', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1540222803, 'Chrome', 'Windows'),
(153, '5bcdef829465a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1540222850, 'Firefox', 'Windows'),
(154, '5bce71d187c44', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1540256209, 'Firefox', 'Windows'),
(155, '5bce677abc17e', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1540253562, 'Firefox', 'Windows'),
(156, '5bcf0e6668eff', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1540296294, 'Firefox', 'Windows'),
(157, '5bcf86be0365a', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1540327102, 'Firefox', 'Windows'),
(158, '5bcf9b293767f', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 2, 1540332329, 'Chrome', 'Windows'),
(159, '5bd05e58a91a9', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:62.0) Gecko/20100101 Firefox/62.0', 2, 1540382296, 'Firefox', 'Windows');

-- --------------------------------------------------------

--
-- Estrutura da tabela `visitatec_produto`
--

CREATE TABLE `visitatec_produto` (
  `id` int(11) NOT NULL,
  `fk_visita` int(11) NOT NULL,
  `fk_produto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `visita_tecnica`
--

CREATE TABLE `visita_tecnica` (
  `id` int(11) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `fk_produto` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `solicitante` varchar(50) NOT NULL,
  `agendamento` datetime DEFAULT NULL,
  `situacao` tinyint(3) NOT NULL,
  `data_situacao` date DEFAULT NULL,
  `motivo` text NOT NULL,
  `ocorrencias` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aditivo`
--
ALTER TABLE `aditivo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_aditivo_contrato_idx` (`fk_contrato`);

--
-- Indexes for table `anexos_documentos`
--
ALTER TABLE `anexos_documentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_anexos_tipo_documento_idx` (`fk_tipo_documento`),
  ADD KEY `fk_anexos_cliente_idx` (`fk_cliente`);

--
-- Indexes for table `atendimento`
--
ALTER TABLE `atendimento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_atendimento_cliente_idx` (`fk_cliente`),
  ADD KEY `fk_atendimento_contato_cliente_idx` (`fk_contato_cliente`),
  ADD KEY `fk_atendimento_usuario_idx` (`fk_usuario`),
  ADD KEY `fk_atendimento_usuario_solucao_idx` (`fk_usuario_solucao`),
  ADD KEY `fk_atendimento_contrato_idx` (`fk_contrato`),
  ADD KEY `fk_atendimento_produto_idx` (`fk_produto`),
  ADD KEY `fk_atendimento_tipo_atendimento_idx` (`fk_tipo_atendimento`),
  ADD KEY `fk_atendimento_tipo_ocorrencia_idx` (`fk_tipo_ocorrencia`);

--
-- Indexes for table `atendimento_anexos`
--
ALTER TABLE `atendimento_anexos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_atendimento_anexo_atendimento_idx` (`fk_atendimento`);

--
-- Indexes for table `audit_trail_entry`
--
ALTER TABLE `audit_trail_entry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IN_audit_trail_entry_fast_access` (`model_type`,`happened_at`),
  ADD KEY `FK_audit_trail_entry_user` (`user_id`);

--
-- Indexes for table `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD PRIMARY KEY (`item_name`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_item`
--
ALTER TABLE `auth_item`
  ADD PRIMARY KEY (`name`),
  ADD KEY `rule_name` (`rule_name`),
  ADD KEY `idx-auth_item-type` (`type`),
  ADD KEY `fk_auth_item_group_code` (`group_code`);

--
-- Indexes for table `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD PRIMARY KEY (`parent`,`child`),
  ADD KEY `child` (`child`);

--
-- Indexes for table `auth_item_group`
--
ALTER TABLE `auth_item_group`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `auth_rule`
--
ALTER TABLE `auth_rule`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `banco`
--
ALTER TABLE `banco`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_banco_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `bloqueio`
--
ALTER TABLE `bloqueio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_bloqueio_cliente_idx` (`fk_cliente`),
  ADD KEY `fk_bloqueio_contrato_idx` (`fk_contrato`),
  ADD KEY `fk_bloqueio_usuario_idx` (`fk_usuario`);

--
-- Indexes for table `bloqueio_produto`
--
ALTER TABLE `bloqueio_produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_bloqueio_produto_idx` (`fk_produto`),
  ADD KEY `fk_bloqueio_produto_bloqueio_idx` (`fk_bloqueio`);

--
-- Indexes for table `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cargo_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cliente_tipo_idx` (`fk_tipo_cliente`),
  ADD KEY `fk_cliente_entidade_idx` (`fk_entidade`),
  ADD KEY `fk_cliente_tipo_orgao_idx` (`fk_tipo_orgao`),
  ADD KEY `fk_cliente_representante_idx` (`fk_representante`);

--
-- Indexes for table `conta`
--
ALTER TABLE `conta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_conta_banco_idx` (`fk_banco`);

--
-- Indexes for table `contato_cliente`
--
ALTER TABLE `contato_cliente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contato_cliente_idx` (`fk_cliente`),
  ADD KEY `fk_departamento_idx` (`fk_departamento`),
  ADD KEY `fk_contato_cargo_idx` (`fk_cargo`);

--
-- Indexes for table `conta_orcamento`
--
ALTER TABLE `conta_orcamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_conta_orcamento_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `contrato`
--
ALTER TABLE `contrato`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contrato_cliente_idx` (`fk_cliente`),
  ADD KEY `fk_contrato_modalidade_idx` (`fk_modalidade`);

--
-- Indexes for table `contrato_produtos`
--
ALTER TABLE `contrato_produtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contrato_idx` (`fk_contrato`),
  ADD KEY `fk_produto_idx` (`fk_produto`);

--
-- Indexes for table `controle_versao`
--
ALTER TABLE `controle_versao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_versao_produto_idx` (`fk_produto`),
  ADD KEY `fk_versao_usuario_idx` (`fk_usuario`);

--
-- Indexes for table `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_departamento_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `entidade`
--
ALTER TABLE `entidade`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `CNPJ_UNIQUE` (`cnpj`);

--
-- Indexes for table `financeiro`
--
ALTER TABLE `financeiro`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_financeiro_cliente_idx` (`fk_cliente`),
  ADD KEY `fk_financeiro_nota_idx` (`fk_nota_fiscal`),
  ADD KEY `fk_financeiro_tipo_documento_idx` (`fk_tipo_documento`),
  ADD KEY `fk_financeiro_conta_idx` (`fk_conta`),
  ADD KEY `fk_financeiro_banco_idx` (`fk_banco_portador`),
  ADD KEY `fk_financeiro_conta_orcamento_idx` (`fk_conta_orcamento`);

--
-- Indexes for table `gestao`
--
ALTER TABLE `gestao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_gestao_cliente_idx` (`fk_cliente`);

--
-- Indexes for table `itens_orcamento`
--
ALTER TABLE `itens_orcamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_itens_orcamento_idx` (`fk_orcamento`),
  ADD KEY `fk_itens_produto_idx` (`fk_produto`);

--
-- Indexes for table `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `modalidade`
--
ALTER TABLE `modalidade`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nota_fiscal`
--
ALTER TABLE `nota_fiscal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_nota_cliente_idx` (`fk_cliente`),
  ADD KEY `fk_nota_usuario_idx` (`fk_usuario`);

--
-- Indexes for table `orcamento_proposta`
--
ALTER TABLE `orcamento_proposta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_orcamento_cliente_idx` (`fk_cliente`),
  ADD KEY `fk_orcamento_contato_cliente_idx` (`fk_contato_cliente`);

--
-- Indexes for table `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `telefone`
--
ALTER TABLE `telefone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_telefone_contato_cliente_idx` (`fk_contato_cliente`),
  ADD KEY `fk_tipo_telefone` (`fk_tipo_telefone`);

--
-- Indexes for table `tipo_anexo`
--
ALTER TABLE `tipo_anexo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tipo_anexo_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `tipo_atendimento`
--
ALTER TABLE `tipo_atendimento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tipo_atendimento_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `tipo_cliente`
--
ALTER TABLE `tipo_cliente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tipo_cliente_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipo_ocorrencia`
--
ALTER TABLE `tipo_ocorrencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tipo_ocorrencia_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `tipo_orgao`
--
ALTER TABLE `tipo_orgao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tipo_orgao_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `tipo_telefone`
--
ALTER TABLE `tipo_telefone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tipo_telefone_entidade_idx` (`fk_entidade`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_entidade_user` (`fk_entidade`);

--
-- Indexes for table `user_visit_log`
--
ALTER TABLE `user_visit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `visitatec_produto`
--
ALTER TABLE `visitatec_produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_visitatec_visita_idx` (`fk_visita`),
  ADD KEY `fk_visitatec_produto_idx` (`fk_produto`);

--
-- Indexes for table `visita_tecnica`
--
ALTER TABLE `visita_tecnica`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_visita_user_idx` (`fk_user`),
  ADD KEY `fk_visita_cliente_idx` (`fk_cliente`),
  ADD KEY `fk_visita_produto_idx` (`fk_produto`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aditivo`
--
ALTER TABLE `aditivo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `anexos_documentos`
--
ALTER TABLE `anexos_documentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `atendimento`
--
ALTER TABLE `atendimento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `atendimento_anexos`
--
ALTER TABLE `atendimento_anexos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_trail_entry`
--
ALTER TABLE `audit_trail_entry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=840;

--
-- AUTO_INCREMENT for table `banco`
--
ALTER TABLE `banco`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bloqueio`
--
ALTER TABLE `bloqueio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `bloqueio_produto`
--
ALTER TABLE `bloqueio_produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `conta`
--
ALTER TABLE `conta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contato_cliente`
--
ALTER TABLE `contato_cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `conta_orcamento`
--
ALTER TABLE `conta_orcamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contrato`
--
ALTER TABLE `contrato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contrato_produtos`
--
ALTER TABLE `contrato_produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `controle_versao`
--
ALTER TABLE `controle_versao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `entidade`
--
ALTER TABLE `entidade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `financeiro`
--
ALTER TABLE `financeiro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gestao`
--
ALTER TABLE `gestao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `itens_orcamento`
--
ALTER TABLE `itens_orcamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `modalidade`
--
ALTER TABLE `modalidade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nota_fiscal`
--
ALTER TABLE `nota_fiscal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orcamento_proposta`
--
ALTER TABLE `orcamento_proposta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `produto`
--
ALTER TABLE `produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` bigint(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `telefone`
--
ALTER TABLE `telefone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tipo_anexo`
--
ALTER TABLE `tipo_anexo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tipo_atendimento`
--
ALTER TABLE `tipo_atendimento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipo_cliente`
--
ALTER TABLE `tipo_cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipo_ocorrencia`
--
ALTER TABLE `tipo_ocorrencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipo_orgao`
--
ALTER TABLE `tipo_orgao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tipo_telefone`
--
ALTER TABLE `tipo_telefone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_visit_log`
--
ALTER TABLE `user_visit_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- AUTO_INCREMENT for table `visitatec_produto`
--
ALTER TABLE `visitatec_produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `visita_tecnica`
--
ALTER TABLE `visita_tecnica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `aditivo`
--
ALTER TABLE `aditivo`
  ADD CONSTRAINT `fk_aditivo_contrato` FOREIGN KEY (`fk_contrato`) REFERENCES `contrato` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `anexos_documentos`
--
ALTER TABLE `anexos_documentos`
  ADD CONSTRAINT `fk_anexos_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_anexos_tipo_documento` FOREIGN KEY (`fk_tipo_documento`) REFERENCES `tipo_anexo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `atendimento`
--
ALTER TABLE `atendimento`
  ADD CONSTRAINT `fk_atendimento_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_atendimento_contato_cliente` FOREIGN KEY (`fk_contato_cliente`) REFERENCES `contato_cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_atendimento_contrato` FOREIGN KEY (`fk_contrato`) REFERENCES `contrato` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_atendimento_produto` FOREIGN KEY (`fk_produto`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_atendimento_tipo_atendimento` FOREIGN KEY (`fk_tipo_atendimento`) REFERENCES `tipo_atendimento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_atendimento_tipo_ocorrencia` FOREIGN KEY (`fk_tipo_ocorrencia`) REFERENCES `tipo_ocorrencia` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_atendimento_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_atendimento_usuario_solucao` FOREIGN KEY (`fk_usuario_solucao`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `atendimento_anexos`
--
ALTER TABLE `atendimento_anexos`
  ADD CONSTRAINT `fk_atendimento_anexo_atendimento` FOREIGN KEY (`fk_atendimento`) REFERENCES `atendimento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `audit_trail_entry`
--
ALTER TABLE `audit_trail_entry`
  ADD CONSTRAINT `FK_audit_trail_entry_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_assignment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `auth_item`
--
ALTER TABLE `auth_item`
  ADD CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_auth_item_group_code` FOREIGN KEY (`group_code`) REFERENCES `auth_item_group` (`code`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `banco`
--
ALTER TABLE `banco`
  ADD CONSTRAINT `fk_banco_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `bloqueio`
--
ALTER TABLE `bloqueio`
  ADD CONSTRAINT `fk_bloqueio_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_bloqueio_contrato` FOREIGN KEY (`fk_contrato`) REFERENCES `contrato` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_bloqueio_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `bloqueio_produto`
--
ALTER TABLE `bloqueio_produto`
  ADD CONSTRAINT `fk_bloqueio_produto_bloqueio` FOREIGN KEY (`fk_bloqueio`) REFERENCES `bloqueio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_bloqueio_produto_produto` FOREIGN KEY (`fk_produto`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `cargo`
--
ALTER TABLE `cargo`
  ADD CONSTRAINT `fk_cargo_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cliente_representante` FOREIGN KEY (`fk_representante`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cliente_tipo` FOREIGN KEY (`fk_tipo_cliente`) REFERENCES `tipo_cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cliente_tipo_orgao` FOREIGN KEY (`fk_tipo_orgao`) REFERENCES `tipo_orgao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `conta`
--
ALTER TABLE `conta`
  ADD CONSTRAINT `fk_conta_banco` FOREIGN KEY (`fk_banco`) REFERENCES `banco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `contato_cliente`
--
ALTER TABLE `contato_cliente`
  ADD CONSTRAINT `fk_contato_cargo` FOREIGN KEY (`fk_cargo`) REFERENCES `cargo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_contato_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_contato_cliente_departamento` FOREIGN KEY (`fk_departamento`) REFERENCES `departamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `conta_orcamento`
--
ALTER TABLE `conta_orcamento`
  ADD CONSTRAINT `fk_conta_orcamento_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `contrato`
--
ALTER TABLE `contrato`
  ADD CONSTRAINT `fk_contrato_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_contrato_modalidade` FOREIGN KEY (`fk_modalidade`) REFERENCES `modalidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `contrato_produtos`
--
ALTER TABLE `contrato_produtos`
  ADD CONSTRAINT `fk_contrato` FOREIGN KEY (`fk_contrato`) REFERENCES `contrato` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_produto` FOREIGN KEY (`fk_produto`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `controle_versao`
--
ALTER TABLE `controle_versao`
  ADD CONSTRAINT `fk_versao_produto` FOREIGN KEY (`fk_produto`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_versao_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `departamento`
--
ALTER TABLE `departamento`
  ADD CONSTRAINT `fk_departamento_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `financeiro`
--
ALTER TABLE `financeiro`
  ADD CONSTRAINT `fk_financeiro_banco` FOREIGN KEY (`fk_banco_portador`) REFERENCES `banco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_financeiro_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_financeiro_conta` FOREIGN KEY (`fk_conta`) REFERENCES `conta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_financeiro_conta_orcamento` FOREIGN KEY (`fk_conta_orcamento`) REFERENCES `conta_orcamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_financeiro_nota` FOREIGN KEY (`fk_nota_fiscal`) REFERENCES `nota_fiscal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_financeiro_tipo_documento` FOREIGN KEY (`fk_tipo_documento`) REFERENCES `tipo_documento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `gestao`
--
ALTER TABLE `gestao`
  ADD CONSTRAINT `fk_gestao_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `itens_orcamento`
--
ALTER TABLE `itens_orcamento`
  ADD CONSTRAINT `fk_itens_orcamento` FOREIGN KEY (`fk_orcamento`) REFERENCES `orcamento_proposta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_produto` FOREIGN KEY (`fk_produto`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `nota_fiscal`
--
ALTER TABLE `nota_fiscal`
  ADD CONSTRAINT `fk_nota_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_nota_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `orcamento_proposta`
--
ALTER TABLE `orcamento_proposta`
  ADD CONSTRAINT `fk_orcamento_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orcamento_contato_cliente` FOREIGN KEY (`fk_contato_cliente`) REFERENCES `contato_cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `telefone`
--
ALTER TABLE `telefone`
  ADD CONSTRAINT `fk_telefone_contato_cliente` FOREIGN KEY (`fk_contato_cliente`) REFERENCES `contato_cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tipo_telefone` FOREIGN KEY (`fk_tipo_telefone`) REFERENCES `tipo_telefone` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tipo_anexo`
--
ALTER TABLE `tipo_anexo`
  ADD CONSTRAINT `fk_tipo_anexo_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tipo_atendimento`
--
ALTER TABLE `tipo_atendimento`
  ADD CONSTRAINT `fk_tipo_atendimento_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tipo_cliente`
--
ALTER TABLE `tipo_cliente`
  ADD CONSTRAINT `fk_tipo_cliente_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tipo_ocorrencia`
--
ALTER TABLE `tipo_ocorrencia`
  ADD CONSTRAINT `fk_tipo_ocorrencia_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tipo_orgao`
--
ALTER TABLE `tipo_orgao`
  ADD CONSTRAINT `fk_tipo_orgao_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tipo_telefone`
--
ALTER TABLE `tipo_telefone`
  ADD CONSTRAINT `fk_tipo_telefone_entidade` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_entidade_user` FOREIGN KEY (`fk_entidade`) REFERENCES `entidade` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `user_visit_log`
--
ALTER TABLE `user_visit_log`
  ADD CONSTRAINT `user_visit_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `visitatec_produto`
--
ALTER TABLE `visitatec_produto`
  ADD CONSTRAINT `fk_visitatec_produto` FOREIGN KEY (`fk_produto`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_visitatec_visita` FOREIGN KEY (`fk_visita`) REFERENCES `visita_tecnica` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `visita_tecnica`
--
ALTER TABLE `visita_tecnica`
  ADD CONSTRAINT `fk_visita_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_visita_produto` FOREIGN KEY (`fk_produto`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_visita_user` FOREIGN KEY (`fk_user`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

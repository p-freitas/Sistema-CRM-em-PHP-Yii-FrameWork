-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 31-Ago-2018 às 21:29
-- Versão do servidor: 10.1.34-MariaDB
-- PHP Version: 7.1.20

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
('/cargo/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/update', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cargo/view', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/*', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/cliente/index', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
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
('/tipo-cliente/create', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-cliente/delete', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
('/tipo-cliente/error', 3, NULL, NULL, NULL, 1535457346, 1535457346, NULL),
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
  `fk_produto` int(11) DEFAULT NULL,
  `fk_usuario` int(11) NOT NULL,
  `data_bloqueio` date NOT NULL,
  `data_limite` date DEFAULT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(2, 1, 'Diretor');

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
  `email` varchar(100) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `data_situacao` date DEFAULT NULL,
  `data_cadastro` date NOT NULL,
  `situacao` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `email` varchar(100) NOT NULL,
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

-- --------------------------------------------------------

--
-- Estrutura da tabela `contrato_produtos`
--

CREATE TABLE `contrato_produtos` (
  `id` int(11) NOT NULL,
  `fk_contrato` int(11) NOT NULL,
  `fk_produto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Estrutura da tabela `log`
--

CREATE TABLE `log` (
  `id` int(11) NOT NULL,
  `fk_usuario` int(11) NOT NULL,
  `entidade` varchar(45) NOT NULL,
  `operacao` varchar(45) NOT NULL,
  `data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
('m180720_143745_excluiLog', 1535733778),
('m180720_143821_create_new_log', 1535733778);

-- --------------------------------------------------------

--
-- Estrutura da tabela `modalidade`
--

CREATE TABLE `modalidade` (
  `id` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(1, 1, 'pdf'),
(2, 1, 'word');

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
(2, 1, 'Externo', 3);

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
(2, 1, 'Orgão Diretoria', 'OD');

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
(3, 1, 'Celular');

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
(40, '5b895ab2d1497', '::1', 'pt', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134', 2, 1535728306, 'Edge', 'Windows');

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
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `fk_bloqueio_produto_idx` (`fk_produto`),
  ADD KEY `fk_bloqueio_usuario_idx` (`fk_usuario`);

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
-- Indexes for table `itens_orcamento`
--
ALTER TABLE `itens_orcamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_itens_orcamento_idx` (`fk_orcamento`),
  ADD KEY `fk_itens_produto_idx` (`fk_produto`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_log_user1_idx` (`fk_usuario`);

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
  ADD KEY `fk_telefone_contato_cliente_idx` (`fk_contato_cliente`);

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aditivo`
--
ALTER TABLE `aditivo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `anexos_documentos`
--
ALTER TABLE `anexos_documentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `banco`
--
ALTER TABLE `banco`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bloqueio`
--
ALTER TABLE `bloqueio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `conta`
--
ALTER TABLE `conta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contato_cliente`
--
ALTER TABLE `contato_cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `conta_orcamento`
--
ALTER TABLE `conta_orcamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contrato`
--
ALTER TABLE `contrato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contrato_produtos`
--
ALTER TABLE `contrato_produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `itens_orcamento`
--
ALTER TABLE `itens_orcamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `modalidade`
--
ALTER TABLE `modalidade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` bigint(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `telefone`
--
ALTER TABLE `telefone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `tipo_anexo`
--
ALTER TABLE `tipo_anexo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tipo_atendimento`
--
ALTER TABLE `tipo_atendimento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipo_cliente`
--
ALTER TABLE `tipo_cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tipo_telefone`
--
ALTER TABLE `tipo_telefone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_visit_log`
--
ALTER TABLE `user_visit_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

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
  ADD CONSTRAINT `fk_bloqueio_produto` FOREIGN KEY (`fk_produto`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_bloqueio_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Limitadores para a tabela `itens_orcamento`
--
ALTER TABLE `itens_orcamento`
  ADD CONSTRAINT `fk_itens_orcamento` FOREIGN KEY (`fk_orcamento`) REFERENCES `orcamento_proposta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_produto` FOREIGN KEY (`fk_produto`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `fk_log_user1` FOREIGN KEY (`fk_usuario`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

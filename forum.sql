-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 25-Jan-2021 às 15:23
-- Versão do servidor: 5.7.26
-- versão do PHP: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `forum`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE IF NOT EXISTS `categoria` (
  `idCategoria` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `descricao`) VALUES
(1, 'Jogo'),
(2, 'Filme'),
(3, 'Análise'),
(4, 'Série'),
(5, 'Programação'),
(6, 'Humor');

-- --------------------------------------------------------

--
-- Estrutura da tabela `comentario`
--

DROP TABLE IF EXISTS `comentario`;
CREATE TABLE IF NOT EXISTS `comentario` (
  `idComentario` int(11) NOT NULL AUTO_INCREMENT,
  `idTopico` int(11) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL,
  `mensagem` text,
  `data` datetime NOT NULL,
  PRIMARY KEY (`idComentario`),
  KEY `fk_userComment` (`idUsuario`),
  KEY `fk_comTopico` (`idTopico`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `comentario`
--

INSERT INTO `comentario` (`idComentario`, `idTopico`, `idUsuario`, `mensagem`, `data`) VALUES
(1, 1, 5, 'Acho que ainda está bem cedo para qualquer julgamento, bom não elevar muito a expectativa e acabar se frustrando.', '2021-01-22 17:59:47'),
(2, 1, 7, 'Confesso que tb to bem hypado, o jogo ta muito bonito e traz uma sensação bem diferente dos outros X.\r\nSe acabar n sendo bom é só esperar pelo remake do antigo msm e é isso :v', '2021-01-22 18:05:37'),
(3, 1, 8, 'com esse tema que eles estão mostrando no trailer, já nem parece mais o mesmo jogo. Bom, vou esperar mais um pouco antes de falar, mas diria que minha expectativa não tá muito alta', '2021-01-22 18:08:56'),
(4, 2, 5, 'Diria que não. Se você esperar mais um pouco ela pode cair de preço, fora que nesse preço existem opções melhores por ai, só pesquisar.\r\n\r\nNessa faixa de preço recomendo dar uma avaliada nessas placas aqui:\r\nPlaca Y\r\nPlaca Z', '2021-01-22 18:15:38'),
(5, 2, 6, 'vi aqui e acabei comprando o Y. Tinha umas análises legais dele no youtube. vlw msm mano', '2021-01-22 18:17:03'),
(6, 2, 5, 'Tranquilo, fico feliz em ter ajudado!', '2021-01-22 18:17:33'),
(7, 3, 6, 'cara varia mt do seu gosto mas te recomendaria as que eu mais gosto dentre as populares, tipo a X, a Y e a Z', '2021-01-22 18:22:42'),
(8, 3, 7, 'ss, a Y q o camarada citou ai é muito boa, assiste V tb q na minha opinião é a melhor série da história', '2021-01-22 18:23:47'),
(9, 3, 8, 'nice, vou dar uma olhada dps vlw gnt', '2021-01-22 18:25:08'),
(10, 4, 6, 'They had us in the first half ngl', '2021-01-22 18:28:43'),
(11, 4, 8, 'blz', '2021-01-22 18:29:07'),
(12, 5, 5, 'Pensa mais ai e faz algo decente', '2021-01-22 18:32:24'),
(13, 5, 7, 'qlqr coisa', '2021-01-22 18:34:30'),
(14, 5, 7, 'qlqr coisa', '2021-01-22 18:34:35'),
(15, 5, 7, 'qlqr coisa', '2021-01-22 18:34:57'),
(16, 5, 2, '@coconut, evite o flood por favor.', '2021-01-22 18:35:40'),
(17, 6, 5, 'mds, o que que esse site está se tornando. Se quer xp usa direito e traga discussões interessantes, simples. Não tem porque upar se for ficar fazendo esse tipo de post', '2021-01-22 18:39:11'),
(18, 6, 6, 'kkkk ngc ta triste hein', '2021-01-22 18:39:54'),
(19, 6, 7, '@strawberry calma cara, é só brincadeira >.>', '2021-01-22 18:40:45'),
(20, 7, 5, 'tá usando o eclipse?', '2021-01-22 18:44:55'),
(21, 7, 8, 'ss, esqueci de informar esse detalhe', '2021-01-22 18:45:32'),
(22, 7, 5, 'Tenta ir na aba window > preferences > general > workspace, ai procura \"text file encoding\", aciona a opção other e escreve UTF-8', '2021-01-22 18:47:24'),
(23, 7, 8, 'ae foi, vlw era isso msm', '2021-01-22 18:47:48'),
(24, 8, 8, 'apesar do Y ser uma promessa em tanto, o X já se mostrou bom no conteúdo atual então diria que é a opção mais segura, mas tudo depende do seu divertimento e tals. Eu sempre priorizo a diversão acima do meta, mas ai depende do que vc gosta quando ta jogando', '2021-01-22 18:53:45'),
(25, 8, 7, 'Ah n importa o q os outros falem vou de X, o hype é mais importante que os status fora que ele com certeza vai ser bem forte', '2021-01-22 18:54:56'),
(26, 8, 8, 'é, no fim vai de gosto mas se pra vc tanto faz, então a opção mais segura é melhor', '2021-01-22 18:55:59'),
(27, 8, 6, 'no fim continuo na dvd mas acho q é isso msm, tenho q tomar logo essa decisão, vlw ae pela tentativa de qq forma', '2021-01-22 18:57:30');

-- --------------------------------------------------------

--
-- Estrutura da tabela `conquista`
--

DROP TABLE IF EXISTS `conquista`;
CREATE TABLE IF NOT EXISTS `conquista` (
  `idConquista` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  PRIMARY KEY (`idConquista`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `conquista`
--

INSERT INTO `conquista` (`idConquista`, `nome`, `descricao`) VALUES
(1, 'Admin', 'Ser um Administrador'),
(2, 'Mod', 'Ser um Moderador'),
(3, 'Explorador', 'Alcançar level 3'),
(4, 'Veterano', 'Alcançar level 5'),
(5, 'Expert', 'Alcançar level 10'),
(6, 'Apreciador', 'Gostar de 100 tópicos diferentes'),
(7, 'Informante', 'Criar 20 tópicos');

-- --------------------------------------------------------

--
-- Estrutura da tabela `conquistado`
--

DROP TABLE IF EXISTS `conquistado`;
CREATE TABLE IF NOT EXISTS `conquistado` (
  `idConquistado` int(11) NOT NULL AUTO_INCREMENT,
  `idConquista` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `aquisicao` date DEFAULT NULL,
  PRIMARY KEY (`idConquistado`),
  KEY `fk_usuarioConquista` (`idUsuario`),
  KEY `fk_conquistaObtida` (`idConquista`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `conquistado`
--

INSERT INTO `conquistado` (`idConquistado`, `idConquista`, `idUsuario`, `aquisicao`) VALUES
(1, 1, 1, '2021-01-22'),
(2, 3, 1, '2021-01-22'),
(3, 3, 2, '2021-01-22'),
(4, 4, 2, '2021-01-22'),
(5, 4, 1, '2021-01-22'),
(6, 5, 1, '2021-01-22');

-- --------------------------------------------------------

--
-- Estrutura da tabela `denuncia`
--

DROP TABLE IF EXISTS `denuncia`;
CREATE TABLE IF NOT EXISTS `denuncia` (
  `idDenuncia` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idDenunciado` int(11) NOT NULL,
  `tipo` int(11) DEFAULT NULL,
  `descricao` text,
  PRIMARY KEY (`idDenuncia`),
  KEY `fk_userDenuncia` (`idUsuario`),
  KEY `fk_userDenunciado` (`idDenunciado`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `denuncia`
--

INSERT INTO `denuncia` (`idDenuncia`, `idUsuario`, `idDenunciado`, `tipo`, `descricao`) VALUES
(1, 5, 7, 0, 'Esse usuário está spammando para farmar xp');

-- --------------------------------------------------------

--
-- Estrutura da tabela `level`
--

DROP TABLE IF EXISTS `level`;
CREATE TABLE IF NOT EXISTS `level` (
  `idLevel` int(11) NOT NULL,
  `exp` int(11) NOT NULL,
  PRIMARY KEY (`idLevel`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `level`
--

INSERT INTO `level` (`idLevel`, `exp`) VALUES
(1, 0),
(2, 40),
(3, 90),
(4, 170),
(5, 342),
(6, 685),
(7, 1370),
(8, 2740),
(9, 5475),
(10, 10950);

-- --------------------------------------------------------

--
-- Estrutura da tabela `likes`
--

DROP TABLE IF EXISTS `likes`;
CREATE TABLE IF NOT EXISTS `likes` (
  `idLike` int(11) NOT NULL AUTO_INCREMENT,
  `idTopico` int(11) DEFAULT NULL,
  `idComentario` int(11) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL,
  `tipo` int(11) DEFAULT NULL,
  `data` date NOT NULL,
  PRIMARY KEY (`idLike`),
  KEY `fk_likeTopico` (`idTopico`),
  KEY `fk_likeComentario` (`idComentario`),
  KEY `fk_userLike` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `likes`
--

INSERT INTO `likes` (`idLike`, `idTopico`, `idComentario`, `idUsuario`, `tipo`, `data`) VALUES
(1, 1, 0, 7, 1, '2021-01-22'),
(2, 1, 0, 8, 1, '2021-01-22'),
(3, 0, 1, 8, 2, '2021-01-22'),
(5, 0, 2, 6, 2, '2021-01-22'),
(6, 0, 4, 6, 2, '2021-01-22'),
(7, 0, 5, 5, 2, '2021-01-22'),
(8, 0, 6, 6, 2, '2021-01-22'),
(9, 3, 0, 6, 1, '2021-01-22'),
(10, 3, 0, 7, 1, '2021-01-22'),
(11, 0, 8, 8, 2, '2021-01-22'),
(12, 0, 7, 8, 2, '2021-01-22'),
(13, 3, 0, 8, 1, '2021-01-22'),
(15, 0, 10, 8, 2, '2021-01-22'),
(16, 5, 0, 6, 1, '2021-01-22'),
(17, 5, 0, 7, 1, '2021-01-22'),
(18, 0, 17, 6, 2, '2021-01-22'),
(19, 7, 0, 8, 1, '2021-01-22'),
(20, 7, 0, 5, 1, '2021-01-22'),
(21, 0, 22, 8, 2, '2021-01-22'),
(22, 0, 20, 8, 2, '2021-01-22'),
(23, 7, 0, 6, 1, '2021-01-22'),
(24, 0, 20, 6, 2, '2021-01-22'),
(25, 0, 22, 6, 2, '2021-01-22'),
(26, 7, 0, 7, 1, '2021-01-22'),
(27, 0, 20, 7, 2, '2021-01-22'),
(28, 0, 22, 7, 2, '2021-01-22'),
(29, 5, 0, 8, 1, '2021-01-22'),
(30, 8, 0, 8, 1, '2021-01-22'),
(31, 8, 0, 7, 1, '2021-01-22');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logban`
--

DROP TABLE IF EXISTS `logban`;
CREATE TABLE IF NOT EXISTS `logban` (
  `idLogBan` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `descricao` text,
  `dataBan` datetime DEFAULT NULL,
  PRIMARY KEY (`idLogBan`),
  KEY `fk_userBanido` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `logban`
--

INSERT INTO `logban` (`idLogBan`, `idUsuario`, `descricao`, `dataBan`) VALUES
(1, 1, 'Desbanido por admin', '2021-01-22 19:26:38');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logexp`
--

DROP TABLE IF EXISTS `logexp`;
CREATE TABLE IF NOT EXISTS `logexp` (
  `idLogEXP` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `data` date DEFAULT NULL,
  PRIMARY KEY (`idLogEXP`),
  KEY `fk_userEXP` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `logexp`
--

INSERT INTO `logexp` (`idLogEXP`, `idUsuario`, `qtd`, `data`) VALUES
(1, 4, 3, '2021-01-22'),
(2, 5, 3, '2021-01-22'),
(3, 6, 3, '2021-01-22'),
(4, 6, 10, '2021-01-22'),
(5, 7, 3, '2021-01-22'),
(6, 7, 5, '2021-01-22'),
(7, 8, 3, '2021-01-22'),
(8, 8, 5, '2021-01-22'),
(9, 6, 10, '2021-01-22'),
(10, 8, 10, '2021-01-22'),
(11, 6, 5, '2021-01-22'),
(12, 7, 5, '2021-01-22'),
(13, 8, 5, '2021-01-22'),
(14, 7, 10, '2021-01-22'),
(15, 6, 5, '2021-01-22'),
(16, 6, 5, '2021-01-22'),
(17, 7, 5, '2021-01-22'),
(18, 2, 3, '2021-01-22'),
(19, 7, 10, '2021-01-22'),
(20, 8, 10, '2021-01-22'),
(21, 8, 5, '2021-01-22'),
(22, 5, 5, '2021-01-22'),
(23, 6, 5, '2021-01-22'),
(24, 7, 5, '2021-01-22'),
(25, 8, 5, '2021-01-22'),
(26, 8, 5, '2021-01-22'),
(27, 7, 5, '2021-01-22'),
(28, 3, 3, '2021-01-22'),
(29, 4, 3, '2021-01-24');

-- --------------------------------------------------------

--
-- Estrutura da tabela `nivelusuarios`
--

DROP TABLE IF EXISTS `nivelusuarios`;
CREATE TABLE IF NOT EXISTS `nivelusuarios` (
  `idNivelUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nivel` varchar(50) NOT NULL,
  PRIMARY KEY (`idNivelUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `nivelusuarios`
--

INSERT INTO `nivelusuarios` (`idNivelUsuario`, `nivel`) VALUES
(1, 'Usuário'),
(2, 'Moderador'),
(3, 'Administrador');

-- --------------------------------------------------------

--
-- Estrutura da tabela `seguir`
--

DROP TABLE IF EXISTS `seguir`;
CREATE TABLE IF NOT EXISTS `seguir` (
  `idSeguir` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idSeguido` int(11) NOT NULL,
  PRIMARY KEY (`idSeguir`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `seguir`
--

INSERT INTO `seguir` (`idSeguir`, `idUsuario`, `idSeguido`) VALUES
(1, 6, 8),
(2, 6, 7),
(3, 7, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `topico`
--

DROP TABLE IF EXISTS `topico`;
CREATE TABLE IF NOT EXISTS `topico` (
  `idTopico` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `mensagem` text NOT NULL,
  `data` date NOT NULL,
  PRIMARY KEY (`idTopico`),
  KEY `fk_userPost` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `topico`
--

INSERT INTO `topico` (`idTopico`, `idUsuario`, `idCategoria`, `titulo`, `mensagem`, `data`) VALUES
(1, 6, 1, 'Sobre o Jogo X', 'Vi o trailer e alguns vídeos da demo do novo X e sinceramente estou muito animado para o seu lançamento, o que vocês estão achando?', '2021-01-22'),
(2, 6, 3, 'Vale a pena comprar essa placa X por 5k?', 'to montando um pc novo e vi umas promoções aparentemente bem altas dessa placa X. Como eu n entendo muito, qria saber se vale 5 mil', '2021-01-22'),
(3, 8, 4, 'Preciso de recomendação de séries', 'ultimamente não tenho encontrado séries interessantes para assistir, será que alguém poderia me recomendar algumas?', '2021-01-22'),
(4, 7, 6, 'olha o que aconteceu qndo eu tava indo pro trabalho', 'imagine que tem uma história engraçada aqui :)', '2021-01-22'),
(5, 6, 5, 'Projeto de Escola', 'to fazendo um projeto pra entregar e preciso de comentários, escrevam qlqr coisa ai q já da uma ajuda', '2021-01-22'),
(6, 7, 6, 'Escrevendo tópico pra ganhar xp diária', 'foi mal por criar esses tópicos sem assunto, mas to fazendo pra ganhar a xp diária, preciso criar dois tópicos', '2021-01-22'),
(7, 8, 5, 'meus arquivos jsp não estão identificando as pontuações', 'Assim como descrito no título, estou tendo esse problema, já coloquei charset=utf8 e o pageEncoding tb, mas n ta resolvendo', '2021-01-22'),
(8, 6, 1, 'NomeDoJogo - Qual desses personagens eu devo investir? X vs Y', 'pra qm conhece bem os personagens, tenho visto umas builds pra eles, mas sinceramente n consigo me decidir em qual pegar já q ambos parecem ser mt bons, então to pedindo ajuda pra escolher.', '2021-01-22');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `apelido` varchar(50) DEFAULT NULL,
  `password` varchar(90) NOT NULL,
  `email` varchar(50) NOT NULL,
  `idNivelUsuario` int(11) NOT NULL,
  `idConquista` int(11) DEFAULT NULL,
  `bio` text,
  `gender` varchar(20) DEFAULT NULL,
  `dataNasc` date DEFAULT NULL,
  `dataInsc` date DEFAULT NULL,
  `ultimaSessao` date DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `exp` int(11) NOT NULL,
  `ativo` int(11) NOT NULL,
  `banido` int(11) NOT NULL,
  `privado` int(11) NOT NULL,
  `cod` varchar(70) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `fk_nivelUser` (`idNivelUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `apelido`, `password`, `email`, `idNivelUsuario`, `idConquista`, `bio`, `gender`, `dataNasc`, `dataInsc`, `ultimaSessao`, `foto`, `exp`, `ativo`, `banido`, `privado`, `cod`) VALUES
(1, 'admin', 'asd', 'admin@gmail.com', 3, 1, 'Olá, sou o Administrador do site.', 'masculino', '2000-01-01', '2021-01-17', '2021-01-22', 'foto0', 11000, 1, 0, 0, '1Z0cmfhoAYq$@ixo7gHzIGWkMA9GZfNh'),
(2, 'mod', 'asd', 'teste@gmail.com', 1, 2, 'Olá, sou o moderador!', 'masculino', '2000-01-02', '2021-01-18', '2021-01-22', 'foto0', 574, 1, 0, 0, 'B@US2nNkq3@hHP4441EKXbL3bNtxbGGd'),
(3, 'normal', 'asd', 'teste2@gmail.com', 1, 0, 'Olá, sou um usuário normal!', 'masculino', '2000-01-03', '2021-01-21', '2021-01-22', 'foto1', 3, 1, 0, 0, 'B@US2nNkq3@hHP4441EKXbL3bNtxbGGd'),
(4, 'seiki', 'asd', 'seikinagaishi@gmail.com', 1, 0, 'Olá', 'Não informado', '2001-10-14', '2021-01-22', '2021-01-24', 'foto0', 6, 1, 0, 0, '0imHmTSYMmve@dWFywWYQJF6EXLVbwT4'),
(5, 'strawberry', 'asd', 'strawberry@gmail.com', 1, 0, 'Se me seguir não sigo de volta!', 'masculino', '2021-01-22', '2021-01-22', '2021-01-22', 'foto1', 8, 1, 0, 1, ''),
(6, 'apple', 'asd', 'apple@gmail.com', 1, 0, 'Apple aqui para tirar dúvidas que passam na minha cabeça', 'Não informado', '2021-01-22', '2021-01-22', '2021-01-22', 'foto4', 43, 1, 0, 0, ''),
(7, 'coconut', 'asd', 'coconut@gmail.com', 1, 0, 'Olá', 'Não informado', '2021-01-22', '2021-01-22', '2021-01-22', 'foto2', 48, 1, 0, 0, ''),
(8, 'pine', 'asd', 'pine@gmail.com', 1, 0, 'Gosto de fazer x, y e z coisas', 'Não informado', '2021-01-22', '2021-01-22', '2021-01-22', 'foto3', 48, 1, 0, 0, '');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

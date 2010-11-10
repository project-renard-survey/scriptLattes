scriptLattes V7
-----------------

SINOPSIS
	scriptLattes <nome_arquivo_de_configuracao>

REQUISITOS
	Para a compila��o precisam-se de alguns m�dulos Perl (a partir da vers�o 7 �
	requerido o m�dulo libjson-perl). 
	Para instalar esses m�dulos execute como root:

	# apt-get install libgd-graph-perl libgd-text-perl libgraphviz-perl libtimedate-perl libjson-perl

EXECU��O
	Teste o scriptLattes com os seguintes exemplos de compila��o na linha de comando:

	(i) Exemplo A:
	$ cd <nome_diretorio_scriptLattes>
	$ ./scriptLattes ./exemplo/vision-ime-usp-PARAMETROS-A.txt

	Nesse exemplo consideram-se todas as produ��es (todos os anos). O relat�rio, 
	em portugu�s, apresenta o mapa de pesquisa. Essa configura��o de par�metros
	� a mais completa. O resultado da compila��o estar� dispon�vel em:
	./exemplo/vision-ime-usp-RESULTS-A

	(ii) Exemplo B:
	$ cd <nome_diretorio_scriptLattes>
	$ ./scriptLattes ./exemplo/vision-ime-usp-PARAMETROS-B.txt

	Nesse exemplo consideram-se todas as produ��es cujos anos de publica��o
	est�o entre 1970 e HOJE. O relat�rio, em ingl�s, n�o apresenta o mapa de pesquisa.
	O resultado da compila��o estar� dispon�vel em:
	./exemplo/vision-ime-usp-RESULTS-B

	OBS: Veja o arquivo exemplo/vision-ime-usp-IDS.txt um exemplo
	de IDs Lattes usado como entrada para o scriptLattes.

DESENVOLVEDORES
	Jes�s P. Mena-Chalco <jmena@vision.ime.usp.br>
	Roberto M. Cesar-Jr <cesar@vision.ime.usp.br>

URL DO PROJETO
	http://scriptlattes.sourceforge.net/

=========================================================================================
LOG

Mon Mar 15 08:02:22 BRT 2010
-- Melhoramento da fun��o de compara��o. Em m�dia o algoritmo de compara��o da
   vers�o 7.02 � 13X mais r�pido que o anterior.
-- Cria��o do grafo de colabora��es com indicadores de produ��o usando um mapa
   de cores (hotcolors).
-- Foram consideradas, mediante novos par�metros, os seguintes relat�rios adicionais:
   - Participa��o em bancas examinadoras.
   - Participa��o em comiss�es julgadoras.
   - Eventos.

Ter Out 20 13:32:13 BRST 2009
-- Gera��o de relat�rios dispon�veis para os idiomas: ingl�s, portugu�s e espanhol.
-- Cria��o de uma p�gina de 'detalhe de colabora��es'. Clique nas arestas do Grafo de colabora��es
   para listar as publica��es realizadas entre os membros.
-- Melhoramento da fun��o de localiza��o geogr�fica (com suporte para endere�os do exterior).
   Utilize o arquivo 'scriptLattes.cep' para refinar a localiza��o no googleMaps.
-- Cria��o de listas de produ��es em formato JSON: 'database.json'. Tais listas poderiam
   ser utilizadas para exportar as produ��es ou popular bancos de dados.
-- Melhoramento na visualiza��o/apresenta��o/compila��o dos relat�rios.
   O scriptLattes n�o usa o script 'terminalTags.sh'.

S�b Abr 18 16:23:31 BRT 2009
-- Foram considerados nas Produ��es t�cnicas os "Processos ou t�cnicas"
-- Foram considerados nas Orienta��es as "Monografias de conclus�o de curso de aperfei�oamento/especializa��o"
-- O procedimento para identifica��o do ano nas produ��es foi corrigido.
-- "Itens sem ano" est�o sendo listados no final de cada relat�rio.

Ter Mar 24 07:59:43 BRT 2009
-- Mapa de pesquisa, considerando os alunos com doutorado conclu�do.
-- Foram corrigidos alguns pequenos erros de inicializa��o de vari�veis.

Qua Mar  4 12:45:40 BRT 2009
-- Uso de um arquivo de configura��o.
-- Delimita��o de produ��es por per�odos (global e local).
-- Mapa de pesquisa (usando o maps.google.com).
-- Produ��es t�cnicas e art�sticas foram consideradas nos relat�rios.
-- Cria��o de p�ginas para cada pesquisador.
-- Produ��o autom�tica de p�ginas JSP (opcional)
-- Divis�o autom�tica de produ��es em p�ginas (ex. 1000 produ��es por p�gina).
-- CSS para todas as p�ginas.
-- Refatora��o do script.

S�b Nov  8 16:11:46 BRST 2008
-- Vers�o interativa e postscript do grafo de colabora��es.
-- Lista de pesquisadores considerados na execu��o.
-- Cria��o de um indice geral.

Seg Mar 24 12:30:03 BRT 2008
-- Refatora��o.
-- Link para busca da publica��o no Google.
-- Compila��o de orienta��es (em andamento/conclu�das).

Sex Fev  8 18:24:33 BRST 2008
-- Criadas as fun��es de compila��o de todas as publica��es.
-- Gera��o autom�tica da p�gina index.html.
-- Gera��o autom�tica de um grafo de colabora��es.

Ter Mar 13 12:04:40 BRT 2007 : 
-- Barras estat�sticas das publica��es (uso do GD::Graph do perl).
-- Criada a fun��o de similaridade LCS (longest common sequence).
-- Modificada a fun��o de extra��o de datas das publica��es.

Seg Mar 20 17:50:21 BRT 2006 :
-- Atualiza��o das fun��es b�sicas.

Sex Mar 25 13:04:27 BRT 2005 : 
-- Criada a fun��o de similaridade b�sica.

=========================================================================================

#
#
#  Copyright 2005-2010: Jes�s P. Mena-Chalco e Roberto M. Cesar-Jr.
#
#
#  Este arquivo � parte do programa sriptLattes.
#  scriptLattes � um software livre; voc� pode redistribui-lo e/ou 
#  modifica-lo dentro dos termos da Licen�a P�blica Geral GNU como 
#  publicada pela Funda��o do Software Livre (FSF); na vers�o 2 da 
#  Licen�a, ou (na sua opni�o) qualquer vers�o.
#
#  Este programa � distribuido na esperan�a que possa ser util, 
#  mas SEM NENHUMA GARANTIA; sem uma garantia implicita de ADEQUA��O a qualquer
#  MERCADO ou APLICA��O EM PARTICULAR. Veja a
#  Licen�a P�blica Geral GNU para maiores detalhes.
#
#  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral GNU
#  junto com este programa, se n�o, escreva para a Funda��o do Software
#  Livre(FSF) Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#


##################################################################################
# scriptLattes                                                                   #
#                                                                                #
# Modulo usado HTML::Parser. Para extrair as produ��es                           #
# de todos os tipos em formato de tabelas HTML                                   #
#                                                                                #
# $self->{Publication_type}[X]: Contem o nomes do tipo de publica��es X.         #
# $self->{Publication}[Y]     : Contem as publica��es correspondentes ao tipo Y. #
#                                                                                #
# $self->{ProducaoTecnica_type}[X]:                                              #
# $self->{ProducaoTecnica}[Y] :                                                  #
#                                                                                #
# $self->{ProducaoArtistica_type}[X]:                                            #
# $self->{ProducaoArtistica}[Y]:                                                 #
#                                                                                #
# $self->{DemaisTrabalhos_type}[X]:                                              #
# $self->{DemaisTrabalhos}[Y]:                                                   #
#                                                                                #
# $self->{BancasExaminadoras_type}[X]:                                           #
# $self->{BancasExaminadoras}[Y]     :                                           #
#                                                                                #
# $self->{ComissoesJulgadoras_type}[X]:                                          #
# $self->{ComissoesJulgadoras}[Y]     :                                          #
#                                                                                #
# $self->{Eventos_type}[X]:                                                      #
# $self->{Eventos}[Y]     :                                                      #
#                                                                                #
# $self->{Orientacoes_status}[P]: Nomes dos estados de orientacao                #
# $self->{Orientacoes_type}[P]  : Nomes dos tipos de orientacao                  #
#                                                                                #
# $self->{OrientacoesAdamento}[P]:                                               #
# $self->{OrientacoesConcluidas}[P]:                                             #
#                                                                                #
#--------------------------------------------------------------------------------#
#                                                                                #
# $self->{FormacaoAcademica}[Y]:                                                 #
#                                                                                #
# $self->{AreasAtuacao}[Y]:                                                      #
#                                                                                #
# $self->{Projetos_type}[P]  : Nomes dos tipos de projeto                        #
# $self->{Projetos}[P]  : items ...                                              #
#                                                                                #
# $self->{Premios_type}[Y]:                                                      #
# $self->{Premios}[Y]:                                                           #
#                                                                                #
#--------------------------------------------------------------------------------#
#                                                                                #
# $self->{Name}                                                                  #
# $self->{Produtividade}                                                         #
# $self->{PhotoID}                                                               #
# $self->{Address}                                                               #
# $self->{Orientandos}[X]                                                        #
# $self->{Updated}                                                               #
#                                                                                #
##################################################################################

package scriptLattes;
use strict;
use vars qw(@ISA $infield $inrecord $intable $inlink $start_session $table_type $validated_row $validated_table $newID $start_address $validated_address $validated_name $internal_text $skip_field $separator $validated_produtividade);
@ISA = qw(HTML::Parser);
require HTML::Parser;

# Override do prodedimento start
sub start()
{
	my($self,$tag,$attr,$attrseq,$orig) = @_;

	# Vari�veis para busca
	if ( $tag eq 'html' ) 
	{ 
		$self->{Address} = "";
 		$self->{Name} = "";
 		$self->{Produtividade} = "";
		$self->{PhotoID} = "";
		$self->{Updated} = "";
		
     @{$self->{Publication_type}} = (
	   "Artigos completos publicados em peri�dicos",
	   "Livros publicados\/organizados ou edi��es",
	   "Cap�tulos de livros publicados",
       "Textos em jornais de not�cias\/revistas",
	   "Trabalhos completos publicados em anais de congressos",
	   "Resumos expandidos publicados em anais de congressos",
	   "Resumos publicados em anais de congressos",
       "Artigos aceitos para publica��o",
	   "Apresenta��es de trabalho",
	   "Demais tipos de produ��o bibliogr�fica",
       );
	 
	 @{$self->{Orientacoes_status}} = (
	   "Orienta��es em andamento",
	   "Supervis�es e orienta��es conclu�das",
	   );
	 
	 @{$self->{Orientacoes_type}} = (
	   "Supervis�o de p�s-doutorado",
	   "Tese de doutorado",
	   "Disserta��o de mestrado",
       "Monografia de conclus�o de curso de aperfei�oamento\/especializa��o",
	   "Trabalho de conclus�o de curso de gradua��o",
	   "Inicia��o cient�fica",
	   "Orienta��es de outra natureza",
	   );

	 @{$self->{ProducaoTecnica_type}} = (
	   "Softwares com registro de patente",
	   "Softwares sem registro de patente",
	   "Produtos tecnol�gicos",
       "Processos ou t�cnicas",
	   "Trabalhos t�cnicos",
	   "Demais tipos de produ��o t�cnica",
	   );

	 @{$self->{ProducaoArtistica_type}} = (
	   "Produ��o art�stica\/cultural",
	   );

	 @{$self->{BancasExaminadoras_type}} = (
	   "Teses de doutorado",
	   "Qualifica��es de doutorado",
	   "Disserta��es",
       "Trabalhos de conclus�o de curso de gradua��o",
	   );
	 
	@{$self->{ComissoesJulgadoras_type}} = (
	   "Professor titular",
	   "Concurso p�blico",
	   "Livre doc�ncia",
	   "Avalia��o de cursos",
       "Outras participa��es",
	   );
	
	@{$self->{Eventos_type}} = (
	   "Participa��o em eventos",
	   "Organiza��o de eventos",
	   );

	@{$self->{Projetos_type}} = ( # natureza do projeto
       "Projetos de Pesquisa",
       );
	
	@{$self->{Premios_type}} = (
       "Pr�mios e t�tulos",
       );
	
	@{$self->{DemaisTrabalhos_type}} = (
       "Demais trabalhos",
       );

		$internal_text = "";
 		$start_session = 0 ;
		$table_type = 0;
	
		$intable = 0; 
		$infield = 0; 
		$inrecord = 0;
 	}

	if ($tag eq 'table' && $start_session && ($orig =~m/class="IndicProdTabela"/i) ) {
		$self->{Table} = ''; 
		$intable++; 
		$validated_table = 1;
	}

	if ($tag eq 'tr' && $validated_table) { 
		$self->{Row} = ''; 
		$inrecord++ ;
		$validated_row = 0;
		
		if ($orig =~ m/class="IndicProdTabelaLinha"/i) {
			$skip_field = 0; # utilizamos a linha inteira
			$separator = ": ";
			$validated_row = 1;
		}

		if ($orig =~ m/class="AtuaProfTabelaLinha"/i) {
			$skip_field = 1; # utilizamos somente a segunda celula
			$separator = "";
			$validated_row = 1;
		}
	}

	if ($tag eq 'td' && $validated_row ) { 
		$self->{Field}  = ''; 
		$infield++;

		if ($orig =~ m/class="agrupadorsub"/i) {
			$validated_row = 0;
		}
	}

	if ($tag eq 'a' && $validated_row && $validated_table && $infield ) { 
		if ($orig=~m/lattes\.cnpq\.br/i) {
			$inlink++; 
			if ($start_session==12||$start_session==13) { # icone Lattes para os orientandos
		   		$self->{Link} = $orig."<img border=0 src=./logolattes.gif>"; 
			}
	
			if ($table_type==1 && $start_session==13) { # alunos com doutorado conclu�do
				$orig =~ m/(\d{16})/;
				$newID = $1;
			}
		}
	
		if ($orig=~m/dx\.doi\.org/i) {
			$inlink++; 
			if ($start_session==5) { # icone DOI para as publica��es
		   		$self->{Link} = $orig."<img border=0 src=./logodoi.gif></a>"; 
			}
		}

	}

	#---------------------------------------------	 melhorarrrrr
	if ( $tag eq 'p' && $orig=~m/class="titulo"/i) { 
		$self->{Name}  = '';
		$self->{Produtividade}  = '';
		$validated_name = 1; 
		$validated_produtividade = 0; 
	}

	if( $tag eq 'br' && $validated_name ) { 
		$validated_name = 0;
		$validated_produtividade = 1; 
	}

	if ( $tag eq 'img' && $orig=~m/servletrecuperafoto/i) { 
		$orig =~ m/id=(\w*)"/;
		$self->{PhotoID} = $1;
	}

	if ( $tag eq 'td' && $start_address ) { 
		$self->{Address}  = ''; 
		$validated_address = 1;
	}

	#------------------------------------------------	
	$internal_text = "";

	# Casos especiais de parada:
    #if ( $internal_text=~"Bancas" || $internal_text=~"Demais trabalhos" || $internal_text=~"Outras informa��es relevantes" || $internal_text=~"Atua��o profissional" || $internal_text=~"Conselhos, Comiss�es e Consultoria" || $internal_text=~m/ensino.*n�vel:/i)
#    if ( $internal_text=~"Bancas" || $internal_text=~"Demais trabalhos" || $internal_text=~"Outras informa��es relevantes" || $internal_text=~"Atua��o profissional" || $internal_text=~"Conselhos, Comiss�es e Consultoria" || $internal_text=~m/ensino.*n�vel:/i || $internal_text=~"Dados pessoais" || $internal_text="Atua��o profissional" || $internal_text="Projetos de Pesquisa" || $internal_text="Membro de corpo editorial"|| $internal_text="Revisor de peri�dico"|| $internal_text="Idiomas"|| $internal_text="Pr�mios e t�tulos"|| $internal_text="Produ��o em C,T & A")
#    { 
#    	$start_session   = 0; 
#		$validated_table = 0; 
#	}


	if ( $tag eq 'a' ) {
		if ($orig =~ m/name="Formacaoacademica\/Titulacao"/) { # fora da lista de ordenacao
			$start_session   = 1;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="ProjetoPesquisa"/) {
			$start_session   = 2;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Areasdeatuacao"/) {               # fora da lista de ordenacao
			$start_session   = 3;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Premiosetitulos"/) {
			$start_session   = 4;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Producaobibliografica"/) {
			$start_session   = 5;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Producaotecnica"/) {
			$start_session   = 6;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Producaoartistica\/cultural"/) {
			$start_session   = 7;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Demaistrabalhos"/) {
			$start_session   = 8;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Participacaoembancasdetrabalho"/) {
			$start_session   = 9;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Participacaoembancasdecomissoes"/) {
			$start_session   = 10;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Participacaoemeventos"/) {
			$start_session   = 11;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Orientacaoemandamento"/) {
			$start_session   = 12;
	  		$validated_table = 0;
		}
		if ($orig =~ m/name="Orientacoesconcluidas"/) {
			$start_session   = 13;
	  		$validated_table = 0;
		}


		# casos de parada
		if ($orig =~ m/name="DadosPessoais"/ ||
			$orig =~ m/name="Atuacaoprofissional"/ ||
			$orig =~ m/name="MembroCorpoEditorial"/ ||
			$orig =~ m/name="RevisorPeriodico"/ ||
			$orig =~ m/name="Idiomas"/ ||
			$orig =~ m/name="Producaocientifica"/ ||
			$orig =~ m/name="Bancas"/ ||
			$orig =~ m/name="Eventos"/ ||
			$orig =~ m/name="Orientacoes"/ ||
			$orig =~ m/name="Outrasinformacoesrelevantes"/ ) {

	    	$start_session   = 0; 
			$validated_table = 0; 
		}
	}

}


# Override do procedimento text
sub text()
{
	my ($self,$text) = @_;

	$text =~ s/&nbsp;/ /gi;
	$text =~ s/\n/ /gi;
	$text =~ s/\./\. /gi;
	$text =~ s/\s+/ /gi;
	$text =~ s/&ccedil;/�/gi;
	$text =~ s/&aacute;/�/gi;
	$text =~ s/&Aacute;/�/gi;
	$text =~ s/&eacute;/�/gi;
	$text =~ s/&iacute;/�/gi;
	$text =~ s/&oacute;/�/gi;
	$text =~ s/&uacute;/�/gi;
	$text =~ s/&atilde;/�/gi;
	$text =~ s/&otilde;/�/gi;
	$text =~ s/&ocirc;/�/gi;
	$text =~ s/&ecirc;/�/gi;
	$text =~ s/&Agrave;/�/gi;
	$text =~ s/&agrave;/�/gi;
	$text =~ s/&Egrave;/�/g;
	$text =~ s/&egrave;/�/g;
	  
	$internal_text .= $text; 

#	$internal_text =~ s/\n/ /gi;
#	$internal_text =~ s/\s+/ /gi;
	$internal_text =~ s/^\s+//gi;
	$internal_text =~ s/\s+$//gi;

	###############################################################################
	if ($start_session) {

		if ( ($start_session==2) && ($self->{Projetos_type}) ) {
			# my $MAX = @{$self->{Projetos_type}};
			my $MAX = 1;
	    	for (my $i=0; $i<$MAX; $i++) { 
				if (lc($internal_text) eq lc($self->{Projetos_type}[$i])) {
    				$table_type      = $i; 
			   	} 
 			}
		}	

		if ( ($start_session==4) && ($self->{Premios_type}) ) {
			# my $MAX = @{$self->{Projetos_type}};
			my $MAX = 1;
	    	for (my $i=0; $i<$MAX; $i++) { 
				if (lc($internal_text) eq lc($self->{Premios_type}[$i])) {
	    			$table_type      = $i; 
			   	} 
	 		}
		}	

		if ( ($start_session==5) && ($self->{Publication_type}) ) {
			# my $MAX = @{$self->{Publication_type}};
			my $MAX = 10;
    		for (my $i=0; $i<$MAX; $i++) { 
				if (lc($internal_text) eq lc($self->{Publication_type}[$i])) {
	    			$table_type      = $i; 
		   		} 
 			}
		}	

		if ( ($start_session==6) && ($self->{ProducaoTecnica_type}) ) {
			# my $MAX = @{$self->{ProducaoTecnica_type}};
			my $MAX = 6;
			for (my $i=0; $i<$MAX; $i++) { 
				if (lc($internal_text) eq lc($self->{ProducaoTecnica_type}[$i])) { 
    				$table_type      = $i; 
			   	} 
			}
		}
	
		if ( ($start_session==7) && ($self->{ProducaoArtistica_type}) ) {
			# my $MAX = @{$self->{ProducaoArtistica_type}};
			my $MAX = 1;
    		for (my $i=0; $i<$MAX; $i++) { 
				if (lc($internal_text) eq lc($self->{ProducaoArtistica_type}[$i])) { 
	    			$table_type = $i; 
			   	} 
			}
		}

		if ( ($start_session==8) && ($self->{DemaisTrabalhos_type}) ) {
			# my $MAX = @{$self->{Projetos_type}};
			my $MAX = 1;
    		for (my $i=0; $i<$MAX; $i++) { 
				if (lc($internal_text) eq lc($self->{DemaisTrabalhos_type}[$i])) {
    				$table_type = $i; 
			   	} 
 			}
		}	

		if ( ($start_session==9) && ($self->{BancasExaminadoras_type}) ) {
			my $MAX = 4;
			for (my $i=0; $i<$MAX; $i++) { 
				if (lc($internal_text) eq lc($self->{BancasExaminadoras_type}[$i])) { 
    				$table_type = $i;
			   	} 
			}
		}

		if ( ($start_session==10) && ($self->{ComissoesJulgadoras_type}) ) {
		my $MAX = 5;
			for (my $i=0; $i<$MAX; $i++) { 
				if (lc($internal_text) eq lc($self->{ComissoesJulgadoras_type}[$i])) {
	    			$table_type = $i;
			   	} 
			}
		}

		if ( ($start_session==11) && ($self->{Eventos_type}) ) {
			my $MAX = 2;
			for (my $i=0; $i<$MAX; $i++) {
				if (lc($internal_text) eq lc($self->{Eventos_type}[$i])) {
    				$table_type = $i;
			   	} 
			}
		}

		if ( ($start_session==12||$start_session==13) && ($self->{Orientacoes_type}) ) {
			# $MAX = @{$self->{Orientacoes_type}};
			my $MAX = 7;
    		for (my $i=0; $i<$MAX; $i++) {
				if (lc($internal_text) eq lc($self->{Orientacoes_type}[$i])) { 
    				$table_type  = $i; 
		   		} 
			}
		}
	
#		if ( ($start_session==13) && ($self->{Orientacoes_type}) ) {
#			# $MAX = @{$self->{Orientacoes_type}};
#			my $MAX = 7;
#	    	for (my $i=0; $i<$MAX; $i++) {
#				if (lc($internal_text) eq lc($self->{Orientacoes_type}[$i])) { 
#	    			$table_type  = $i; 
#	   			} 
#			}
#		}

	}

	#######################################################

	if ($internal_text=~"Endere�o profissional") {
		$start_address = 1;
		$validated_address = 0;
	}

	if ($start_address && $validated_address) {
  		$self->{Address} .= " ".$text; 
	}   
	
	if ($validated_name) {
  		$self->{Name} .= " ".$text; 
	}   

	if ($validated_produtividade) {
  		$self->{Produtividade} .= " ".$text; 
	}   
	
 	$internal_text=~m/�ltima atualiza��o do curr�culo em (.*)/i;
	if ($1) {
		$self->{Updated} = $1;
	}
	
	# Atribui��o do texto para tabelas validas
	if ($intable && $inrecord && $infield && $start_session && $validated_table && $validated_row) {
   		$self->{Field} .= $text; 
	}   
	
}

# Override do procedimento end
sub end()
{
	my ($self,$tag) = @_;

	$internal_text = "";

	if($tag eq 'a' && $validated_row && $validated_table && $infield && $inlink) {
		$inlink--; 
		if ($start_session==12||$start_session==13) {
			$self->{Link} .= '</a>'; 
		}
		if ($start_session==1) {
			$self->{Link} .= '</a>'; 
		}
	}

	if($tag eq 'p' && $validated_name) { # para nao extrair a bolsa de produtividade...
		$validated_produtividade = 1;
		$validated_name = 0;
	}

	if($tag eq 'p' && $validated_produtividade) { # para nao extrair a bolsa de produtividade...
		$validated_produtividade = 0;
	}

	if($tag eq 'table' && $validated_table) {
		$intable--;
		$self->{Table} .= '';

		if ($self->{Table} ne '') {
			$self->{Table} =~ s/^\.//gi;		
		 	if ($self->{Link}) {
			 	$self->{Table} .= $self->{Link}; 
		 		undef $self->{Link}; 
			 }

			if ($start_session==5) {
				push @{$self->{Publication}[$table_type]}, $self->{Table};
			}
			if ($start_session==6) {
				push @{$self->{ProducaoTecnica}[$table_type]}, $self->{Table};
			}
			if ($start_session==7) {
				push @{$self->{ProducaoArtistica}[$table_type]}, $self->{Table};
			}
			if ($start_session==8) {
				push @{$self->{DemaisTrabalhos}[$table_type]}, $self->{Table};
			}
			if ($start_session==9) {
				push @{$self->{BancasExaminadoras}[$table_type]}, $self->{Table};
			}
			if ($start_session==10) {
				push @{$self->{ComissoesJulgadoras}[$table_type]}, $self->{Table};
			}
			if ($start_session==11) {
				push @{$self->{Eventos}[$table_type]}, $self->{Table};
			}
			if ($start_session==12) {
				push @{$self->{OrientacoesAndamento}[$table_type]}, $self->{Table};
			}
			if ($start_session==13) {
				push @{$self->{OrientacoesConcluidas}[$table_type]}, $self->{Table};

				if ($table_type==1 && $newID) { # alunos com doutorado conclu�do e ID Lattes cadastrado
					push @{$self->{Orientandos}}, $newID; 
					undef $newID;
				}
			}
			$validated_table = 0;
		}
	}

	if($tag eq 'tr' && $validated_row && $validated_table) {
		$inrecord--; 
		$self->{Table} .= $self->{Row}; 

		if ($start_session==1) {
			push @{$self->{FormacaoAcademica}}, $self->{Row};
		}
		if ($start_session==2)	{
			push @{$self->{Projetos}[$table_type]}, $self->{Row};
		}  
		if ($start_session==3)	{
			push @{$self->{AreasAtuacao}}, $self->{Row};
		}  
		if ($start_session==4)	{
			push @{$self->{Premios}[$table_type]}, $self->{Row};
		}
		$validated_row = 0;
	}
	
	if($tag eq 'td' && $validated_table && $infield) {
		$infield--; 

		if ($skip_field == 0) {
			$self->{Row} .= $self->{Field} . $separator ;
			$separator = "";
		}else {
			$skip_field--;
		}
	}

	if($tag eq 'td' && $validated_address) {
		$start_address = 0;
		$validated_address = 0;
	}
}

1;

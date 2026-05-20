\NeedsTeXFormat{LaTeX2e}
   \ProvidesClass{ic}[2004/02/18 v1.0 Modelo IC-UFAL de Trabalhos de Conclusao 
de Curso e Dissertacoes]

\LoadClass[a4paper,12pt]{report} %210 mm X 294 mm
%%------------------------------------------------------------------------------
%% Habilita a utilização de arroba
%%------------------------------------------------------------------------------
\makeatletter

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      LISTA DE PACOTES REQUERIDOS PARA A UTILIZAÇÃO DESTA CLASSE            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[T1]{fontenc} % Definição da codificação das fontes como T1
\RequirePackage{graphicx} % Inclusão de imagens
\RequirePackage{tabularx}
\RequirePackage{setspace} % Definição dos espaçamemtos entre linhas
\RequirePackage{calc} % Aceitação de notação infixa
\RequirePackage{fancyhdr} % Personalização de cabeçalhos e rodapés
\RequirePackage{listings} % Inclusão de código fonte de diversas linguagens
\RequirePackage{pslatex} % Utilização de fontes PostScript Tipo 1
\RequirePackage[utf8]{inputenc} % Uso caracteres especiais UTF8
\RequirePackage[a4paper]{geometry} % Para ajustar o papel
\RequirePackage[portuguese]{babel} % Para habilitar os macros de linguas
\RequirePackage[square, numbers]{natbib} % Estilo das referências
\RequirePackage{url} % Para lidar com URLs
\RequirePackage{color,colortbl} % Permite "pintar" as tabelas
\RequirePackage[active]{srcltx} % Busca inversa do dvi para o tex
\RequirePackage{ifthen} % Utilização de condicionais em latex
\RequirePackage{booktabs}
% \RequirePackage[binary-units]{siunitx}
\RequirePackage{units}
\RequirePackage{subfigure}
\RequirePackage{multicol}

%%%%%%%%%%%%%%%%%%%%%%%%%% [Rian,Ivan] Início Modificações %%%%%%%%%%%%%%%%%%%%%
\RequirePackage{amsmath} %
\RequirePackage{amsfonts} %
\RequirePackage{bbm} 
\RequirePackage{amssymb} %
\RequirePackage{amscd} %
% \RequirePackage{units} %
\RequirePackage{undertilde} % Utilização de caracteres com til em baixo
\RequirePackage{rotating}

% \RequirePackage{algorithm}
% \RequirePackage{algorithmic}
% \floatname{algorithm}{Algoritmo}
% \renewcommand{\algorithmicrequire}{\textbf{Input:}}
% \renewcommand{\algorithmicensure}{\textbf{Output:}}
% \renewcommand{\listalgorithmname}{Lista de Algoritmos}

\newenvironment{myequation}[2]
{\begin{equation}\label{#1}\addcontentsline{loe}{table}{\theequation~ #2}}
{\end{equation}}


\newcommand{\mequation}[3]{
\begin{equation}\label{#1}\addcontentsline{loe}{table}{\theequation~ #2}
#3
\end{equation}}

%%------------------------------------------------------------------------------
%% Fontes
%%------------------------------------------------------------------------------

%\RequirePackage{yfonts} %

\RequirePackage{tikz} % Pacote para desenhos (fig:diagrama)
\RequirePackage{xcolor} % Definição das cores
\RequirePackage{bm} % Pacote para criação do modelo de RSsF (fig:model_rssf)
\RequirePackage{float} %
\RequirePackage{pdfcomment} % Comentário do Abstract
\RequirePackage[pdftex]{hyperref} %
\RequirePackage{fancybox}
\RequirePackage{multicol}

%\RequirePackage{subfig} %
%\RequirePackage{booktabs} %

\definecolor{light_gray}{gray}{0.8}
\definecolor{Red}{rgb}{0.5,0,0}
\definecolor{Blue}{rgb}{0,0,0.5}

\newcommand\NomeFonteCap{Art Nouveau Caps}

\input{ArtNouvc.fd}
\newcommand*\myfont{\fontsize{60}{75}\usefont{U}{ArtNouvc}{xl}{n}}

%%------------------------------------------------------------------------------
%% Redefinindo capítulo
%%------------------------------------------------------------------------------
\newcounter{mychaptercounter}
\newenvironment{mychapterenviroment}{\refstepcounter{mychaptercounter}}{}
\newcommand{\mychapter}[2]{
\stepcounter{chapter}
\chapter*{
\begin{mychapterenviroment}
\label{#2}
\end{mychapterenviroment}
\begin{flushright}
\normalfont\myfont\arabic{mychaptercounter}\normalfont\Huge\bf\\
\vspace{1em}
#1
\end{flushright}
}
\addcontentsline{toc}{chapter}{\arabic{mychaptercounter}\hspace{1em}#1}
}

%%------------------------------------------------------------------------------
%% Comando para colocar uma inicialização em cada capítulo
%%------------------------------------------------------------------------------
% \newcommand{\initialcitation}[4]{
% \begin{raggedleft}
% {\it``#1''\\\vspace{1em}{\em{\bf#2}\\#3 (#4)}\\}
% \end{raggedleft}
% \vspace{2em}
% }

%%------------------------------------------------------------------------------
%% Para a fonte da lettrine ser a que defini
%%------------------------------------------------------------------------------
%\renewcommand{\LettrineFontHook}{\myfont}

%%------------------------------------------------------------------------------
%% Opções do pacote lettrine
%%------------------------------------------------------------------------------
% \setcounter{DefaultLines}{3}
% \renewcommand{\DefaultLoversize}{0}
% \renewcommand{\DefaultLraise}{0.1}
% \setlength{\DefaultNindent}{0em}
% \setlength{\DefaultSlope}{-.5em}


%==============================================================================
% Códigos
%==============================================================================
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{black}{rgb}{0,0,0}
\definecolor{blue}{rgb}{0,0,0.4}
\definecolor{purple}{rgb}{0.8,0,0.3}
\definecolor{orange}{rgb}{1,0.4,0}

\newcommand{\codejava}[3]{
  \mbox{
    \lstset{framexleftmargin=5mm, frame=shadowbox, rulesepcolor=\color{gray}}
    \lstinputlisting[language=Java,
      breaklines=true,
      basicstyle=\footnotesize\ttfamily,
      keywordstyle=\bfseries\color{purple},
      commentstyle=\itshape\color{dkgreen},
      stringstyle=\color{orange},
      showstringspaces=false,
      rulecolor=\color{black},
      caption=#1,label=#2]{#3}
  }
}

\newcommand{\codec}[3]{
  \mbox{
    \lstset{framexleftmargin=5mm, frame=shadowbox, rulesepcolor=\color{gray}}
    \lstinputlisting[language=C,
      breaklines=true,
      basicstyle=\footnotesize\ttfamily,
      keywordstyle=\bfseries\color{dkgreen},
      commentstyle=\itshape\color{purple},
      identifierstyle=\color{blue},
      stringstyle=\color{orange},
      showstringspaces=false,
      caption=#1,label=#2]{#3}
  }
}

% Comentário do abstract
\newcommand{\comAbstract}[3]{
\pdfmarkupcomment[color=white,author=#2,markup=Squiggly]{#1}{#3}
}
\newcommand{\doi}[1]{\textbf{DOI}~{\href{http://dx.doi.org/#1}{\color{Blue}#1}}}


% Resumo do capítulo
\newcommand{\resumocap}[1]{
\vfill
% \singlespacing
\begin{center}
\setlength\fboxsep{0.5pt}
\setlength\fboxrule{2pt}
 \doublebox{\colorbox{light_gray}{\parbox{.9\linewidth}{
#1
}}}
\end{center}
}




%%%%%%%%%%%%%%%%%%%%%%%%%%% [Rian,Ivan] Fim Modificações %%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                DECLARAÇÃO DE OPÇÕES: DISSERTAÇÃO e TCC                     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%------------------------------------------------------------------------------
%% Define TCC como padrão
%%------------------------------------------------------------------------------
\newboolean{tcc}
\setboolean{tcc}{true}

%%------------------------------------------------------------------------------
%% Declara a opção de dissertação
%%------------------------------------------------------------------------------
\DeclareOption{dissertacao}{%
    \setboolean{tcc}{false}
    \typeout{Tipo de Documento: Proposta de Dissertação de Mestrado.}
}

%%------------------------------------------------------------------------------
%% Declara a opção de TCC
%%------------------------------------------------------------------------------
\DeclareOption{tcc}{%
    \setboolean{tcc}{true}
    \typeout{Tipo de Documento: Proposta de Dissertação de Mestrado.}
}

%%------------------------------------------------------------------------------
%% Executa as opções
%%------------------------------------------------------------------------------
\ProcessOptions\relax


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                 DEFINIÇÃO DO LAYOUT DO DOCUMENTO                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%------------------------------------------------------------------------------
%%  TAMANHOS VERTICAIS - COPIADO DO ESTILO PADRÃO DA ABNT - Pacote abntex.cls
%%------------------------------------------------------------------------------
% A distancia entre o topo do cabeçalho e o topo do texto é de 1cm, 
% isto é, 1cm=\headheight+\headsep
% ...mas, nós consideramos a profundidade do cabeçallho, adicionando 2mm.
\setlength{\headsep}{1.2cm-\headheight}
% A distância entre a borda do papel e o número deve ser de 2cm
% 2cm=\topmargin+\voffset+1in
\setlength{\topmargin}{2cm-1in-\voffset}
% A borda inferior deve ser de 2cm
% \paperheight=\topmargin+\voffset+1in+\headheight+\headsep+\textheight+2cm
\setlength{\textheight}%
{\paperheight-\topmargin-\voffset-1in-\headheight-\headsep-2cm}

%%------------------------------------------------------------------------------
%% TAMANHOS HORIZONTAIS - COPIADO DO ESTILO PADRÃO DA ABNT - Pacote abntex.cls
%%------------------------------------------------------------------------------
% A margem esquerda é de 3cm e a direita é igual a 2cm.
\setlength{\oddsidemargin}{3cm-\hoffset-1in}
% para compatibilidade com impressão frente e verso, o tamanho das margens 
%deve ser alterado
\setlength{\evensidemargin}{2cm-\hoffset-1in}
% \paperwidth=\textwidth+\oddsidemargin+\hoffset+1in+2cm
\setlength{\textwidth}{\paperwidth-\oddsidemargin-\hoffset-1in-2cm}

%%------------------------------------------------------------------------------
%% Define o cabeçalho das páginas
%%------------------------------------------------------------------------------
% Limpa qualquer configuração anterior
\fancyhf{}

% Define a aparição do nome da seção no cabeçalho(esquerda)
\lhead{\rightmark} 

% Define a aparição do número da página no cabeçalho(direita)
\rhead{\thepage} % Número da página

% Define a largura da barra
\renewcommand{\headrulewidth}{0.6pt} 

% Define a altura do cabeçalho
\addtolength{\headheight}{3.05pt} 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                           DEFINIÇÃO DOS COMANDOS                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%------------------------------------------------------------------------------
%% Definição do comando CAPA
%%----------------------------------------------------------------------------
\newcommand{\capa}{%
    \thispagestyle{empty}%
    \begin{flushright} % Alinhamento à direita
      \href{http://ic.ufal.br}{\includegraphics[width=.3\linewidth]{IC.eps}}\\%
% [Rian] Adicionado href
      \Large \vspace*{2cm} \ifthenelse{\boolean{tcc}}{Proposta de Dissertação de Mestrado}{Dissertação de Mestrado}\\%
      \vspace*{2cm} \LARGE \textbf{\@titulo} \\%
      \vspace*{2cm}%
      \Large \href{\@autorPagina}{\color{black}{\@autorNome}} \\ \normalsize %
\texttt{\@autorEmail} \\ % [Rian] Adicionado href
      \ifthenelse{\boolean{autorDoisExiste}}{\Large \@autorDoisNome \\ %
\normalsize \texttt{\@autorDoisEmail}\\}{}%
      \vspace*{2cm}%
      \Large%
      \ifthenelse{\boolean{orientadorDoisExiste}}{Orientadores:}{Orientador:}%
      \\
      \vspace*{0.2cm}%
      \large
      \href{\@orientadorPagina}{\color{black}\@orientadorNome}\\%
% [Rian] Adicionado href
      \@orientadorDoisNome\\
      \@orientadorTresNome\\
      \normalsize \vfill Maceió, \@data%
    \end{flushright}%
    \folhaDeRosto%
    \aprovacao%
    \renewcommand{\thepage}{\roman{page}} \setcounter{page}{0}
    \normalsize%
}


%%------------------------------------------------------------------------------
%% Definição do comando FOLHA DE ROSTO
%%------------------------------------------------------------------------------
\newcommand{\folhaDeRosto}{
    \newpage%
    \thispagestyle{empty}%
    \begin{center}
        \Large
        \@autorNome\\
        \@autorDoisNome\\
        \vspace*{3cm} \LARGE \textbf{\@titulo} \\%
    \end{center}
    \vspace*{2cm}
    \hspace{5 cm}%
    \large%
    \hfill%
    \begin{minipage}{ 11 cm }%
        \ifthenelse{\boolean{tcc}}%
       {Proposta de Dissertação apresentada como requisito
parcial para obtenção do grau de Mestre em Informática
pelo Programa de Pós – Graduação em Informática do
Instituto de Computação da Universidade Federal de
Alagoas.}%
        {Proposta de Dissertação apresentada como requisito parcial para obtenção do grau de
Mestre em Informática pelo Programa de Pós – Graduação em Informática do Instituto
de Computação da Universidade Federal de Alagoas., aprovada pela comissão
examinadora que abaixo assina.}%
    \end{minipage}%
    \begin{flushright}
        \vspace*{2cm} \large%
        \ifthenelse{\boolean{orientadorDoisExiste}}{Orientadores:}{Orientador:}%
        \\%
        \vspace*{0.5cm}%
        \Large%
        \@orientadorNome\\
        \vspace*{0.2cm}%
        \@orientadorDoisNome\\
        \vspace*{0.2cm}%
        \@orientadorTresNome\\
        \normalsize%
        \vfill%
        Maceió, \@data%
    \end{flushright}
    \normalsize%
}%

%%------------------------------------------------------------------------------
%% Definição do comando APROVACAO
%%------------------------------------------------------------------------------

%%------------------------------------------------------------------------------
%% Contador de assinaturas
%%------------------------------------------------------------------------------
\newcounter{numeroDeAssinaturas}
\setcounter{numeroDeAssinaturas}{2}

%%------------------------------------------------------------------------------
%% Início do termo de aprovação
%%------------------------------------------------------------------------------
\newcommand{\aprovacao}{
    \newpage%
    \thispagestyle{empty}%
    \ifthenelse{\boolean{tcc}}%
        {Proposta de Dissertação apresentada como requisito parcial para obtenção do grau de Mestre pelo Curso de Mestrado em Informática do Instituto de Computação da
Universidade Federal de Alagoas, aprovada pela comissão examinadora que abaixo assina.}%
        {Dissertação apresentada como requisito parcial para obtenção do grau de
Mestre pelo Curso de Mestrado em Modelagem Computacional de Conhecimento do
Instituto de Computação da Universidade Federal de Alagoas, aprovada pela
comissão examinadora que abaixo assina.}%
    \begin{center}
        \normalsize%
        % 6 assinaturas: 0.7cm
        % 5 assinaturas: 1.5cm
        % 4 assinaturas: 3.0cm
        % 3 assinaturas: 4.0cm
        % 2 assinaturas: 4.0cm
        \ifthenelse{\value{numeroDeAssinaturas} = 2}{\vspace*{4cm}}{}%
        \ifthenelse{\value{numeroDeAssinaturas} = 3}{\vspace*{4cm}}{}%
        \ifthenelse{\value{numeroDeAssinaturas} = 4}{\vspace*{3cm}}{}%
        \ifthenelse{\value{numeroDeAssinaturas} = 5}{\vspace*{1.5cm}}{}%
        \ifthenelse{\value{numeroDeAssinaturas} = 6}{\vspace*{0.7cm}}{}%
        \rule{9cm}{0.02cm}\\%
        \vspace*{0.2cm}%
        \@orientadorPrefixo~\@orientadorNome~-~Orientador\\
        \@orientadorDepartamento\\
        \@orientadorInstituicao\\
        \ifthenelse{\boolean{orientadorDoisExiste}}{
            \vspace*{1cm}%
            \rule{9cm}{0.02cm}\\%
            \vspace*{0.2cm}%
            \@orientadorDoisPrefixo~\@orientadorDoisNome~-~Coorientador\\
            \@orientadorDoisDepartamento\\
            \@orientadorDoisInstituicao\\
        }{}
        \ifthenelse{\boolean{orientadorTresExiste}}{
            \vspace*{1cm}%
            \rule{9cm}{0.02cm}\\%
            \vspace*{0.2cm}%
            \@orientadorTresNome~-~Orientador\\
            \@orientadorTresDepartamento\\
            \@orientadorTresInstituicao\\
        }{}
        
        \ifthenelse{\boolean{examinadorUmExiste}}{
            \vspace*{1cm}%
            \rule{9cm}{0.02cm}\\%
            \vspace*{0.2cm}%
            \@examinadorPrefixo~\@examinadorNome~-~Examinador\\
            \@examinadorDepartamento\\
            \@examinadorInstituicao\\
        }{}
        \ifthenelse{\boolean{examinadorDoisExiste}}{
            \vspace*{1cm}%
            \rule{9cm}{0.02cm}\\%
            \vspace*{0.2cm}%
            \@examinadorDoisPrefixo~\@examinadorDoisNome~-~Examinador\\
            \@examinadorDoisDepartamento\\
            \@examinadorDoisInstituicao\\
        }{}
        \ifthenelse{\boolean{examinadorTresExiste}}{
            \vspace*{1cm}%
            \rule{9cm}{0.02cm}\\%
            \vspace*{0.2cm}%
            \@examinadorTresNome~-~Examinador\\
            \@examinadorTresDepartamento\\
            \@examinadorTresInstituicao\\
        }{}
        \vfill%
        Maceió, \@data%
    \end{center}
    \normalsize%
}

%%------------------------------------------------------------------------------
%% Definição do comando INICIO para formatação de páginas
%%------------------------------------------------------------------------------
\newcommand{\inicio}{%
    \newpage%
    %Números no estilo arábico
    \renewcommand{\thepage}{\arabic{page}}%
    %Contador de página = 1
    \setcounter{page}{1}%
    %Espaçamento 1,5
    \onehalfspacing%
}%

%%------------------------------------------------------------------------------
%% Definição do comando AUTOR
%%------------------------------------------------------------------------------
\newcommand{\@autorNome}{}
\newcommand{\@autorEmail}{}
\newcommand{\@autorPagina}{}
\newcommand{\autor}[3]{
    \renewcommand{\@autorNome}{#1}
    \renewcommand{\@autorEmail}{#2}
    \renewcommand{\@autorPagina}{#3} % [Rian] página Web do autor
}

%%------------------------------------------------------------------------------
%% Definição do comando AUTOR2
%%------------------------------------------------------------------------------
\newcommand{\@autorDoisNome}{~}
\newcommand{\@autorDoisEmail}{~}
\newboolean{autorDoisExiste}
\setboolean{autorDoisExiste}{false}
\newcommand{\autorDois}[2]{
    \renewcommand{\@autorDoisNome}{#1}
    \renewcommand{\@autorDoisEmail}{#2}
    \setboolean{autorDoisExiste}{true}
}

%%------------------------------------------------------------------------------
%% Definição do comando ORIENTADOR
%%------------------------------------------------------------------------------
\newcommand{\@orientadorNome}{}
\newcommand{\@orientadorPagina}{}
\newcommand{\@orientadorDepartamento}{}
\newcommand{\@orientadorInstituicao}{}
\newcommand{\@orientadorPrefixo}{}
\newcommand{\orientador}[5]{
    \renewcommand{\@orientadorNome}{#1}
    \renewcommand{\@orientadorPagina}{#2} % [Rian] página Web do orientador
    \renewcommand{\@orientadorDepartamento}{#3}
    \renewcommand{\@orientadorInstituicao}{#4}
    \renewcommand{\@orientadorPrefixo}{#5}
}

%%------------------------------------------------------------------------------
%% Definição do comando ORIENTADOR 2
%%------------------------------------------------------------------------------
\newcommand{\@orientadorDoisNome}{~}
\newcommand{\@orientadorDoisEmail}{~}
\newcommand{\@orientadorDoisDepartamento}{~}
\newcommand{\@orientadorDoisInstituicao}{~}
\newcommand{\@orientadorDoisPrefixo}{~}
\newboolean{orientadorDoisExiste}
\setboolean{orientadorDoisExiste}{false}
\newcommand{\orientadorDois}[5]{
    \renewcommand{\@orientadorDoisNome}{#1}
    \renewcommand{\@orientadorDoisEmail}{#2}
    \renewcommand{\@orientadorDoisDepartamento}{#3}
    \renewcommand{\@orientadorDoisInstituicao}{#4}
    \renewcommand{\@orientadorDoisPrefixo}{#5}
    \setboolean{orientadorDoisExiste}{true}
    \addtocounter{numeroDeAssinaturas}{1}
}

%%------------------------------------------------------------------------------
%% Definição do comando ORIENTADOR 3
%%------------------------------------------------------------------------------
\newcommand{\@orientadorTresNome}{~}
\newcommand{\@orientadorTresEmail}{~}
\newcommand{\@orientadorTresDepartamento}{~}
\newcommand{\@orientadorTresInstituicao}{~}
\newboolean{orientadorTresExiste}
\setboolean{orientadorTresExiste}{false}
\newcommand{\orientadorTres}[4]{
    \renewcommand{\@orientadorTresNome}{#1}
    \renewcommand{\@orientadorTresEmail}{#2}
    \renewcommand{\@orientadorTresDepartamento}{#3}
    \renewcommand{\@orientadorTresInstituicao}{#4}
    \setboolean{orientadorTresExiste}{true}
    \addtocounter{numeroDeAssinaturas}{1}
}

%%------------------------------------------------------------------------------
%% Definição do comando EXAMINADOR
%%------------------------------------------------------------------------------
\newcommand{\@examinadorNome}{}
\newcommand{\@examinadorEmail}{}
\newcommand{\@examinadorDepartamento}{}
\newcommand{\@examinadorInstituicao}{}
\newcommand{\@examinadorPrefixo}{}
\newboolean{examinadorUmExiste}
\setboolean{examinadorUmExiste}{false}
\newcommand{\examinador}[5]{
    \renewcommand{\@examinadorNome}{#1}
    \renewcommand{\@examinadorEmail}{#2}
    \renewcommand{\@examinadorDepartamento}{#3}
    \renewcommand{\@examinadorInstituicao}{#4}
    \renewcommand{\@examinadorPrefixo}{#5}
    \setboolean{examinadorUmExiste}{true}
}

%%------------------------------------------------------------------------------
%% Definição do comando EXAMINADOR 2
%%------------------------------------------------------------------------------
\newcommand{\@examinadorDoisNome}{~}
\newcommand{\@examinadorDoisEmail}{~}
\newcommand{\@examinadorDoisDepartamento}{~}
\newcommand{\@examinadorDoisInstituicao}{~}
\newcommand{\@examinadorDoisPrefixo}{~}
\newboolean{examinadorDoisExiste}
\setboolean{examinadorDoisExiste}{false}
\newcommand{\examinadorDois}[5]{
    \renewcommand{\@examinadorDoisNome}{#1}
    \renewcommand{\@examinadorDoisEmail}{#2}
    \renewcommand{\@examinadorDoisDepartamento}{#3}
    \renewcommand{\@examinadorDoisInstituicao}{#4}
    \renewcommand{\@examinadorDoisPrefixo}{#5}
    \setboolean{examinadorDoisExiste}{true}
    \addtocounter{numeroDeAssinaturas}{1}
}

%%------------------------------------------------------------------------------
%% Definição do comando EXAMINADOR 3
%%------------------------------------------------------------------------------
\newcommand{\@examinadorTresNome}{~}
\newcommand{\@examinadorTresEmail}{~}
\newcommand{\@examinadorTresDepartamento}{~}
\newcommand{\@examinadorTresInstituicao}{~}
\newboolean{examinadorTresExiste}
\setboolean{examinadorTresExiste}{false}
\newcommand{\examinadorTres}[4]{
    \renewcommand{\@examinadorTresNome}{#1}
    \renewcommand{\@examinadorTresEmail}{#2}
    \renewcommand{\@examinadorTresDepartamento}{#3}
    \renewcommand{\@examinadorTresInstituicao}{#4}
    \setboolean{examinadorTresExiste}{true}
    \addtocounter{numeroDeAssinaturas}{1}
}

%%------------------------------------------------------------------------------
%% Definição do comando TITULO
%%------------------------------------------------------------------------------
\newcommand{\@titulo}{}
\newcommand{\titulo}[1]{\renewcommand{\@titulo}{#1}}

%%------------------------------------------------------------------------------
%% Definição do comando DATA
%%------------------------------------------------------------------------------
\newcommand{\@data}{}
\newcommand{\dataMesAno}[3]{
    \renewcommand{\@data}{
    #1 de #2
    }%%Fim de @DATA
}%Fim de DATA

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                       DEFINIÇÃO DE AMBIENTES                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%------------------------------------------------------------------------------
%% Definição do ambiente RESUMO
%%------------------------------------------------------------------------------
\newenvironment{resumo}{
    \onehalfspacing
    \chapter*{\thispagestyle{empty}\centering Resumo}
}{}

%%------------------------------------------------------------------------------
%% Redefinição do ambiente ABSTRACT
%%------------------------------------------------------------------------------
\renewenvironment{abstract}{
    \onehalfspacing
    \chapter*{\thispagestyle{empty}\centering Abstract}
}{}

%%------------------------------------------------------------------------------
%% Definição do ambiente AGRADECIMENTOS
%%------------------------------------------------------------------------------
\newenvironment{agradecimentos}{
    \onehalfspacing
    \chapter*{\thispagestyle{empty}\centering Agradecimentos}
}{}


%%------------------------------------------------------------------------------
%% Definição do ambiente EPÍGRAFO
%%------------------------------------------------------------------------------

\newenvironment{epigraph}[2][2em]
  {\setlength{\@tempdima}{#1}%
   \def\chapquote@author{#2}%
   \parshape 1 \@tempdima \dimexpr\textwidth-2\@tempdima\relax%
   \itshape}
  {\par\normalfont\hfill--\ \chapquote@author\hspace*{\@tempdima}\par\bigskip}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                 CONFIGURAÇÕES PARA O CORPO DO DOCUMENTO                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{
    \normalsize
    %% Configura para utilizar o cabeçalho e rodapé definidos anteriormente.    
    \pagestyle{fancy}
    %% Define o módulo de citação abreviado(Harvard)
    %% \citationmode{abbr}
    %% Define o estilo bibligráfico agsm(Harvard)
    \bibliographystyle{estilo_}
}

%%------------------------------------------------------------------------------
%% Desabilita a utilização de arroba
%%------------------------------------------------------------------------------
\makeatother

%=====================================================================
% Definição do conteúdo de listas de abreviaturas e símbolos
%=====================================================================
\newcommand{\makeabrevpage}[1]{
  \begin{listofabbrv}{XXXXXX}
    #1
  \end{listofabbrv}
  \pagebreak
}{}

\newcommand{\makesymbolspage}[1]{
  \begin{listofsymbols}{XXXXXX}
    #1
  \end{listofsymbols}
  \pagebreak
}{}

%=====================================================================
% Definição das listas de abreviaturas e siglas e de símbolos
%=====================================================================

\newcommand{\makefigurespage}{
  \addcontentsline{toc}{chapter}{\listfigurename}
  \listoffigures{}
  \pagebreak
}{}

%=====================================================================
% Definição do conteúdo de listas de tabelas
%=====================================================================
\newcommand{\maketablespage}{
  \addcontentsline{toc}{chapter}{\listtablename} 
  \listoftables{}
  \pagebreak
}{}

\newenvironment{listofabbrv}[1]{
  \chapter*{Lista de Abreviaturas e Siglas}
  \addcontentsline{toc}{chapter}{Lista de Abreviaturas e Siglas}
  \begin{list}{\textbf{??}}{
    \settowidth{\labelwidth}{#1}
    \setlength{\labelsep}{1em}
    \setlength{\itemindent}{0mm}
    \setlength{\leftmargin}{\labelwidth}
      \addtolength{\leftmargin}{\labelsep}
    \setlength{\rightmargin}{0mm}
    \setlength{\itemsep}{.1\baselineskip}
    \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
  }
}
{
  \end{list}
}
\newenvironment{listofsymbols}[1]{
  \chapter*{Lista de Símbolos}
  \addcontentsline{toc}{chapter}{Lista de Símbolos}
  \begin{list}{\textbf{??}}{
    \settowidth{\labelwidth}{#1}
    \setlength{\labelsep}{1em}
    \setlength{\itemindent}{0mm}
    \setlength{\leftmargin}{\labelwidth}
      \addtolength{\leftmargin}{\labelsep}
    \setlength{\rightmargin}{0mm}
    \setlength{\itemsep}{.1\baselineskip}
    \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
  }
}
{
  \end{list}
}

\newcommand{\palavrasChave}[1]{
    \vspace{1em}
    \textbf{Palavras-chave}: #1
}

\newcommand{\keywords}[1]{
    \vspace{1em}
    \textbf{Key-words}: #1
}
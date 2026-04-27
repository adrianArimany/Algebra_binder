\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{setassignment}[2025/07/09 Academic Binder Class for Mathematics Courses]

%_____________________________________________________________%
\LoadClass[11pt]{report} %The text size, and report format
\errorcontextlines=999

%_____________________________________________________________%
\RequirePackage{sty/packages} %Global Packages being used in the document
\RequirePackage{sty/macros} %Personal Global Macros
\RequirePackage{sty/baseEnv} %Calls for mathetical Enviroments that are used in document.
\RequirePackage{sty/bodyEnv} %Call for body related in the document.

%_____________________________________________________________%

%Defines the maximum number of coloumns in a matrix command.
\setcounter{MaxMatrixCols}{20}
% =========================
% Assignment environment (key-value authoring)
% =========================
%\makeatletter

% === Global Metadata ===
\gdef\@studentname{Adrian Arimany}
\gdef\@carnet{211063}
\gdef\@course{Modern Algebra}
\gdef\@duedate{}
\gdef\@assignmenttitle{}


% Defaults for keys
\def\asgn@header{HeaderA}
\def\asgn@body{BodyB}
\def\asgn@title{}
\def\asgn@duedate{}
%\def\studentname{}
\def\asgn@course{}
\def\asgn@carnet{}
\def\asgn@toc{false}
\def\asgn@toctitle{}
\def\asgn@exlist{false}

% Keys
\define@key{asgn}{header}{\def\asgn@header{#1}}
\define@key{asgn}{body}{\def\asgn@body{#1}}
\define@key{asgn}{title}{\def\asgn@title{#1}}
\define@key{asgn}{duedate}{\def\asgn@duedate{#1}}
\define@key{asgn}{studentname}{\def\asgn@studentname{#1}}
\define@key{asgn}{course}{\def\asgn@course{#1}}
\define@key{asgn}{carnet}{\def\asgn@carnet{#1}}
\define@key{asgn}{toc}{\def\asgn@toc{#1}}
\define@key{asgn}{toctitle}{\def\asgn@toctitle{#1}}
\define@key{asgn}{exlist}{\def\asgn@exlist{#1}}

%_____________List of Exercises________________________%

% --- Exercise list header toggle (fancyhdr) ---
\makeatletter

% Save/restore a few header-related settings
\newcommand{\AsgnExlistOn}{%
  \fancyhead[C]{\footnotesize Ejercicios:\ \ExerciseHeaderList}%
}

\newcommand{\AsgnExlistOff}{%
  \fancyhead[C]{}%
}

\makeatother

% --- Custom Table of Contents Layout ---
\makeatletter

\renewcommand{\tableofcontents}{%
  \vspace*{-1cm}
  \noindent
  \begin{minipage}[t]{0.5\textwidth}
    \textbf{Name:} \@studentname \\
    \textbf{Date:} \today
  \end{minipage}%
  \begin{minipage}[t]{0.5\textwidth}
    \raggedleft
    \textbf{Course:} \@course
  \end{minipage}

  \vspace{1.5em}
  \begin{center}
    {\Large \bfseries Tabla de Contenidos}
  \end{center}
  \vspace{1em}

  \@starttoc{toc}
}

\makeatother







\makeatletter 
% Assignment environment: key-value + body capture
\NewDocumentEnvironment{assignment}{O{} +b}{%
  \begingroup



  % 1) reset defaults
  \def\asgn@header{HeaderA}%
  \def\asgn@body{BodyB}%
  \def\asgn@title{}%
  \def\asgn@duedate{}%
  \def\asgn@studentname{}%
  \def\asgn@course{}%
  \def\asgn@carnet{}%
  \def\asgn@toc{false}%
  \def\asgn@toctitle{}%
  \def\asgn@exlist{false}%

  % 2) parse keys
  \setkeys{asgn}{#1}%

  % 3) apply metadata (for header)
  \ifx\asgn@title\@empty\else \gdef\@assignmenttitle{\asgn@title}\fi
  \ifx\asgn@duedate\@empty\else \gdef\@duedate{\asgn@duedate}\fi
  \ifx\asgn@studentname\@empty\else \gdef\@studentname{\asgn@studentname}\fi
  \ifx\asgn@course\@empty\else  \gdef\@course{\asgn@course}\fi
  \ifx\asgn@carnet\@empty\else  \gdef\@carnet{\asgn@carnet}\fi

   % 4) reset exercise list per assignment
  \ResetEjercicios

  
 
  
  % 5) load header/body packages once
  \input{design/header/\asgn@header.tex}%
  \csname use\asgn@header\endcsname

  




  % 7) enable/disable the running exercise list header (NO duplicates)
  \ifstrequal{\asgn@exlist}{true}{\AsgnExlistOn}{\AsgnExlistOff}%


  % 7) your manual header block (once)
  %really unnecessary.
  %\setassignmentmanualheader
  %\vspace{0.5em}
  %\noindent\rule{\textwidth}{0.5pt}\par 

 % 8) ToC entry if requested
  \ifstrequal{\asgn@toc}{true}{%
    \ifx\asgn@toctitle\@empty
      \addcontentsline{toc}{chapter}{\asgn@title}%
    \else
      \addcontentsline{toc}{chapter}{\asgn@toctitle}%
    \fi
  }{}%

  
  % 9) BODY begin layour
  \input{design/body/\asgn@body.tex}%
  \@ifundefined{use\asgn@body begin}{}{%
    \csname use\asgn@body begin\endcsname
  }%

    
  % 10) Body content
  #2
}{
 % 11) BODY end hook
  \@ifundefined{use\asgn@body end}{}{%
    \csname use\asgn@body end\endcsname
  }%


  % 12) turn off exercise header so it does NOT leak to next assignment
  %\ifstrequal{\asgn@exlist}{true}{\AsgnExlistOff}{}%


\AsgnExlistOff

\endgroup
}

\makeatother
%_____________________________________________________________%




% --- Custom For two coloumn content ---
% \newcommand{\twoColumn}[2]{%
%   \noindent
%   \begin{minipage}[t]{\leftColumnWidth}
%     \raggedright
%     \small
%     #1
%   \end{minipage}%
%   \hspace{\columnGap}%
%   \begin{minipage}[t]{\rightColumnWidth}
%     \raggedright
%     \small
%     #2
%   \end{minipage}%
%   \normalsize
% }






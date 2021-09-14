<div align="center">
  <img style="width: 20%;" src="https://github.com/jorgepiloto/escriba/blob/main/{{cookiecutter.escriba_project}}/fig/static/logo.png">
  <p><b>An efficient and automated LaTeX project layout</b></p>
  <br>
  <img src="https://img.shields.io/badge/LaTeX-%E2%99%A5-blue">
  <img src="https://github.com/jorgepiloto/escriba/actions/workflows/ci_actions.yml/badge.svg?branch=main">
  <img src="https://img.shields.io/badge/LICENSE-Apache%202.0-black">
</div>


## What is it?

The ESCRIBA project is simply a [LaTeX](https://www.latex-project.org/) project
layout for efficiently managing academical works. It ships with different
automated commands via [Makefile](https://www.gnu.org/software/make/) for:

* Compiling and linking [Asymptote](https://asymptote.sourceforge.io/) based figures.
* Execute any sort of binaries ([Python](https://www.python.org) scripts are the
  default ones).
* Reformatting [LaTeX](https://www.latex-project.org/) files via
  [latexindent](https://latexindentpl.readthedocs.io/en/latest/index.html). 
* Building project's bibliography with
  [biber](http://biblatex-biber.sourceforge.net/).
* Cleaning junk and auxiliary LaTeX files inside project's directory.

If you want to know what ESCRIBA can do for you, please refer to:

<div align="center">
 <a href="https://github.com/jorgepiloto/escriba/blob/docs/escriba_user_guide.pdf">OFFICIAL ESCRIBA USER GUIDE</a>
</div>


## Installation guide

ESCRIBA needs from a set of dependencies, being these ones:

```
build-essential, texlive-full, ghostscript, asymptote
```

In addition, ESCRIBA is provided as a [cookiecutter
template](https://github.com/cookiecutter/cookiecutter), meaning that you
require [Python](https://www.python.org) for using this tool.

After installing Python, you just need to install [cookiecutter](https://github.com/cookiecutter/cookiecutter) by doing:

```
python -m pip install cookiecutter
```

## Create a new project

Now, you are ready to initialize a new ESCRIBA project by doing:

```bash
cookiecutter gh:jorgepiloto/escriba
```

Answer the different questions with your preferred configuration options. Then,
move inside your new project and run:

```bash
make pdf
```

which will compile and render the final document in a PDF file. If you face any
problems during these steps, please [open a new
issue](https://github.com/jorgepiloto/escriba/issues).


## The project structure

Any ESCRIBA project is divided into different directories, each one devoted to
store a particular type of information:

```bash
escriba_project
├── asy                # Save here your Asymptote scripts
├── bib                # All bibliography related files
├── bin                # Any Python binaries
├── dat                # A directory holding data files for your scripts
├── fig                # Generated figures from Asymptote or Python will be placed in here
│   └── static         # Static figures will no be removed when cleaning project directories
├── main.tex           # The main project file
├── Makefile           # A make script for automating different ESCRIBA commands
├── README.md          # Introduce your readers to your project with a README file
├── src                # All core files: organize those by chapters, then by sections
│   ├── ch00
│   │   ├── index.tex
│   │   ├── one_section.tex
│   │   └── another_section.tex
│   ├── ch01
│   │   ├── index.tex
│   │   └── ...
│   └── ...
└── tex                # LaTeX customization: packages, commands, cover and preface
    ├── commands.tex   # Define your custom commands in here
    ├── cover.tex      # The cover of your project
    ├── packages.tex   # All require packages for your project
    └── preface.tex    # The preface or abstract goes in here
```

This structure allows you to have a well organized project, helping you to
isolate the different chapters and their sections. At the same time, it splits
the TeX configuration files from the ones holding all the information of your
work, preventing you from mixing them.


## About this project

I accidentally created this tool while working on my bachelor thesis. My project
required from Python, Asymptote and other tools for generating the
document figures. 

My idea was to create a layout in which the different scripts, drawings,
configuration files and source ones could be stored, reformatted, linked and
compiled using some kind of command.

Now, I cannot imagine working without ESCRIBA, as it has become a very useful
tool!

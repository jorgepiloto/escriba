# ----------------------------------------------------------------------------
#                              PROJECT DIRECTORIES
# ----------------------------------------------------------------------------
PROJECTDIR = .
ASYDIR = asy
BINDIR = bin
FIGDIR = fig
TEXDIR = tex
SRCDIR = src
OUTDIR = $(PROJECTDIR)


# ----------------------------------------------------------------------------
#                             MAIN FILE AND CHAPTERS
# ----------------------------------------------------------------------------
MAINFILE = $(PROJECTDIR)/main
OUTPUTFILE = escriba_user_guide
CHDIRS = $(SRCDIR)/00_introduction $(SRCDIR)/01_installation $(SRCDIR)/02_how_to_use $(SRCDIR)/03_how_to_customize

# ----------------------------------------------------------------------------
#                          CRITICAL FILES AND SUFFIXES
# ----------------------------------------------------------------------------
STRUCTURE = $(PROJECTDIR) $(TEXDIR) $(CHDIRS)
ASYFILES := $(addsuffix /*.asy, $(ASYDIR))
AUXFILES := $(addsuffix /*.aux,$(STRUCTURE))
BAKFILES := $(addsuffix /*.bak*,$(STRUCTURE))
BBLFILES := $(addsuffix /*.bbl,$(STRUCTURE))
BCFFILES := $(addsuffix /*.bcf,$(STRUCTURE))
BLGFILES := $(addsuffix /*.blg,$(STRUCTURE))
BLXFILES := $(addsuffix /*blx.bib,$(STRUCTURE))
GZFILES := $(addsuffix /*.gz,$(STRUCTURE))
LOFFILES := $(addsuffix /*.lof,$(STRUCTURE))
LOGFILES := $(addsuffix /*.log,$(STRUCTURE))
LOTFILES := $(addsuffix /*.lot,$(STRUCTURE))
OUTFILES := $(addsuffix /*.out,$(STRUCTURE))
PYFILES := $(addsuffix /*.py, $(BINDIR))
RUNFILES := $(addsuffix /*run.xml,$(STRUCTURE))
TEXFILES := $(addsuffix /*.tex,$(STRUCTURE))
TOCFILES := $(addsuffix /*.toc,$(STRUCTURE))
JUNKFILES := $(AUXFILES) $(AUXFILES) \
	     $(BAKFILES) $(BBLFILES) $(BCFFILES) $(BLGFILES) $(BLXFILES) \
	     $(GZFILES) \
	     $(LOFFILES) $(LOGFILES) $(LOTFILES) \
	     $(OUTFILES) \
	     $(RUNFILES) \
	     $(TOCFILES)


# ----------------------------------------------------------------------------
#                            TOOLS AND CONFIGURATION
# ----------------------------------------------------------------------------
# Latex engine and compiling options
LATEXENGINE = xelatex
LATEXOPTS = -interaction=batchmode -output-directory=$(OUTDIR) -jobname=$(OUTPUTFILE)

# Bibliography engine and options
BIBENGINE = biber
BIBOPTS = -quiet

# Latex indentation engine and options
LATEXINDENT = latexindent
LATEXINDENTOPTS = -s -w -y="defaultIndent: '  '"

# Asymptote options
ASYENGINE = asy
ASYOPTS = -maxtile "(256,256)"

# Finding tool engine and options
FIND = find
FINDOPTS =


# ----------------------------------------------------------------------------
#                           CRITICAL FILES AND SUFFIX
# ----------------------------------------------------------------------------
ASYFILES := $(addsuffix /*.asy, $(ASYDIR))
PYFILES := $(addsuffix /*.py, $(BINDIR))
BAKFILES := $(addsuffix /*.bak0, $(STRUCTURE))
LOGFILES := $(addsuffix /*.log, $(STRUCTURE))
LOTFILES := $(addsuffix /*.lot, $(STRUCTURE))
LOFFILES := $(addsuffix /*.lof, $(STRUCTURE))
LOFFILES := $(addsuffix /*.tex, $(STRUCTURE))
OUTFILES := $(addsuffix /*.out,$(STRUCTURE))
LOGFILES := $(addsuffix /*.log,$(STRUCTURE))
TOCFILES := $(addsuffix /*.toc,$(STRUCTURE))
GZFILES := $(addsuffix /*.gz,$(STRUCTURE))
BBLFILES := $(addsuffix /*.bbl,$(STRUCTURE))
BCFFILES := $(addsuffix /*.bcf,$(STRUCTURE))
BLGFILES := $(addsuffix /*.blg,$(STRUCTURE))
BLXFILES := $(addsuffix /*blx.bib,$(STRUCTURE))
RUNFILES := $(addsuffix /*run.xml,$(STRUCTURE))
JUNKFILES := $(AUXFILES) $(OUTFILES) $(LOGFILES) $(TOCFILES) $(GZFILES) $(BBLFILES) $(BCFFILES) $(BLGFILES) $(BLXFILES) $(RUNFILES)

# ----------------------------------------------------------------------------
#                       ALL MAKE RULES ARE DEFINED BELOW
# ----------------------------------------------------------------------------


# Default rule
all: clean pdf

# Generates a PDF and cleans all the work space
pdf: compile

# Build auxiliary and PDF files
compile: binaries drawings
	@echo "Building PDF file..."
	@$(LATEXENGINE) $(LATEXOPTS) $(MAINFILE)
	@$(BIBENGINE) $(BIBOPTS) $(OUTPUTFILE)
	# Compile twice for properly linking the bibliography
	@$(LATEXENGINE) $(LATEXOPTS) $(MAINFILE)
	@rm -f $(FIGDIR)/*.png
	@echo "Done!"

# Compile all Asymptote scripts
drawings:
	@echo "Compiling drawings..."
ifeq ($(ASYFILES), $(ASYDIR)/*.asy)
	@echo "No Asymptote drawings were found in $(ASYDIR)!"
else
	@$(ASYENGINE) $(ASYOPTS) $(ASYFILES)
	@echo "Copying all files to $(FIGDIR) directory..."
	@mv *.png $(FIGDIR)
	@echo "Done!"
endif

# Compile all the binaries
binaries:
	@echo "Compiling binaries..."
ifeq ($(PYFILES), $(BINDIR)/*.py)
	@echo "No Python binaries were found in $(BINDIR)!"
else
	@echo "Compiling Python binaries..."
	@for script in $(PYFILES); do\
		echo "$${script}";\
		python $${script};\
		done
	@echo "Done!"
endif

# Reformat all the required files for good code quality
reformat:
	@echo "Reformating all TEX files..."
	@for tex_file in $(TEXFILES); do\
		echo "$${tex_file}";\
		$(LATEXINDENT) $(LATEXINDENTOPTS) $${tex_file};\
	done
	@echo "Cleaning log files..."
	@rm -rf $(LOGFILES) $(BAKFILES)
	@echo "Done!"

# Clean workspace by removing junk files
clean:
	@echo "Cleaning workspace..."
	@rm -f $(JUNKFILES)
	@rm -f *.lot *.lof
	@rm -f $(FIGDIR)/*.png
	@echo "Done!"

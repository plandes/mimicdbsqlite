# (@)Id: makefile automates the build and deployment for docker projects

## Build config
#
# project def
PROJ_TYPE =		markdown
PROJ_MODULES =		git


# build app config
DATA_ARCH_DIR ?=	mimic-iii-clinical-database-1.4
CODE_DIR ?=		./mimic-code/mimic-iii/buildmimic/sqlite
DB_FILE_NAME ?=		mimic3.sqlite3
DB_ABS_FILE ?=		$(CODE_DIR)/$(DB_FILE_NAME)

# clean
ADD_CLEAN_ALL +=	$(DATA_ARCH_DIR) ./mimic-code


include ./zenbuild/main.mk


## Targets
#
$(DATA_ARCH_DIR):
			unzip $(DATA_ARCH_DIR).zip

# clone the MIMIC-III database parsing code base
$(CODE_DIR):		$(DATA_ARCH_DIR)
			@echo "cloning mimic code repository"
			git clone 'https://github.com/MIT-LCP/mimic-code.git'
			@echo "copying data files to code dir (design for simplicity)"
			cp $(DATA_ARCH_DIR)/* $(CODE_DIR)

# load the database
.PHONY:			load
load:			$(CODE_DIR)
			( cd $(CODE_DIR) ; ./import.sh && mv mimic3.db $(DB_FILE_NAME) )

.PHONY:			postconfig
postconfig:
			@echo "executing post configuration..."
			./src/bin/postconfig.sh $(DB_ABS_FILE)

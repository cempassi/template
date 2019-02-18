# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cempassi <cempassi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/02/17 23:46:04 by cempassi          #+#    #+#              #
#    Updated: 2019/02/18 15:02:55 by cempassi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = Clang
COMPILE = $(CC) -c
DEBUG = $(CC) -g -c

# Reset
NC = \033[0m

# Regular Colors
BLACK = \033[0;30m
RED = \033[0;31m
GREEN = \033[32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
PURPLE = \033[0;35m
CYAN = \033[0;36m
WHITE = \033[0;37m

NAME = #####
CLEANUP = rm -rf
MKDIR = mkdir -p

PATHO = objs/
PATHI = includes/

INCS += #####
SRCS += #####

DSYM += $(NAME).dSYM
DSYM += $(DBNAME).dSYM

OBJS = $(patsubst %.c, $(PATHO)%.o, $(SRCS))
OBJD = $(patsubst %.c, $(PATHO)db%.o, $(SRCS))

WFLAGS += -Wall
WFLAGS += -Werror
WFLAGS += -Wextra
DFLAGS += -fsanitize=address
IFLAGS = -I$(PATHI)
CFLAGS = $(WFLAGS)

vpath %.c srcs
vpath %.h includes

all : $(PATHO) $(NAME)

debug : $(PATHO) $(DBNAME)

$(NAME): $(OBJS)
	$(CC) $@ $^
	printf "$(GREEN)$@ is ready.\n$(NC)"

$(DBNAME): $(OBJD)
	$(CC) $(DFLAGS) $@ $^
	printf "$(GREEN)$@ is ready.\n$(NC)"

$(OBJS): $(PATHO)%.o : %.c $(INCS)
	$(COMPILE) $(CFLAGS) $(IFLAGS) $< -o $@
	printf "$(BLUE)Compiling $<\n$(NC)"

$(OBJD): $(PATHO)db%.o : %.c $(INCS)
	$(DEBUG) $(DFLAGS) $(CFLAGS) $(IFLAGS) $< -o $@
	printf "$(BLUE)Compiling $< for debug\n$(NC)"

$(PATHO) :
	$(MKDIR) $(PATHO)

clean:
	$(CLEANUP) $(PATHO)*.o
	printf "$(RED)All *.o files from libft removed\n$(NC)"
	$(CLEANUP) $(DSYM)
	printf "$(RED)All $(DSYM) removed\n$(NC)"

cleandb :
	$(CLEANUP) $(DBNAME)
	printf "$(RED)$(DBNAME) deleted\n$(NC)"

fclean: clean cleandb
	$(CLEANUP) $(NAME)
	$(CLEANUP) $(PATHO)
	printf "$(RED)$(NAME) deleted\n$(NC)"

re : fclean all

.PHONY: all clean fclean debug cleandb
.SILENT:

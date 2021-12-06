# COLORS
NOC         = \033[0m
BOLD        = \033[1m
UNDERLINE   = \033[4m
BLACK       = \033[1;30m
RED         = \033[1;31m
GREEN       = \033[1;32m
YELLOW      = \033[1;33m
BLUE        = \033[1;34m
VIOLET      = \033[1;35m
CYAN        = \033[1;36m
WHITE       = \033[1;37m

# SYMBOLS
INFO = $(WHITE)[$(BLUE)ℹ️$(WHITE)] $(NOP)
SUCCESS = $(WHITE)[$(GREEN)✅$(WHITE)] $(GREEN)
WARNING = $(WHITE)[$(YELLOW)⚠️$(WHITE)] $(YELLOW)
ERROR = $(WHITE)[$(RED)❌$(WHITE)] $(RED)

# Binary
SRV_NAME=server
CLT_NAME=client

# Path
SRC_PATH = ./Sources/
OBJ_PATH = ./objs/
INCDIR = includes

# Sources
SRV_SRCS = server.c 

CLT_SRCS = client.c

OBJ_SRV = $(SRV_SRCS:.c=.o)
OBJ_CLT = $(CLT_SRCS:.c=.o)

# Files
SRV_SRC = $(addprefix $(SRC_PATH)/,$(SRV_SRCS))
SRV_OBJ = $(addprefix $(OBJ_PATH), $(OBJ_SRV))

CLT_SRC = $(addprefix $(SRC_PATH)/, $(CLT_SRCS))
CLT_OBJ = $(addprefix $(OBJ_PATH), $(OBJ_CLT))

# Libft
FT		= ./libft/
FT_LIB	= $(addprefix $(FT),libft.a)
FT_INC	= -I ./libft
FT_LNK	= -L ./libft -l ft

# Flags
CC = gcc $(CFLAGS)
CFLAGS = -Wall -Wextra -Werror


all: obj $(FT_LIB) $(SRV_NAME) $(CLT_NAME)

obj:
	@echo "$(INFO)Creating objects folder... $(NOC)"
	@mkdir -p $(OBJ_PATH)
	@echo "$(SUCCESS)Objects folder created successfully$(NOC)"

$(OBJ_PATH)%.o:$(SRC_PATH)%.c
	@$(CC) $(CFLAGS) $(FT_INC) -I $(INCDIR) -o $@ -c $<

$(FT_LIB):
	@echo "$(INFO)Building libft library...$(NOC)"
	@make -C $(FT)
	@echo "$(SUCCESS)Libft library built successfully!$(NOC)"

$(SRV_NAME): $(SRV_OBJ)
	@echo "$(INFO)Building $(SRV_NAME)...$(NOC)"
	@$(CC) $(SRV_OBJ) $(FT_LNK) -o $@
	@echo "$(SUCCESS)$(SRV_NAME) built successfully!$(NOC)"

$(CLT_NAME): $(CLT_OBJ)
	@echo "$(INFO)Building $(CLT_NAME)...$(NOC)"
	@$(CC) $(CLT_OBJ) $(FT_LNK) -o $@
	@echo "$(SUCCESS)$(CLT_NAME) built successfully!$(NOC)"

clean:
	@echo "$(INFO)Deleting .o files...$(NOC)"
	@rm -rf $(OBJ_PATH)
	@echo "$(SUCCESS).o files deleted successfully!$(NOC)"
	@echo "$(INFO)Deleting libft files..."
	@make -C $(FT) clean
	@echo "$(SUCCESS)Libft files deleted successfully!$(NOC)"

fclean: clean
	@echo "$(INFO)Deleting $(NAME)...$(NOC)"
	@rm -rf $(SRV_NAME)
	@rm -rf $(CLT_NAME)
	@echo "$(SUCCESS)$(NAME) deleted successfully!$(NOC)"
	@make -C $(FT) fclean

re: fclean all

.PHONY: all obj clean fclean re
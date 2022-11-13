NAME = libft.a

CUR_DIR = $(shell pwd)

COLORS = "\\033[30m" "\\033[31m" "\\033[33m"

i = 1

FILES = ft_isalpha\
	  ft_isdigit\
	  ft_isalnum\
	  ft_isascii\
	  ft_isprint\
	  ft_strlen\
	  ft_bzero\
	  ft_memset\
	  ft_memcpy\
	  ft_memmove\
	  ft_strlcpy\
	  ft_strlcat\
	  ft_toupper\
	  ft_tolower\
	  ft_strchr\
	  ft_strrchr\
	  ft_strncmp\
	  ft_memchr\
	  ft_memcmp\
	  ft_strnstr\
	  ft_atoi\
	  ft_calloc\
	  ft_strdup\
	  ft_substr\
	  ft_strjoin\
	  ft_strtrim\
	  ft_itoa\
	  ft_strmapi\
	  ft_striteri\
	  ft_putchar_fd\
	  ft_putstr_fd\
	  ft_putendl_fd\
	  ft_putnbr_fd\
	  ft_split\
	  ft_min\
	  ft_max\

S = $(foreach f, $(FILES), $(f).c)
OBJ = $(S:.c=.o)

FILES_BON = ft_lstnew\
		  ft_lstadd_front\
		  ft_lstsize\
		  ft_lstlast\
		  ft_lstadd_back\
		  ft_lstdelone\
		  ft_lstclear\
		  ft_lstiter\
		  ft_lstmap\

S_BON = $(foreach f, $(FILES_BON), $(f).c)

OBJ_BON = $(S_BON:.c=.o)

CFLAGS = -Wall -Wextra -Werror

C1			= $(shell bc <<< "((($(CMP_COUNT)*100)/($(CMP_TOTAL) / 2))*255)/200")
C2			= $(shell bc <<< "((($(CMP_COUNT)*100)/($(CMP_TOTAL) / 2))*255)/100")
C4			= $(shell bc <<< "255 - (((($(CMP_COUNT) - ($(CMP_TOTAL) / 2))*100)/($(CMP_TOTAL) / 2))*255)/100")
C5			= $(shell bc <<< "255 - $(C1)")
CMP_TOTAL	= $(shell awk -F' ' '{printf NF}' <<< "$(S) $(S_BON)")
CMP_COUNT	= 0

all: $(OBJ) $(OBJ_BON)
	@ar -rc $(NAME) $(OBJ) $(OBJ_BON)

bonus: $(NAME) $(OBJ_BON)
	@ar -rc $(NAME) $(OBJ_BON)

$(NAME): $(OBJ)
	@ar -rc $(NAME) $(OBJ)

.c.o:
	@gcc $(CFLAGS) -o $@ -c $<
	@$(eval CMP_COUNT = $(shell expr $(CMP_COUNT) + 1))
	@if [ $(CMP_COUNT) -gt $(shell expr $(CMP_TOTAL) / 2) ]; \
		then printf "\x1b[38;2;255;$(C5);$(C4)m$(CMP_COUNT) / $(CMP_TOTAL) » $<\n"; \
		else printf "\x1b[38;2;$(C2);$(C1);255m$(CMP_COUNT) / $(CMP_TOTAL) » $<\n"; \
	fi

clean:
	@rm -rf $(OBJ) $(OBJ_BON)

fclean: clean
	@rm -rf $(NAME)

re: fclean all

.PHONY: all bonus clean fclean re

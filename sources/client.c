/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lfilloux <lfilloux@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/12/06 11:09:23 by lfilloux          #+#    #+#             */
/*   Updated: 2021/12/06 14:30:41 by lfilloux         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../Includes/minitalk.h"

static void	send_mess(int pid, char *message)
{
	int		i;
	char	c;

	while (*message)
	{
		i = 8;
		c = *message++;
		while (i --)
		{
			if (c >> i & 1)
				kill(pid, SIGUSR2);
			else
				kill(pid, SIGUSR1);
			usleep(30);
		}
	}
	i = 8;
	while (i--)
	{
		kill(pid, SIGUSR1);
		usleep (30);
	}
}

int	main(int ac, char **av)
{
	if (ac != 3 || !ft_strlen(av[2]))
	{
		ft_putstr_fd("Invalid number of arguments\n", 2);
		exit(EXIT_FAILURE);
	}
	if (kill(ft_atoi(av[1]), SIGUSR1) == -1)
	{
		ft_putstr_fd("Wrong PID!\n", 2);
		exit(EXIT_FAILURE);
	}
	send_mess(ft_atoi(av[1]), av[2]);
	return (0);
}

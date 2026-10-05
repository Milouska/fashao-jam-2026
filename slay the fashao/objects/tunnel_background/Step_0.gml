depth = 50;

if (fork) {
	fork_x = lerp(fork_x, fork_x_max, 0.2);
} else {
	fork_x = lerp(fork_x, 0, 0.2);
}
def arrange_billiard_balls(x_front, y_front, radius, n):
  """
  Arranges billiard balls in a triangle given the front ball's position and radius.

  Args:
    x_front: x-coordinate of the front ball.
    y_front: y-coordinate of the front ball.
    radius: radius of the billiard ball.
    n: number of balls in the triangle.

  Returns:
    A list of (x, y) coordinates for each ball.
  """
  base_width = 2 * (n - 1) * radius
  height = (n - 1) * radius * 3**0.5 / 2
  ball_positions = []
  for i in range(1, n + 1):
    x_i = x_front + (i - 1) * radius * (1 - (2 * i - 1) / n)
    y_i = y_front - (i - 1) * radius * 3 **0.5 / 2
    ball_positions.append((x_i, y_i))
  return ball_positions

# Example usage
ball_positions = arrange_billiard_balls(100, 200, 10, 5)
print(ball_positions)

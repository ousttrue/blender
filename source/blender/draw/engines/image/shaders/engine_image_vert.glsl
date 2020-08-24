#pragma BLENDER_REQUIRE(common_view_lib.glsl)

in vec3 pos;

out vec2 uvs;

void main()
{
  /* `pos` contains the coordinates of a quad (-1..1). but we need the coordinates of an image
   * plane (0..1) */
  vec3 image_pos = pos / 2.0 + 0.5;
  vec3 world_pos = point_object_to_world(image_pos);
  vec4 position = point_world_to_ndc(world_pos);

  /* Move drawn pixels to the front. In the overlay engine the depth is used
   * to detect if a transparency texture or the background color should be drawn. */
  position.z = 0.0;
  gl_Position = position;

  uvs = world_pos.xy;
}

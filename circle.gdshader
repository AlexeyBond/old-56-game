shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = (UV - 0.5) * 2.0;
	
	if (dot(uv, uv) > 1.0) {
		discard;
	}
}

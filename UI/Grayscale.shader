shader_type canvas_item;

uniform bool grayscale = false;

void fragment() {
	if (grayscale) {
		COLOR = texture(TEXTURE, UV);
		float lumi = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
		COLOR.rgb = vec3(lumi);
	} else {
		COLOR = texture(TEXTURE, UV);
	}
}
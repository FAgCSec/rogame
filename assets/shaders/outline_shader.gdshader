shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 2.0;
uniform bool animate_outline = true;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    vec2 size = TEXTURE_PIXEL_SIZE * outline_width;
    
    // Animación del contorno
    float animation = 1.0;
    if (animate_outline) {
        animation = sin(TIME * 3.0) * 0.3 + 0.7;
    }
    
    // Detectar bordes
    float outline = 0.0;
    outline += texture(TEXTURE, UV + vec2(-size.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
    outline += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
    outline = min(outline, 1.0);
    
    // Mezclar con color original
    vec3 final_color = mix(outline_color.rgb * animation, color.rgb, color.a);
    float final_alpha = max(color.a, outline * (1.0 - color.a));
    
    COLOR = vec4(final_color, final_alpha);
}

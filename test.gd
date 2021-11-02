# Copyright © 2021 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.
extends Node3D

var previous_cas_intensity := 0.5
var sway_camera := false
var counter := 0.0


func _process(delta: float) -> void:
	$VBoxContainer/FPS.text = "%d FPS (%.2f mspf)" % [Engine.get_frames_per_second(), 1000.0 / Engine.get_frames_per_second()]
	counter += delta
	if sway_camera:
		$Camera.rotation.y = TAU * 0.75 + sin(counter) * 0.1


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_info"):
		$Info.visible = not $Info.visible

	if event.is_action_pressed("increase_render_scale"):
		get_viewport().scale_3d = clamp(get_viewport().scale_3d + 0.05, 0.25, 2.0)
		$VBoxContainer/RenderScale.text = "Render scale: %.2f" % get_viewport().scale_3d

	if event.is_action_pressed("decrease_render_scale"):
		get_viewport().scale_3d = clamp(get_viewport().scale_3d - 0.05, 0.25, 2.0)
		$VBoxContainer/RenderScale.text = "Render scale: %.2f" % get_viewport().scale_3d

	if event.is_action_pressed("toggle_fxaa"):
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED if get_viewport().screen_space_aa else Viewport.SCREEN_SPACE_AA_FXAA
		$VBoxContainer/FXAA.text = "FXAA: Enabled" if get_viewport().screen_space_aa else "FXAA: Disabled"

	if event.is_action_pressed("increase_msaa"):
		get_viewport().msaa = wrapi(get_viewport().msaa + 1, 0, Viewport.MSAA_MAX)
		$VBoxContainer/MSAA.text = "MSAA: %d" % get_viewport().msaa
	
	if event.is_action_pressed("increase_msaa"):
		get_viewport().msaa = wrapi(get_viewport().msaa + 1, 0, Viewport.MSAA_MAX)
		$VBoxContainer/MSAA.text = "MSAA: %d" % get_viewport().msaa

	if event.is_action_pressed("toggle_animation"):
		sway_camera = not sway_camera

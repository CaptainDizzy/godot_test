extends CanvasLayer

func transition_in_fade():
	%AnimationPlayer.play("in_fade")
	

func transition_out_fade():
	%AnimationPlayer.play("out_fade")

func transition_in_wipe_left():
	%AnimationPlayer.play("in_wipe_left")

func transition_in_wipe_up():
	%AnimationPlayer.play("in_wipe_up")

func transition_in_wipe_right():
	%AnimationPlayer.play("in_wipe_right")

func transition_in_wipe_down():
	%AnimationPlayer.play("in_wipe_down")

func transition_out_wipe_left():
	%AnimationPlayer.play("out_wipe_left")

func transition_out_wipe_up():
	%AnimationPlayer.play("out_wipe_up")

func transition_out_wipe_right():
	%AnimationPlayer.play("out_wipe_right")

func transition_out_wipe_down():
	%AnimationPlayer.play("out_wipe_down")

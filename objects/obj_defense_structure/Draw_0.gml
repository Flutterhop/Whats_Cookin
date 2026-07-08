draw_self()
if(not_null(struct)){
	if(not_null(struct.state_machine)){
		scribble(struct.state_machine.GetStateName()).starting_format("main_sm").draw(x,y)
	}
}